



local this = {
    vm = nil,
    zjtdActivityTipsId = "25401"
}
local characterId;
local rankUp;
local characterConfig;
local character;
local upLvNum=1;
local allCost = {}
local selecIndex=1;
local closePanelFun = nil
local data = {
    
    upLvText="";
    removeIsOn=false;
    removeIsHide=false;
    addIsOn=false;
    addIsHide=false;
    
    selectDatas = {
        {
            id = "",
            isLight = false,
            itemName = "",
            item = {},
            itemCount = 0,
            rare = DefaultSprite,
            icon = DefaultTexture,
            group = 0.0,
        }
    };
    selectTXK = false;
    txkText = "";
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.InvokeUIEventListeners(UIEventConst.HeroZZSelectClosePanel)
            LuaMgr.HidePanel(UIName.HeroZZSelectViewModel)
        end
    },

    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if selecIndex == 2 and this.CheckZJTDActivity() then
                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, ConfigMgr.LangGlobal(this.zjtdActivityTipsId), this.OnClickConfirm, nil);
            else
                this.OnClickConfirm()
            end
        end
    },

    itemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SelectItem(1 + param)
        end
    },

    addConnand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

            if ((character.star + upLvNum + 1) > ConfigMgr.Config.constants.maxStar) then
                local tip = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2602"].NameLan)
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tip)

                this.UpdateBtn();
                return ;
            end

            upLvNum = upLvNum + 1;

            local _targetStar = character.star + upLvNum;

            this.SetItems(_targetStar)
            this.UpdateBtn();

        end
    },

    removeConnand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

            if ((upLvNum - 1) <= 0) then
                local tip = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2603"].NameLan)
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tip)
                this.UpdateBtn();
                return ;
            end

            upLvNum = upLvNum - 1;

            local _targetStar = character.star + upLvNum;

            this.SetItems(_targetStar)
            this.UpdateBtn();

        end
    },
    txkCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local status = this.vm.data.selectTXK;
            SettingHelper.SetPrefsBool(ESetting.Msg_ZZTXKRed_Open, not status);
            SettingHelper.SetPrefsBool(ESetting.Msg_ZZTXKRed_Close, status);
            this.SetTXK();
            PlayerCharacterMgr.CheckCharacter();
            RedMgr.Singleton:UpdateClientRedData("1025", PlayerCharacterMgr.RedZZ(characterId) and 1 or 0);
            RedMgr.Singleton:Refresh();
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            characterId = vm.behaviour.Params[0]
            closePanelFun = vm.behaviour.Params[1]
            selecIndex = nil;
            allCost = {};
            upLvNum = 1;

            characterConfig = ConfigMgr.Config.characterTable[characterId]
            if (characterConfig == nil) then
                return
            end

            character = DataMgr.Player.characters[characterId]
            if (character == nil) then
                return
            end

            this.UpdateBtn();

            local _targetStar = character.star + upLvNum;
            this.SetItems(_targetStar)
            this.SetTXK();
            vm.behaviour:UpdateTopBar("", this.OnBack)
        end
    end,

    before_deactive = function(vm)
         if (vm.behaviour.Params ~= nil) then
            if closePanelFun ~= nil then
                closePanelFun()
                closePanelFun = nil
            end
        end
    end
}

this.UpdateBtn = function(parameter)
    local ismax = (character.star + upLvNum) >= ConfigMgr.Config.constants.maxStar;
if ismax then
        if upLvNum<=1 then
            this.vm.data.removeIsOn = false;
            this.vm.data.removeIsHide = true;
            this.vm.data.addIsOn = false;
            this.vm.data.addIsHide = true;
        else
            this.vm.data.removeIsOn = true;
            this.vm.data.removeIsHide = false;
            this.vm.data.addIsOn = false;
            this.vm.data.addIsHide = true;
        end
    else
        if upLvNum<= 1 then
            this.vm.data.removeIsOn = false;
            this.vm.data.removeIsHide = true;
            this.vm.data.addIsOn = true;
            this.vm.data.addIsHide = false;
        else
            this.vm.data.removeIsOn = true;
            this.vm.data.removeIsHide = false;
            this.vm.data.addIsOn = true;
            this.vm.data.addIsHide = false;
        end
    end
end
    
    this.OnClickConfirm = function(parameter)
        local _item=this.vm.data.selectDatas[selecIndex];

        print(" 背包数量  : ".._item.bagCount .."需要总数量 ： ".._item.allNeedCount);

        if (_item.bagCount < _item.allNeedCount) then
            local tip = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2006"].NameLan)
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tip)

            return
        end

        local needItem = {}

        local allNum=#allCost;
        if allCost~=nil then
            local allNum=#allCost;
            if allNum~=nil then
                for i = 1, allNum do
                    local _item=allCost[i];
                    if _item.targetStar<=(character.star+upLvNum) then
                        if _item.index==selecIndex then
                            table.insert(needItem, _item.index);
                        end
                    end
                end
            end
        end

        data = {
            characterId = characterId,
            cost = needItem
        }


        ApiMgr.Request(
                "rank_up_multiple",
                data,
                true,
                function(result)
                    local re = json.decode(result)
                    this.UpStarResponse(re)
                end,
                function(failCode)
                end,
                true
        )
    end

    this.UpStarResponse = function(result)
        if (result ~= nil) then


            LuaMgr.InvokeUIEventListeners(UIEventConst.CharacterUpStar)

            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/Character_StarUp.mp3")
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/change_LvUp.mp3")
        end
        LuaMgr.HidePanel(UIName.HeroZZSelectViewModel)
    end

    this.HeroZZSelectData = function(_itemRow, _needCount,_index,_targetStar)
        local needTab = {}
        local _bagCount = DataHelper.GetItemCountById(_itemRow.id)

        local _allNeedCount=0;

        if allCost~=nil then
            local allNum=#allCost;
            if allNum~=nil then
                for i = 1, allNum do
                    local _item=allCost[i];
                    if _item.targetStar<_targetStar then
                        if _item.id==_itemRow.id then
                            _allNeedCount=_allNeedCount+_item.needCount;
                        end
                    end
                end
            end
        end

_allNeedCount=_allNeedCount+_needCount;

        needTab = {
            allNeedCount=_allNeedCount;
            targetStar=_targetStar;
            index=_index;
            id = _itemRow.id,
            isLight = false,
            itemName = LuaMgr.GetLangText(_itemRow.nameLan),
            rare = LuaMgr.GetSprite("ItemRare", "itemRare" .. _itemRow.rare),
            icon = LuaMgr.GetTexture("Images/ItemIcons/itemicon_" .. _itemRow.id .. ".png"),
bagCount = _bagCount,
needCount=_needCount,
            group = 1.0,
            itemCount = string.format("<color=%s>%s</color>/<color=#c1c0c0>%s</color>", _bagCount < _allNeedCount and "#c31f36" or "#32d9ce", _bagCount, _allNeedCount
            )
        }
        return needTab
    end


    this.SetItems = function(_targetStar)

        rankUp = ConfigCharacterMgr.GetCharacterRankUp(tostring(_targetStar), tostring(characterConfig.rare))

        if (rankUp == nil) then
            return
        end

        local SelectDataTab = {}
        this.vm.data.selectDatas = {}

        local itemConfig = ConfigHelper.GetItemById(characterConfig.crystalItemId)

        if (itemConfig ~= nil) then
            table.insert(SelectDataTab, this.HeroZZSelectData(itemConfig, rankUp.count,1,_targetStar))
        end

        itemConfig = ConfigHelper.GetItemById(rankUp.matItem.id)
        if (itemConfig ~= nil) then
            table.insert(SelectDataTab, this.HeroZZSelectData(itemConfig, rankUp.matItem.count,2,_targetStar))
        end
        local bagCount = SelectDataTab[1].bagCount
        local needCount = SelectDataTab[1].needCount
        if bagCount >= needCount and #SelectDataTab > 1 then
            SelectDataTab[2].group = 0.5
        end
        this.vm.data.selectDatas = SelectDataTab
        this.vm.data.upLvText=string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_2601"),upLvNum);

        local dataNum=#this.vm.data.selectDatas;

        if dataNum<=0 then
            return;
        end

        if selecIndex==nil then
            this.SelectItem(1)
        else
            this.SelectItem(selecIndex)
        end

        for i = 1, dataNum do
            local _selectDats=this.vm.data.selectDatas[i];

            local isChange=false;
            if allCost~=nil then
                local allNum=#allCost;
                if(allNum~=nil)then
                    for k = 1, allNum do
                        local _item=allCost[k];
                        if _item.targetStar==(character.star+upLvNum) and _item.id==_selectDats.id then

                            allCost[k]=_selectDats;
                            isChange=true;

                            break;
                        end
                    end
                end
            end

            if not isChange then
                table.insert(allCost, _selectDats)
            end

        end
    end

    this.SelectItem = function(index)
        local dataNum=#this.vm.data.selectDatas;

        if (index > dataNum) then
            return
        end

        if index > 1 then
            local bagCount = this.vm.data.selectDatas[1].bagCount
            local needCount = this.vm.data.selectDatas[1].needCount
            if bagCount >= needCount then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("HeroZZSelectViewModel_1"));
                return
            end
        end
        
        if (selecIndex ~= nil and  selecIndex<= dataNum ) then
            this.vm.data.selectDatas[selecIndex].isLight = false
        end

        selecIndex=index;

        if (selecIndex ~= nil) then
            this.vm.data.selectDatas[selecIndex].isLight = true
        end
    end

this.SetTXK = function()
    this.vm.data.selectTXK = SettingHelper.GetPrefasBool(ESetting.Msg_ZZTXKRed_Open);
    this.vm.data.txkText = ConfigMgr.LangGlobal("1651");
end


this.CheckZJTDActivity = function()
    this.zjtdActivityTipsId = "25401"
    for i,v in pairs(ConfigMgr.Config.activityGroup) do
        if ActivityMgr.CheckIsGiftCharacter(v.text) then
            local activityData = DataExHelper.GetDataExByTag(v.key);
            if activityData ~= nil and DataExHelper.CommonActivityCheck(v.key) then
                local cardPoolId = v.IconPanel[1]
                if cardPoolId ~= nil then
                    local cardCfg = ConfigMgr.Config.cardPools[cardPoolId]
                    if not TableIsNull(cardCfg.characterShow) and not IsNull(cardCfg.characterShow[1]) and cardCfg.characterShow[1] == characterId then
if v.text == "dptd" then
                            this.zjtdActivityTipsId = "26527"
                        end 
                        return true
                    end
                end
            end
        end
    end
    return false
end

return vm(
        {
            data = data,
            command = command,
            hook = hook
        }
)