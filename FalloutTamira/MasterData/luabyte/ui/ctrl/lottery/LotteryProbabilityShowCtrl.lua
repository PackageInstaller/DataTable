local LotteryProbabilityShowCtrl = BaseClass("LotteryProbabilityShowCtrl" ,BaseUICtrl )
local M = LotteryProbabilityShowCtrl
local tInsert = table.insert

function M:Init()
    self:AddListener()
end

function M:AddListener()
    self._view.BG:onClick(Bind(self,self._OnClickBG))
    self._view.Btn_Home:onClick(Bind(self, self.ReturnMainUI))
end

function M:OnEnter(cardPoolId)
    self:Show(cardPoolId)
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true 
end

function M:Show(cardPoolId)
    local cardPoolData = ConfigHelper.GetCfg("cardPool",cardPoolId)
    local isHeroPool = cardPoolId <= 9000 --ID小于9000的是英雄抽卡 大9000的是礼物抽卡
    if isHeroPool then --英雄抽卡/礼物抽卡显示的文本不一样
        self._view.tiptext:SetText(ConfigHelper.GetLocalString(549))
    else
        self._view.tiptext:SetText(ConfigHelper.GetLocalString(548))
    end

    local allDic = {}

    if cardPoolData ~= nil then
        for index, value in ipairs(cardPoolData.publicityItem) do
            local item = ConfigHelper.GetCfg("item",value)

            if allDic[item.quality] == nil  then
                allDic[item.quality] = {}
            end


            allDic[item.quality].Probability = cardPoolData.publicityProbability[index]
            
            if cardPoolData.probabilityUp[index] ~= nil and cardPoolData.probabilityUp[index] ~= 0 then
                if allDic[item.quality].upList == nil then 
                    allDic[item.quality].upList = {}
                end
                tInsert(allDic[item.quality].upList,item.id)
                 
            else
                if allDic[item.quality].normalList == nil then 
                    allDic[item.quality].normalList = {}
                end
                tInsert(allDic[item.quality].normalList,item.id)
            end
        end

        --排序
        local KeyList = {}
        for key, value in pairs(allDic) do --value 同品级下的的东西
            if not table.indexof(KeyList,key) then
                tInsert(KeyList,key)
            end
        end

       table.sort(KeyList,
       function(a,b)
        return a>b
       end
       )

        if isHeroPool then --英雄抽卡
            --实例化UI
            for i=1 ,#KeyList do
                local item =allDic[KeyList[i]]
                self:GetProbabilityHeroView():Init(KeyList[i] , item.Probability,item.upList ,item.normalList)
            end
        else --道具抽卡
            for i=1 ,#KeyList do
                local item =allDic[KeyList[i]]
                self:GetProbabilitySpItemView():Init(KeyList[i] , item.Probability,item.upList ,item.normalList)
            end
        end

        self._view.layout:RefLayout()

    end
end



-- function M:Show(cardPoolId)
--     local cardPoolData = ConfigHelper.GetCfg("cardPool",cardPoolId)
--     if cardPoolId > 9000 then --英雄抽卡/礼物抽卡显示的文本不一样
--         self._view.tiptext:SetText(ConfigHelper.GetLocalString(548))
--     else
--         self._view.tiptext:SetText(ConfigHelper.GetLocalString(549))
--     end

--     local upDic = {}
--     local noUpDic = {}

--     if cardPoolData ~= nil then
--         for index, value in ipairs(cardPoolData.publicityItem) do
--             local item = ConfigHelper.GetCfg("item",value)
--             local targetDic = {}
--             if cardPoolData.probabilityUp[index] ~= nil and cardPoolData.probabilityUp[index] ~= 0 then
--                 targetDic = upDic
--             else
--                 targetDic = noUpDic
--             end

--             -- if not table.indexof(targetDic,item.quality)  then
--             if targetDic[item.quality] == nil  then
--                 targetDic[item.quality] = {}
--             end

--             if targetDic[item.quality][cardPoolData.publicityProbability[index]] == nil then
--                 targetDic[item.quality][cardPoolData.publicityProbability[index]] = {}
--             end

--             local datalist = targetDic[item.quality][cardPoolData.publicityProbability[index]]
--             tInsert(datalist,item.id)
--             targetDic[item.quality][cardPoolData.publicityProbability[index]] = datalist
--         end

--         --排序
--         local UpdicKeyList = {}
--         for key, value in pairs(upDic) do --value 同品级下的的东西
--             if not table.indexof(UpdicKeyList,key) then
--                 tInsert(UpdicKeyList,key)
--             end
--         end

--        table.sort(UpdicKeyList,
--        function(a,b)
--         return a>b
--        end
--        )

--        local NoUpdicKeyList = {}
--        for key, value in pairs(noUpDic) do --value 同品级下的的东西
--            if not table.indexof(NoUpdicKeyList,key) then
--                tInsert(NoUpdicKeyList,key)
--            end
--        end

--       table.sort(NoUpdicKeyList,
--       function(a,b)
--        return a>b
--       end
--       )


--         --实例化UI
--         for i=1 ,#UpdicKeyList do
--             for k, v in pairs(upDic[UpdicKeyList[i]]) do  --V 同概率下的东西
--                 self:GetTitleView():Init(UpdicKeyList[i],k)
--                 self:GetProbabilityHeroView():Init(v)
--             end
--         end

--         for i=1 ,#NoUpdicKeyList do
--             for k, v in pairs(noUpDic[NoUpdicKeyList[i]]) do
--                 self:GetTitleView():Init(NoUpdicKeyList[i],k)
--                 self:GetProbabilityItemView():Init(v)
--             end
--         end

--         -- for key, value in pairs(upDic) do --value 同品级下的的东西
--         --     for k, v in pairs(value) do  --V 同概率下的东西
--         --         self:GetTitleView():Init(key,k)
--         --         self:GetProbabilityHeroView():Init(v)
--         --     end
--         -- end

--         -- for key, value in pairs(noUpDic) do
--         --     for k, v in pairs(value) do
--         --         self:GetTitleView():Init(key,k)
--         --         self:GetProbabilityItemView():Init(v)
--         --     end
--         -- end

--         self._view.layout:RefLayout()

--     end
-- end

function M:_OnClickBG(go)
    self:Close()
end

function M:GetTitleView()
    -- local titleCtr = require("UI.Ctrl.Lottery.LotteryProbabilityTitleCtrl")
    local titleView = self._view.titlePrefab:Instantiate()
    titleView.gameObject.transform:SetParent(self._view.titlePrefab.gameObject.transform.parent)
    titleView.gameObject.transform.localPosition = self._view.titlePrefab.gameObject.transform.localPosition
    titleView.gameObject.transform.localScale = self._view.titlePrefab.gameObject.transform.localScale
    --titleCtr.New(titleView)
    return titleView
end

function M:GetProbabilityHeroView()
    --local HeroCtr = require("UI.Ctrl.Lottery.LotteryProbabilityHero")
    local HeroView = self._view.ProbabilityHero:Instantiate()
    HeroView.gameObject.transform:SetParent(self._view.ProbabilityHero.gameObject.transform.parent)
    HeroView.gameObject.transform.localPosition = self._view.ProbabilityHero.gameObject.transform.localPosition
    HeroView.gameObject.transform.localScale = self._view.ProbabilityHero.gameObject.transform.localScale
    --HeroCtr.New(HeroView)
    return HeroView
end

function M:GetProbabilityItemView()
    --local itemCtr = require("UI.Ctrl.Lottery.LotteryProbabilityItem")
    local itemView = self._view.ProbabilityItem:Instantiate()
    itemView.gameObject.transform:SetParent(self._view.ProbabilityItem.gameObject.transform.parent)
    itemView.gameObject.transform.localPosition = self._view.ProbabilityItem.gameObject.transform.localPosition
    itemView.gameObject.transform.localScale = self._view.ProbabilityItem.gameObject.transform.localScale
    --itemCtr.New(itemView)
    return itemView
end

function M:GetProbabilitySpItemView()
    local itemView = self._view.ProbabilitySpItem:Instantiate()
    itemView.gameObject.transform:SetParent(self._view.ProbabilitySpItem.gameObject.transform.parent)
    itemView.gameObject.transform.localPosition = self._view.ProbabilitySpItem.gameObject.transform.localPosition
    itemView.gameObject.transform.localScale = self._view.ProbabilitySpItem.gameObject.transform.localScale
    return itemView
end




return LotteryProbabilityShowCtrl 