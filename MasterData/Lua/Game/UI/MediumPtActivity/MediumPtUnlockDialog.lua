---
--- Created by Eric.
--- DateTime: 2022/6/10 11:42
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local MediumPTActivityComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.MediumPTActivityComponent)

------------ import ------------

------------ define ------------

------------ define ------------


--- from: Assets/BundleResources/Prefabs/MediumPt/MediumPtUnlockDialog.prefab
---@class MediumPtUnlockDialog
---@field Env                           	MediumPtUnlockDialog
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ImgRole                       	Engine.UI.RawImageAlterable
---@field TxtNumber                     	UnityEngine.UI.Text
---@field ImgCoin                       	Engine.UI.ImageAlterable
---@field ExpendGroup                   	UnityEngine.RectTransform
---@field CommonBtnConsumePop           	UnityEngine.RectTransform
---@field BtnUnlock                     	UnityEngine.RectTransform
---@field MaxNumber                     	TMPro.TextMeshProUGUI
---@field NowNumber                     	TMPro.TextMeshProUGUI
---@field TxtTittle                     	UnityEngine.UI.Text
---@field BtnClose                      	UnityEngine.RectTransform
local MediumPtUnlockDialog = Class("MediumPtUnlockDialog")
function MediumPtUnlockDialog:__init()
    self.plotLuaIndex = nil
    self.plotDataList = {}
    self.pos = nil
end

function MediumPtUnlockDialog:__delete()
    self.plotLuaIndex = nil
    self.plotDataList = nil
    self.pos = nil

    self.controller = nil
end

function MediumPtUnlockDialog:Awake()
    local parameters = self.controller.Argument.parameters
    self.EventPlotPlay = Events.AddListener(Constants.EventNames.IsPlotPlaying, Bind(self, self.PlotPlaying))

    if not isNull(parameters) then
        self.plotLuaIndex = clone(parameters.plotLuaIndex)
        self.plotDataList = clone(parameters.plotDataList)
        self.pos = clone(parameters.pos)
        self:FreshBaseUI()
    end
end

function MediumPtUnlockDialog:PlotPlaying(isPlotPlaying)
    KTool.SetActive(self.controller.gameObject, not isPlotPlaying)
end

function MediumPtUnlockDialog:FreshBaseUI()
    local isInReview = MediumPTActivityComponent:IsInReview()

    SetButtonAction(self.BtnClose, function()
        UIModule.BackDialog()
    end)
    local plotData = self.plotDataList[self.plotLuaIndex]
    if isInReview then
        plotData.unlockItem = 0
    end
    self.TxtTittle.text = plotData.plotDesc
    self.NowNumber.text = self.plotLuaIndex
    self.MaxNumber.text = #self.plotDataList
    local isNoConsume = checkNumber(plotData.unlockItem) == 0
    KTool.SetActive(self.CommonBtnConsumePop, not isNoConsume)

    if not isNoConsume then
        CfUtils.FillCommonBtnConsumePopNode(self.CommonBtnConsumePop.gameObject, plotData.unlockItem, checkNumber(plotData.unlockNum))

        --local currencyVo = GoodsConfMgr:GetGoodsVoById(plotData.unlockItem)
        --CfUtils.FillImage(self.ImgCoin, currencyVo.photoPath)
        --CfUtils.FillText(self.TxtNumber, plotData.unlockNum)
    end
    SetButtonAction(self.BtnUnlock, function()
        local isEnd = MediumPTActivityComponent:IsEnd()
        if isEnd then
            GameUtils.Toast(localize("活动已结束"))
            return
        end

        local canUnlock
        if isNoConsume then
            canUnlock = true
        else
            local hasNum = GoodsUtils.GetThingNo(plotData.unlockItem)
            canUnlock = hasNum >= checkNumber(plotData.unlockNum)
        end
        if canUnlock then
            if isInReview then
                MediumPTActivityComponent:EnterPlotNoReq(self.pos, plotData.id, function ()
                    Events.Broadcast(Constants.EventNames.MediumPtMainPlot)
                end ,
                        function ()
                            UIModule.BackDialog()
                        end)
            else
                MediumPTActivityComponent:EnterPlot(self.pos, plotData.id, function ()
                    if not isNoConsume then
                        GoodsUtils.ConsumeGoods({
                            {
                                goodsId = plotData.unlockItem,
                                goodsNum = plotData.unlockNum
                            }
                        })
                    end
                end ,
                        function ()
                            Events.Broadcast(Constants.EventNames.MediumPtMainPlot)
                            UIModule.BackDialog()
                        end)
            end
        else
            local currencyVo = GoodsConfMgr:GetGoodsVoById(plotData.unlockItem)
            GameUtils.Toast(localize("_name_不足",{_name_ = currencyVo.name}))
        end
    end)
    self.ImgRole:LoadSprite(plotData.plotImage)
end


function MediumPtUnlockDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end

function MediumPtUnlockDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        Events.RemoveListener(Constants.EventNames.IsPlotPlaying, self.EventPlotPlay)
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return MediumPtUnlockDialog