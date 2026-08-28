
------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
------------ import ------------


------------ define ------------

local CancelAniName = "CultivateOverseaMainDialog_LeftLabeBtn_Cancel"
local SelectAniName = "CultivateOverseaMainDialog_LeftLabeBtn_Select"

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaMainDialog.prefab
---@class CardProgressionMainTabNode
---@field Env                           	CardProgressionMainTabNode                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field redPoint                      	UnityEngine.RectTransform               
---@field TextDesc                      	Game.Native.Common.UISwitchText         
---@field ImgLock                       	UnityEngine.RectTransform               
---@field SelectNode                    	UnityEngine.Animation                   
---@field BtnNode                       	UnityEngine.RectTransform               
local CardProgressionMainTabNode = Class('CardProgressionMainTabNode')

function CardProgressionMainTabNode:__init()

end


function CardProgressionMainTabNode:__delete()

end


function CardProgressionMainTabNode:Awake()
end


function CardProgressionMainTabNode:Start()
    SetButtonAction(self.BtnNode.gameObject, Bind(self, self.OnClickCellAction))
end


function CardProgressionMainTabNode:OnDestroy()
    if self._redPointConstant then
        GameUtils.RemoveRedPointCallBack(self._redPointConstant)
    end
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------


---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

--- FreshUI
---@param tabData table
---@param index   number
---@param selectCardEntity CardProgressionEntity
function CardProgressionMainTabNode:FreshUI(tabData, index, selectCardEntity)
    self._index = index

    KTool.SetActive(self.ImgLock.gameObject, tabData.isLock)
    self.TextDesc.text = tabData.title

    local redPointConstant = tabData.config.redPointConstant
    if redPointConstant then
        self._redPointConstant = redPointConstant
        GameUtils.BindRedPoint(redPointConstant, self.controller.transform, true)
    end
end


function CardProgressionMainTabNode:FreshSelectState(isSelect, isInit)
    -- KTool.SetActive(self.SelectNode.gameObject, isSelect)
    self.TextDesc.Status = isSelect and 2 or 1
    
    if isInit then
        if isSelect then
            self.SelectNode:Play(SelectAniName)
        end
    else
        self.SelectNode:Play(isSelect and SelectAniName or CancelAniName)
    end
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CardProgressionMainTabNode:SetCallback(callback)
    self._callback = callback
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function CardProgressionMainTabNode:OnClickCellAction()
    if self._callback then
        local isSelect = self._callback(self, self._index)
        if isSelect then
            self:FreshSelectState(isSelect)
            
        end
    end
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionMainTabNode
