














PropTemplate = {}
PropTemplate.__index = PropTemplate

local objs = {
    usePropBtn = {path = "", type = UITool.Button},
    rectTrans = {path = "", type = UITool.RectTransform},
}

function PropTemplate.New(prefab, index, openUsePropMaskCallback, lookPropDetailCallback)
    local self = setmetatable({}, PropTemplate)
    self.gameObject = prefab
    self.transform = self.gameObject.transform
    self.itemIndex = index
    self.openUsePropMaskCallback = openUsePropMaskCallback
    self.lookPropDetailCallback = lookPropDetailCallback
    UITool.Parse(self.gameObject, self, objs)

    self.usePropBtn = self.transform:GetComponent(UITool.Button)

    local lookDetailBtnTrans = self.transform:Find("Group/LookDetailBtn")
    local countTextTrans = self.transform:Find("Group/CountText")
    local detailDescTextTrans = self.transform:Find("Group/DescText")
    local detailUseDescTextTrans = self.transform:Find("Group/UseDescText")
    if IsNull(lookDetailBtnTrans) == false then
        self.lookDetailBtn = lookDetailBtnTrans:GetComponent(UITool.Button)
    end
    if IsNull(countTextTrans) == false then
        self.countText = countTextTrans:GetComponent(UITool.Text)
    end
    if IsNull(detailDescTextTrans) == false then
        self.detailDescText = detailDescTextTrans:GetComponent(UITool.Text)
    end
    if IsNull(detailUseDescTextTrans) == false then
        self.detailUseDescText = detailUseDescTextTrans:GetComponent(UITool.Text)
    end

    local onUseProp = function()
        self:UseProp()
    end
    if self.usePropBtn ~= nil then
        LuaMgr.AddClick(self.usePropBtn, onUseProp)
    end

    local onlookDetail = function()
        self.lookPropDetailCallback(self)
    end
    if self.lookDetailBtn ~= nil then
        LuaMgr.AddClick(self.lookDetailBtn, onlookDetail)
    end
    return self
end

function PropTemplate:UseProp()
    self.openUsePropMaskCallback(self)
end

function PropTemplate:SetData(data)
    self.data = data
    local countStr = tostring(data.remainCount)
    self.countText.text = countStr
    if self.detailDescText ~= nil then
        local elementConfig = ConfigMgr.Config.EliminateElementMap[tostring(data.ID)]
        self.detailDescText.text = LuaMgr.GetLangText(elementConfig.DescLan)
    end
    if self.detailUseDescText ~= nil then
        local useLimitCount = data.count
        if useLimitCount < 1 then
            local useLanStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_25206")
            self.detailUseDescText.text = useLanStr
        else
            local useLanStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_25204")
            self.detailUseDescText.text = string.format(useLanStr, useLimitCount)
        end
    end
end

function PropTemplate:SetCount(count)
    self.data.remainCount = count
    self.countText.text = tostring(count)
end

function PropTemplate:GetAnchorPosY()
    return self.rectTrans.anchoredPosition.y
end