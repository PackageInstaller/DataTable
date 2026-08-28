---
--- Created by Eric.
--- DateTime: 2022/6/22 10:41
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule

------------ import ------------

------------ define ------------
local SwitchImgStatus = {
    Normal = 1,
    Select = 2,
}
------------ define ------------


---@class CatHouseTutorialDialog
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ImgPoint                      	UnityEngine.RectTransform
---@field PagePoint                     	UnityEngine.RectTransform
---@field BtnArrowRight                 	UnityEngine.RectTransform
---@field BtnArrowLeft                  	UnityEngine.RectTransform
---@field Group4                        	UnityEngine.RectTransform
---@field Group3                        	UnityEngine.RectTransform
---@field Group2                        	UnityEngine.RectTransform
---@field Group1                        	UnityEngine.RectTransform
---@field desc2                         	UnityEngine.UI.Text
---@field desc3                         	UnityEngine.UI.Text
---@field desc1                         	UnityEngine.UI.Text
local CatHouseTutorialDialog = Class("CatHouseTutorialDialog")
function CatHouseTutorialDialog:__init()
    self.data = {}
    self.pageGoList = {}
    self.selectLuaIndex = 1--默认选第一页

end

function CatHouseTutorialDialog:__delete()
    self.data = nil
    self.pageGoList = nil
    self.selectLuaIndex = nil

    self.controller = nil
end

function CatHouseTutorialDialog:Awake()
    local systemToggleId = self.controller.Argument.parameters.systemToggleId

    local ids =  string.split(CfUtils.GetIdGroupData(AutoIds.IdSetting1918, checkString(systemToggleId), "ids")[1], ";")
    for i, v in pairs(ids) do
        local vo = CfUtils.GetCfVo(AutoIds.IdSetting1918, "CatHouseIntroductionVo", v)
        table.insert(self.data, vo)
    end
    self:ProcessData()
    self:InitPageGo()
    self:FreshArrow()
    self:SetBtnAction()
end

function CatHouseTutorialDialog:SetBtnAction()
    SetButtonAction(self.BtnArrowLeft, function()
        if self.selectLuaIndex <= 1 then
            return
        else
            --CfUtils.PlayAnimator(self["Group"..self.selectLuaIndex], "Out")
            CfUtils.SetUISwitchImage(self.pageGoList[self.selectLuaIndex], SwitchImgStatus.Normal)
            self.selectLuaIndex = self.selectLuaIndex - 1
            CfUtils.SetUISwitchImage(self.pageGoList[self.selectLuaIndex], SwitchImgStatus.Select)
            self:FreshArrow()
            --KTool.SetActive(self["Group"..self.selectLuaIndex], true)
            --CfUtils.PlayAnimator(self["Group"..self.selectLuaIndex], "In")
        end
    end)
    SetButtonAction(self.BtnArrowRight, function()
        if self.selectLuaIndex >= table.count(self.data) then
            return
        else
            CfUtils.SetUISwitchImage(self.pageGoList[self.selectLuaIndex], SwitchImgStatus.Normal)
            self.selectLuaIndex = self.selectLuaIndex + 1
            CfUtils.SetUISwitchImage(self.pageGoList[self.selectLuaIndex], SwitchImgStatus.Select)
            self:FreshArrow()
            --KTool.SetActive(self["Group"..self.selectLuaIndex], true)
            --CfUtils.PlayAnimator(self["Group"..self.selectLuaIndex], "In")
        end
    end)

end

function CatHouseTutorialDialog:InitPageGo()
    for i = 1, #self.data do
        local go
        go = self.pageGoList[i]
        if not go then
            go = CfUtils.InstantiateGo(self.ImgPoint, self.PagePoint.gameObject)
            go.name = "Node"..i
            self.pageGoList[i] = go.gameObject
        end

        KTool.SetActive(go, true)
    end
end

function CatHouseTutorialDialog:FreshArrow()
    local isLeftMost = self.selectLuaIndex == 1
    local isRightMost = self.selectLuaIndex == table.count(self.data)
    KTool.SetActive(self.BtnArrowLeft, not isLeftMost)
    KTool.SetActive(self.BtnArrowRight, not isRightMost)
    self:FreshGroup()
end

function CatHouseTutorialDialog:FreshGroup()
    --print("self.data----->>"..table.dump(self.data, nil, 3))

    local data = self.data[self.selectLuaIndex]
    --print(self.selectLuaIndex.."----->>"..table.dump(data, nil, 3))
    if data.photo1 ~= "" then
        CfUtils.FillImage(self["Group"..data.group].transform:Find("ImgContent1").gameObject, data.photo1)
    end
    if data.photo2 ~= "" then
        CfUtils.FillImage(self["Group"..data.group].transform:Find("ImgContent2").gameObject, data.photo2)
    end
    if data.photo3 ~= "" then
        CfUtils.FillImage(self["Group"..data.group].transform:Find("ImgContent3").gameObject, data.photo3)
    end
    self.desc1.text = data.desc1 or ""
    self.desc2.text = data.desc2 or ""
    self.desc3.text = data.desc3 or ""

    for i, v in pairs(self.data) do
        if i == self.selectLuaIndex then
            KTool.SetActive(self["Group"..v.group], true)
            CfUtils.PlayAnimator(self["Group"..v.group], "Go")
        else
            if not (v.group == data.group) then
                --CfUtils.PlayAnimator(self["Group"..v.group], "Out")
                KTool.SetActive(self["Group"..v.group], false)
            end
        end
    end
end

function CatHouseTutorialDialog:ProcessData()
    if isNull(self.data) then
        return
    end
    table.sort(self.data, function(a,b)
        if a.sort ~= b.sort then
            return a.sort < b.sort
        end
        return false
    end)
end

function CatHouseTutorialDialog:OnFocus(focus)
end

function CatHouseTutorialDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end

function CatHouseTutorialDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return CatHouseTutorialDialog