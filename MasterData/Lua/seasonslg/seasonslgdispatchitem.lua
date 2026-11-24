require("SeasonSLG/EventPopUp/HeroHeadItem")
SeasonSLGDispatchItem = {};

SeasonSLGDispatchItem.__index = SeasonSLGDispatchItem;

local objs = {
    txtTitle = { path = "Group/title", type = "Text" },
    rateText = { path = "Group/rateBg/rateText", type = "Text" },
    heroList = { path = "Group/heroList", type = "RectTransform" },
    godisPatchTime = { path = "Group/timeBG", type = "GameObject" },
    disPatchTimeText = { path = "Group/timeBG/disPatchTime", type = "Text" },
    btnAction = { path = "Group/actionbutton", type = "Button" },
    goSelectBtn = { path = "Group/actionbutton/SelectBtn", type = "GameObject" },
    goDispatchBtn = { path = "Group/actionbutton/DispatchBtn", type = "GameObject" },
    goReciveRewardBtn = { path = "Group/actionbutton/ReciveRewardBtn", type = "GameObject" },
    goHeadItem = { path = "Group/template/headItem", type = "GameObject" },
    resourceCount_Icon = { path = "Group/resourceCount/icon", type = "RawImage" },
    resourceCount_Text = { path = "Group/resourceCount/Text", type = "Text" },
    needLevelText = { path = "Group/needLevel", type = "Text" },
    needHeroCount = { path = "Group/needHeroCount", type = "Text" },
    deletePatchingBtn = { path = "Group/timeBG/DeletePatchingBtn", type = "Button" },
    disPatchCostText = { path = "Group/actionbutton/disPatchCostText", type = "Text" },
};

local function SetText(text, value)
    if text ~= nil then
        text.text = value or "";
    end
end

function SeasonSLGDispatchItem.New()
    local self = {};
    setmetatable(self, SeasonSLGDispatchItem);
    self.onClick = nil;
    self.LocHeroCallBack = function()
        self:OpenChooseHero()
    end
    return self;
end

function SeasonSLGDispatchItem:CheckIsHeroPatched(members)
    local havingpatched = false
    local fillterMmbers = {}
    for i=1, #members do
        local characterId = members[i]
        if SeasonSLGMapMgr.CheckCharacterIsDispatching(characterId) then
            havingpatched = true
        else
            table.insert(fillterMmbers, characterId)
        end
    end

    return havingpatched, fillterMmbers
end

function SeasonSLGDispatchItem:GetHeroNormalLevelInfo(normalLevel, normalLevelReward)
    local levelInfo = {}
    local levelCount = #normalLevel
    local levelRewardCount = #normalLevelReward
    for i=1, levelCount do
        local levelLimit = {}
        local nextIdx = i+1
        levelLimit.minLevel = tonumber(normalLevel[i])
        if nextIdx<=levelCount then
            levelLimit.maxLevel = tonumber(normalLevel[nextIdx])
        end
        table.insert(levelInfo, levelLimit)
    end

    for i=1, levelRewardCount do
        if i<=levelCount then
            levelInfo[i].extralProduct = normalLevelReward[i]
        end
    end

    return levelInfo
end

function SeasonSLGDispatchItem:GetHeroLevelCfgInfo(cfgLevel, cfgLevelReward)
    local levelInfo = {}
    local levelCount = #cfgLevel
    local levelRewardCount = #cfgLevelReward
    for i=1, levelCount do
        local levelLimit = {}
        local nextIdx = i+1
        levelLimit.minLevel = tonumber(cfgLevel[i])
        if nextIdx<=levelCount then
            levelLimit.maxLevel = tonumber(cfgLevel[nextIdx])
        end
        table.insert(levelInfo, levelLimit)
    end

    for i=1, levelRewardCount do
        if i<=levelCount then
            levelInfo[i].extralProduct = cfgLevelReward[i]
        end
    end

    return levelInfo
end

function SeasonSLGDispatchItem:GetHeroQualityCfgInf(cfgQuality, cfgQualityReward)
    local qualityInfo = {}
    local qualityCount = #cfgQuality
    local qualityRewardCount = #cfgQualityReward
    for i=1, qualityCount do
        local qualityTemp = {}
        qualityTemp.quality = tonumber(cfgQuality[i])
        table.insert(qualityInfo, qualityTemp)
    end

    for i = 1, qualityRewardCount do
        if i<=qualityCount then
            qualityInfo[i].extralProduct = cfgQualityReward[i]
        end
    end

    return qualityInfo
end

function SeasonSLGDispatchItem:GetLevelExtralProduct(heroLevel, levelInfo)
    if IsNull(levelInfo) then
        return
    end
    for i=1, #levelInfo do
        if heroLevel >= levelInfo[i].minLevel then
            if levelInfo[i].maxLevel == nil then
                return levelInfo[i].extralProduct
            else
                if heroLevel < levelInfo[i].maxLevel then
                    return levelInfo[i].extralProduct
                end
            end
        end
    end
end

function SeasonSLGDispatchItem:GetHeroQualityProduct(quality, qualityInfo)
    if IsNull(qualityInfo) then
        return
    end
    for i=1, #qualityInfo do
        if quality == qualityInfo[i].quality then
            return qualityInfo[i].extralProduct
        end
    end
end

function SeasonSLGDispatchItem:GetResourcePatchBaseProduct(functionKey)
    local produceBaseInfo = {}
    local cfgGirdRes=ConfigMgr.Config.SeasonalGridResourceMap[functionKey];
    if IsNull(cfgGirdRes) then
        return produceBaseInfo
    end
    local resourceLevelConfig = ConfigMgr.Config.SeasonalGridResourceLevelMap[cfgGirdRes.Level[1]]
    if IsNull(resourceLevelConfig) then
        return produceBaseInfo
    end

    if self.normalLevelInf == nil then
        self.normalLevelInf = self:GetHeroLevelCfgInfo(resourceLevelConfig.ExtraLevel, resourceLevelConfig.ExtraLevelReward)
    end
    if self.seasonLevelInf == nil then
        self.seasonLevelInf = self:GetHeroLevelCfgInfo(resourceLevelConfig.ExtraSeasonalLevel, resourceLevelConfig.ExtraSeasonalLevelReward)
    end
    if self.qualityInf == nil then
        self.qualityInf = self:GetHeroQualityCfgInf(resourceLevelConfig.Rare, resourceLevelConfig.RareReward)
    end
    local extraProduct = {}
    if self.chooseMembers ~= nil and #self.chooseMembers>0 then
        for i=1, #self.chooseMembers do
            local heroId = self.chooseMembers[i]
            local heroLevel = DataMgr.Player.characters[heroId].level
            local seasonLevel = SeasonSLGMapMgr.GetCharacterSeasonLevel(heroId)
            local characterConfig = ConfigMgr.Config.characterTable[heroId]
            local heroQuality = characterConfig.rare

            local levelProduct = self:GetLevelExtralProduct(heroLevel, self.normalLevelInf)
            if levelProduct ~= nil then
                table.insert(extraProduct, levelProduct)
            end

            local seasonLevelProduct = self:GetLevelExtralProduct(seasonLevel, self.seasonLevelInf)
            if seasonLevelProduct ~= nil then
                table.insert(extraProduct, seasonLevelProduct)
            end

            local qualityProduct = self:GetHeroQualityProduct(heroQuality, self.qualityInf)
            if qualityProduct~=nil then
                table.insert(extraProduct, qualityProduct)
            end
        end
    end

    for i=1, #resourceLevelConfig.ProduceSweep do
        local produceTemp = table.Copy(resourceLevelConfig.ProduceSweep[i])
        for idx=1, #extraProduct do
            if produceTemp.id == extraProduct[idx].id then
                produceTemp.count = produceTemp.count + extraProduct[idx].count
            end
        end

        table.insert(produceBaseInfo, produceTemp)
    end
    return produceBaseInfo
end

function SeasonSLGDispatchItem:GetWorldPatchBaseProduct(functionKey)
    local produceBaseInfo = {}
    local wordDispatch=ConfigMgr.Config.SeasonalGridWorldGuardMap[functionKey]
    if IsNull(wordDispatch) then
        return produceBaseInfo
    end
    if self.normalLevelInf == nil then
        self.normalLevelInf = self:GetHeroLevelCfgInfo(wordDispatch.Level, wordDispatch.HourlyProduce1)
    end
    if self.seasonLevelInf == nil then
        self.seasonLevelInf = self:GetHeroLevelCfgInfo(wordDispatch.SeasonLevel, wordDispatch.HourlyProduce2)
    end
    if self.qualityInf == nil then
        self.qualityInf = self:GetHeroQualityCfgInf(wordDispatch.Rare, wordDispatch.RareReward)
    end
    local extraProduct = {}
    if self.chooseMembers ~= nil and #self.chooseMembers>0 then
        for i=1, #self.chooseMembers do
            local heroId = self.chooseMembers[i]
            local heroLevel = DataMgr.Player.characters[heroId].level
            local seasonLevel = SeasonSLGMapMgr.GetCharacterSeasonLevel(heroId)
            local characterConfig = ConfigMgr.Config.characterTable[heroId]
            local heroQuality = characterConfig.rare

            local levelProduct = self:GetLevelExtralProduct(heroLevel, self.normalLevelInf)
            if levelProduct ~= nil then
                table.insert(extraProduct, levelProduct)
            end

            local seasonLevelProduct = self:GetLevelExtralProduct(seasonLevel, self.seasonLevelInf)
            if seasonLevelProduct ~= nil then
                table.insert(extraProduct, seasonLevelProduct)
            end

            local qualityProduct = self:GetHeroQualityProduct(heroQuality, self.qualityInf)
            if qualityProduct~=nil then
                table.insert(extraProduct, qualityProduct)
            end
        end
    end




    local defaultRareProduce = {}
    local rareProductItem=wordDispatch.RareReward[1]
    if defaultRareProduce[rareProductItem.id]==nil then
        defaultRareProduce[rareProductItem.id]={id=rareProductItem.id,count=0};
    end
    defaultRareProduce[rareProductItem.id].count=defaultRareProduce[rareProductItem.id].count+rareProductItem.count;
    local addProducts = {
        SeasonSLGEventMgr.GetProductAddByHeroLevel(self.chooseMembers or {}, wordDispatch.Level, wordDispatch.HourlyProduce1),
        SeasonSLGEventMgr.GetProductAddByHeroSeasonLevel(self.chooseMembers or {}, wordDispatch.SeasonLevel, wordDispatch.HourlyProduce2),
        (self.chooseMembers ~= nil and #self.chooseMembers > 0)
                and SeasonSLGEventMgr.GetProductAddByHeroRareLevel(self.chooseMembers or {}, wordDispatch.Rare, wordDispatch.RareReward)
                or defaultRareProduce,
    }
    local addMap = {}
    for i = 1, #addProducts do
        for _, productItem in pairs(addProducts[i]) do
            if productItem ~= nil and productItem.id ~= nil then
                if addMap[productItem.id] == nil then
                    addMap[productItem.id] = { id = productItem.id, count = 0 }
                    table.insert(produceBaseInfo, addMap[productItem.id])
                end
                addMap[productItem.id].count = addMap[productItem.id].count + productItem.count
            end
        end
    end













    return produceBaseInfo
end


function SeasonSLGDispatchItem:UpdateResourceCount()
    local resourceCount = 0
    local rateValue = 0
    if self.data.funcType == "10" then

        rateValue = self:GetWorldProduceBuffRate()
    else

        rateValue = self:GetProduceRate()
    end
    local productBase = 0
    if self.data.funcType == "10" then
        productBase = self:GetWorldPatchBaseProduct(self.data.funcKeyId)
    elseif self.data.funcType == "4" then
        productBase = self:GetResourcePatchBaseProduct(self.data.funcKeyId)
    end
    if #productBase > 0 then
        resourceCount = productBase[1].count
    end
    if self.data.funcType == "10" then

        resourceCount = math.floor(resourceCount * (1 + rateValue / 10000))
    else

        resourceCount = resourceCount + resourceCount * rateValue/10000
    end
    self.resourceCount_Text.text = string.format(LuaMgr.GetLangText("SeasonSLGDispatchItem_0"), resourceCount, rateValue/100)
    if self.chooseTime ~= nil then
        local chooseHour = tonumber(self.chooseTime)
        for k,v in pairs(self.data.dispatchNeedItem) do
            local needItemId = v.id
            local needCountPerHour = v.count
            local configData = ConfigMgr.Config.itemMap[needItemId]
            if not IsNull(configData) then
                local itemName = LuaMgr.GetLangText(configData.nameLan)
                local haveDestItemCount = DataHelper.GetItemCountById(needItemId)
                local needItemCount = chooseHour * needCountPerHour
                if needItemCount > haveDestItemCount then
                    self.disPatchCostText.text = string.format(LuaMgr.GetLangText("SeasonSLGDispatchItem_1"), itemName,needItemCount)
                else
                    self.disPatchCostText.text = string.format(LuaMgr.GetLangText("SeasonSLGDispatchItem_2"), itemName,needItemCount)
                end
                break
            end
        end
    end

end

function SeasonSLGDispatchItem:IsCanDispatch()
    if self.chooseTime == nil then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSLGDispatchItem_3"))
        return false
    end
    local isPatched, fillterMembers = self:CheckIsHeroPatched(self.chooseMembers)
    if isPatched then
        self.chooseMembers = fillterMembers
        self:OpenChooseHero()
        self:RefreshSelectMembers(self.chooseMembers)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSLGDispatchItem_4"))
        return false
    end
    if #self.chooseMembers<self.data.patchHeroCountMin then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(LuaMgr.GetLangText("SeasonSLGDispatchItem_5"), self.data.patchHeroCountMin))
        return false
    end
    local chooseHour = tonumber(self.chooseTime)
    for k,v in pairs(self.data.dispatchNeedItem) do
        local needItemId = v.id
        local needCountPerHour = v.count
        local haveDestItemCount = DataHelper.GetItemCountById(needItemId)
        local needItemCount = chooseHour * needCountPerHour
        if needItemCount > haveDestItemCount then
            local configData = ConfigMgr.Config.itemMap[needItemId]
            local itemName = LuaMgr.GetLangText(configData.nameLan)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(LuaMgr.GetLangText("SeasonSLGDispatchItem_6"), itemName))
            return false
        end
    end
    return true
end

function SeasonSLGDispatchItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.dispatchLocUIList=UIListView.New(self.heroList)
    self.isListenEvent = false
    self.produceItemId = ""
    self.RefreshDownTime = function()
        self:RefreshDispatchTimeText()
    end
    self.onClick = function()
        if self.data ~= nil and self.data.callBack ~= nil then
            self.data.callBack(self.data);
        end
        local dispatchStatus = SeasonSLGEventMgr.GetDisPatchStatus(self.data.dispatchInfo.Members, self.data.dispatchInfo.ProduceTime)
        if dispatchStatus == SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_No then

            local isCurrentGridMisinter = SeasonSLGMapMgr.CheckGridConditionType(self.data.gridId,SeasonSLGMapMgr.RecommendConditionKey.Misinter)
            if isCurrentGridMisinter then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35150"))
                return
            end
            if self.chooseMembers ~= nil and #self.chooseMembers>0 then
                local isPatched, fillterMembers = self:CheckIsHeroPatched(self.chooseMembers)
                if isPatched then
                    self.chooseMembers = fillterMembers
                    self:OpenChooseHero()
                    self:RefreshSelectMembers(self.chooseMembers)
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSLGDispatchItem_7"))
                    return false
                end


                if not self:IsCanDispatch() then
                    return
                end
                if self.data.funcType == "4" then
                    SeasonSLGAPI.OnAskResourceDispatch(self.data.gridId,self.data.funcKeyId ,self.chooseTime,self.chooseMembers,
                    function()
                        if self.data.funcType == "4" then
                            local newPatchInfo = DataMgr.Player.SeasonalResource[self.data.gridId]
                            self.data.dispatchInfo = {}
                            self.data.dispatchInfo.Members = newPatchInfo.Members
                            self.data.dispatchInfo.ProduceTime = newPatchInfo.ProduceTime
                        end
                        self.chooseMembers = self.data.dispatchInfo.Members
                        self:RefreshDispatchStatus(self.data.dispatchInfo, self.chooseMembers)
                        self:UpdateResourceCount()
                    end)
                elseif self.data.funcType == "10" then

                    SeasonSLGAPI.OnAskTimeEventDispatch(self.data.gridId, self.data.funcKeyId, self.chooseTime,self.chooseMembers,
                        function()
                            if self.data.funcType == "10" then

                                local newPatchInfo = DataMgr.Player.SeasonalWorldGuard[self.data.gridId]
                                self.data.dispatchInfo = {}
                                self.data.dispatchInfo.Members = newPatchInfo.Members
                                self.data.dispatchInfo.ProduceTime = newPatchInfo.ProduceTime
                            end
                            self.chooseMembers = self.data.dispatchInfo.Members
                            self:RefreshDispatchStatus(self.data.dispatchInfo, self.chooseMembers)
                            self:UpdateResourceCount()
                            SeasonSLGEventMgr.UpdateUnLockProgress()
                        end)
                end
            else
                self:OpenChooseHero()
            end
        elseif dispatchStatus == SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_Reward  then
            LuaMgr.InvokeUIEventListeners(UIEventConst.SeasonSLGOverViewReciveAllDispatch);




















        end

    end
    if self.btnAction ~= nil then
        LuaMgr.AddClick(self.btnAction, self.onClick);
    end

    self.CancelDispatch = function()

        if self.data.funcType == "10" then

            SeasonSLGAPI.OnAskTimeEventDispatchCancel(self.data.gridId,self.data.funcKeyId ,
                    function()


                        self.data.dispatchInfo.Members = {}
                        self.data.dispatchInfo.ProduceTime = 0

                        self.chooseMembers = self.data.dispatchInfo.Members
                        self:RefreshDispatchStatus(self.data.dispatchInfo, self.chooseMembers)
                        self:UpdateResourceCount()
                    end)
        elseif self.data.funcType == "4" then
            SeasonSLGAPI.OnAskCancleDispatch(self.data.gridId,self.data.funcKeyId ,
                    function()



                        self.data.dispatchInfo.Members ={}
                        self.data.dispatchInfo.ProduceTime = 0

                        self.chooseMembers = self.data.dispatchInfo.Members
                        self:RefreshDispatchStatus(self.data.dispatchInfo, self.chooseMembers)
                        self:UpdateResourceCount()
                    end)
        end
    end

    self.onClickDeletePatching = function()
        local data = {}
        data.clickCallbacks = {[ConfirmCommonPanel.BtnType.Confirm]=self.CancelDispatch}
        data.btnTextStrs = {}
        data.contentStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35112")
        data.btnTextStrs[ConfirmCommonPanel.BtnType.Confirm] = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35113")
        data.btnTextStrs[ConfirmCommonPanel.BtnType.Cancel] = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_34173")
        LuaMgr.ShowLuaPanel(UIName.ConfirmCommonPanel, ConfirmCommonPanel.MsgBoxType.TextButton, data)
    end

    if self.deletePatchingBtn ~= nil then
        LuaMgr.AddClick(self.deletePatchingBtn, self.onClickDeletePatching);
    end
end

function SeasonSLGDispatchItem:OpenChooseHero()

    local dispatchStatus = SeasonSLGEventMgr.GetDisPatchStatus(self.data.dispatchInfo.Members, self.data.dispatchInfo.ProduceTime)

    if dispatchStatus ~= SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_No then
        return
    end

    local updateFunc = function(params)
        self.chooseTime = params.chooseTime
        self.chooseMembers = params.chooseMembers
        self:RefreshDispatchStatus(self.data.dispatchInfo, self.chooseMembers)
        self:UpdateResourceCount()
    end
    LuaMgr.ShowLuaPanel(UIName.SeasonSLGDisPatchHerochoicePopuoView,{gridId = self.data.gridId,
        functionType = self.data.funcType, functionKey = self.data.funcKeyId,
        dispatchTimeList = self.data.dispatchTimeList,
        dispatchInfo = table.Copy(self.data.dispatchInfo),
        heroSeasonLevelMin = self.data.heroLevelMin,
        fillterChoose = self.chooseMembers,
        updateCallBack = updateFunc,
        chooseTime = self.chooseTime})
end


function SeasonSLGDispatchItem:SetData(pdata)
    self.data = nil;
    if pdata ~= nil then
        self.data = pdata.data;
    end
    if self.data == nil then
        return;
    end
    self.isListenEvent = false
    LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGOverViewDispatchTime, self.RefreshDownTime);
    self:UpdatePatchInfo()
    self:RefreshDispatchStatus(self.data.dispatchInfo)
    self:UpdateResourceCount()
end

function SeasonSLGDispatchItem:UpdatePatchInfo()
    self.produceItemId = ""
    self.txtTitle.text = self.data.title

    local path = ""
    if not IsNull(self.data.produceItemInfos) and #self.data.produceItemInfos>0 then
        self.produceItemId = self.data.produceItemInfos[1].id
        path = ConfigHelper.GetItemIconPath(self.produceItemId)
    end
    if not IsNullOrEmpty(path) then
        self.resourceCount_Icon.texture = LuaMgr.GetTexture(path)
    else
        self.resourceCount_Icon.texture = ""
    end
    self.needLevelText.text = string.format(LuaMgr.GetLangText("SeasonSLGDispatchItem_8") , self.data.heroLevelMin)
    self.needHeroCount.text = string.format(LuaMgr.GetLangText("SeasonSLGDispatchItem_9") , self.data.patchHeroCountMin)

    self:UpdateRateText()
end

function SeasonSLGDispatchItem:GetProduceRate()
    local rateValue = 0
    if IsNullOrEmpty(self.produceItemId) then
        return rateValue
    end
    local seasonId=SeasonSLGMapMgr.curSeasonal.Id;
    local seasonalData=DataMgr.Player.Seasonal[tostring(seasonId)] or DataMgr.Player.Seasonal[seasonId]
    rateValue = seasonalData.ProduceIncr[self.produceItemId]
    if IsNull(rateValue) then
        rateValue = 0
    end
    return rateValue
end



function SeasonSLGDispatchItem:GetWorldProduceBuffRate()
    if IsNullOrEmpty(self.produceItemId) then
        return 0
    end
    local _, produceDic = SeasonSLGMapMgr.GetActiveProduceBuff()
    if produceDic == nil then
        return 0
    end
    return produceDic[self.produceItemId] or 0
end

function SeasonSLGDispatchItem:UpdateRateText()






end

function SeasonSLGDispatchItem:RefreshDispatchStatus(dispatchInfo, chooseMembers)
    local dispatchStatus = SeasonSLGEventMgr.GetDisPatchStatus(dispatchInfo.Members, dispatchInfo.ProduceTime)
    if chooseMembers == nil then
        self.chooseMembers = dispatchInfo.Members
    else
        self.chooseMembers = chooseMembers
    end
    if self.chooseMembers == nil then
        self.chooseMembers = {}
    end
    SetActive(self.godisPatchTime, dispatchStatus == SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_Ing)
    SetActive(self.goReciveRewardBtn, dispatchStatus == SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_Reward)
    SetActive(self.btnAction.gameObject, dispatchStatus ~= SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_Ing)
    SetActive(self.goSelectBtn, dispatchStatus == SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_No and #self.chooseMembers==0)
    SetActive(self.goDispatchBtn, dispatchStatus == SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_No and #self.chooseMembers>0)
    SetActive(self.disPatchCostText.gameObject, dispatchStatus == SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_No and #self.chooseMembers>0)
    if dispatchStatus == SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_Ing then
        if not self.isListenEvent then
            LuaMgr.AddUIEventListener(UIEventConst.SeasonSLGOverViewDispatchTime, self.RefreshDownTime);
            self.isListenEvent = true
        end
    else
        if self.isListenEvent then
            LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGOverViewDispatchTime, self.RefreshDownTime);
        end
    end
    if not IsNull(dispatchInfo) and not IsNull(dispatchInfo.Members) and #dispatchInfo.Members > 0 then
        self:RefreshSelectMembers(dispatchInfo.Members)
    else
        self:RefreshSelectMembers(self.chooseMembers)
    end
end



function SeasonSLGDispatchItem:RefreshSelectMembers(members)
    self.dispatchLocUIList:Clear();
    local heroList={};
    for _,v in ipairs(members) do
        local heroInfo={
            id=v,
            level=DataMgr.Player.characters[v]~=nil and DataMgr.Player.characters[v].level or 1,
            sLevel=SeasonSLGMapMgr.GetCharacterSeasonLevel(v),
            rare=HeroMgr.GetHeroNowRare(v);
        }
        table.insert(heroList,heroInfo);
    end

    local list = {}
    for i=1,self.data.countDispatch do
        local heroItem={index=i,callBack=self.LocHeroCallBack};
        if i<=#heroList then
            local cfgHero=ConfigMgr.Config.characterTable[heroList[i].id]
            if cfgHero~=nil then
                heroItem={
                    index=i,
                    id=heroList[i].id,
                    rare=HeroMgr.GetHeroNowRare(heroList[i].id),
                    job=cfgHero.job,
                    name=LuaMgr.GetLangText(cfgHero.namelan),
                    level= SeasonSLGMapMgr.GetCharacterLevel(heroList[i].id),
                    callBack=self.LocHeroCallBack,
                    sLevel=SeasonSLGMapMgr.GetCharacterSeasonLevel(heroList[i].id)
                }
            end
        end
        local heroData=UIListData.GetData(self.goHeadItem,"HeroHeadItem",heroItem);
        table.insert(list,heroData);
    end
    self.dispatchLocUIList:SetData(list);
end

function SeasonSLGDispatchItem:RefreshDispatchTimeText()
    local leftTime = self.data.dispatchInfo.ProduceTime - LuaMgr.Timestamp()
    if leftTime <= 0 then
        self:RefreshDispatchStatus(self.data.dispatchInfo)
    else
        local h,m,s = GetTimeHMS2(leftTime)
        local str = ""
        if h > 0 then
            str = str .. tostring(h) .. LuaMgr.GetLangText("SeasonSLGDispatchItem_10")
        end
        if m > 0 then
            str = str .. tostring(m) .. LuaMgr.GetLangText("SeasonSLGDispatchItem_11")
        end
        str = str .. tostring(s) .. LuaMgr.GetLangText("SeasonSLGDispatchItem_12")
        self.disPatchTimeText.text = string.format(LuaMgr.GetLangText("SeasonSLGDispatchItem_13"),str)
    end
end

function SeasonSLGDispatchItem:Clear()
    self.data = nil
    self.normalLevelInf = nil
    self.seasonLevelInf = nil
    self.qualityInf = nil
    self.chooseMembers = {}
    self.dispatchLocUIList:Clear();
    UIListView.ClearItem("HeroHeadItem");
    LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGOverViewDispatchTime, self.RefreshDownTime)
end

function SeasonSLGDispatchItem:Destroy()
    self.dispatchLocUIList:Clear();
    UIListView.ClearItem("HeroHeadItem");
    LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGOverViewDispatchTime, self.RefreshDownTime)
    if self.btnAction ~= nil and self.onClick ~= nil then
        LuaMgr.RemoveClick(self.btnAction, self.onClick)
    end
    if self.deletePatchingBtn ~= nil and self.onClickDeletePatching ~= nil then
        LuaMgr.RemoveClick(self.deletePatchingBtn, self.onClickDeletePatching)
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.data = nil
    self.normalLevelInf = nil
    self.seasonLevelInf = nil
    self.qualityInf = nil
    self.gameObject = nil;
end