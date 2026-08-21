---@class HomeWalkPanel : HomeWalkPanel_Generate
---##################### 【HomeWalkPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【HomeWalkPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local HomeWalkPanel = require "HomeWalkPanel_Generate"

function HomeWalkPanel:InitLogic(data)
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

--function HomeWalkPanel:StartCreating(time)
--
--end

--function HomeWalkPanel:StartEnter(time)
--
--end

--function HomeWalkPanel:StartRemoving(time)
--
--end

--function HomeWalkPanel:StartExit(time)
--
--end

function HomeWalkPanel:OnOpen(data, initiative)
--导航栏
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.HomeWalk, self)
    self:SetView()
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

function HomeWalkPanel:SetView(FiltrateData, isSort)
    --初始化记录的散步信息
    self.nowWalkRoleList = Me:getWalkHeroList()
    self.filtrateData = FiltrateData
    self:SetFiltrate(self.filtrateData)
    if not isSort then
        self:setWalkObjList()
    end

    --去除rolelist中正在工作的角色
    for i = #self.RoleList, 1, -1 do
        local workRole = Me:roleInHomeDispose(self.RoleList[i].server.id)   --是否在工作
        if workRole then
            table.remove(self.RoleList, i)
        end
    end
    self.roleObjList = {}
    --初始化当前散步信息

    self.roleList.loopGridView:SetListItemCount(0)
    self.roleList.loopGridView:SetListItemCount(#self.RoleList, true)
    isSort = false
    self:setMsgView()
end

---更新滑动列表
---@param index integer 数据索引
---@param gridView SuperScrollView.LoopGridView
---@param index integer
---@param row integer
---@param col integer
function HomeWalkPanel:OnItemValueChange(gridView, index, row, col)
    local loopItem = gridView:GetShownItemByItemIndex(index)
    if loopItem == nil then
        loopItem = gridView:NewListViewItem("CustomRoleBox")
    end
    local obj = loopItem.gameObject

    EngineUtil.FillPeer(self.customRoleBox, obj)
    local customRoleBox = obj
    local isSort = false
    index = index + 1
    local temp = {
            obj = customRoleBox,
            index = index,
            data = self.RoleList[index],
        }
    table.insert(self.roleObjList, temp)
    -- if isSort then
    --     customRoleBox.btn.canvasGroup.alpha = 0
    -- end
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
function HomeWalkPanel:clickCustomRoleBox(id, obj)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self:selectBox(id, obj)
end

function HomeWalkPanel:selectBox(id, obj)
    --判断自身是否已经在列表里
    local WalkBoxCount = Config.GetConfigInfo("homeCharacterShowBase") + Me:getBuildAddWalkRoleCount()
    local isIn = self:getWalkListById(id)
    if isIn then
        self:removeWalkList(id, obj)
    else
        local count = 0
        for k, v in pairs(self.nowWalkRoleList) do
            if k > WalkBoxCount then
               goto continue 
            end
            if v ~= nil and v ~= -1 then
               count = count + 1 
            end
            ::continue::
        end
        if count >= WalkBoxCount then
            UICommonUtils.PopToast("可部署栏位已达到上限")
            return
        end
        self:addWalkList(id, obj)
    end
end

--加入散步列表
function HomeWalkPanel:addWalkList(roleId, obj)
    local WalkBoxCount = Config.GetConfigInfo("homeCharacterShowBase")  + Me:getBuildAddWalkRoleCount()
    for i = 1, WalkBoxCount do
        if self.nowWalkRoleList and next(self.nowWalkRoleList) then
            local id = self.nowWalkRoleList[i]
            if id == nil or id == -1 then
                self.nowWalkRoleList[i] = roleId
                obj.isSelect:SetActive(true)
                obj.indexBg:SetActive(true)
                obj.indexTxt.text.text = i
                break
            end
        else
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
function HomeWalkPanel:removeWalkList(roleId, obj)
    local isIn = self:getWalkListById(roleId)
    if isIn then
        self.nowWalkRoleList[isIn] = -1
        obj.isSelect:SetActive(false)
        obj.indexBg:SetActive(false)
        --刷新散步列表显示
        self:refreshWalkList()
    end
end

--根据角色id获取散步列表中的位置
---@param roleId integer
---@return integer?
function HomeWalkPanel:getWalkListById(roleId)
    if self.nowWalkRoleList and next(self.nowWalkRoleList) then
        for key, value in pairs(self.nowWalkRoleList) do
            if value == roleId then
                return key
            end
        end
    end
    return nil
end

function HomeWalkPanel:setWalkObjList()
    --生成右侧部署栏位
    self.walkBoxList = {}
    local WalkBoxCount = Config.GetConfigInfo("homeCharacterShowBase") + Me:getBuildAddWalkRoleCount()

    WalkBoxCount = Me:getMaxWalkRoleCount()

    self:FillTemplateContent(self.roleWalkBox, self.content, WalkBoxCount, function(index, roleWalkBox)
        local temp = {
            obj = roleWalkBox,
            index = index,
            roleId = nil,
        }
        table.insert(self.walkBoxList, temp)

        local walkRoleData = nil
        if self.nowWalkRoleList and next(self.nowWalkRoleList) then
            walkRoleData = self.nowWalkRoleList[index]
        end

        --设置显示
        roleWalkBox.addImg:SetActive(false)                        --空格子显示加号
        roleWalkBox.unLoadBtn:SetActive(false)
        roleWalkBox.randomBtn:SetActive(false)
        roleWalkBox.unKownBg:SetActive(walkRoleData == 0)
        roleWalkBox.roleBg:SetActive(walkRoleData ~= nil and walkRoleData ~= 0)
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
                self.nowWalkRoleList[index] = -1
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
    end, function()
        self:refreshWalkList()
        GuideMgr:StartGuideTrigger("HomeWalkPanel")
    end)
end

--点击部署格子
function HomeWalkPanel:clickEditBtn()
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self:openEditMode()
end

--打开编辑模式
function HomeWalkPanel:openEditMode()
    self.isEditorMode = true
    --展开左侧列表
    self.roleListBg:SetActive(true)
    --更新编辑模式下列表按钮显示情况
    self:refreshWalkList()
end

--刷新散步列表
function HomeWalkPanel:refreshWalkList()

    local buildAddCount = Me:getBuildAddWalkRoleCount()
    local unlockInfo = Me:getWalkRoleUnlockInfo()
    local baseCount = Config.GetConfigInfo("homeCharacterShowBase")

    for _, v in pairs(self.walkBoxList) do
        local roleId = -1
        if self.nowWalkRoleList and next(self.nowWalkRoleList) then
            roleId = self.nowWalkRoleList[v.index] or -1
        end
        v.obj.unKownBg:SetActive(roleId == 0)                         --等于0表示随机模式
        v.obj.roleBg:SetActive(roleId ~= -1 and roleId ~= 0)       --不为0也不为-1表示角色模式
        v.obj.unLoadBtn:SetActive(roleId ~= -1 and self.isEditorMode == true)                      --不为空代表可以卸载
        v.obj.randomBtn:SetActive(roleId == -1 and self.isEditorMode == true)                      --空格子可以选择随机模式
        v.obj.addImg:SetActive(roleId == -1)                        --空格子显示加号

        if roleId ~= -1 and roleId ~= 0 then
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
                local str = string.format("%s%s级解锁", b.name
                , a.level)
                obj.unlockInfoText.text.text = str
                obj.btn.scaleButton.interactable = false
            end
        end
    end

    self:setMsgView()
end

--退出编辑模式
function HomeWalkPanel:closeEditMode()
    self.roleListBg:SetActive(false)
    for _, v in pairs(self.walkBoxList) do
        v.obj.unLoadBtn:SetActive(false)
        v.obj.randomBtn:SetActive(false)
    end
    self.isEditorMode = false
    local baseCount = Config.GetConfigInfo("homeCharacterShowBase")
    local addCount = Me:getBuildAddWalkRoleCount()
    local maxCount = Me:getMaxWalkRoleCount()
    for i = 1, maxCount do

        if self.nowWalkRoleList[i] == nil then
            self.nowWalkRoleList[i] = -1
        end
        if i > (baseCount + addCount) then
            self.nowWalkRoleList[i] = -1
        end
    end
    Me:setHomeWalkHeroReq({heroIdList = self.nowWalkRoleList}, function()
        UICommonUtils.PopToast("编辑成功!")
    end)
end

--设置左侧信息视图
function HomeWalkPanel:setMsgView()
    self.maxWalkBg.countTxt.text.text = (Config.GetConfigInfo("homeCharacterShowBase") + Me:getBuildAddWalkRoleCount())..")"
    local freeCount = 0
    local setWalkCount = 0
    if self.nowWalkRoleList and next(self.nowWalkRoleList) then
        for _, value in pairs(self.nowWalkRoleList) do
            if value == 0 then
                freeCount = freeCount + 1
            elseif value ~= nil then
                setWalkCount = setWalkCount + 1
            end
        end
    end
    
    self.freeWalkBg.countTxt.text.text = freeCount..")"
    self.setWalkBg.countTxt.text.text = setWalkCount..")"
end

--根据筛选信息显示
function HomeWalkPanel:SetFiltrate(FiltrateData)
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
function HomeWalkPanel:SetSortView()
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
function HomeWalkPanel:SortInfo()
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
function HomeWalkPanel:refreshSortView()
    for k,v in pairs(self.sortBtnlist) do
        v.obj.isOpen:SetActive(self.nowSortIndex == v.key)
        if GE.RoleSortType[GE.RoleSortTypeName[self.nowSortIndex]] == GE.RoleSortType.nature and self.nowSortIndex == v.key then
            v.obj.natureList:SetActive(not v.obj.natureList.activeSelf)
        else
            v.obj.natureList:SetActive(false)
        end
    end
end

--function HomeWalkPanel:OnClose(initiative)
--
--end

--function HomeWalkPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function HomeWalkPanel:OnRefresh(data)
--
--end

--[[
/RoleListBg/ExitBtn onClick 
--]]
function HomeWalkPanel:exitBtn_ScaleButton_onClick(exitBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self:closeEditMode()
end

--[[
/RoleListBg/CustomSortBox/SortBg/SortBtn onClick 
--]]
function HomeWalkPanel:sortBtn_ScaleButton_onClick(sortBtn)
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
function HomeWalkPanel:sortStateBtn_ScaleButton_onClick(sortStateBtn)
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
function HomeWalkPanel:filtrateBtn_ScaleButton_onClick(filtrateBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    UIMgr:popUICover("DockFiltrateBox", {mode = 2})
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/RoleListBg/CustomSortBox/LikeFiltrateBtn onClick 
--]]
function HomeWalkPanel:likeFiltrateBtn_ScaleButton_onClick(likeFiltrateBtn)

end

--[[
/Custom/CustomRoleBox/Btn onClick 
--]]
function HomeWalkPanel:btn_ScaleButton_onClick(btn)

end

--[[
/LeftPanel/Aita onClick 
--]]
function HomeWalkPanel:aita_Button_onClick(aita)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self.aitaClickCount = self.aitaClickCount + 1
    if self.aitaClickCount >= 10 then
        self.aitaTxt.text.text = "嘿嘿~戳戳~"
        DLuaTimer:DoAfter(2, function()
            self.aitaTxt.text.text = "点击角色框右上角可以切换散步状态哦~"
            self.aitaClickCount = 0
        end)
    end
end

--[[
/Custom/SortTypeBtn onClick 
--]]
function HomeWalkPanel:sortTypeBtn_ScaleButton_onClick(sortTypeBtn)

end

--[[
/Custom/NatureNameBtn onClick 
--]]
function HomeWalkPanel:natureNameBtn_ScaleButton_onClick(natureNameBtn)

end

--[[
/SortMask onClick 
--]]
function HomeWalkPanel:sortMask_Button_onClick(sortMask)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

return HomeWalkPanel
