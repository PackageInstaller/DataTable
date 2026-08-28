---
--- Created by Eric.
--- DateTime: 2022/11/16 15:14
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local Yielders = CS.Engine.Lib.Yielders

local cs_coroutine = require 'XLua.cs_coroutine'
------------ import ------------

------------ define ------------
local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.RoleClothesComponent)

------------ define ------------


--- from: Assets/BundleResources/Prefabs/MainInteraction/MainClothChangePanel.prefab
---@class MainRoleClothesDialogColorNode
---@field Env                           	MainRoleClothesDialogColorNode
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field LockGroup                     	UnityEngine.RectTransform
---@field WearGroup                     	UnityEngine.RectTransform
---@field ImgColor                      	UnityEngine.UI.Image
---@field ColorCell                     	UnityEngine.RectTransform
local MainRoleClothesDialogColorNode = Class("MainRoleClothesDialogColorNode")
function MainRoleClothesDialogColorNode:__init()
    self.btnAction = nil

end

function MainRoleClothesDialogColorNode:__delete()
    self.btnAction = nil

    self.controller = nil
end

---SetCallBack
---设置单击回调函数
function MainRoleClothesDialogColorNode:SetBtnCallBack(cb)
    self.btnAction = cb
end

function MainRoleClothesDialogColorNode:Awake()
    SetButtonAction(self.ColorCell.gameObject, function()
        if type(self.btnAction) == 'function' then
            self.btnAction()
        end
    end)
end

function MainRoleClothesDialogColorNode:FreshBaseUI(data)
    print("data===>>"..table.dump(data))
    self.isUnlock = comp:IsUnlockClothByGoodsId(data.id)
    local isWear = comp:IsRoleWearTargetClothByGoodsId(data.roleId, data.id)
    KTool.SetActive(self.WearGroup, isWear)
    if not string.isEmpty(data.color) then
        self.ImgColor.color = CS.Engine.Lib.XLuaUtils.HexToColor(data.color)
    end
end

function MainRoleClothesDialogColorNode:FreshSelectStatus(isSelected)
    local animName = string.format("ClothChange_Color%s%s", self.isUnlock and "_Normal" or "_Lock", isSelected and "_Choose" or '')
    self.ColorCell:Play(animName)
end


function MainRoleClothesDialogColorNode:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return MainRoleClothesDialogColorNode