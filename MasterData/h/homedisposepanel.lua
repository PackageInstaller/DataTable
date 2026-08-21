---@class HomeDisposePanel : HomeDisposePanel_Generate
---##################### 【HomeDisposePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【HomeDisposePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local HomeDisposePanel = require "HomeDisposePanel_Generate"

function HomeDisposePanel:InitLogic(data)
    
    self.msgEventHandler = {
        {GameMsgType.RoleBoxClickTag, self.onRefreshTagInfo},
    }
    self.curSelPos = 1
    self.curSelRoleId = 0
    self.multiplePosSignal = false  --是否每个位置对应一组词条
    self.homeSignalTypeList = {}  --房间能用的词条类型
    self.disposeRoleList = {} --当前房间的部署角色
    ---@type RoleHeadBoxData[]
    self.showRoleList = {} --展示的角色列表
end

--function HomeDisposePanel:StartCreating(time)
--
--end

--function HomeDisposePanel:StartEnter(time)
--
--end

--function HomeDisposePanel:StartRemoving(time)
--
--end

--function HomeDisposePanel:StartExit(time)
--
--end

---@class HomeDisposePanelData
---@field constructId number
---@field maxRoleNum number
---@field unlockCount number|nil  --解锁数量，默认0

---@param data HomeDisposePanelData
function HomeDisposePanel:OnOpen(data, initiative)
    if initiative then
        self:initData(data)
        self:bindRoleIconList()
        self:refreshRoleList()
        self:onPosSelChange()
    else
        self:initData(data)
        self:refreshRoleList()
        self:onPosSelChange()
    end
end

---@param data HomeDisposePanelData
function HomeDisposePanel:initData(data)
    self.constructId = data.constructId
    self.maxRoleNum = data.maxRoleNum
    self.unlockCount = data.unlockCount or 0
    self.constructCfg = Config.GetConstructionInfo(self.constructId)
    self.disposeRoleList = Me:getDisposeRole(self.constructId)

    self:autoChangeSelPos()
    if tablex.size(self.constructCfg.signalType) == 1 then
        self.multiplePosSignal = false
        self.homeSignalTypeList = self.constructCfg.signalType[1]
    else
        self.homeSignalTypeList = self.constructCfg.signalType[self.curSelPos]
        self.multiplePosSignal = true
    end
    -- 获取角色列表
    self.showRoleList = {}
    local roleList = ClientData:GetRoleList()
    for _, role in pairs(roleList) do
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
    self:fillHeadData()
end

function HomeDisposePanel:fillHeadData()
    local homeDisposeRoleList = Me:getInHomeDisposeRole()
    --当建筑可部署的位置是否已满
    local isFull = true
    for i = 1, self.unlockCount do
        if self.disposeRoleList[i] == 0 then
            isFull = false
            break
        end
    end
    for _, v in pairs(self.showRoleList) do
        --已部署标志
        v.isSel = tablex.find(homeDisposeRoleList,v.roleId)

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
            if tablex.find(homeDisposeRoleList, v.roleId) and tablex.find(self.disposeRoleList, v.roleId) == false then
                UICommonUtils.PopOkCancelBox(LocalStrEnum.ChangeCharacterJobTitle, LocalStrEnum.ChangeCharacterJob, function()
                    self:changeDispose(v.roleId)
                end)
            else
                self:changeDispose(v.roleId)
            end
        end
    end
end

--自动切换空的位置
function HomeDisposePanel:autoChangeSelPos()
    for i = 1, self.unlockCount do
        if self.disposeRoleList[i] == 0 then
            self.curSelPos = i
            return
        end
    end
end

--初始化角色头像列表
function HomeDisposePanel:bindRoleIconList()
    self.roleIconList.loopListView2:InitListView(tablex.size(self.showRoleList), function (listView, index)
        local loopListViewItem2 = listView:GetShownItemByItemIndex(index)
        if loopListViewItem2 == nil then
            loopListViewItem2 = listView:NewListViewItem("RoleHeadBox")
        end
        local itemObj = loopListViewItem2.gameObject
        itemObj.transform.localScale = Vector3.New(0.9, 0.9, 1)
        EngineUtil.FillPeer(self.roleHeadBox, itemObj)
        ---@type RoleHeadBox
        local roleHeadBox = itemObj.roleHeadBox
        roleHeadBox:setMono(self)
        roleHeadBox:refreshUI(self.showRoleList[index + 1])
        return loopListViewItem2
    end)
end

--角色填充位置选择改变
function HomeDisposePanel:onPosSelChange()
    self:refreshRoleList()
    self:sortShowRole()
    self:fillTagData()
    self:fillHeadData()
    self:refreshIconList()
end

function HomeDisposePanel:sortShowRole()
    table.sort(self.showRoleList, function (a, b)
        return a.roleId < b.roleId
    end)
end

--填充建筑可用tag数据
function HomeDisposePanel:fillTagData()
    if self.multiplePosSignal == false then
        return
    end
    self.homeSignalTypeList = self.constructCfg.signalType[self.curSelPos]
    for _, v in pairs(self.showRoleList) do
        v.tagData = self:getRoleCanUseSignal(v.roleId)
    end
end

---改变部署角色
---@param roleId number
function HomeDisposePanel:changeDispose(roleId, pos)
    local roleIdList = self.disposeRoleList
    if pos then
        roleIdList[pos] = roleId
    else
        local needChange = true
        for i = 1, self.unlockCount do
            if roleIdList[i] == roleId then
                roleIdList[i] = 0
                --if i == self.curSelPos then
                    needChange = false
                --end
            end
        end
        if needChange then
            roleIdList[self.curSelPos] = roleId
        end
    end
    local data = {
        constructionId = self.constructId,
        heroIdList = roleIdList
    }
    Me:setHomeDisposeHeroReq(data, function()
        self.disposeRoleList = roleIdList
        self:refreshRoleList()
        self:autoChangeSelPos()
        self:onPosSelChange()
    end)
end

--刷新上方角色列表
function HomeDisposePanel:refreshRoleList()
    for i = 1, self.unlockCount do
        local roleObg = self["disposeRole"..i]
        roleObg:SetActive(true)
        ---@type HomeDisposeRoleBoxData
        local data = {
            constructionId = self.constructId,
            isSel = self.curSelPos == i,
            posIndex = i,
            roleId = self.disposeRoleList[i],
            clickFunc = function()
                self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
                if self.disposeRoleList[i] == 0 then
                    --没有角色就不进行操作
                    return
                end
                --下人
                self:changeDispose(0, i)
                -- self:onPosSelChange()
            end
        }
        ---@type HomeDisposeRoleBox
        local roleBox = roleObg.homeDisposeRoleBox
        roleBox:refreshUI(data)
    end
end

--刷新角色头像列表
function HomeDisposePanel:refreshIconList()
    self.roleIconList.loopListView2:RefreshAllShownItem2()
end

--
function HomeDisposePanel:getRoleCanUseSignal(roleId)
  
    local roleTagList = Me:getHeroTagList(roleId)
    if not roleTagList then
        return nil
    end
    for _,v in pairs(roleTagList) do
        ---@type SignalTable
        local tagData = Config.SignalInfo(v)
        if tagData.type == GE.TagType.dwelling and self:canUseSignal(tagData) then
            return tagData
        end
    end
    return nil
end

---该房间能否使用该类型的词条,非词条表的词条类型
function HomeDisposePanel:canUseSignal(tagData)
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

--function HomeDisposePanel:OnClose(initiative)
--
--end

--function HomeDisposePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function HomeDisposePanel:OnRefresh(data)
--
--end

--[[
/CloseBtn onClick 
--]]
function HomeDisposePanel:closeBtn_ScaleButton_onClick(closeBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    GameMsgMgr:sendEvent(GameMsgType.RefreshHomeFuncPanel)
    UIMgr:closeSpecificUI(self)
end

--[[
/TagInfo onClick 
--]]
function HomeDisposePanel:tagInfo_Button_onClick(tagInfo)
    self.tagInfo:SetActive(false)
end

function HomeDisposePanel:onRefreshTagInfo(tagData)
    self.tagInfo:SetActive(true)
    self.tagTitle.text.text = tagData.SignalName
    self.tagDesc.text.text = tagData.Signaldesc
end

--[[
/ResetBtn onClick 
--]]
function HomeDisposePanel:resetBtn_ScaleButton_onClick(resetBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    local data = {
        constructionId = self.constructId,
        heroIdList = {0,0,0,0}
    }
    Me:setHomeDisposeHeroReq(data, function()
        self.disposeRoleList = {0,0,0,0}
        self:refreshRoleList()
        self:onPosSelChange()
    end)
end

--[[
/SureBtn onClick 
--]]
function HomeDisposePanel:sureBtn_ScaleButton_onClick(sureBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    GameMsgMgr:sendEvent(GameMsgType.RefreshHomeFuncPanel)
    UIMgr:closeSpecificUI(self)
end

--[[
/Mask onClick 
--]]
function HomeDisposePanel:mask_Button_onClick(mask)
    GameMsgMgr:sendEvent(GameMsgType.RefreshHomeFuncPanel)
    UIMgr:closeSpecificUI(self)
end

return HomeDisposePanel
