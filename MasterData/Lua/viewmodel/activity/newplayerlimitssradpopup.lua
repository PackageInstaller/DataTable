
local this = {
    vm = nil,
    data = {
        characterId = "",
        goodsIdList = "",
        curIndex = 0,
        chargeId = "",
        isPaying = false,
        playAnim = false,
        attrItemShowIndex = 0,
        LevelUpImmedParam = nil,
    },
    rewardItemTrList = {},
    RewardItemTemp = nil,
    rewardContentTr = nil,
}

local data = {
    pageActive = false,
    titleImg = DefaultSprite,
    goodsImg = DefaultTexture,
    oldZZSprite = DefaultSprite,
    newZZSprite = DefaultSprite,
    oldZZStr = "",
    newZZStr = "",
    oldLevel = "",
    newLevel = "",
    showLevel = false,
    showZZ = false,
    showUpIcon = false,
    animationName = "",

    isShowContent_1 = false,
    isShowContent_2 = false,
    isShowContent_3 = false,
    
    text_1 = "",
    leftTimeStr = "",
    
    goodsPriceStr = "",
    
    isShowAttrList = false,
    attrList = {
        {
            text_1 = "",
            text_2 = "",
            alpha = 0.0,
            animName = "",
        }
    },
    isShowLeftBtn = false,
    isShowRightBtn = false,
}

local command = {
    leftBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local newIndex = this.data.curIndex - 1
            if newIndex <= 0 then
                newIndex = 1
            end
            if newIndex == this.data.curIndex then
                return
            end
            this.data.curIndex = newIndex
            this.RefreshPage()
        end
    },
    rightBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local newIndex = this.data.curIndex + 1
            if newIndex > #this.data.goodsIdList then
                newIndex = #this.data.goodsIdList
            end
            if newIndex == this.data.curIndex then
                return
            end
            this.data.curIndex = newIndex
            this.RefreshPage()
        end
    },
    buyBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.data.isPaying then
                return
            end
            local goodsId = this.data.goodsIdList[this.data.curIndex]
            this.data.chargeId = goodsId
            this.data.isPaying = true
            LuaMgr.LuaOnAskPay(goodsId);
        end
    },
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.NewPlayerLimitSSRAdPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.RewardItemTemp = this.vm.behaviour.transform:Find("root/Middle/obj/Info/ItemList/RewardItem").gameObject
        this.rewardContentTr = this.vm.behaviour.transform:Find("root/Middle/obj/Info/ItemList"):GetComponent("RectTransform")
        SetActive(this.RewardItemTemp, false)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.data.goodsIdList = {}
        this.data.curIndex = 1
        this.vm.data.pageActive = false
        this.data.playAnim = true
        this.RefreshData()
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.AddUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.AddUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.ClosePopPanel, this.ClosePopPanel);
        LuaMgr.AddUIEventListener(UIEventConst.ClosePopPanel, this.ClosePopPanel);
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        NewPlayerLimitSSRMgr.RefreshData()
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRAdTimer);
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRCheckStatusTimer)
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRAdShowTimer)
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.ClosePopPanel, this.ClosePopPanel);
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.RefreshData = function()
    NewPlayerLimitSSRMgr.RefreshData()
    LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRAdTimer)
    local curTime = LuaMgr.Timestamp()
    local newGoodsId = {}

    for k, goodsData in pairs(NewPlayerLimitSSRMgr.GoodsTimeMap) do
        if goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.WaitShow or (goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Hide and curTime > goodsData.openTime) or 
                (goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing and NewPlayerLimitSSRMgr.GetGoodsDisplayTime(k) == 0) then
            for listIndex, goodsList in ipairs(NewPlayerLimitSSRMgr.HeroGoodsIDList) do
                for goodsIndex = 1, #goodsList do
                    if k == goodsList[goodsIndex] and (goodsIndex == 4 or goodsIndex == 5 or goodsIndex == 6) then
                        table.insert(newGoodsId, k)
                    end
                end
            end

            if #newGoodsId > 0 then
                break
            end
        end
    end

    function RefreshDataAndPage()
        NewPlayerLimitSSRMgr.RefreshData()
        for i, v in ipairs(newGoodsId) do
            table.insert(this.data.goodsIdList, v)
        end
        if this.CheckGoodsIdList() then
            this.SortGoodsIdList()
            this.RefreshPage()
            LuaMgr.AddTimer(TimerConst.NewPlayerLimitSSRAdTimer, this.UpdateLeftTimer, 1, -1, true)
        end
    end
    if #newGoodsId > 0 then
        ApiMgr.Request("set_goods_display_time", { GoodsID = newGoodsId}, true, function()
            NewPlayerLimitSSRMgr.isAddAdPageToPopupList = false
            RefreshDataAndPage()
        end, nil, true, true);
    else
        RefreshDataAndPage()
    end
end

this.CheckGoodsIdList = function()
    local curTime = LuaMgr.Timestamp()
    for i = #this.data.goodsIdList, 1, -1 do
        local goodsId = this.data.goodsIdList[i]
        local goodsData = NewPlayerLimitSSRMgr.GoodsTimeMap[goodsId]
        if goodsData == nil or goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Close or goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Bought or
                (goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing and curTime > goodsData.closeTime) then
            table.remove(this.data.goodsIdList, i)
        end
    end
    if #this.data.goodsIdList == 0 then
        LuaMgr.HidePanel(UIName.NewPlayerLimitSSRAdPopup)
        return false
    end

    if this.data.curIndex > #this.data.goodsIdList then
        this.data.curIndex = 1
    end
    return true
end

this.SortGoodsIdList = function()
    local sortMap = {}
    for listIndex, goodsList in ipairs(NewPlayerLimitSSRMgr.HeroGoodsIDList) do
        for goodsIndex = 1, #goodsList do
            local goodsId = goodsList[goodsIndex]
            local characterId = ConfigMgr.Config.constants.NewPlayerLimitSSRHeroList[listIndex]
            local data = DataMgr.Player.characters[characterId]
            local level = data == nil and 0 or data.level
            local zz = data == nil and 0 or data.star
            sortMap[goodsId] = zz * 100 + level * 10 + goodsIndex
        end
    end
    
    table.sort(this.data.goodsIdList, function(a, b)
        return sortMap[a] < sortMap[b]
    end)
end

this.RefreshPage = function()
    this.vm.data.pageActive = true
    this.SetPageInfo()
    this.SetRewardList()
    this.SetAddAttr()

    this.data.isPaying=false;
    this.data.chargeId=nil;
    this.vm.data.goodsPriceStr = NewPlayerLimitSSRMgr.GetGoodsPriceStr(this.data.goodsIdList[this.data.curIndex])
    this.vm.data.isShowLeftBtn = this.data.curIndex > 1
    this.vm.data.isShowRightBtn = this.data.curIndex < #this.data.goodsIdList
    if this.data.playAnim then
        this.data.playAnim = false
        this.vm.data.animationName = ""
        LuaMgr.NextFrame(function()
            if this == nil then
                return
            end
            this.vm.data.animationName = "ani_NewPlayerLimitSSRAdPopup_root_ZZ_001"
        end)
    else
        this.vm.data.animationName = "ani_NewPlayerLimitSSRAdPopup_root_ZZ_001"
    end
    NewPlayerLimitSSRMgr.isAddPageToPopupList = false
end

this.SetPageInfo = function()
    for listIndex, goodsList in ipairs(NewPlayerLimitSSRMgr.HeroGoodsIDList) do
        for i, v in ipairs(goodsList) do
            if v == this.data.goodsIdList[this.data.curIndex] then
                local imgIndex = (i - 3) + (listIndex - 1) * 3
                this.vm.data.titleImg = LuaMgr.GetSprite("NewPlayerLimitSSR", "ui_plt_xsth_lb_title_0" .. listIndex);
                this.vm.data.goodsImg = LuaMgr.GetTexture("Images/NewPlayerLimitSSRAd/ui_plt_xsth_lb_lbt_0".. imgIndex .. ".png")
                this.vm.data.showLevel = i == 4
                this.vm.data.showUpIcon = i == 4
                this.vm.data.oldLevel = 1
                this.vm.data.newLevel = 70
                this.vm.data.showZZ = false
                if i == 5 then
                    this.vm.data.oldZZSprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_zz2");
                    this.vm.data.oldZZStr = string.format("<color=#aca9a3>%s</color>", HeroMgr.GetNumStr(1));
                    this.vm.data.newZZSprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_zz1");
                    this.vm.data.newZZStr = string.format("<color=#262429>%s</color>", HeroMgr.GetNumStr(3));
                elseif i == 6 then
                    this.vm.data.oldZZSprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_zz1");
                    this.vm.data.oldZZStr = string.format("<color=#262429>%s</color>", HeroMgr.GetNumStr(3));
                    this.vm.data.newZZSprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_zz1");
                    this.vm.data.newZZStr = string.format("<color=#262429>%s</color>", HeroMgr.GetNumStr(6));
                end
                this.vm.data.isShowContent_1 = i == 4
                this.vm.data.isShowContent_2 = i == 5
                this.vm.data.isShowContent_3 = i == 6
                local newCharacterId = ConfigMgr.Config.constants.NewPlayerLimitSSRHeroList[listIndex]
                this.data.playAnim = this.data.characterId ~= newCharacterId
                this.data.characterId = newCharacterId
            end
        end
    end
end   

this.SetRewardList = function()
    local _cfgChargeMap= ConfigMgr.Config.charge
    local charge=_cfgChargeMap[this.data.goodsIdList[this.data.curIndex]];
    if charge == nil or charge.Reward == nil then
        return
    end

    local index = 1
    for i,v in ipairs(charge.Reward) do
        local goodsItem = nil
        if this.rewardItemTrList[i] == nil then
            local obj = LuaMgr.InstantiateGO(this.RewardItemTemp, this.rewardContentTr, false)
            SetActive(obj, false)
            this.rewardItemTrList[i] = GoodsDataItem.New(obj.transform)
        end
        SetActive(this.rewardItemTrList[i].transform.parent.gameObject,true)
        local itemConfig = ConfigMgr.Config.itemMap[v.id]
        itemConfig["count0"] = v.count
        this.rewardItemTrList[i]:SetData(1, itemConfig, 1, false, Vector3(0.8, 0.8, 0.8), false)
        index = index + 1
    end
    for i = index, #this.rewardItemTrList do
        SetActive(this.rewardItemTrList[i].transform.parent.gameObject,false)
    end
end

this.SetAddAttr = function()
    if this.vm.data.isShowContent_1 then
        this.vm.data.isShowAttrList = false
        return
    end
    this.vm.data.isShowAttrList = true
    local list = ConfigCharacterMgr.GetRoleAttr(this.data.characterId)
    if list == nil then

    end
    local tempList = {}
    local numStr = ""
    local bgStr = ""
    local content = ""
    local content2 = ""
    local sameName = false
    local show2Message = false
    local notshowSkill = false
    local Line1add1 = false
    local Line1Add1Have = false
    local Line1Add2Have = false
    local Line2Add2Have = false

    local showNumone = ""
    local showNumtwo = ""
    local index = 0
    local characterData = DataMgr.Player.characters[this.data.characterId]
    local star = characterData == nil and 0 or characterData.star

    for i = 2, #list, 1 do
        local AttarList = {}
        index = index + 1
        local IsGet = false
        local outline
        if list[i].starUpAttr ~= nil and list[i].starUpAttr ~= "" then
            local attar = list[i].starUpAttr
            local attar2 = list[i].starUpAttr2
            local GetStr = string.sub(attar, 2, #list[i].starUpAttr - 1)
            local strs = NumTool.split(GetStr, ",")
            local attr = strs[1]
            local attarSplite
            local attar2Splite
            local GetStr2
            local strs2
            local attr2

            if attr == "SkillUP" then
                notshowSkill = false
                sameName = false
                show2Message = false
                local skillUpStr = ""
                local skillId = strs[2]
                local skillLevel = HeroManager.GetCharacterSkillLevel(this.data.characterId, skillId)
                local skillName = HeroManager.GetCharacterSkillName(skillId, skillLevel)
                if skillName ~= nil and skillName ~= "" then
                    local colord = LuaMgr.GetLangText("HeroZZViewModel_0")
                    skillUpStr = colord .. "<a href=" .. skillId .. LuaMgr.GetLangText("HeroZZViewModel_11") .. skillName .. "】</a></color>"
                end
                skillName = HeroManager.GetCharacterSkillName(skillId .. "ex", skillLevel)
                if skillName ~= nil and skillName ~= "" then
                    local colord = LuaMgr.GetLangText("HeroZZViewModel_2")
                    skillUpStr = skillUpStr .. LuaMgr.GetLangText("HeroZZViewModel_4")
                    skillUpStr = skillUpStr .. colord .. "<a href=" .. skillId .. LuaMgr.GetLangText("HeroZZViewModel_12") .. skillName .. "】</a></color>"
                end
                if star >= index then
                    numStr = "<color=#e7dacd>%s</color>"
                    bgStr = "ui_zz_di01"
                    IsGet = true
                    content = skillUpStr
                else
                    numStr = "<color=#c9cbc3>%s</color>"
                    bgStr = "ui_zz_di00"
                    content = skillUpStr
                end
            else
                notshowSkill = true
                local function GetOutLines(attr, strs, persent)
                    local attrDes = this.GetAttrDes(attr)
                    local attrValue = strs[2];
                    if (attrValue ~= nil) then
                        if (attr == "EnergyRecoveryCycle_FIX") then
                            attrValue = LuaMgr.Division(tonumber(attrValue), 100);
                        end
                    else
                        attrValue = "";
                    end
                    if attrDes ~= nil then
                        if (star >= index) then
                            IsGet = true
                            return attrDes.Name ~= nil and LuaMgr.GetLangText(attrDes.Name) or "",
                            string.format(
                                    "%s%s",
                                    attrValue,
                                    attrDes.AttrDisplayType ~= nil and attrDes.AttrDisplayType or ""
                            ), UnityEngine.Color(0, 60 / 255, 60 / 255, 1), "ui_zz_di01"
                        else
                            return attrDes.Name ~= nil and LuaMgr.GetLangText(attrDes.Name) or "",
                            string.format(
                                    "%s%s",
                                    attrValue,
                                    attrDes.AttrDisplayType ~= nil and attrDes.AttrDisplayType or ""
                            ), UnityEngine.Color(0, 60 / 255, 60 / 255, 1), "ui_zz_di00"
                        end
                    end
                end
                attarSplite = NumTool.split(attr, "_")
                content, showNumone, outline, bgStr = GetOutLines(attr, strs, attarSplite[2] == "PERCENT")

                if list[i].starUpAttr2 ~= nil and list[i].starUpAttr2 ~= "" then
                    GetStr2 = string.sub(attar2, 2, #list[i].starUpAttr2 - 1)
                    strs2 = NumTool.split(GetStr2, ",")
                    attr2 = strs2[1]
                    attar2Splite = NumTool.split(attr2, "_")
                    content2, showNumtwo = GetOutLines(attr2, strs2, attar2Splite[2] == "PERCENT")
                end
                attarSplite = attarSplite == nil and {} or attarSplite
                attar2Splite = attar2Splite == nil and {} or attar2Splite
                local Num2 = (strs2 ~= nil and strs2[2] ~= nil) and strs2[2] or ""
                sameName = (Num2 ~= "" and Num2 ~= "0")
                if attarSplite[1] == attar2Splite[1] then
                    show2Message = false

                    Line1Add1Have = (strs ~= nil and strs[2] ~= nil and strs[2] ~= "")
                    Line1Add2Have = (strs2 ~= nil and strs2[2] ~= nil and strs2[2] ~= "")
                    Line1add1 = false
                    Line2Add2Have = false
                else
                    Line1add1 = true
                    Line1Add1Have = (strs ~= nil and strs[2] ~= nil and strs[2] ~= "")
                    Line1Add2Have = false
                    Line2Add2Have = (strs2 ~= nil and strs2[2] ~= nil and strs2[2] ~= "")
                    show2Message = sameName and true
                end
            end
        end
        AttarList = {
            num = index,
            content = content,
            content2 = content2,
            Line1add1 = Line1add1,
            Line1add1have = Line1Add1Have,
            Line1add2have = Line1Add2Have,
            Line2add2have = Line2Add2Have,
            zzsameName = sameName,
            zzshow2Message = show2Message,
            showNum1 = showNumone,
            showNum2 = showNumtwo,
            outline = outline,
            notSkillshow = notshowSkill,
            Name = tostring(index),
        }

        table.insert(tempList, AttarList)
    end

    if this.vm.data.isShowContent_2 then
        this.vm.data.text_1 = LuaMgr.GetLangText("NewPlayerLimitSSRAdPopup_3") .. tempList[3].content
    elseif this.vm.data.isShowContent_3 then
        local skinTable = ConfigMgr.Config.characterSkins[this.data.characterId]
        local heroList = ConfigMgr.Config.constants.NewPlayerLimitSSRHeroList
        local heroIndex = 1
        for i = 1, #heroList do
            if heroList[i] == this.data.characterId then
                heroIndex = i
            end
        end
        local skinId = ConfigMgr.Config.constants.NewPlayerLimitSSR6Skin[heroIndex]
        local typeName = ""
        local skinName = ""
        for i = 1, #skinTable do
            local skinCfg = skinTable[i]
            if skinCfg.skinID == skinId then
                skinName = LuaMgr.GetLangText(skinCfg.skinNamelan)
                if skinCfg.skinLOGO == 210 then
                    typeName = LuaMgr.GetLangText("NewPlayerLimitSSRAdPopup_6")
                elseif skinCfg.skinLOGO == 206 then
                    typeName = LuaMgr.GetLangText("NewPlayerLimitSSRAdPopup_7")
                end
            end
        end
        
        this.vm.data.text_1 = string.format(LuaMgr.GetLangText("NewPlayerLimitSSRAdPopup_8"), typeName, skinName)
    end
    
    local tempAttrList = {}
    for i = 1, #tempList do
        local data = tempList[i]
        if (this.vm.data.isShowContent_2 and i < 3) or (this.vm.data.isShowContent_3 and i > 3) then
            local item = {text_1 = data.content .. LuaMgr.GetLangText("NewPlayerLimitSSRAdPopup_4") }
            local str = ""
            if data.Line1add1 then
                str = str .. "+"
            end
            if data.Line1add1have then
                str = str .. data.showNum1
            end
            if data.Line1add2have then
                str = str .. "+"
            end
            if data.Line1add2have then
                str = str .. data.showNum2
            end
            item.text_2 = str
            item.alpha = 0.0
            item.animName = ""
            table.insert(tempAttrList, item)
        end
    end
    
    this.vm.data.attrList = tempAttrList
    if this.data.playAnim then
        this.data.attrItemShowIndex = 1
        LuaMgr.AddTimer(TimerConst.NewPlayerLimitSSRAdShowTimer, this.OnAttrItemShow, 0.07, -1, false)
    end
end


this.GetAttrDes = function(attr)
    local attarlist = { Name = "", AttrDisplayType = "" }
    local attrDes = ConfigMgr.Config.attrDesMap[attr];
    if (attrDes ~= nil) then
        attarlist.Name = attrDes.NameLan;
        attarlist.AttrDisplayType = attrDes.attrDisplayType;
    end
    return attarlist;
end

this.UpdateLeftTimer = function()
    local curTime = LuaMgr.Timestamp()
    for i = #this.data.goodsIdList, 1, -1 do
        local goodsId = this.data.goodsIdList[i]
        local goodsData = NewPlayerLimitSSRMgr.GoodsTimeMap[goodsId]
        if goodsData ~= nil and goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing then
            local leftTime = goodsData.closeTime - curTime
            if leftTime < 0 then
                LuaMgr.HidePanel(UIName.NewPlayerLimitSSRAdPopup)
                break
            else
                this.vm.data.leftTimeStr = LuaMgr.GetLangText("NewPlayerLimitSSRAdPopup_5") .. this.GetLeftTimeText(leftTime)
            end
        end
    end
end

this.GetLeftTimeText = function(leftTime)
    local timeStr = "%s : %s : %s"
    if leftTime < 0 then
        return timeStr
    end
    local h, m, s = GetTimeHMS(leftTime)
    return string.format(timeStr, h, m, s)
end

this.PayOrder=function(data)
    if data.Length==2 then
        local reChargeId=tostring(data[0]);
        this.data.order=tostring(data[1]);
        if this.data.chargeId ~= reChargeId then return end;
        if LuaMgr.GetPlatform()~="EDITOR" then return end;
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRCheckStatusTimer)
        LuaMgr.AddTimer(TimerConst.NewPlayerLimitSSRCheckStatusTimer,this.OnTimer,1,100,true);
    end
end

this.OnPayResult=function(data)
    if data.Length==1 then
        if this.data.order~=nil and this.data.order~=tostring(data[0]) then return end;
        this.data.isPaying=false;
    end
end

this.OnPaySuccess=function(data)
    if data.Length==1 then
        if this.data.order~=nil and this.data.order~=tostring(data[0]) then return end;
        if not this.CheckRewardIsLevelUpImmed(this.data.chargeId) then
            LuaMgr.HidePanel(UIName.NewPlayerLimitSSRAdPopup)
        end
    end
end

this.OnTimer=function()
    local askData={order=this.data.order}
    ApiMgr.Request("check_recharge_status", askData, true, function(result)
        local re=json.decode(result);
        if re.result.status==2 then
            LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRCheckStatusTimer)
            local rewards=re.result.rewards;
            if rewards~=nil then
                local data=json.encode(rewards);
                LuaMgr.ShowItemRewared(data);
            end
            if not this.CheckRewardIsLevelUpImmed(this.data.chargeId) then
                LuaMgr.HidePanel(UIName.NewPlayerLimitSSRAdPopup)
            end
        end

    end, nil, true);
end

this.OnAttrItemShow = function()
    if this.data.attrItemShowIndex > #this.vm.data.attrList then
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRAdShowTimer)
        return 
    end
    this.vm.data.attrList[this.data.attrItemShowIndex].animName = "ani_NewPlayerLimitSSRAdPopup_attrItem_001"
    this.data.attrItemShowIndex = this.data.attrItemShowIndex + 1
end

this.CheckRewardIsLevelUpImmed = function(chargeId)
    local _cfgChargeMap= ConfigMgr.Config.charge
    local charge=_cfgChargeMap[chargeId];
    if charge.Reward == nil then
        return false
    end

    local index = 1
    for i,v in ipairs(charge.Reward) do
        local itemId = v.id
        local itemConfig = ConfigHelper.GetItemById(itemId)
        if itemConfig ~= nil and itemConfig.UseType ~= nil and itemConfig.UseType == "4" then
            for listIndex, goodsList in ipairs(NewPlayerLimitSSRMgr.HeroGoodsIDList) do
                for goodsIndex = 1, #goodsList do
                    local goodsId = goodsList[goodsIndex]
                    if goodsId == chargeId then
                        local characterId = ConfigMgr.Config.constants.NewPlayerLimitSSRHeroList[listIndex]
                        local itemCharacterUp = ConfigMgr.Config.ItemsCharacterUp[itemId];
                        if (itemCharacterUp ~= nil) then
                            local obj = {characterId = characterId, itemId = itemId};
                            local objStr = json.encode(obj);
                            this.data.LevelUpImmedParam = {
                                characterId = characterId,
                                itemCharacterUp = itemCharacterUp,
                                objStr = objStr
                            }
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end

this.ClosePopPanel = function(data)
    if this == nil then
        return
    end
    local popName = tostring(data[0])
    if popName ~= UIName.ItemGetViewModel or this.data.LevelUpImmedParam == nil then
        return
    end
    LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel", this.data.LevelUpImmedParam.characterId, nil,
            this.data.LevelUpImmedParam.itemCharacterUp.Level, this.data.LevelUpImmedParam.itemCharacterUp.Talent, this.data.LevelUpImmedParam.objStr);
    this.data.LevelUpImmedParam = nil
    LuaMgr.HidePanel(UIName.NewPlayerLimitSSRAdPopup)
end

return vm({
    data = data,
    command = command,
    hook = hook
})