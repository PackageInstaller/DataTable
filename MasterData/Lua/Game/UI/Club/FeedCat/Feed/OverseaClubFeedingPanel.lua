---@type OverseaClubFeedCatMgr
local Mgr = import("Game.UI.Club.FeedCat.OverseaClubFeedCatMgr"):GetInstance()
---@type OverseaClubFeedCatUtils
local Utils = import("Game.UI.Club.FeedCat.OverseaClubFeedCatUtils")

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubFeedingDialog.prefab > name: OverseaClubFeedingDialog
---@class OverseaClubFeedingPanel
---@field Env                           	OverseaClubFeedingPanel                 
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Root                          	UnityEngine.RectTransform               	@ 0    
---@field TxtTitle                      	UnityEngine.RectTransform               	@ 1    
---@field BtnView                       	UnityEngine.RectTransform               	@ 2    
---@field LvProgressBar                 	UnityEngine.UI.Slider                   	@ 3    
---@field ExpFill                       	Game.Native.Common.UISwitchImage        	@ 4    
---@field TextExpNum                    	UnityEngine.RectTransform               	@ 5    
---@field TextLv                        	UnityEngine.RectTransform               	@ 6    
---@field FoodFill                      	UnityEngine.UI.Image                    	@ 7    
---@field VFXFood                       	UnityEngine.RectTransform               	@ 8    
---@field BtnGVG                        	UnityEngine.RectTransform               	@ 9    
---@field TextHungerNum                 	UnityEngine.RectTransform               	@ 10   
---@field TextClubPoint                 	UnityEngine.RectTransform               	@ 11   
---@field TextClubExp                   	UnityEngine.RectTransform               	@ 12   
---@field BtnAdd                        	UnityEngine.RectTransform               	@ 13   
---@field IconFood                      	UnityEngine.RectTransform               	@ 14   
---@field GoodNodeFood                  	UnityEngine.RectTransform               	@ 15   
---@field QuantitySlider                	UnityEngine.RectTransform               	@ 16   
---@field TextFeedLimit                 	UnityEngine.RectTransform               	@ 17   
---@field BtnFeed                       	UnityEngine.RectTransform               	@ 18   
---@field OverseaClubFeedingTipPopup    	Engine.Modules.LuaBehaviour             	@ 19   
local OverseaClubFeedingPanel = Class("OverseaClubFeedingPanel")

function OverseaClubFeedingPanel:__init()
    self.controller = nil
    self.chooseFoodId = 0
    self.chooseFoodCount = 0
    self.events = CfUtils.EventsDecorated({ 
        [ClubUtils.EventName.FeedCat_ChooseFood] = Bind(self,self.ChooseFoodEventHandle),
    })
end

function OverseaClubFeedingPanel:__delete()
    self.controller = nil
    CfUtils.EventsUndecorated(self.events)
end

function OverseaClubFeedingPanel:Awake()
    SetButtonAction(self.BtnView, function()
        CfUtils.DialogOpen(Constants.UITypeIds.OverseaClubFeedingStagePopup)
    end)
    SetButtonAction(self.BtnGVG, function()
        CfUtils.SetActive(self.OverseaClubFeedingTipPopup, true)
    end)
    local vo = CfUtils.SystemToggleVo( Constants.SystemToggleIds.Id4006)

    --TODO 暂时直接隐藏
    --if vo and checkNumber(vo.switch) == Constants.ModelFunctionSwitch.Off then
    if true then
        CfUtils.SetActive(self.BtnGVG, false)
    end
    
    SetButtonAction(self.BtnAdd, Bind(self,self.OnAddClick))
    SetButtonAction(self.BtnFeed, Bind(self,self.OnFeedClick))
    
    ---@type CommonSliderNode
    self.slider = CfUtils.GetLuaScr(self.QuantitySlider, "Game.UI.Common.CommonSliderNode")
    self.slider:RefreshNode(0,0,0,nil)
end

function OverseaClubFeedingPanel:Show(flag)
    CfUtils.SetActive(self.controller,flag)
    if flag then
        self:RefreshUI()
    end
end

function OverseaClubFeedingPanel:GetTotalExp(level)
    local totalExp = 0
    for i = 1, level do
        local row = Utils.GetExpVo(i)
        if row then
            totalExp = totalExp + row.consNum    
        end
    end
    return totalExp
end

function OverseaClubFeedingPanel:RefreshUI()
    local dojo = Mgr.Server.dojo
    --经验值
    local levelRow = Utils.GetExpVo(dojo.petsLevel)
    local levelUpExp = self:GetTotalExp(dojo.petsLevel + 1)
    local exp = checkNumber(dojo.petsExp)
    
    --饱食度
    local satietyLimit = levelRow.catSatiety
    satietyLimit = satietyLimit == 0 and 1 or satietyLimit
    local satiety = checkNumber(dojo.petsSatiety)
    
    --社团积分,社团经验
    local clubPoint = 0
    local clubExp = 0

    --投喂次数
    local maxFeedNum = checkNumber(Utils.GetParamValue(Utils.ParamsId.MaxFeedCount))
    local remainFeedNum = maxFeedNum - Mgr.Server.dojo.petsFeedTimes

    if self.chooseFoodId ~= 0 then
        local foodRow = Utils.GetFoodVo(self.chooseFoodId)
        if foodRow then
            exp = exp + foodRow.catExp * self.chooseFoodCount
            satiety = satiety + foodRow.catSatiety * self.chooseFoodCount
            satiety = satiety > satietyLimit and satietyLimit or satiety

            if Mgr:IsLikeFood(foodRow.id) then
                clubExp = foodRow.likeClubExp * self.chooseFoodCount
                clubPoint = foodRow.likeClubIntegral * self.chooseFoodCount
            else
                clubPoint = foodRow.clubIntegral * self.chooseFoodCount
                clubExp = foodRow.clubExp * self.chooseFoodCount
            end

            CfUtils.SetActive(self.IconFood, true)
            CfUtils.RefeshGoodGo2(self.GoodNodeFood, self.chooseFoodId, self.chooseFoodCount,nil,nil,Bind(self,self.OnAddClick))
            CfUtils.SetUISwitchImage(self.ExpFill, 2)
            

            
            local ownNum = GoodsUtils.GetThingNo(self.chooseFoodId)
            local maxNum = remainFeedNum > ownNum and ownNum or remainFeedNum
            self.slider:RefreshNode(self.chooseFoodCount,0, maxNum,function(value)
                self.chooseFoodCount = value
                self:RefreshUI()
            end)
        end
    else
        CfUtils.SetActive(self.IconFood, false)
        CfUtils.SetUISwitchImage(self.ExpFill, 1)
        CfUtils.SetActive(self.VFXFood, false)
        self.slider:RefreshNode(0,0, 0,nil)
    end

    if satiety >= satietyLimit then
        CfUtils.SetActive(self.VFXFood, true)
    else
        CfUtils.SetActive(self.VFXFood, false)
    end

    local vo = Utils.GetPhaseVo(Mgr.Server.dojo.petsPhase)
    CfUtils.FillText(self.TxtTitle,vo.title)
    self.LvProgressBar.value = exp / levelUpExp
    CfUtils.FillText(self.TextExpNum, string.format("<#FF16A9>%s</color>/%s", exp, levelUpExp))
    CfUtils.FillText(self.TextLv, "Lv."..dojo.petsLevel)
    self.FoodFill.fillAmount = satiety / satietyLimit
    CfUtils.FillText(self.TextHungerNum, string.format("<#FF16A9>%s</color>/%s", satiety, satietyLimit))
    CfUtils.FillText(self.TextClubPoint, clubPoint)
    CfUtils.FillText(self.TextClubExp, clubExp)
    CfUtils.FillText(self.TextFeedLimit, localize("今日剩余投喂次数：_remain_/_max_", {_remain_ = remainFeedNum, _max_ = maxFeedNum}))
    self.remainFeedNum = remainFeedNum
    if remainFeedNum == 0 then
        CfUtils.SetButtonStyle(self.BtnFeed,"B17","")    
    end
    
    --TODO 社团积分tips
    --local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(Constants.Currency.ClubCoin)
    --GameUtils.ShowCommonTipsBoard(self.BtnFeed,goodsVo.name,goodsVo.desc,goodsVo.quality,goodsVo.id)
end

function OverseaClubFeedingPanel:OnAddClick()
    CfUtils.DialogOpen(Constants.UITypeIds.OverseaClubFeedingFoodPopup)
end

function OverseaClubFeedingPanel:OnFeedClick()
    if checkNumber(self.remainFeedNum) == 0 then
        return
    end
    
    if self.chooseFoodId == 0 then
        self:OnAddClick()
        return
    end

    if self.chooseFoodCount == 0 then 
        localize("请选择投喂数量")
        return
    end
    
    Mgr.Server:ReqFeedCat(self.chooseFoodId, self.chooseFoodCount, function()
        self.chooseFoodId = 0
        self.chooseFoodCount = 0
        self:RefreshUI()
    end)
end

function OverseaClubFeedingPanel:ChooseFoodEventHandle(foodId)
    self.chooseFoodId = foodId
    self.chooseFoodCount = 1
    self:RefreshUI()
end

function OverseaClubFeedingPanel:OnDestroy()
    self:Delete()
end

return OverseaClubFeedingPanel