---
--- Created by Eric.
--- DateTime: 2021/10/18 15:35
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
------------ import ------------

------------ define ------------

------------ define ------------


---@class PatrolBuffPreviewNode
---@field TxtIntroduction               	UnityEngine.UI.Text
---@field TxtName                       	UnityEngine.UI.Text
---@field RawImage                      	Engine.UI.RawImageAlterable
---@field ImgBg                         	Game.Native.Common.UISwitchImage
local PatrolBuffPreviewNode = Class("PatrolBuffPreviewNode")
function PatrolBuffPreviewNode:__init()
    --self.btnAction = nil

end

function PatrolBuffPreviewNode:__delete()
    --self.btnAction = nil


    self.controller = nil
end

---SetCallBack
---设置单击回调函数
--function PatrolBuffPreviewNode:SetBtnCallBack(cb)
--    self.btnAction = cb
--end

function PatrolBuffPreviewNode:Awake()
    --SetButtonAction(self.StoreBtnNode, function ()
    --    if type(self.btnAction) == 'function' then
    --        self.btnAction()
    --    end
    --end)
    --UIEventProxy.Create(self.controller.gameObject).onPointerClick = function()
    --end
end

function PatrolBuffPreviewNode:FreshBaseUI(data)
    --printInfo("Item=====>>"..table.dump(data,nil,3))
    local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(data.id, Constants.IDArea.Maze)
    self.ImgBg.Status = checkNumber(vo.quality)
    self.RawImage:LoadSprite(vo.photoPath)
    self.TxtName.text = vo.name
    self.TxtIntroduction.text = vo.desc
end

function PatrolBuffPreviewNode:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return PatrolBuffPreviewNode