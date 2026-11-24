require("SeasonSLG/SeasonSLGBuffFixItem")
require("SeasonSLG/SeasonSLGMapMgr")

SeasonSLGBuffFixCom = {}

SeasonSLGBuffFixCom.__index = SeasonSLGBuffFixCom

local PREFAB_PATH = "Assets/_BundleResources/UI/SeasonSLG/SeasonSLGBuffFixCom.prefab"

local function GetPrefabSize(prefab)
    if prefab == nil then
        return 0, 0
    end
    local rect = prefab:GetComponent("RectTransform")
    if rect == nil then
        return 0, 0
    end
    local width = rect.sizeDelta.x
    local height = rect.sizeDelta.y
    if width <= 0 and rect.rect ~= nil then
        width = rect.rect.width
    end
    if height <= 0 and rect.rect ~= nil then
        height = rect.rect.height
    end
    return width, height
end

local function FindGameObject(gameObject, path)
    if gameObject == nil or path == nil then
        return nil
    end
    local transform = gameObject.transform:Find(path)
    return transform ~= nil and transform.gameObject or nil
end

local function FindComponent(gameObject, path, componentName)
    local target = FindGameObject(gameObject, path)
    if target == nil then
        return nil
    end
    return target:GetComponent(componentName)
end

SeasonSLGBuffFixCom.New = function(parent,isRight)
    if parent == nil then
        return nil
    end

    local gameObject = LuaMgr.GetPrefab(PREFAB_PATH)
    if gameObject == nil then
        return nil
    end

    local self = {}
    setmetatable(self, SeasonSLGBuffFixCom)
    self.parent = parent
    self.gameObject = gameObject
    self.transform = gameObject:GetComponent("RectTransform")
    self.buffPanelOpen = false
    self.listenAdded = false
    self.onBuffOpen = function()
        self:SetBuffPanelActive(true)
    end
    self.onBuffClose = function()
        self:SetBuffPanelActive(false)
    end
    self.onBuffRefresh = function()
        self:RefreshBuffList()
    end
    self.isRight = isRight
    self.transform:SetParent(parent, false)
    self:InitUI()
    self:InitScrollView()
    self:AddEvents()
    self:SetBuffPanelActive(false)
    self:RefreshBuffList()
    return self
end

function SeasonSLGBuffFixCom:InitUI()
    self.root = self.gameObject
    self.middle = self.gameObject
    self.goBuffPanel = FindGameObject(self.gameObject, "goBuffPanel")
    self.scrollView = FindComponent(self.gameObject, "goBuffPanel/ScrollView", "ScrollRect")
    self.tranContent = FindComponent(self.gameObject, "goBuffPanel/ScrollView/Viewport/Content", "RectTransform")
    self.btnBuffOpen = FindComponent(self.gameObject, "btnBuffOpen", "Button")
    self.btnBuffClose = FindComponent(self.gameObject, "btnBuffClose", "Button")
    self.buffItemTemplate = FindGameObject(self.gameObject, "template/buffItem")
    self.transBg = FindComponent(self.gameObject, "goBuffPanel/bg","RectTransform")
    self.transWords = FindComponent(self.gameObject, "goBuffPanel/Text","RectTransform")
    SetActive(self.buffItemTemplate, false)
    self:SetPanelPosInfo()
end

function SeasonSLGBuffFixCom:SetPanelPosInfo()
    local transBtnOpen = self.btnBuffOpen:GetComponent("RectTransform")
    local transBtnClose = self.btnBuffClose:GetComponent("RectTransform")
    local transPanel = self.goBuffPanel:GetComponent("RectTransform")
    self.transBg.localScale = Vector3(self.isRight and -1 or 1,1,1)
    self.transWords.anchoredPosition = Vector2(self.isRight and 110 or -135,0)

    transPanel.anchoredPosition = Vector2(self.isRight and 224 or -42,0)
    transPanel.anchorMax = Vector2(self.isRight and 0 or 1,0.5)
    transPanel.anchorMin = Vector2(self.isRight and 0 or 1,0.5)

    transBtnOpen.localScale = Vector3(self.isRight and -1 or 1,1,1)
    transBtnOpen.anchoredPosition = Vector2(self.isRight and -7.4 or -25,0)
    transBtnOpen.anchorMax = Vector2(self.isRight and 0 or 1,0.5)
    transBtnOpen.anchorMin = Vector2(self.isRight and 0 or 1,0.5)

    transBtnClose.localScale = Vector3(self.isRight and -1 or 1,1,1)
    transBtnClose.anchoredPosition = Vector2(self.isRight and -6.2 or -25,0)
    transBtnClose.anchorMax = Vector2(self.isRight and 0 or 1,0.5)
    transBtnClose.anchorMin = Vector2(self.isRight and 0 or 1,0.5)
end

function SeasonSLGBuffFixCom:InitScrollView()
    if self.scrollView == nil then
        return
    end
    self.buffScrollView = UIScrollView.New(self.scrollView.gameObject)
    self.buffScrollView:SetParams()
end

function SeasonSLGBuffFixCom:AddEvents()
    if self.btnBuffOpen ~= nil then
        LuaMgr.AddClick(self.btnBuffOpen, self.onBuffOpen)
    end
    if self.btnBuffClose ~= nil then
        LuaMgr.AddClick(self.btnBuffClose, self.onBuffClose)
    end
    self:AddBuffRefreshListeners()
end

function SeasonSLGBuffFixCom:RemoveEvents()
    if self.btnBuffOpen ~= nil then
        LuaMgr.RemoveClick(self.btnBuffOpen, self.onBuffOpen)
    end
    if self.btnBuffClose ~= nil then
        LuaMgr.RemoveClick(self.btnBuffClose, self.onBuffClose)
    end
    self:RemoveBuffRefreshListeners()
end

function SeasonSLGBuffFixCom:SetBuffPanelActive(active)
    self.buffPanelOpen = active == true
    SetActive(self.goBuffPanel, self.buffPanelOpen)
    if self.btnBuffOpen ~= nil then
        SetActive(self.btnBuffOpen.gameObject, not self.buffPanelOpen)
    end
    if self.btnBuffClose ~= nil then
        SetActive(self.btnBuffClose.gameObject, self.buffPanelOpen)
    end
end

function SeasonSLGBuffFixCom:AddBuffRefreshListeners()
    if self.listenAdded == true then
        return
    end
    self.listenAdded = true
    self:AddBuffRefreshListener(UIEventConst.SLGSeasonUpdateMap)
    self:AddBuffRefreshListener(UIEventConst.OnPaySuccess)
    self:AddBuffRefreshListener(UIEventConst.SeasonSLGWorldProgressChange)
    self:AddBuffRefreshListener(UIEventConst.SeasonSLGTimedEventTrigger)
    self:AddBuffRefreshListener(UIEventConst.SeasonSLGTimedEventEnd)
end

function SeasonSLGBuffFixCom:RemoveBuffRefreshListeners()
    if self.listenAdded ~= true then
        return
    end
    self.listenAdded = false
    self:RemoveBuffRefreshListener(UIEventConst.SLGSeasonUpdateMap)
    self:RemoveBuffRefreshListener(UIEventConst.OnPaySuccess)
    self:RemoveBuffRefreshListener(UIEventConst.SeasonSLGWorldProgressChange)
    self:RemoveBuffRefreshListener(UIEventConst.SeasonSLGTimedEventTrigger)
    self:RemoveBuffRefreshListener(UIEventConst.SeasonSLGTimedEventEnd)
end

function SeasonSLGBuffFixCom:AddBuffRefreshListener(eventName)
    if eventName ~= nil then
        LuaMgr.AddUIEventListener(eventName, self.onBuffRefresh)
    end
end

function SeasonSLGBuffFixCom:RemoveBuffRefreshListener(eventName)
    if eventName ~= nil then
        LuaMgr.RemoveUIEventListener(eventName, self.onBuffRefresh)
    end
end

function SeasonSLGBuffFixCom:Refresh()
    self:RefreshBuffList()
end

function SeasonSLGBuffFixCom:RefreshBuffList()
    local list = {}
    local addedMap = {}
    local index = 0
    for _, buffData in ipairs(SeasonSLGMapMgr.GetActiveProduceBuff() or {}) do
        if ConfigMgr.Config.SeasonalProduceBuffMap[buffData.BuffId].Sort ~= 0 then
            index = self:AddProduceBuff(list, addedMap, buffData, index)
        end
    end



    table.sort(list, function(a, b)
        local sortA = a.sortValue or 0
        local sortB = b.sortValue or 0
        if sortA ~= sortB then
            return sortA > sortB
        end


        return a.sortIndex < b.sortIndex
    end)
    self:RefreshBuffItems(list)
end

function SeasonSLGBuffFixCom:RefreshBuffItems(list)
    if self.buffScrollView == nil or self.buffItemTemplate == nil or list == nil then
        return
    end
    local width, height = GetPrefabSize(self.buffItemTemplate)
    local scrollDatas = {}
    for i = 1, #list do
        table.insert(scrollDatas, UIScrollData.GetData(self.buffItemTemplate, "SeasonSLGBuffFixItem", width, height, list[i]))
    end
    self.buffScrollView:SetData(scrollDatas, true)
end

function SeasonSLGBuffFixCom:ClearBuffItems()
    if self.buffScrollView ~= nil then
        self.buffScrollView:Clear(true)
    end
end

function SeasonSLGBuffFixCom:AddProduceBuff(list, addedMap, buffData, index)
    local buffId = buffData.BuffId
    local buffTypePriority = buffData.BuffTypePriority
    local sortTime = buffData.SortTime
    local tags = buffData.Tags
    if IsNullOrEmpty(buffId) or ConfigMgr.Config.SeasonalProduceBuffMap == nil then
        return index
    end
    local config = ConfigMgr.Config.SeasonalProduceBuffMap[buffId] or ConfigMgr.Config.SeasonalProduceBuffMap[tostring(buffId)]
    if config == nil then
        return index
    end
    local iconTexture = LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(buffData.icon))
    table.insert(list, {
        buffId = buffId,
        buffIcon = LuaMgr.Texture2DToSprite(iconTexture),
        buffDesc = self:FormatBuffDesc(tags, buffData.RealDesc),
        tags = tags or "",
        buffTypePriority = buffTypePriority,
        sortTime = sortTime or 0,
        sortIndex = index,
        sortValue = tonumber(config.Sort) or 0,
    })
    return index + 1
end

function SeasonSLGBuffFixCom:AddBattleBuff(list, addedMap, buffData, index)
    local buffId = buffData.BuffId
    local buffTypePriority = buffData.BuffTypePriority
    local sortTime = buffData.SortTime
    local tags = buffData.Tags
    if IsNullOrEmpty(buffId) or ConfigMgr.Config.SeasonalBuffMap == nil then
        return index
    end
    local key = "battle_" .. tostring(buffId)
    if addedMap[key] then
        return index
    end
    local config = ConfigMgr.Config.SeasonalBuffMap[buffId] or ConfigMgr.Config.SeasonalBuffMap[tostring(buffId)]
    if config == nil then
        return index
    end

    addedMap[key] = true
    table.insert(list, {
        buffId = buffId,
        buffIcon = LuaMgr.GetSprite("BuffIcon", config.BuffIcon),
        buffDesc = self:FormatBuffDesc(tags, LuaMgr.GetLangText(config.BuffDesLan)),
        tags = tags or "",
        buffTypePriority = buffTypePriority,
        sortTime = sortTime or 0,
        sortIndex = index,
    })
    return index + 1
end

function SeasonSLGBuffFixCom:FormatBuffDesc(tags, desc)
    if IsNullOrEmpty(tags) then
        return desc or ""
    end
    return "<color=#d4d0ad>" .. tags .. "</color>" .. (desc or "")
end

function SeasonSLGBuffFixCom:Destroy()
    self:RemoveEvents()
    self:ClearBuffItems()
    if self.buffScrollView ~= nil then
        self.buffScrollView:Destroy()
        self.buffScrollView = nil
    end
    UIScrollView.ClearItem("SeasonSLGBuffFixItem")
    if self.gameObject ~= nil then
        LuaMgr.DestroyImmediateGO(self.gameObject)
    end
    self.parent = nil
    self.gameObject = nil
    self.transform = nil
    self.root = nil
    self.middle = nil
    self.goBuffPanel = nil
    self.scrollView = nil
    self.tranContent = nil
    self.btnBuffOpen = nil
    self.btnBuffClose = nil
    self.buffItemTemplate = nil
    self.onBuffOpen = nil
    self.onBuffClose = nil
    self.onBuffRefresh = nil
end

return SeasonSLGBuffFixCom