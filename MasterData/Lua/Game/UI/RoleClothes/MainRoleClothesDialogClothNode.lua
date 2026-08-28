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
---@class MainRoleClothesDialogClothNode
---@field Env                           	MainRoleClothesDialogClothNode
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ImgIcon                       	UnityEngine.RectTransform
---@field RoleHeadGroup                 	UnityEngine.RectTransform
---@field WearGroup                     	UnityEngine.RectTransform
---@field ImgCloth                      	UnityEngine.RectTransform
---@field ClothCell                     	UnityEngine.Animation
local MainRoleClothesDialogClothNode = Class("MainRoleClothesDialogClothNode")
function MainRoleClothesDialogClothNode:__init()
    self.btnAction = nil

end

function MainRoleClothesDialogClothNode:__delete()
    self.btnAction = nil

    self.controller = nil
end

---SetCallBack
---设置单击回调函数
function MainRoleClothesDialogClothNode:SetBtnCallBack(cb)
    self.btnAction = cb
end

function MainRoleClothesDialogClothNode:Awake()
    SetButtonAction(self.ClothCell.gameObject, function()
        if type(self.btnAction) == 'function' then
            self.btnAction()
        end
    end)
end

function MainRoleClothesDialogClothNode:FreshBaseUI(data)
    self.isUnlock = comp:IsUnlockClothByDisplayId(data.id)
    CfUtils.FillImage(self.ImgCloth, data.picture)
    local isWear = comp:IsRoleWearTargetClothByDisplayId(data.roleId, data.id)
    KTool.SetActive(self.WearGroup, isWear)
    KTool.SetActive(self.RoleHeadGroup, data.isShowRoleHead)
    if data.isShowRoleHead then
        local imageVo = CfUtils.GetCfVo(AutoIds.IdSetting19, "RolesVo", data.roleId)

        CfUtils.FillImage(self.ImgIcon, imageVo.character)
    end
    
    print("=====>>"..table.dump(data))
    --self.isUnlock = comp:IsUnlockClothByDisplayId(data.id)
    --
    --
    --self:SetBtnCallBack(function()
    --    if isUnlock then
    --        comp:EnterPlotNoReq(data)
    --    else
    --        GameUtils.Toast(localize("未解锁"))
    --    end
    --end)
end

function MainRoleClothesDialogClothNode:FreshSelectStatus(isSelected)
    local animName = string.format("ClothChange_Cloth%s%s", self.isUnlock and "_Normal" or "_Lock", isSelected and "_Choose" or '')
    CfUtils.SetUISwitchImage(self.ImgBg, isSelected and 2 or 1)
    self.ClothCell:Play(animName)
end



function MainRoleClothesDialogClothNode:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return MainRoleClothesDialogClothNode