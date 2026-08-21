---@class HomeFuncPanel : HomeFuncPanel_Generate
---##################### 【HomeFuncPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【HomeFuncPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local HomeFuncPanel = require "HomeFuncPanel_Generate"

function HomeFuncPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshHomeFuncPanel, self.onRefreshUI},
        {GameMsgType.RoleBoxClickTag, self.onRefreshTagInfo},
        {GameMsgType.ItemMapNtf, self.onRefreshRedPoint},
        {GameMsgType.RoleDisposeChange, self.onRefreshRedPoint},
        
        
    }
    self.disposeRoleList = {} --当前展示的角色
    ---@type HomeSignalInfo[]
    self.signalShowList = {} --词条

    self.curSelPos = 0 --当前选中位置
    self.heroLeftOpen = false --左侧面板是否打开

    self.multiplePosSignal = false  --是否每个位置对应一组词条
    self.homeSignalTypeList = {}  --房间能用的词条类型

    --self.homeImg.rawImage.texture = CoveManager.instance().rt

    -- local listener = self.homeImg:AddComponent(TypeInfo.DragListener)
    -- listener.onBeginDragEvent = function(eventData)
    --    self:OnHomeImgBeginDrag(eventData)
    -- end

    -- listener.onDragEvent = function(eventData)
    --     self:OnHomeImgDrag(eventData)
    -- end

    -- listener.onEndDragEvent = function(eventData)
    --     self:OnHomeImgEndDrag(eventData)
    -- end

end

--function HomeFuncPanel:StartCreating(time)
--
--end

--function HomeFuncPanel:StartEnter(time)
--
--end

--function HomeFuncPanel:StartRemoving(time)
--
--end

--function HomeFuncPanel:StartExit(time)
--
--end

---@class HomeFuncPanelData
---@field homeType HomeFuncType
---@field constuctId number

---@param data HomeFuncPanelData
---@param initiative boolean
function HomeFuncPanel:OnOpen(data, initiative)
    if CoveManager.instance() then
        CoveManager.instance():SetHomelandShowOrHide(true, true)
    end
    self.tagInfo:SetActive(false)
    if initiative then
        self:initData(data)
        self:bindList()
        self:refreshAllUI()
        local naType
        if data.constuctId == GE.CoustructionEnum.CommandRoom then
            naType = GE.NavigationType.CommandRoom
        elseif data.constuctId == GE.CoustructionEnum.Armory then
            naType = GE.NavigationType.Armory
        elseif data.constuctId == GE.CoustructionEnum.WS2 then
            naType = GE.NavigationType.BulletFactory
        elseif data.constuctId == GE.CoustructionEnum.OilWell then
            naType = GE.NavigationType.Oil
        elseif data.constuctId == GE.CoustructionEnum.Steel then
            naType = GE.NavigationType.Steel
        elseif data.constuctId == GE.CoustructionEnum.Aluminum then
            naType = GE.NavigationType.Aluminum
        elseif data.constuctId == GE.CoustructionEnum.Dormitory then
            naType = GE.NavigationType.Dormitory
        elseif data.constuctId == GE.CoustructionEnum.TrainingCenter then
            naType = GE.NavigationType.TrainingCenter
        end
        if naType ~= nil then
            self.customBackPanel.customBackPanel:Bind(naType, self)
        end
        self.customBackPanel.customBackPanel:OverrideBackFunc(function()
            --self.animator:SetTrigger("out")
            --self.animOverCallBack:SetCallBack(function()
                UIMgr:closeSpecificUI(self)
                self.customBackPanel.customBackPanel:ClearBackFunc()
            --end)
        end)
    else
        if data then
            self:initData(data)
        end
        self:refreshAllUI()
    end
    --CoveManager.instance()._buildingMgr:FocusingBuild(data.constuctId)
    GuideMgr:StartGuideTrigger("HomeFuncPanel")
    self:refreshOpen()
    self:onRefreshRedPoint()
end

function HomeFuncPanel:initData(data)
    self.roleHeadBoxList = {}
    self.constuctId = data.constuctId
    self.homeType = data.homeType
    ---@type ConstructionTable
    self.constructCfg = Config.GetConstructionInfo(self.constuctId)
    if not self.constructCfg then
        LuaLogger.e("GetConstructionInfo Nil:"..self.constuctId)
        return
    end
    self.maxRoleNum = self.constructCfg.workChara

    self.constructData = Me:getConstructionDataById(self.constuctId)
    if self.constructData and self.constructData.level > 0 then
        self.constructLvCfg = Config.GetConstructionLevelInfoByTypeLevel(self.constuctId, self.constructData.level)
    end
    self.disposeRoleList = Me:getDisposeRole(self.constuctId)
    self.signalShowList = Me:getHomeSignal(self.constuctId)
    if tablex.size(self.constructCfg.signalType) == 1 then
        self.multiplePosSignal = false
        self.homeSignalTypeList = self.constructCfg.signalType[1]
    else
        self.multiplePosSignal = true
    end
    self:refreshUnLockCount()
    -- 获取角色列表
    local walkHeroList = Me:getWalkHeroList()
    self.showRoleList = {}
    local roleList = ClientData:GetRoleList()
    for _, role in pairs(roleList) do
        if not tablex.find(walkHeroList, role.id) then
            local roleCfg = Config.GetCharacterInfo(role.id)
            if roleCfg and roleCfg.isSpecial == 0 then
                ---@type RoleHeadBoxData
                local temp = {
                    roleId = role.id,
                    showTag = true,
                    tagData = self:getRoleCanUseSignal(role.id),
                    isPure = true,
                }
                table.insert(self.showRoleList, temp)
            end
        end
    end
    self:fillHeadData()
end

function HomeFuncPanel:fillHeadData(notUpdateDispose)
    if not notUpdateDispose then
        self.homeDisposeRoleList = Me:getInHomeDisposeRole()
    end
    --当建筑可部署的位置是否已满
    local isFull = true
    for i = 1, self.unlockCount do
        if self.disposeRoleList[i] == 0 or self.disposeRoleList[i] == nil then
            isFull = false
            break
        end
    end
    for _, v in pairs(self.showRoleList) do
        --已部署标志
        v.isSel = tablex.find(self.homeDisposeRoleList,v.roleId)

        if isFull and tablex.find(self.disposeRoleList, v.roleId) == false then
            v.isGray = true
        else
            v.isGray = false
        end
        v.clickFunc = function()
            self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
            if v.isGray then
                --TODO 提示
                return
            end
            --在部署中就进行提示
            if tablex.find(self.homeDisposeRoleList, v.roleId) and tablex.find(self.disposeRoleList, v.roleId) == false then
                UICommonUtils.PopOkCancelBox(LocalStrEnum.ChangeCharacterJobTitle, LocalStrEnum.ChangeCharacterJob, function()
                    self:changeDispose(v.roleId)
                end)
            else
                self:changeDispose(v.roleId)
            end
        end
    end
end

function HomeFuncPanel:refreshUnLockCount()
    --解锁位置数量
    self.unlockCount = 0
    self.unlockList = {}
    if self.constructLvCfg then
        for _, ef in pairs(self.constructLvCfg.effect) do
            if ef[1] == GE.HomeBuildEffectType.UnlockPos then
                self.unlockList = tablex.copy(ef) --解锁的角色位置
            end
        end
        table.remove(self.unlockList, 1) --移除第一个元素
    end
    for i = 1, self.maxRoleNum do
        if tablex.find(self.unlockList, i) then
            self.unlockCount = self.unlockCount + 1
        end
    end
end

---改变部署角色
---@param roleId number
function HomeFuncPanel:changeDispose(roleId, pos)
    local roleIdList = self.disposeRoleList
    if pos then
        roleIdList[pos] = roleId
    else
        local curRoleId = roleIdList[self.curSelPos]
        if curRoleId == roleId then
            roleIdList[self.curSelPos] = 0
            for index, disRoleId in pairs(self.homeDisposeRoleList) do
                if disRoleId == roleId then
                    table.remove(self.homeDisposeRoleList, index)
                    break
                end
            end
        else
            local isChangePos = false
            for i = 1, self.unlockCount do
                if roleIdList[i] == roleId then
                    roleIdList[i] = curRoleId
                    isChangePos = true
                    break
                end
            end
            if isChangePos == false then
                for index, disRoleId in pairs(self.homeDisposeRoleList) do
                    if disRoleId == curRoleId then
                        table.remove(self.homeDisposeRoleList, index)
                        break
                    end
                end
                table.insert(self.homeDisposeRoleList, roleId)
            end
            roleIdList[self.curSelPos] = roleId
            --table.insert(self.homeDisposeRoleList, roleId)
        end
    end
    self.disposeRoleList = roleIdList
    local isFull = true
    for i = 1, self.unlockCount do
        if self.disposeRoleList[i] == 0 then
            isFull = false
            break
        end
    end
    for _, v in pairs(self.showRoleList) do
        v.isSel = tablex.find(self.homeDisposeRoleList,v.roleId)
        if isFull and tablex.find(self.disposeRoleList, v.roleId) == false then
            v.isGray = true
        else
            v.isGray = false
        end
    end
    self:refreshLeftRoleList()
    self:onRefreshUI()
end

--刷新按钮开启状态
function HomeFuncPanel:refreshOpen()
    local functionState = Me:getFunctionOpenStateById(GE.FunctionOpenModule.WeaponFuse)
    local makeWeaponState = Me:getFunctionOpenStateById(GE.FunctionOpenModule.WeaponMake)
    self.combineBtn:SetActive(functionState ~= GE.FunctionOpenState.Lock)   --TODO: 不确定是否有锁定态
    self.combineBtn.isNew:SetActive(functionState == GE.FunctionOpenState.Open)
    self.productBtn:SetActive(makeWeaponState ~= GE.FunctionOpenState.Lock)
    self.productBtn.isNew:SetActive(makeWeaponState == GE.FunctionOpenState.Open)
end

function HomeFuncPanel:refreshSignList(signalNum)
    self:FillTemplateContent(self.signListBox, self.signList, signalNum, function (index, SignBox)
        ---@type HomeSignalInfo
        local signalInfo = self.signalShowList[index]
        ---@type CharacterTable
        local roleConfig = Config.GetCharacterInfo(signalInfo.roleId)
        ---@type SignalTable
        local tagData = Config.SignalInfo(signalInfo.signalId)
        SignBox:SetActive(true)
        SignBox.signName.text.text = roleConfig.name
        SignBox.signDesc.text.text = tagData.Signaldesc
        SignBox.signType.text.text = tagData.SignalName
    end)
    
end

function HomeFuncPanel:onRefreshUI()
    self.signalShowList = Me:getHomeSignal(self.constuctId)
    self.constructData = Me:getConstructionDataById(self.constuctId)
    if self.constructData and self.constructData.level > 0 then
        self.constructLvCfg = Config.GetConstructionLevelInfoByTypeLevel(self.constuctId, self.constructData.level)
    end
    self:refreshUnLockCount()
    self:refreshLeftUI()
    self:refreshRoleBox()
    self:refreshOpen()
end

function HomeFuncPanel:refreshAllUI()
    self.hideBtn:SetActive(false)
    self.noSign:SetActive(self.maxRoleNum ~= 0)
    self.signView:SetActive(self.homeType ~= HomeFuncType.ProduceRoom)
    self.increase:SetActive(self.maxRoleNum ~= 0)
    self.roleImg:SetActive(self.maxRoleNum == 0)
    self.weaponBtnRoot:SetActive(self.homeType == HomeFuncType.WeaponRoom)
    self.checkBtn:SetActive(self.homeType ~= HomeFuncType.CommandRoom and self.constuctId ~= GE.CoustructionEnum.Dormitory
    and self.constuctId ~= GE.CoustructionEnum.TrainingCenter)
    self.trainingRoot:SetActive(self.homeType == HomeFuncType.TrainingRoom)
    if self.constuctId == GE.CoustructionEnum.OilWell then
        self.checkBtn:SetActive(false)
    end

    self.walkRoot.gameObject:SetActive(self.constuctId == GE.CoustructionEnum.Dormitory)
    self.patrolRoot.gameObject:SetActive(self.constuctId == GE.CoustructionEnum.CommandRoom)

    self:refreshLeftUI()
    self:refreshRoleBox()
end

function HomeFuncPanel:refreshLeftUI()
    self.homeName.text.text = self.constructCfg.name
    self.homeLv.text.text = "0" .. self.constructData.level
    if self.homeType == HomeFuncType.ProduceRoom then
        self.funcDesc.text.text = ""
        self.produceInfo:SetActive(true)
        local baseNum = 0
        local baseEfficiency = Me:getHomeOutputBaseEfficiency(self.constuctId)
        if baseEfficiency[1] then
            local itemCfg = Config.GetItemInfo(baseEfficiency[1][2])
            baseNum = baseEfficiency[1][3]
            self.produceT1.text.text = itemCfg.itemName .. " " .. baseNum .."/h"
        end
        self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, "ItemIcon_"..baseEfficiency[1][2]), function (s)
            self.pIcon1.image.sprite = s
            self.pIcon2.image.sprite = s
        end)
        local efficiency = Me:getHomeOutputEfficiency(self.constuctId)
        if efficiency[1] then
            if efficiency[1][3] - baseNum == 0 then
                self.produceT2.text.text = LocalStrEnum.VarietyDescribe_100094
            else
                self.produceT2.text.text = (efficiency[1][3] - baseNum) .. "/h"
            end
        end
    else
        if self.constructLvCfg then
            self.funcDesc.text.text = self.constructLvCfg.describe
        end
        self.produceInfo:SetActive(false)
    end
    local signalNum = tablex.size(self.signalShowList)
    if self.maxRoleNum ~= 0 then
        self.noSign:SetActive(signalNum == 0)
    end
    self.signView:SetActive(signalNum > 0)
    self:refreshSignList(signalNum)
end

---角色列表刷新
function HomeFuncPanel:refreshRoleBox()
    for i = 1, self.maxRoleNum do
        self["homeRoleBox"..i]:SetActive(true)
        ---@type HomeRoleBoxData
        local data = {}
        data.roleId = self.disposeRoleList[i]
        data.showTitle = self.homeType == HomeFuncType.CommandRoom
        data.pos = i
        data.isLock = not tablex.find(self.unlockList, i)
        data.sel = i == self.curSelPos and true or false
        data.clickCallback = function()
            self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
            self.curSelPos = i
            self:onClickHomeRoleBox()
        end
        self["homeRoleBox"..i].homeRoleBox:setMono(self)
        self["homeRoleBox"..i].homeRoleBox:refreshUI(data)
    end
end

function HomeFuncPanel:onClickHomeRoleBox()
    if self.heroLeftOpen == false then
        self.hideBtn:SetActive(true)
        self.heroLeftOpen = true
        self.leftHeroPanel.rectTransform:DOAnchorPos(Vector2.New(-291, 0),0.5)
    end
    if self.multiplePosSignal then
        self.homeSignalTypeList = self.constructCfg.signalType[self.curSelPos]
    end
    self:refreshRoleBox()
    self:fillTagData()
    self:fillHeadData(true)
    self:refreshLeftRoleList()
end

function HomeFuncPanel:bindList()
    self.roleLoopList.loopGridView:InitGridView(#self.showRoleList, function(gridView, index, row, col)
        local loopListViewItem2 = gridView:GetShownItemByItemIndex(index)
        if loopListViewItem2 == nil then
            loopListViewItem2 = gridView:NewListViewItem("RoleHeadBox")
        end
        local itemObj = loopListViewItem2.gameObject
        EngineUtil.FillPeer(self.roleHeadBox, itemObj)
        ---@type RoleHeadBox
        local roleHeadBox = itemObj.roleHeadBox
        -- roleHeadBox.noTag.rectTransform.anchoredPosition = Vector2.New(0, -120)
        -- roleHeadBox.tagBg.rectTransform.anchoredPosition = Vector2.New(0, -120)
        roleHeadBox:setMono(self)
        roleHeadBox:refreshUI(self.showRoleList[index + 1])
        table.insert(self.roleHeadBoxList, roleHeadBox)
        return loopListViewItem2
    end)
end

function HomeFuncPanel:refreshLeftRoleList()
    self.roleHeadBoxList = {}
    self.roleLoopList.loopGridView:SetListItemCount(#self.showRoleList)
    self.roleLoopList.loopGridView:RefreshAllShownItem2()
end

function HomeFuncPanel:onRefreshRedPoint()
    self.upgradeBtn.redPoint:SetActive(RedPointMgr:HomeBulidCanUp(self.constuctId))

    --可部署角色数量
    local canDisposeRoleCount = 0
    local heroList = ClientData:GetRoleList()
    local homeDisposeRoleList = Me:getInHomeDisposeRole()
	for k, v in pairs(heroList) do
		if tablex.find(homeDisposeRoleList, v.id) == false then
			canDisposeRoleCount = canDisposeRoleCount + 1
		end
	end
    for i = 1, self.maxRoleNum do
        local homeRoleBox = self["homeRoleBox"..i]
        local roleId = self.disposeRoleList[i]
        local isLock = not tablex.find(self.unlockList, i)
        if isLock == false and roleId == 0 and canDisposeRoleCount > 0 then
            homeRoleBox.homeRoleBox.redPoint:SetActive(true)
            canDisposeRoleCount = canDisposeRoleCount - 1
        else
            homeRoleBox.homeRoleBox.redPoint:SetActive(false)
        end
    end
end

function HomeFuncPanel:getRoleCanUseSignal(roleId)
    local roleTagList = Me:getHeroTagList(roleId)
    if not roleTagList then
        return nil
    end
    for _,v in pairs(roleTagList) do
        ---@type SignalTable
        local tagData = Config.SignalInfo(v)
        if tagData and tagData.type == GE.TagType.dwelling and self:canUseSignal(tagData) then
            return tagData
        end
    end
    return nil
end

---该房间能否使用该类型的词条,非词条表的词条类型
function HomeFuncPanel:canUseSignal(tagData)
    if not tagData or not tagData.effect then
        return false
    end
    local signalType = tagData.useType
    for _,v in pairs(self.homeSignalTypeList) do
        if v == signalType then
            return true
        end
    end
    return false
end

--填充建筑可用tag数据
function HomeFuncPanel:fillTagData()
    if self.multiplePosSignal == false then
        return
    end
    self.homeSignalTypeList = self.constructCfg.signalType[self.curSelPos]
    for _, v in pairs(self.showRoleList) do
        v.tagData = self:getRoleCanUseSignal(v.roleId)
    end
end

function HomeFuncPanel:onRefreshTagInfo(tagData)
    self.tagInfo:SetActive(true)
    self.tagTitle.text.text = tagData.SignalName
    self.tagDesc.text.text = tagData.Signaldesc
end

function HomeFuncPanel:OnClose(initiative)
    -- self.cameraObj:SetActive(false)
    --CoveManager.instance()._buildingMgr:ClearFocusingBuild(self.constuctId)
end

function HomeFuncPanel:OnDestroy()
    CoveManager.instance():setCameraMoveable(true)
    CoveManager.instance()._buildingMgr:changeBtnState(true)
    CoveManager.instance():ChangeVCam(CoveManager.instance().homeFuncVcamObj, false, true, 1)
    -- CoveManager.instance()._buildingMgr:ClearFocusingBuild(self.constuctId)
    -- if self.super.OnDestroy ~= nil then
	--     self.super:OnDestroy(self)
    -- end
    self.super:OnDestroy(self)
end

--function HomeFuncPanel:OnRefresh(data)
--
--end

--[[
/Upgrade onClick 
--]]
function HomeFuncPanel:upgrade_ScaleButton_onClick(upgrade)
  
end

--[[
/SetBtn onClick 
--]]
function HomeFuncPanel:setBtn_ScaleButton_onClick(setBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    -- ---@type HomeDisposePanelData
    -- local temp = {
    --     maxRoleNum = self.maxRoleNum,
    --     constructId = self.constuctId,
    --     unlockCount = self.unlockCount,
    -- }
    -- UIMgr:popUICover("HomeDisposePanel", temp)
end

--[[
/CheckBtn onClick 
--]]
function HomeFuncPanel:checkBtn_ScaleButton_onClick(checkBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    UIMgr:popUICover("HomeSchedulePanel", {constuctId = self.constuctId})
end

--[[
/UpgradeBtn onClick 
--]]
function HomeFuncPanel:upgradeBtn_ScaleButton_onClick(upgradeBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    UIMgr:popUICover("HomeLvUpPanel", {
        constuctId = self.constuctId,
        homeType = self.homeType
    })

    --CoveManager.instance()._buildingMgr:ShowBuildingLevelUpDissolveEffect(self.constuctId, 1)
end

--[[
/HomeImg/WeaponBtnRoot/ProductBtn onClick 
--]]
function HomeFuncPanel:productBtn_ScaleButton_onClick(productBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    local functionState = Me:getFunctionOpenStateById(GE.FunctionOpenModule.WeaponMake)
    local functionOpenConfig = Config.GetFunctionOpenInfo(GE.FunctionOpenModule.WeaponMake)
    if functionState == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(functionOpenConfig.unlockKey)
        return
    elseif functionState == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.WeaponMake})
    end
    UIMgr:popUI("HomeWeaponProPanel")
end

--[[
/HomeImg/WeaponBtnRoot/CombineBtn onClick 
--]]
function HomeFuncPanel:combineBtn_ScaleButton_onClick(combineBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    local functionState = Me:getFunctionOpenStateById(GE.FunctionOpenModule.WeaponFuse)
    local functionOpenConfig = Config.GetFunctionOpenInfo(GE.FunctionOpenModule.WeaponFuse)
    if functionState == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(functionOpenConfig.unlockKey)
        return
    elseif functionState == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.WeaponFuse})
    end

    UIMgr:popUI("WeaponFusePanel")
end

function HomeFuncPanel:OnHomeImgBeginDrag(pos)
    self.HomeImgBeginPos = pos
end

function HomeFuncPanel:OnHomeImgDrag(pos)
    if not self.HomeImgBeginPos then
        return
    end
    if self.HomeImgBeginPos == nil then
        self.homeImgBeginPos = pos
        return
    end
    local delta = pos - self.HomeImgBeginPos
    self.HomeImgBeginPos = pos
    CoveManager.instance()._buildingMgr:MoveFocusingCamera(delta)
end

function HomeFuncPanel:OnHomeImgEndDrag(pos)
    self.HomeImgBeginPos = nil
end

--[[
/HideBtn onClick 
--]]
function HomeFuncPanel:hideBtn_Button_onClick(hideBtn)
    self.hideBtn:SetActive(false)
    self.heroLeftOpen = false
    self.leftHeroPanel.rectTransform:DOAnchorPos(Vector2.New(840, 0),0.5)
    self.curSelPos = 0
    --self:refreshRoleBox()
    local data = {
        constructionId = self.constuctId,
        heroIdList = self.disposeRoleList
    }
    Me:setHomeDisposeHeroReq(data, function()
        self.disposeRoleList = self.disposeRoleList
        self.curSelPos = 0
        self:fillHeadData()
        self:refreshLeftRoleList()
        self:onRefreshUI()
    end)
end

--[[
/LeftHeroPanel/ConfirmBtn onClick 
--]]
function HomeFuncPanel:confirmBtn_ScaleButton_onClick(confirmBtn)
    self.hideBtn:SetActive(false)
    self.heroLeftOpen = false
    self.leftHeroPanel.rectTransform:DOAnchorPos(Vector2.New(840, 0),0.5)
    self.curSelPos = 0
    --self:refreshRoleBox()

    local data = {
        constructionId = self.constuctId,
        heroIdList = self.disposeRoleList
    }
    Me:setHomeDisposeHeroReq(data, function()
        self.disposeRoleList = self.disposeRoleList
        self.curSelPos = 0
        self:fillHeadData()
        self:refreshLeftRoleList()
        self:onRefreshUI()
    end)
end

--[[
/LeftHeroPanel/CanselBtn onClick 
--]]
function HomeFuncPanel:canselBtn_ScaleButton_onClick(canselBtn)
    local data = {
        constructionId = self.constuctId,
        heroIdList = {}
    }
    for i = 1, self.unlockCount do
        table.insert(data.heroIdList, 0)
    end
    Me:setHomeDisposeHeroReq(data, function()
        self.disposeRoleList = data.heroIdList
        self:fillHeadData()
        self:refreshLeftRoleList()
        self:onRefreshUI()
    end)
end

--[[
/walkRoot/walkBtn onClick 
--]]
function HomeFuncPanel:walkBtn_ScaleButton_onClick(walkBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    UIMgr:popUI("HomeWalkPanel", {})
end

--[[
/patrolRoot/patrolBtn onClick 
--]]
function HomeFuncPanel:patrolBtn_ScaleButton_onClick(patrolBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.HomePatrol)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
        return
    end
    if state == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.HomePatrol})
    end
    UIMgr:popUI("HomePatrolPanel", {})
end

--[[
/TagInfo onClick 
--]]
function HomeFuncPanel:tagInfo_Button_onClick(tagInfo)
    self.tagInfo:SetActive(false)
end

--[[
/TrainingRoot/TrainingBtn onClick 
--]]
function HomeFuncPanel:trainingBtn_ScaleButton_onClick(trainingBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    --开放条件拦截
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.GenRoleFrag)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
        return
    end
    if state == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.GenRoleFrag})
    end
    LoadingMgr:SetUISwitchStart(function()
        if CoveManager.instance() then
            CoveManager.instance():SetHomelandShowOrHide(false)
        end
        -- local asyncOperation = UnityEngine.SceneManagement.SceneManager.LoadSceneAsync("GenRoleFrag",UnityEngine.SceneManagement.LoadSceneMode.Additive)
        -- if self.loadSceneTimer then
        --     DLuaTimer:RemoveTimer(self.loadSceneTimer)
        -- end
        -- self.loadSceneTimer = DLuaTimer:DoRepeatForever(0.1, function()
        --     if (asyncOperation.isDone) then
        --         DLuaTimer:RemoveTimer(self.loadSceneTimer)
        --         ResMgr:LoadPrefabAsync(Config.PrefabPath.GenRoleFragRoot, function (obj)
        --             self.battleRoot = Instantiate(obj).gameObject
        --             local targetScene = UnityEngine.SceneManagement.SceneManager.GetSceneByName("GenRoleFrag");
		--             UnityEngine.SceneManagement.SceneManager.MoveGameObjectToScene(self.battleRoot, targetScene);
        --              UIMgr:popUI("GenRoleFragPanel", {}, function()
        --                 LoadingMgr:SetUISwitchOver()
        --             end)
        --         end)
        --     end
        -- end)
        ResMgr:LoadSceneAsyncLua(Config.ScenePath.GenRoleFragScene, true, function(sceneName)
            ResMgr:LoadPrefabAsync(Config.PrefabPath.GenRoleFragRoot, function (obj)
                self.battleRoot = Instantiate(obj).gameObject
                local targetScene = UnityEngine.SceneManagement.SceneManager.GetSceneByName("GenRoleFrag");
                UnityEngine.SceneManagement.SceneManager.MoveGameObjectToScene(self.battleRoot, targetScene);
                 UIMgr:popUI("GenRoleFragPanel", {}, function()
                    LoadingMgr:SetUISwitchOver()
                end)
            end)
        end)
    end)
end

return HomeFuncPanel
