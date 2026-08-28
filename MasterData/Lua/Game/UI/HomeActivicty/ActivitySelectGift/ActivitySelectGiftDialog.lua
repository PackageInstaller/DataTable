--- from: Assets/BundleResources/Prefabs/HomeGift/GiftSelectDialog.prefab
---@class ActivitySelectGiftDialog
---@field Env                           	ActivitySelectGiftDialog
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field Content                       	UnityEngine.RectTransform
---@field MemberGroup                   	UnityEngine.RectTransform
---@field Cell                          	UnityEngine.RectTransform
---@field ButtonClose                   	UnityEngine.UI.Button
---@field block                         	UnityEngine.UI.Button
---@field VertContent                   	UnityEngine.RectTransform
---@field MemberBlock                   	UnityEngine.RectTransform
local ActivitySelectGiftDialog = Class("ActivitySelectGiftDialog")
local GameObject = CS.UnityEngine.GameObject
local UIModule = CS.Engine.UI.UIModule
local CoWait = CS.Engine.Lib.CoWait
local util = require 'XLua.util'
local KTool = CS.Engine.Lib.KTool
local cs_coroutine = require 'XLua.cs_coroutine'
local Yielders = CS.Engine.Lib.Yielders
local GachaponUtils = import('Game.Gachapon.GachaponUtils')
function ActivitySelectGiftDialog:__init()
    self.optionalGiftList = {}   -- 自选道理礼包列表
end
function ActivitySelectGiftDialog:__delete()
    self.optionalGiftList = nil
end

function ActivitySelectGiftDialog:Awake()
end

function ActivitySelectGiftDialog:OnShow()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:BindClick()
        self:UpdateUI()
    end))
    return coWait
end
function ActivitySelectGiftDialog:UpdateUI()
    cs_coroutine.start(function()
        GachaponUtils.ResizeContent(self.Content,#self.optionalGiftList,self.Cell)
        for i = 1 , #self.optionalGiftList do
            --local cell = GameObject.Instantiate(self.Cell , self.Content)
            local memberIns = self.Content:GetChild(i - 1)
            cs_coroutine.yield_return(Yielders.EndOfFrame)
            KTool.SetActive(memberIns,true)
            self:UpdateGoodCell(memberIns , i)
        end
        cs_coroutine.yield_return(Yielders.EndOfFrame)
        CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.VertContent.gameObject:GetComponent(typeof(CS.UnityEngine.RectTransform)))
    end)
end
function ActivitySelectGiftDialog:UpdateGoodCell(cell,index)
    local goodNode =  cell.gameObject.transform:Find("GoodNode")
    local env = GetLuaBehaviour(goodNode.gameObject, "Game.Behaviours.GoodNodeMB")
    if not isNull(env) then
        env:Init()
        if not isNull(env.Env) then
            env.Env:Reload({ goodsId = self.optionalGiftList[index].goodsId, isShowNo = true,
                             num = self.optionalGiftList[index].num,
                             text = string.format('x%d', self.optionalGiftList[index].num)  })

            env.Env:SetClickButtonAction(function(goodsId)
                --- 跳转到对应的
                UIModule.OpenDialog({ id = Constants.UITypeIds.OptionalGiftSelectRewardDialog,
                      parameters = {
                          giftId = self.optionalGiftList[index].goodsId,
                          giftNum = self.optionalGiftList[index].num
                      }
                })
            end)
        end
    end
end

function ActivitySelectGiftDialog:BindClick()
    SetButtonAction(self.ButtonClose, Bind(self, self.CloseClick))
end
function ActivitySelectGiftDialog:CloseClick()
    UIModule.BackDialog()
    -- 获取主界面的dialog
    ---@type Engine.UI.UILuaDialog
    local homeDialog = UIModule.CurrentScreen:GetDialog(Constants.UITypeIds.UIHomeView)
    if not isNull(homeDialog) then
        -- 判断主界面的dialog 是否可见
        ---@type UIHomeMain
        local uiHomeMain = homeDialog.Env
        uiHomeMain:SetBtnGiftActive()
    end
end

function ActivitySelectGiftDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
         self:GetOptionalList()
    end))
    return coWait
end

function ActivitySelectGiftDialog:GetOptionalList()
    self.optionalGiftList = GoodsUtils.GetGoodsByType(Constants.IDType.OptionalGift)
    local settingMgr = SettingMgr:GetInstance()
    ---@type BaseSetting
    local goodsOptionalGiftSet = settingMgr:GetSetting(AutoIds.IdSetting123, "GoodsOptionalGiftVo")
    for index, goodsData in pairs(self.optionalGiftList) do
        ---@type GoodsOptionalGiftVo
        local goodsOptionalGiftVo = goodsOptionalGiftSet:Get(goodsData.goodsId)
        goodsData.quality = goodsOptionalGiftVo.quality
    end
    if self.optionalGiftList and #self.optionalGiftList > 0 then
        table.sort(self.optionalGiftList,function(aGooddData , bGoodsData)
            if aGooddData.quality < bGoodsData.quality then
                return false
            elseif aGooddData.quality ==  bGoodsData.quality then
                if aGooddData.goodsId < bGoodsData.goodsId then
                    return false
                end
            end
            return true
        end)
    end
end

function ActivitySelectGiftDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end
return ActivitySelectGiftDialog