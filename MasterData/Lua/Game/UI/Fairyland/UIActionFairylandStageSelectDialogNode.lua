---
--- 乱流幻境进入界面列表 Node
--- Author: dawanfan
--- Date: 2024-1-11 16:40:11
---
local cs_coroutine = import('XLua.cs_coroutine')
local Yielders = CS.Engine.Lib.Yielders


---@class UIActionFairylandStageSelectDialogNode
---@field Env UIActionFairylandStageSelectDialogNode
---@field controller Engine.UI.UILuaDialog
local UIActionFairylandStageSelectDialogNode = Class("UIActionFairylandStageSelectDialogNode")

function UIActionFairylandStageSelectDialogNode:__init()
    self._cb = nil
    self._index = -1
    self._isSelect = false
    self._data = nil
end

function UIActionFairylandStageSelectDialogNode:__delete()
    self._cb = nil
    self._index = -1
    self._isSelect = false
    self._data = nil
end

function UIActionFairylandStageSelectDialogNode:Awake() end

function UIActionFairylandStageSelectDialogNode:Start()
    SetButtonAction(self.controller.gameObject, Bind(self, self.OnBtnClick))
end

---@param data {index: number, input: FairylandQuestVo}
---@param selectIndex number
---@param cb function
function UIActionFairylandStageSelectDialogNode:Refresh(data, selectIndex, cb)
    self._index = data.index
    self._data = data.input
    self._isSelect = data.index == selectIndex
    self._cb = cb

    self:FillSelf()

    self:FillSelect()
    
end

function UIActionFairylandStageSelectDialogNode:FillSelect()
    if self._selectCo ~= nil then
        cs_coroutine.stop(self._selectCo)
        self._selectCo = nil
    end

    self._selectCo = cs_coroutine.start(
        function ()
            local isUnlocked = true
            if self._isSelect then
                if isUnlocked then
                    self:PlayAnimation("ActionPointMapDialog_Normal_Cell_Selecting")
                    cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.3))
                    self:PlayAnimation("ActionPointMapDialog_Normal_Cell_Selected")
                else
                    self:PlayAnimation("ActionPointMapDialog_Normal_Cell_Locked_Selecting")
                    cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.3))
                    self:PlayAnimation("ActionPointMapDialog_Normal_Cell_Locked_Selected")
                end
            else
                if isUnlocked then
                    self:PlayAnimation("ActionPointMapDialog_Normal_Cell_Normal")
                else
                    self:PlayAnimation("ActionPointMapDialog_Normal_Cell_Locked")
                end
            end
        end
    )
end

function UIActionFairylandStageSelectDialogNode:FillSelf()
    CfUtils.FillImage(self.ImgNormal, "Arts/Icons/Action/fairyland_bg_difficulty_1.png")
    CfUtils.FillCfText(self.TxtDesc, self._data.name)
    CfUtils.FillText(self.TxtNumber, tostring(self._data.id))

    CfUtils.SetActive(self.SelectGroup, self._isSelect)

    self._co = CfUtils.PlayDelayShowAnimate(self.CellRoot.gameObject, self._index, 0.05, 0, "ActionPointMapDialog_Normal_Cell_DropDown")
end

function UIActionFairylandStageSelectDialogNode:OnBtnClick()
    if self._isSelect then
        return
    end

    if self._cb ~= nil then
        self._cb(self._index)
    end
end

---@param select boolean
function UIActionFairylandStageSelectDialogNode:Select(select)
    if self._isSelect == select then
        return
    end

    self._isSelect = select
    CfUtils.SetActive(self.SelectGroup, select)
    self:FillSelect()
end

function UIActionFairylandStageSelectDialogNode:PlayAnimation(animationName)
    CfUtils.PlayAnimation(self.controller.gameObject, animationName)
end

function UIActionFairylandStageSelectDialogNode:OnDestroy()
    if self._co then
        cs_coroutine.stop(self._co)
        self._co = nil
    end

    if self._selectCo then
        cs_coroutine.stop(self._selectCo)
        self._selectCo = nil
    end

    self.controller = nil--luabehaviour 中CSharp对象
    self:Delete()
    self = nil
end

return UIActionFairylandStageSelectDialogNode
