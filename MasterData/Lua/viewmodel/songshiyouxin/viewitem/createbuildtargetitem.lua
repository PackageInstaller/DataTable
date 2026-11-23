







CreateBuildTargetItem = {}
CreateBuildTargetItem.__index = CreateBuildTargetItem

local objs = {
    finishObj = {path = "Group/FinishObj", type = UITool.GameObject},
    noFinishObj = {path = "Group/NoFinishObj", type = UITool.GameObject},
    gotoBtn = {path = "Group/NoFinishObj/GotoBtn", type = UITool.Button},
    desc = {path = "Group/Desc", type = UITool.Text},
    completeEffect = {path = "Group/FinishObj/UI_SSYXCommonPopup_template_Group", type = UITool.GameObject}
}

CreateBuildTargetItem.New = function()

    local self = {}
    setmetatable(self, CreateBuildTargetItem)
    return self
end

function CreateBuildTargetItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickGotoBtn = function()
        if self.data.OnClickGotoBtn ~= nil then
            self.data.OnClickGotoBtn(self)
        end
    end
    LuaMgr.AddClick(self.gotoBtn, self.OnClickGotoBtn)
end

function CreateBuildTargetItem:SetData(data)
    self.data = data.data
    self.desc.text = LuaMgr.GetLangText(self.data.remarksLan)
    SetActive(self.finishObj, self.data.IsComplete == true)
    SetActive(self.noFinishObj, self.data.IsComplete ~= true)
    SetActive(self.gotoBtn.gameObject, self.data.skipPage ~= nil and self.data.skipPage ~= "")
    self:PlayEffect()
end

function CreateBuildTargetItem:PlayEffect()
    SetActive(self.completeEffect, true)
    if self.effectTween ~= nil then
        self.effectTween:Kill(true)
    end
    self.effectTween = DOTWeen:Sequence()
    local callback = function()
        SetActive(self.completeEffect, false)
    end
    self.effectTween:AppendInterval(0.5):OnComplete(callback)
end

function CreateBuildTargetItem:ClearItems()
end

function CreateBuildTargetItem:Clear()
    self:ClearItems()
end

function CreateBuildTargetItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    LuaMgr.RemoveClick(self.gotoBtn, self.OnClickGotoBtn)
    self.gameObject = nil
end