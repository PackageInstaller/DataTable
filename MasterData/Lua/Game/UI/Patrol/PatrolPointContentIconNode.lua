---
--- Created by Eric.
--- DateTime: 2021/10/13 14:04
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
------------ import ------------

------------ define ------------

------------ define ------------


---@class PatrolPointContentIconNode
---@field ImgIcon                       	Engine.UI.ImageAlterable
---@field IconNode                      	UnityEngine.CanvasGroup
local PatrolPointContentIconNode = Class("PatrolPointContentIconNode")
function PatrolPointContentIconNode:__init()

end

function PatrolPointContentIconNode:__delete()


    self.controller = nil
end



function PatrolPointContentIconNode:Awake()

end

function PatrolPointContentIconNode:FreshBaseUI(data)
    self.ImgIcon:LoadSprite(data.iconPath)
    self.IconNode.alpha = data.alpha
end

function PatrolPointContentIconNode:FreshSelectStatus(isSelected)

end

function PatrolPointContentIconNode:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return PatrolPointContentIconNode