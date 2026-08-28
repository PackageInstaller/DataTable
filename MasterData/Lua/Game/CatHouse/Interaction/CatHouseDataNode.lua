---
--- Created by Eric.
--- DateTime: 2021/12/15 10:29
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local ConstantsCatHouse = import("Game.CatHouse.ConstantsCatHouse")
local CatHouseMgr = import('Game.CatHouse.CatHouseMgr'):GetInstance()
local cs_coroutine      = require 'XLua.cs_coroutine'
local Yielders        = CS.Engine.Lib.Yielders
local XLuaUtils = CS.Engine.Lib.XLuaUtils
local RawImageType                  = typeof(CS.UnityEngine.UI.RawImage)

------------ import ------------

------------ define ------------
local SwitchImageStatusBg = {
    --Fail = 5,
    --Lock = 6,
    Normal = 1,
    Lock = 2,
}
local SwitchTextStatusGeneName = {
    Other = 1,
    Variation = 2,
}
local SwitchIconColor = {
    [1] = "#5da375",
    [2] = "#2f8ede",
    [3] = "#ff4f74",
    [4] = "#ff6600",
}
------------ define ------------


---@class CatHouseDataNode
---@field ImgCanUnlock                  	UnityEngine.RectTransform
---@field SliderColor                   	Game.Native.Common.UISwitchImage
---@field Slider                        	UnityEngine.UI.Slider
---@field IncreaseSliderColor           	Game.Native.Common.UISwitchImage
---@field IncreaseSlider                	UnityEngine.UI.Slider
---@field TextNumberAttr                	TMPro.TextMeshProUGUI
---@field TextAttrName                  	UnityEngine.UI.Text
---@field ImgIconLock                   	Engine.UI.RawImageAlterable
---@field Lock                          	UnityEngine.RectTransform
---@field Fail                          	UnityEngine.RectTransform
---@field TextGeneName                  	UnityEngine.UI.Text
---@field ImgDot                        	UnityEngine.RectTransform
---@field ImgIcon                       	Engine.UI.RawImageAlterable
---@field Normal                        	UnityEngine.RectTransform
---@field AnimRoot                      	UnityEngine.RectTransform
---@field ImgBg                         	UnityEngine.RectTransform
local CatHouseDataNode = Class("CatHouseDataNode")
function CatHouseDataNode:__init()
    self.btnAction = nil
    self.catData = nil--猫唯一id
    self.ImgSelect = nil
    self.attrData = nil
    self.animator = nil
    self.maskImageSwitch = nil
    self.ImgGlow = nil
end

function CatHouseDataNode:__delete()
    self.btnAction = nil
    self.catData = nil--猫唯一id
    self.animator = nil
    self.ImgSelect = nil
    self.attrData = nil
    self.maskImageSwitch = nil
    self.ImgGlow = nil
    self.controller = nil
end

---SetCallBack
---设置单击回调函数
function CatHouseDataNode:SetBtnCallBack(cb)
    self.btnAction = cb
end

function CatHouseDataNode:Awake()
    self.maskImageSwitch = self.Normal.transform:Find("Mask/ImgMask")
    self.ImgGlow = self.Normal.transform:Find("ImgGlow")
    --self.EventAttrPreview = Events.AddListener(Constants.EventNames.CatHouseCatAttrPreview, Bind(self, self.FreshAttrPreview))
    self.animator = KTool.GetComponent(self.controller.gameObject, typeof(CS.UnityEngine.Animator))
    self.ImgSelect = self.controller.transform:Find('AnimRoot/ImgSelect')
    self.ImgMask = self.controller.transform:Find('AnimRoot/ImgMask')
    KTool.GetOrAddComponent(self.controller.gameObject, typeof(UIEventProxy)).onPointerClick = function()
        if type(self.btnAction) == 'function' then
            self.btnAction(self.catData)
        end
    end
end

function CatHouseDataNode:LoadIcon(catGeneData)
    local color = SwitchIconColor[checkNumber(catGeneData.kind)]
    self.ImgIcon:LoadSprite(catGeneData.icon)
    self.ImgIcon:SetColor(color)
    if not isNull(self.maskImageSwitch) then
        CfUtils.SetUISwitchImage(self.maskImageSwitch, checkNumber(catGeneData.kind))
    end
end

---@param data table 基因数据
---@param catData number 猫数据
function CatHouseDataNode:FreshChild(data, catData)
    self.catData = catData
    local catGeneData = CfUtils.GetCfVo(AutoIds.IdSetting1902, "CatHouseCatDataVo", data.geneId)
    local isVariation = catGeneData.kind == ConstantsCatHouse.ScreenCatDataType.Variation--- 变异
    --local isCombination = catGeneData.kind == ConstantsCatHouse.ScreenCatDataType.Combination--- 组合
    --local isBasic = catGeneData.kind == ConstantsCatHouse.ScreenCatDataType.Basic--- 基础
    local isPart = catGeneData.kind == ConstantsCatHouse.ScreenCatDataType.Part--- 部件
    KTool.SetActive(self.Lock, isPart)
    KTool.SetActive(self.Normal, not isPart)
    --CfUtils.SetUISwitchImage(self.ImgDot, catGeneData.kind)
    CfUtils.SetUISwitchImage(self.ImgGlow, catGeneData.kind)
    if isPart then
        local catAttrData = CfUtils.GetCfVo(AutoIds.IdSetting1901, "CatHouseCatAttributeVo", catGeneData.attributeIdList[1])
        CfUtils.SetUISwitchImage(self.ImgBg, SwitchImageStatusBg.Lock)
        --self.SliderColor.Status = catGeneData.attributeIdList[1]
        --self.IncreaseSliderColor.Status = catGeneData.attributeIdList[1]
        self.TextAttrName.text = catAttrData.name
        self.TextNumberAttr.text = catGeneData.attributeNumList[1]
        local currentCatData = self.catData
        local progress = currentCatData.attr[catGeneData.attributeIdList[1]] / catGeneData.attributeNumList[1]
        local canUnlock = progress >= 1
        self.co = cs_coroutine.start(function()
            cs_coroutine.yield_return(Yielders.EndOfFrame)
            CfUtils.PlayAnimator(self.Lock.gameObject, canUnlock and "Unlock" or "Default")
        end)
        --self.Slider.value = progress
        self.ImgIconLock:LoadSprite(catAttrData.picture)
        KTool.SetActive(self.ImgCanUnlock, canUnlock)
        --attrData = {
        --    id = v.id,
        --    num = self.catData.attr[v.id],
        --    subJoin = 0,
        --    fullNum = catGeneData.attributeNumList[1]

        --}
        self.attrData = {
            id = catGeneData.attributeIdList[1],
            num = currentCatData.attr[catGeneData.attributeIdList[1]],
            subJoin = 0,
            fullNum = catGeneData.attributeNumList[1]
        }
    else
        CfUtils.SetUISwitchImage(self.ImgBg, SwitchImageStatusBg.Normal)
        self.TextGeneName.text = catGeneData.name
        CfUtils.SetUISwitchText(self.TextGeneName.transform, isVariation and SwitchTextStatusGeneName.Variation or SwitchTextStatusGeneName.Other)
        self:LoadIcon(catGeneData)
    end

end

---@param data table id,num  id为选中道具的id  num为选中的数量
function CatHouseDataNode:FreshAttrPreview(data)
    if not isNull(self.attrData) then
        local CatHouseComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatHouseComponent, Constants.CatHouseEntityId)
        local subjoinAttrMap = CatHouseComponent:GetSubjoinAttr(data)
        if subjoinAttrMap[checkString(self.attrData.id)] then
            self.attrData.subJoin = subjoinAttrMap[checkString(self.attrData.id)]
        else
            self.attrData.subJoin = 0
        end
        local progress = (self.attrData.num + self.attrData.subJoin) / self.attrData.fullNum
        --self.IncreaseSlider.value = progress
        local canUnlock = progress >= 1
        CfUtils.PlayAnimator(self.Lock.gameObject, canUnlock and "Unlock" or "Default")
    end
end

---@param data table 基因数据
---@param catData number 猫数据
function CatHouseDataNode:FreshAdult(data, catData)
    self.catData = catData
    local catGeneData = CfUtils.GetCfVo(AutoIds.IdSetting1902, "CatHouseCatDataVo", data.geneId)
    local isVariation = catGeneData.kind == ConstantsCatHouse.ScreenCatDataType.Variation--- 变异
    --local isCombination = catGeneData.kind == ConstantsCatHouse.ScreenCatDataType.Combination--- 组合
    --local isBasic = catGeneData.kind == ConstantsCatHouse.ScreenCatDataType.Basic--- 基础
    local isPart = catGeneData.kind == ConstantsCatHouse.ScreenCatDataType.Part--- 部件
    --local catAttrData = CfUtils.GetCfVo(AutoIds.IdSetting1901, "CatHouseCatAttributeVo", catGeneData.attributeIdList[1])
    self.TextGeneName.text = catGeneData.name
    CfUtils.SetUISwitchText(self.TextGeneName.transform, isVariation and SwitchTextStatusGeneName.Variation or SwitchTextStatusGeneName.Other)
    self:LoadIcon(catGeneData)
    --CfUtils.SetUISwitchImage(self.ImgDot, catGeneData.kind)
    if isPart then
        --local currentCatData = self.catData
        --local progress = currentCatData.attr[catGeneData.attributeIdList[1]] / catGeneData.attributeNumList[1]
        local isFail = false--progress >= 1
        if data.isFail then
            isFail = true
        end
        CfUtils.SetUISwitchImage(self.ImgBg, (not isFail) and SwitchImageStatusBg.Normal or SwitchImageStatusBg.Lock)
        --KTool.SetActive(self.Lock, isLock)
        KTool.SetActive(self.Normal, not isFail)
        KTool.SetActive(self.Fail, isFail)
    else
        CfUtils.SetUISwitchImage(self.ImgBg, SwitchImageStatusBg.Normal)
        KTool.SetActive(self.Normal, true)
        KTool.SetActive(self.Fail, false)
        --KTool.SetActive(self.Lock, false)
    end
    CfUtils.SetUISwitchImage(self.ImgGlow, catGeneData.kind)
    KTool.SetActive(self.Lock, false)

end

function CatHouseDataNode:FreshHandBook(geneId)
    if not isNull(self.animator) then
        self.animator.enabled = false
    end
    KTool.SetActive(self.Normal, true)
    local catGeneData = CfUtils.GetCfVo(AutoIds.IdSetting1902, "CatHouseCatDataVo", geneId)
    self.catData = catGeneData
    self:LoadIcon(catGeneData)
    self.TextGeneName.text = catGeneData.name
    CfUtils.SetUISwitchImage(self.ImgBg, SwitchImageStatusBg.Normal)
    --CfUtils.SetUISwitchImage(self.ImgDot, catGeneData.kind)
end

---FreshFilterNode
---@param geneId number     基因id
---@param catTypeList table 猫类型列表
function CatHouseDataNode:FreshFilterNode(geneId, catTypeList)
    if not isNull(self.animator) then
        self.animator.enabled = false
    end
    KTool.SetActive(self.Normal.gameObject, true)
    ---@type CatHouseCatDataVo
    local catGeneData = CfUtils.GetCfVo(AutoIds.IdSetting1902, "CatHouseCatDataVo", geneId)
    self.catData      = catGeneData
    self:LoadIcon(catGeneData)
    self.TextGeneName.text = catGeneData.name

    --- 1. 获取选择基因 所支持的猫类型列表
    local catIdList = catGeneData.catIdList
    local catTypeDict = {}
    for i, catType in ipairs(catIdList) do
        catTypeDict[checkNumber(catType)] = true
    end
    
    --- 2. 检查解锁状态
    local isUnLock = next(catTypeList) == nil
    for i, catType in ipairs(catTypeList) do
        if catTypeDict[checkNumber(catType)] then
            isUnLock = isUnLock or catTypeDict[checkNumber(catType)]
        end
    end
    
    -- local kind = catGeneData.kind
    if self.ImgMask then
        KTool.SetActive(self.ImgMask.gameObject, not isUnLock)
        
    end
    -- CfUtils.SetUISwitchImage(self.ImgBg,  isUnLock and kind or SwitchImageStatusBg.Lock)

    --CfUtils.SetUISwitchImage(self.ImgDot, kind)
    return isUnLock, catGeneData.place
end

function CatHouseDataNode:FreshHandBookChecked(checked)
    if self.ImgSelect then
        KTool.SetActive(self.ImgSelect.gameObject, checkBool(checked))
    end
end

function CatHouseDataNode:PlayAnimator(index, interval, initialTime, cb)
    self.showAnimCo = CfUtils.PlayDelayShowAnimate(self.AnimRoot.gameObject, index, interval, initialTime)
    if self.showAnimCo then
        cs_coroutine.yield_return(self.showAnimCo)
    end
    if cb then
        cb()
    end
end

function CatHouseDataNode:OnDestroy()
    --Events.RemoveListener(Constants.EventNames.CatHouseCatAttrPreview, self.EventAttrPreview)
    if self.showAnimCo then
        cs_coroutine.stop(self.showAnimCo)
    end
    if self.co then
        cs_coroutine.stop(self.co)
    end
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return CatHouseDataNode