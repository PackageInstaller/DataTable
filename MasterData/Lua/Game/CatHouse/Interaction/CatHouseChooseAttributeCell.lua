---
--- Created by Eric.
--- DateTime: 2022/3/16 14:52
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
------------ import ------------

------------ define ------------

------------ define ------------


---@class CatHouseChooseAttributeCell
---@field Text                          	UnityEngine.UI.Text
---@field ImgAttribute                  	Engine.UI.RawImageAlterable
local CatHouseChooseAttributeCell = Class("CatHouseChooseAttributeCell")
function CatHouseChooseAttributeCell:__init()
    self.btnAction = nil

end

function CatHouseChooseAttributeCell:__delete()
    self.btnAction = nil

    self.controller = nil
end

---SetCallBack
---设置单击回调函数
function CatHouseChooseAttributeCell:SetBtnCallBack(cb)
    self.btnAction = cb
end

function CatHouseChooseAttributeCell:Awake()
    KTool.GetOrAddComponent(self.controller.gameObject, typeof(UIEventProxy)).onPointerClick = function()
        if type(self.btnAction) == 'function' then
            self.btnAction()
        end
    end
end

function CatHouseChooseAttributeCell:FreshBaseUI(data)
    self.Text.text = data.name
    self.ImgAttribute:LoadSprite(data.picture)
end

function CatHouseChooseAttributeCell:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return CatHouseChooseAttributeCell