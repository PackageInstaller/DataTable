---
--- Created by Eric.
--- DateTime: 2021/10/12 11:40
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
------------ import ------------

------------ define ------------

------------ define ------------


---@class PatrolMainBuffCellNode
---@field FontStyleButton               	UnityEngine.RectTransform
---@field Btn                           	UnityEngine.Animator
---@field AnimRoot                      	UnityEngine.Animator
---@field ContentScale                  	UnityEngine.RectTransform
---@field ImageSelect                   	UnityEngine.RectTransform
---@field TextDesc                      	UnityEngine.UI.Text
---@field TextTitle                     	UnityEngine.UI.Text
---@field ImgIcon                       	Engine.UI.RawImageAlterable
---@field ImgFrame                      	Game.Native.Common.UISwitchImage
---@field BuffNode                      	UnityEngine.CanvasGroup
local PatrolMainBuffCellNode = Class("PatrolMainBuffCellNode")
function PatrolMainBuffCellNode:__init()
    self.btnAction = nil

end

function PatrolMainBuffCellNode:__delete()
    self.btnAction = nil

    self.controller = nil
end

---SetCallBack
---设置单击回调函数
function PatrolMainBuffCellNode:SetBtnCallBack(cb)
    self.btnAction = cb
end

---SetCallBack
---设置单击回调函数
function PatrolMainBuffCellNode:SetBtnGetCallBack(cb)
    self.btnGetAction = cb
end

function PatrolMainBuffCellNode:Awake()
    UIEventProxy.Create(self.controller.gameObject).onPointerClick = function()
        if type(self.btnAction) == 'function' then
            self.btnAction()
        end
    end
    SetButtonAction(self.FontStyleButton, function ()
        if type(self.btnGetAction) == 'function' then
            self.btnGetAction()
        end
    end)
end

function PatrolMainBuffCellNode:FreshBaseUI(relicId)
    --print("222222-->>"..relicId)
    local relicData = GoodsConfMgr:GetGoodsVoById(relicId, Constants.IDArea.Maze)
    self.TextTitle .text = relicData.name
    self.TextDesc.text = relicData.desc
    self.ImgIcon:LoadSprite(relicData.photoPath)
    self.ImgFrame.Status = checkNumber(relicData.quality)
end

function PatrolMainBuffCellNode:FreshSelectStatus(isSelected)
    KTool.SetActive(self.ImageSelect, isSelected)
    self.Btn:Play(isSelected and "Select" or "Cancel")
    KTool.SetActive(self.FontStyleButton, isSelected)
    --self.BuffNode.alpha = isSelected and 1 or 0.7
    --self.ContentScale.localScale = isSelected and Vector3.New(1, 1, 1) or Vector3.New(0.95, 0.95, 1)

end

function PatrolMainBuffCellNode:PlayCancelExitAnim()
    self.Btn:Play("Cancel_Exit")
end

function PatrolMainBuffCellNode:PlaySelectExitAnim()
    self.Btn:Play("Select_Exit")
end

function PatrolMainBuffCellNode:PlayEnterAnim()
    self.Btn:Play("Enter")
end

function PatrolMainBuffCellNode:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return PatrolMainBuffCellNode