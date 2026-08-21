---@class HomePatrolPanel : HomePatrolPanel_Generate
---##################### 【HomePatrolPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【HomePatrolPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local HomePatrolPanel = require "HomePatrolPanel_Generate"

function HomePatrolPanel:InitLogic(data)
    self.nowSortMode = 1        --当前排序模式 默认
    self.sortBtnlist = {}       --排序按钮列表  
    self.natureBtnlist = {}     --属性按钮列表
    self.nowSortIndex = 1       --当前排序索引
    self.lastSortIndex = nil    --上次选中的模式
    self.nowNatureMode = nil    --当前属性模式
    self.filtrateData = nil     --筛选数据
    self.nowSortFace = 1        --排序正反 默认从大到小
    self.RoleList = {}          --角色列表

    self.aitaClickCount = 0     --艾塔被的点击次数
    self.roleObjList = {}       --角色对象列表

    self.nowWalkRoleList = {}   --当前散步角色列表
    self.walkBoxList = {}       --散步栏位列表

    self.isEditorMode = false   --是否是编辑模式
    self.roleList.loopGridView:InitGridView(0, BindCallback_NoParams(self, self.OnItemValueChange))
end

--function HomePatrolPanel:StartCreating(time)
--
--end

--function HomePatrolPanel:StartEnter(time)
--
--end

--function HomePatrolPanel:StartRemoving(time)
--
--end

--function HomePatrolPanel:StartExit(time)
--
--end

function HomePatrolPanel:OnOpen(data, initiative)
--导航栏
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.HomePatrol, self)
    self:SetView(nil, false)
    self:SortInfo()
    if self.sortSelectList.activeSelf then
        if self.nowSortIndex == GE.RoleSortType.nature and self.nowNatureMode == nil then
            self.sortSelectList:SetActive(false)
            self.nowSortIndex = self.lastSortIndex
            self.nowSortMode = self.lastSortIndex
            if self.nowSortMode == GE.RoleSortType.nature and self.nowNatureMode ~= nil then
                self.sortTxt.text.text = LocalStrEnum["NatureType_"..GE.NatureType[GE.NatureTypeName[self.nowNatureMode]]]
            else
                self.sortTxt.text.text = LocalStrEnum["RoleSortType_"..GE.RoleSortType[GE.RoleSortTypeName[self.nowSortMode]]]
            end
        end
    end
    self:refreshSortView()
    self:refreshWalkList()
end

function HomePatrolPanel:SetView(FiltrateData, isSort)
 --初始化记录的散步信息
    local tab = Me:getPatrolHeroList()
    tab = tablex.clone(tab)
    self.nowWalkRoleList = tab
    self.filtrateData = FiltrateData
    self:SetFiltrate(self.filtrateData)
    if not isSort then
        self:setWalkObjList()
    end

    local walkHeroList = Me:getWalkHeroList()
    --去除rolelist中正在工作的角色
    for i = #self.RoleList, 1, -1 do
        local id = self.RoleList[i].server.id
        local roomId = Me:GetHeroRoomId(id)   --是否在工作
        if roomId ~= 0 and roomId ~= GE.CoustructionEnum.PatrolRoom then
            table.remove(self.RoleList, i)
        end
        if tablex.find(walkHeroList, id) then
            table.remove(self.RoleList, i)
        end
    end

    self.roleObjList = {}
    self.roleList.loopGridView:SetListItemCount(0)
    self.roleList.loopGridView:SetListItemCount(#self.RoleList, true)
    --初始化当前散步信息
    isSort = false 

end

---更新滑动列表
---@param index integer 数据索引
---@param gridView SuperScrollView.LoopGridView
---@param index integer
---@param row integer
---@param col integer
function HomePatrolPanel:OnItemValueChange(gridView, index, row, col)
    local loopItem = gridView:GetShownItemByItemIndex(index)
    if loopItem == nil then
        loopItem = gridView:NewListViewItem("CustomRoleBox")
    end
    local obj = loopItem.gameObject

    EngineUtil.FillPeer(self.customRoleBox, obj)
    local customRoleBox = obj
    index = index + 1
    local temp = {
        obj = customRoleBox,
        index = index,
        data = self.RoleList[index],
    }
    table.insert(self.roleObjList, temp)
    customRoleBox.transform.localScale = Vector3.New(0.8, 0.8, 1)

    DLuaTimer:DoAfter(index * 0.025, function()
        customRoleBox.btn.canvasGroup:DOFade(1, 0.15)
    end)

    customRoleBox:SetActive(true)
    customRoleBox.nameTxt.text.text = self.RoleList[index].config.name
    customRoleBox.rankFarmeImg:SetActive(true)
    self:LoadSpriteAsync(string.format(Config.SpritePath.roleNewRankFarmeBg, self.RoleList[index].config.rank), customRoleBox.rankFarmeImg.image)
    customRoleBox.typeIcon:SetActive(true)
    self:LoadSpriteAsync(string.format(Config.SpritePath.RoleTypeIconPath, self.RoleList[index].config.attribute), customRoleBox.typeIcon.image)
    customRoleBox.isSelect:SetActive(false)  --是否在散步列表中
    customRoleBox.indexBg:SetActive(false)
    
    if self.nowWalkRoleList and next(self.nowWalkRoleList) then
        for k, v in pairs(self.nowWalkRoleList) do
            if v == self.RoleList[index].server.id then
                customRoleBox.isSelect:SetActive(true)
                customRoleBox.indexBg:SetActive(true)
                customRoleBox.indexTxt.text.text = k
                break
            end
        end
    end
    customRoleBox.roleIconImg:SetActive(false)
    local skinConfig = Config.GetCharacterSkinInfo(self.RoleList[index].server.equipSkin)
    local resourceFolder = nil
    if tonumber(skinConfig.resourceFolder) ~= nil then
        resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
    else
        resourceFolder = skinConfig.resourceFolder
    end
    customRoleBox.roleIconImg:SetActive(true)
    self:LoadSpriteAsync(string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey), customRoleBox.roleIconImg.image)
    customRoleBox.isEquip:SetActive(self.RoleList[index].config.id == ClientData:GetPosterData().SkinId)
    customRoleBox.btn.scaleButton.onClick:RemoveAllListeners()
    customRoleBox.btn.scaleButton.onClick:AddListener(function()
        self:clickCustomRoleBox(self.RoleList[index].server.id, customRoleBox)
    end)

    return loopItem

end

--角色格子点击方法
function HomePatrolPanel:clickCustomRoleBox(id, obj)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self:selectBox(id, obj)
end

function HomePatrolPanel:selectBox(id, obj)
    --判断自身是否已经在列表里
    local buildAddCount = Me:getBuildAddPatrolRoleCount()
    local unlockInfo = Me:getPatrolRoleUnlockInfo()
    local baseCount = 0

    local WalkBoxCount = buildAddCount + baseCount
    local isIn = self:getWalkListById(id)
    if isIn then
        self:removeWalkList(id, obj)
    else
        local count = 0
        for k, v in pairs(self.nowWalkRoleList) do
            if v ~= 0 then
               count = count + 1 
            end
        end

        if count >= WalkBoxCount then
            UICommonUtils.PopToast("可部署栏位已达到上限")
            return
        end
        self:addWalkList(id, obj)
    end
end

--加入散步列表
function HomePatrolPanel:addWalkList(roleId, obj)
    local WalkBoxCount = 4
    for i = 1, WalkBoxCount do
        if self.nowWalkRoleList[i] == nil or self.nowWalkRoleList[i] ==  0 then
            self.nowWalkRoleList[i] = roleId
            obj.isSelect:SetActive(true)
            obj.indexBg:SetActive(true)
            obj.indexTxt.text.text = i
            break
        end
    end
    self:refreshWalkList()
end

--移除散步列表
---@param roleId integer    角色id
---@param obj UnityEngine.GameObject    角色对象
function HomePatrolPanel:removeWalkList(roleId, obj)
    local isIn = self:getWalkListById(roleId)
    if isIn then
        self.nowWalkRoleList[isIn] = nil
        obj.isSelect:SetActive(false)
        obj.indexBg:SetActive(false)
        --刷新散步列表显示
        self:refreshWalkList()
    end
end

--根据角色id获取散步列表中的位置
---@param roleId integer
---@return integer?
function HomePatrolPanel:getWalkListById(roleId)
    if self.nowWalkRoleList and next(self.nowWalkRoleList) then
        for key, value in pairs(self.nowWalkRoleList) do
            if value == roleId then
                return key
            end
        end
    end
    return nil
end

function HomePatrolPanel:setWalkObjList()
      --生成右侧部署栏位
    self.walkBoxList = {}
    local WalkBoxCount = Me:getMaxPatrolRoleCount()
    self:FillTemplateContent(self.roleWalkBox, self.walkParent, WalkBoxCount, function(index, roleWalkBox)
        local temp = {
            obj = roleWalkBox,
            index = index,
            roleId = nil,
        }
        table.insert(self.walkBoxList, temp)
        local walkRoleData = self.nowWalkRoleList[index] or 0

        --设置显示
        roleWalkBox.unLoadBtn:SetActive(false)
        roleWalkBox.randomBtn:SetActive(false)
        roleWalkBox.unKownBg:SetActive(false)
        roleWalkBox.roleBg:SetActive(walkRoleData ~= 0)
        roleWalkBox.unLoadBtn.scaleButton.onClick:RemoveAllListeners()
        roleWalkBox.unLoadBtn.scaleButton.onClick:AddListener(function()
            self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
            --找到自己这个格子上的角色id
            if self.nowWalkRoleList[index] ~= nil then
               --根据这个id找到左侧列表里对应的格子信息，清除选中模式
                for _, v in pairs(self.roleObjList) do
                    if v.data.server.id == self.nowWalkRoleList[index] then
                        v.obj.isSelect:SetActive(false)
                        v.obj.indexBg:SetActive(false)
                    end
                end
                self.nowWalkRoleList[index] = 0
                self:refreshWalkList()
            end
        end)

        roleWalkBox.randomBtn.scaleButton.onClick:RemoveAllListeners()
        roleWalkBox.randomBtn.scaleButton.onClick:AddListener(function()
            self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
            --随机模式
            self.nowWalkRoleList[index] = 0
            self:refreshWalkList()
        end)

        roleWalkBox.btn.scaleButton.onClick:RemoveAllListeners()
        roleWalkBox.btn.scaleButton.onClick:AddListener(function()
            self:clickEditBtn()
        end)
        if index == WalkBoxCount then
            GuideMgr:StartGuideTrigger("HomePatrolPanel")
        end
    end, function()
        self:refreshSortView()
        self:refreshWalkList()
    end)
end

--点击部署格子
function HomePatrolPanel:clickEditBtn()
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self:openEditMode()
end

--打开编辑模式
function HomePatrolPanel:openEditMode()
    self.isEditorMode = true
    --展开左侧列表
    self.roleListBg:SetActive(true)
    self.spineRoot.gameObject:SetActive(false)
    --更新编辑模式下列表按钮显示情况
    self:refreshWalkList()
end

--刷新散步列表
function HomePatrolPanel:refreshWalkList()

    local buildAddCount = Me:getBuildAddPatrolRoleCount()
    local unlockInfo = Me:getPatrolRoleUnlockInfo()
    local baseCount = 0

    for _, v in pairs(self.walkBoxList) do
        local roleId = self.nowWalkRoleList[v.index] or 0
        v.obj.unKownBg:SetActive(false)                         --等于0表示随机模式
        v.obj.roleBg:SetActive(roleId ~= 0)       --不为0也不为空表示角色模式
        v.obj.unLoadBtn:SetActive(roleId ~= 0 and self.isEditorMode == true)                      --不为空代表可以卸载
        v.obj.randomBtn:SetActive(false)                      --空格子可以选择随机模式
        v.obj.addImg:SetActive(roleId == 0)                        --空格子显示加号

        if roleId ~= 0 then
            local roleData = Me:getPlayerHero(roleId)
            local skinConfig = Config.GetCharacterSkinInfo(roleData.equipSkin)
            local roleConfig = Config.GetCharacterInfo(roleData.id)

            local resourceFolder = nil
            if tonumber(skinConfig.resourceFolder) ~= nil then
                resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
            else
                resourceFolder = skinConfig.resourceFolder
            end

            local imgPath = string.format(Config.SpritePath.CutRolePath, resourceFolder, skinConfig.halfimgKey)
            v.obj.roleImg:SetActive(true)
            self:LoadSpriteAsync(imgPath, v.obj.roleImg.image)
            v.obj.nameTxt.text.text = roleConfig.name
        end

        local index = v.index
        v.obj.lockView:SetActive(false)
        v.obj.btn.scaleButton.interactable = true
        if index > (baseCount + buildAddCount) then
            local add = index - baseCount
            local unlockId = unlockInfo[add]
            if unlockId == nil then
               LuaLogger.ds("判断解锁条件错误 index:" .. index)
            else
                local obj = v.obj
                obj.addImg:SetActive(false)
                obj.roleBg:SetActive(false)
                obj.unKownBg:SetActive(false)
                obj.randomBtn:SetActive(false)
                obj.unLoadBtn:SetActive(false)
                obj.lockView:SetActive(true)
                local a = Config.GetConstructionLevelInfo(unlockId)
                local b = Config.GetConstructionInfo(a.type)
                local str = string.format("-%s%s级解锁-", b.name
                , a.level)
                obj.unlockInfoText.text.text = str
                obj.btn.scaleButton.interactable = false
            end
        end

    end
end

--退出编辑模式
function HomePatrolPanel:closeEditMode()
    self.roleListBg:SetActive(false)
    self.spineRoot.gameObject:SetActive(true)
    for _, v in pairs(self.walkBoxList) do
        v.obj.unLoadBtn:SetActive(false)
        v.obj.randomBtn:SetActive(false)
    end
    self.isEditorMode = false

    local tab = {}
    local maxIndex = 0
    for k, v in pairs(self.nowWalkRoleList) do
        maxIndex = math.max(maxIndex, k)
    end
    for i = 1, maxIndex do
        tab[i] = self.nowWalkRoleList[i] or 0
    end

    local data = {
        constructionId = GE.CoustructionEnum.PatrolRoom,
        heroIdList = tab,
    }
    Me:setHomeDisposeHeroReq(data, function()
        UICommonUtils.PopToast("编辑成功!")
    end)
end

--根据筛选信息显示
function HomePatrolPanel:SetFiltrate(FiltrateData)
    local function CheackFiltrateDataByType(typeName, data)
        for key, value in pairs(FiltrateData[typeName]) do
            if value == data or value == 0 then
                return true
            end
        end
        return false
    end

    local RoleList = ClientData:GetRoleList()
    self.RoleList = {}
    for _,v in pairs(RoleList) do
        local cfg = Config.GetCharacterInfo(v.id)
        if cfg and cfg.isSpecial == 0 then
            local data = {
                server = v,
                config = Config.GetCharacterInfo(v.id)
            }
            if FiltrateData ~= nil then
                if CheackFiltrateDataByType("StarList", data.server.star) and
                    CheackFiltrateDataByType("RankList", data.config.rank) and 
                    CheackFiltrateDataByType("TypeList", data.config.attribute) then
                    table.insert(self.RoleList, data)
                end
            else
                table.insert(self.RoleList, data)
            end
        end
    end
    self:SetSortView()
end

--设置排序
function HomePatrolPanel:SetSortView()
    local function compareValues(aValue, bValue, ascending)
        if ascending then
            return aValue > bValue
        else
            return aValue < bValue
        end
    end
    --获取排序方法
        local function getComparisonFunction()
        local ascending = self.nowSortFace == 1

        -- Helper to compare by a list of keys
        local function multiCompare(a, b, keys)
            for _, key in ipairs(keys) do
                local aValue, bValue
                if key[1] == "server" then
                    aValue = a.server[key[2]]
                    bValue = b.server[key[2]]
                elseif key[1] == "config" then
                    aValue = a.config[key[2]]
                    bValue = b.config[key[2]]
                end
                if aValue ~= bValue then
                    return compareValues(aValue, bValue, ascending)
                end
            end
            return false
        end

        if self.nowSortIndex == GE.RoleSortType.default then
            return function(a, b)
                return multiCompare(a, b, {
                    {"server", "level"},
                    {"config", "rank"},
                    {"server", "star"},
                    {"config", "id"},
                })
            end
        elseif self.nowSortIndex == GE.RoleSortType.level then
            return function(a, b)
                return multiCompare(a, b, {
                    {"server", "level"},
                    {"config", "rank"},
                    {"server", "star"},
                    {"config", "id"},
                })
            end
        elseif self.nowSortIndex == GE.RoleSortType.star then
            return function(a, b)
                return multiCompare(a, b, {
                    {"server", "star"},
                    {"server", "level"},
                    {"config", "rank"},
                    {"config", "id"},
                })
            end
        elseif self.nowSortIndex == GE.RoleSortType.quality then
            return function(a, b)
                return multiCompare(a, b, {
                    {"config", "rank"},
                    {"server", "level"},
                    {"server", "star"},
                    {"config", "id"},
                })
            end
        elseif self.nowSortIndex == GE.RoleSortType.getTime then
            return function(a, b)
                return multiCompare(a, b, {
                    {"server", "getTime"},
                    {"server", "level"},
                    {"config", "rank"},
                    {"server", "star"},
                    {"config", "id"},
                })
            end
        elseif self.nowSortIndex == GE.RoleSortType.allDmg then
            return function(a, b)
                return multiCompare(a, b, {
                    {"server", "allDmg"},
                    {"server", "level"},
                    {"config", "rank"},
                    {"server", "star"},
                    {"config", "id"},
                })
            end
        elseif self.nowSortIndex == GE.RoleSortType.nature then
            local attribute = GE.NatureTypeName[self.nowNatureMode]
            return function(a, b)
                return multiCompare(a, b, {
                    {"server", attribute},
                    {"server", "level"},
                    {"config", "rank"},
                    {"server", "star"},
                    {"config", "id"},
                })
            end
        elseif self.nowSortIndex == GE.RoleSortType.favorability then
            return function(a, b)
                return multiCompare(a, b, {
                    {"server", "affectionLevel"},
                    {"server", "level"},
                    {"config", "rank"},
                    {"server", "star"},
                    {"config", "id"},
                })
            end
        else
            return nil
        end
    end

    local comparisonFunction = getComparisonFunction()
    if comparisonFunction then
        table.sort(self.RoleList, comparisonFunction)
    end
end

--刷新排序
function HomePatrolPanel:SortInfo()
    self.sortBtnlist = {}
    if self.nowSortMode == GE.RoleSortType.nature and self.nowNatureMode ~= nil then
        self.sortTxt.text.text = LocalStrEnum["NatureType_"..GE.NatureType[GE.NatureTypeName[self.nowNatureMode]]]
    else
        self.sortTxt.text.text = LocalStrEnum["RoleSortType_"..GE.RoleSortType[GE.RoleSortTypeName[self.nowSortMode]]]
    end
    self:FillTemplateContent(self.sortTypeBtn, self.sortSelectList, tablex.size(GE.RoleSortTypeName), function(index, sortTypeBtn)
        if GE.RoleSortTypeName[index] == GE.RoleSortType.favorability then
            sortTypeBtn:SetActive(false)
            return
        end

        local temp = {
            obj = sortTypeBtn,
            key = index,
        }
        table.insert(self.sortBtnlist, temp)
        sortTypeBtn.sortTypeTxtOff.text.text =  LocalStrEnum["RoleSortType_"..GE.RoleSortType[GE.RoleSortTypeName[index]]]
        sortTypeBtn.sortTypeTxt.text.text =  LocalStrEnum["RoleSortType_"..GE.RoleSortType[GE.RoleSortTypeName[index]]]
        sortTypeBtn.isEx:SetActive(GE.RoleSortType[GE.RoleSortTypeName[index]] == GE.RoleSortType.nature)
        --初始化属性按钮
        if GE.RoleSortType[GE.RoleSortTypeName[index]] == GE.RoleSortType.nature then
            sortTypeBtn:SetActive(false)
        end
        sortTypeBtn.scaleButton.onClick:RemoveAllListeners()
        sortTypeBtn.scaleButton.onClick:AddListener(function()
            self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
            self.lastSortIndex = self.nowSortIndex
            self.nowSortIndex = index
            if GE.RoleSortType[GE.RoleSortTypeName[self.nowSortIndex]] == GE.RoleSortType.nature then
                self.nowSortMode = GE.RoleSortType.nature
            else
                self.nowNatureMode = nil
                self.nowSortMode = GE.RoleSortType[GE.RoleSortTypeName[self.nowSortIndex]]
                self.sortTxt.text.text = LocalStrEnum["RoleSortType_"..GE.RoleSortType[GE.RoleSortTypeName[self.nowSortMode]]]
                self.sortSelectList:SetActive(false)
                self.sortMask:SetActive(false)
                self:SetView(nil, true)
            end
            self:refreshSortView()
            for _, v in pairs(self.natureBtnlist) do
                v.obj.isOpen:SetActive(self.nowNatureMode == v.key)
            end
        end)
    end)
end

--刷新排序视图
function HomePatrolPanel:refreshSortView()
    for k,v in pairs(self.sortBtnlist) do
        v.obj.isOpen:SetActive(self.nowSortIndex == v.key)
        if GE.RoleSortType[GE.RoleSortTypeName[self.nowSortIndex]] == GE.RoleSortType.nature and self.nowSortIndex == v.key then
            v.obj.natureList:SetActive(not v.obj.natureList.activeSelf)
        else
            v.obj.natureList:SetActive(false)
        end
    end
end

--function HomePatrolPanel:OnClose(initiative)
--
--end

--function HomePatrolPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function HomePatrolPanel:OnRefresh(data)
--
--end

--[[
/RoleListBg/ExitBtn onClick 
--]]
function HomePatrolPanel:exitBtn_ScaleButton_onClick(exitBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self:closeEditMode()
end

--[[
/RoleListBg/CustomSortBox/SortBg/SortBtn onClick 
--]]
function HomePatrolPanel:sortBtn_ScaleButton_onClick(sortBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self.sortSelectList:SetActive(not self.sortSelectList.activeSelf)
    self.sortMask:SetActive(self.sortSelectList.activeSelf)
    if self.sortSelectList.activeSelf then
        if self.nowSortIndex == GE.RoleSortType.nature and self.nowNatureMode == nil then
            self.nowSortIndex = self.lastSortIndex
            self.nowSortMode = self.lastSortIndex
            self:refreshSortView()
        end
    end
end

--[[
/RoleListBg/CustomSortBox/SortBg/SortStateBtn onClick 
--]]
function HomePatrolPanel:sortStateBtn_ScaleButton_onClick(sortStateBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    if self.nowSortFace == 1 then
        self.nowSortFace = 2
    elseif self.nowSortFace == 2 then
        self.nowSortFace = 1
    end
    self.sortStateBtn.upImg:SetActive(self.nowSortFace == 2)
    self.sortStateBtn.downImg:SetActive(self.nowSortFace == 1)
    self:SetView(nil, true)
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/RoleListBg/CustomSortBox/FiltrateBtn onClick 
--]]
function HomePatrolPanel:filtrateBtn_ScaleButton_onClick(filtrateBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    UIMgr:popUICover("DockFiltrateBox", {mode = 2})
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/RoleListBg/CustomSortBox/LikeFiltrateBtn onClick 
--]]
function HomePatrolPanel:likeFiltrateBtn_ScaleButton_onClick(likeFiltrateBtn)

end

--[[
/Custom/CustomRoleBox/Btn onClick 
--]]
function HomePatrolPanel:btn_ScaleButton_onClick(btn)

end

--[[
/Custom/SortTypeBtn onClick 
--]]
function HomePatrolPanel:sortTypeBtn_ScaleButton_onClick(sortTypeBtn)

end

--[[
/Custom/NatureNameBtn onClick 
--]]
function HomePatrolPanel:natureNameBtn_ScaleButton_onClick(natureNameBtn)

end

--[[
/SortMask onClick 
--]]
function HomePatrolPanel:sortMask_Button_onClick(sortMask)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/AdjustRoot/LeftPanel/spineRoot onClick 
--]]
function HomePatrolPanel:spineRoot_Button_onClick(spineRoot)

end

return HomePatrolPanel
