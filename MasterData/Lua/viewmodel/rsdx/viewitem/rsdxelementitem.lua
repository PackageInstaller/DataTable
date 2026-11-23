








RSDXElementItem = {}
RSDXElementItem.__index = RSDXElementItem

local objs = {
    rectTrans = {path = "", type = UITool.RectTransform},
    clickBtn = {path = "", type = UITool.Button},
    icon = {path = "Group/Icon", type = UITool.Image},
    effect = {path = "Group/Vfx", type = UITool.GameObject},
    animator = {path = "", type = UITool.Animator}
}

RSDXElementItem.New = function(obj)

    local self = {}
    setmetatable(self, RSDXElementItem)
    self.gameObject = obj
    self:Init()
    return self
end

function RSDXElementItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickBtn = function()
        if self.data ~= nil and self.data.OnClickElementItem ~= nil then
            self.data.OnClickElementItem(self)
        end
    end
    LuaMgr.AddClick(self.clickBtn, self.OnClickBtn)
end



function RSDXElementItem:SetData(data)
    self.data = data
    self:RefreshElement(true)
end

function RSDXElementItem:RefreshElementData(elementID, isInit)
    self.data:RefreshElement(elementID)
    self:RefreshElement(isInit)
end

function RSDXElementItem:RefreshElement(isInit)
    local elementConfig = self.data.CurElementConfig
    if elementConfig == nil then
        LuaDebug.error("50=========元素配置不存在，元素ID：" .. tostring(self.data.CurElementID) .. debug.traceback())
        return
    end
    if elementConfig.Element == nil or elementConfig.Element == "" then
        self.icon.color = RSDXConst.ElementColor[self.data.CurElementID] or UnityEngine.Color.white
    else
        if isInit then
            self.icon.sprite = LuaMgr.GetSprite(RSDXConst.GameSpriteAtlaName, elementConfig.Element)
        else
            if self.scaleTween ~= nil then
                self.scaleTween:Kill()
                self.scaleTween = nil
            end
            if self.scaleTween1 ~= nil then
                self.scaleTween1:Kill()
                self.scaleTween1 = nil
            end
            self.scaleTween = DOTWeen:Sequence()
            self.scaleTween1 = DOTWeen:Sequence()
            local func = function()
                self.icon.sprite = LuaMgr.GetSprite(RSDXConst.GameSpriteAtlaName, self.data.CurElementConfig.Element)
            end
            local func1 = function()
                SetActive(self.effect, false)
            end
            SetActive(self.effect, true)
            local changeInterval = RSDXConst.EliminateAnimDelay - 0.5
            local hideEffrectTime = RSDXConst.ElemenetEffectTime
            self.scaleTween:AppendInterval(changeInterval):OnComplete(func)
            self.scaleTween1:AppendInterval(hideEffrectTime):OnComplete(func1)
        end        
    end
end

function RSDXElementItem:SetElementData()
end

function RSDXElementItem:ClearItems()
end

function RSDXElementItem:Clear()
    self:ClearItems()
end

function RSDXElementItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end