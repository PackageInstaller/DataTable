-------------------------------------------------------------------------------
-- 海外图鉴 - 区域介绍界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-08-20 21:50:25
-------------------------------------------------------------------------------

---@type IllustratedHandbookComponent
local illustratedHandbookComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.IllustratedHandbookComponent)

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/IllustratedHandbook/IllustbookAreaDescriptionDialog.prefab
---@class IllustratedHandbookAreaIntroDialog
---@field Env                           	IllustratedHandbookAreaIntroDialog      
---@field controller                    	Engine.UI.UILuaDialog                   
---@field descrTxt                      	UnityEngine.RectTransform               @ 描述文本
---@field nameTxt                       	UnityEngine.RectTransform               @ 名字文本
---@field bgImg                         	UnityEngine.RectTransform               @ 背景图
local IllustratedHandbookAreaIntroDialog = Class('IllustratedHandbookAreaIntroDialog')


function IllustratedHandbookAreaIntroDialog:__init()
end


function IllustratedHandbookAreaIntroDialog:__delete()
end


function IllustratedHandbookAreaIntroDialog:Awake()
end


function IllustratedHandbookAreaIntroDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self:SetRegionAreaId(initParams.regionId)
    end)
end


function IllustratedHandbookAreaIntroDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

function IllustratedHandbookAreaIntroDialog:GetRegionAreaId()
    return checkInt(self.regionAreaId_)
end
function IllustratedHandbookAreaIntroDialog:SetRegionAreaId(areaId)
    self.regionAreaId_ = checkInt(areaId)
    self:UpddateRegionAreaInfo_()
end


-------------------------------------------------
-- private

function IllustratedHandbookAreaIntroDialog:UpddateRegionAreaInfo_()
    local encyDojo = illustratedHandbookComp:GetRegionMapEncyDojoMap()[tostring(self:GetRegionAreaId())]
    if not encyDojo then return end

    CfUtils.FillImage(self.bgImg, encyDojo.encyVo.bgImg)
    CfUtils.FillText(self.nameTxt, encyDojo.encyVo.name)
    CfUtils.FillText(self.descrTxt, encyDojo.encyVo.descr)
end


return IllustratedHandbookAreaIntroDialog
