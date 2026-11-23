





local askData={
    CharacterID="",
    Level=1,
    Star=1,
    Talent={},
    EquipmentID="",
    ELevel=1,
    EStar=1,
    AdditionalAttrs={},
    callBack=nil,
    Prestige=0,
    Optional={},
}
require("ViewModel/Test/talentOptionalItem")
local this = {
    vm = nil,
    cfg_charactersList={};
    color_gray=UnityEngine.Color(107/255,107/255,107/255,1),
    color_green=UnityEngine.Color(84/255,135/255,84/255,1),
    cfg_TalentMap={},
    cfg_TalentBankMap={},
    talentList={},
    cfg_equipMap={},
    cfg_equipAttr={},
    cfg_jobEquip={},
    cfg_jobEquipAttr={},

    data_Talent={},
    heroIdIndex=nil,
    equipInIndex=nil,
    hasEquipAttr={
        
    },
    curEquipAttrSelectIndex=nil,
    dataCharacter=nil,
    dataEquip=nil,
    talentOptionItemList={},
    maxLevel = 1,
}

local data = {
   isTalentPanel=false,
   isTalentOptionalPanel=false,
   isEquipPanel=false,

   hero_Info="",
   hero_ID="",
   hero_level="",
   hero_star="",
hero_PrestigeLevel="",
hero_Prestige="",
   hero_LevelRandom = "",

   isOperate=false,
   operate_title="",
   isOperate_Id=false,
   isOperate_equip=false,
   isOperate_equipAttr=false,
   heroContentAnchor=Vector2(0,0),
   heroIdList={
       {
           color=this.color_gray,
           id="",
       }
   },
   

   talentList={
       {
           color=this.color_gray,
           id="",
           info="",
           isOn=false,
           level="",
       }
   },
   talentContentAnchor=Vector2(0,0),
   talentOptionalContentAnchor=Vector2(0,0),

   equip_Id="",
   equip_level="",
   equip_star="",
   equipContentAnchor=Vector2(0,0),
   equipList={
       {
           color=this.color_gray,
           info="",
           id="",
       }
   },
   equipAttr={
       {
           color=this.color_gray,
           id="",
           attrInfo="",
           text=""
       }
   },
   equipAttrList={
       {
           attrInfo="",
           attrId="",
           level="",
       }
   }
}

local command = {

    mainTalentBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.isTalentPanel=true
            this.vm.data.isOperate=false
            this.vm.data.isOperate_Id=false
            this.vm.data.talentContentAnchor=Vector2(0,0)
            local list={}
            local talentItem=nil;
            for i,v in ipairs(this.talentList) do
                local talentRecord=askData.Talent[v.id]
                talentItem={
                    color=talentRecord.status==2 and this.color_green or this.color_gray,
                    id=v.id,
                    info=LuaMgr.GetLangText(this.cfg_TalentBankMap[v.talentBankId].DescriptionLan),
                    isOn=talentRecord.status==2,talentType = v.talentType,
                    level=string.format(LuaMgr.GetLangText("GMHeroTestViewModel_0"),this.cfg_TalentMap[v.id].requireLevel);
                }
                table.insert(list,talentItem)
            end
            this.vm.data.talentList=list;
        end
    },
    mainTalentOptionalBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetTalentOptional(this.vm.data.hero_ID)
        end
    },
    mainEquipBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
           this.vm.data.isEquipPanel=true
            this.vm.data.isOperate=false
            this.vm.data.isOperate_Id=false
            this.cfg_jobEquip={}
            local job=ConfigMgr.Config.characterTable[this.vm.data.hero_ID].job
            for i,v in pairs(this.cfg_equipMap) do
                if v.job==job then
                    table.insert(this.cfg_jobEquip,v);
                end
            end
            table.sort(this.cfg_jobEquip,function(a, b) return a.id<b.id end)
            this.dataEquip=nil;
            if this.dataCharacter~=nil and this.dataCharacter.wear~="" then
                this.dataEquip=DataMgr.Player.equipments[this.dataCharacter.wear];
            end
            local index=1
            if this.dataEquip~=nil then
                for i,v in ipairs(this.cfg_jobEquip) do
                    if v.id==this.dataEquip.equipmentId then
                        index=i
                        break
                    end
                end
            end
            this.vm.data.equip_Id= this.cfg_jobEquip[index].id
            this.vm.data.equip_level=this.dataEquip~=nil and this.dataEquip.level or "1"
            this.vm.data.equip_star=this.dataEquip~=nil  and this.dataEquip.star or "1"
            
            this.SetEquipAttr(this.cfg_jobEquip[index],this.dataEquip);
        end
    },
    mainConfirmBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            
            askData.CharacterID=this.vm.data.hero_ID
            local level=tonumber(this.vm.data.hero_level)
            askData.Level=level>this.maxLevel and this.maxLevel or level
            local star=tonumber(this.vm.data.hero_star)
            askData.Star=star>6 and 6 or star
            local prestigeLevel=tonumber(this.vm.data.hero_PrestigeLevel)
            askData.PrestigeLevel=prestigeLevel>10 and 10 or prestigeLevel
            askData.Prestige=tonumber(this.vm.data.hero_Prestige)

            if #askData.AdditionalAttrs==0 then
                askData.AdditionalAttrs=nil
            end
            ApiMgr.Request("admin/addUpdateCharacter",askData,true,function(re) 
                LuaMgr.HidePanel(UIName.GMHeroTestViewModel)
                if this.callBack~=nil then
                    this.callBack();
                end
            end,nil,true)
        end
    },
    mainCancelBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.GMHeroTestViewModel)
        end
    },
    main_IDBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.isOperate=true
            this.vm.data.isOperate_Id=true
            local list={}
            local textItem=nil
            for i,v in ipairs(this.cfg_charactersList) do
                textItem={ 
                    id=string.format("%s(%s)",v.id,LuaMgr.GetLangText(v.namelan)),
                    color=this.color_gray,
                }
                table.insert(list,textItem)
            end
            this.vm.data.heroIdList=list
            this.vm.data.heroContentAnchor=Vector2(0,0)
        end
    },
    main_StarBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.GMHeroTestViewModel)
        end
    },

    operate_CloseBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.isOperate=false
            this.vm.data.isOperate_equipAttr=false
            this.vm.data.isOperate_Id=false
            this.vm.data.isOperate_equip=false
        end
    },
    operate_idItemBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index=tonumber(param)+1
            if this.heroIdIndex~=nil and this.heroIdIndex==index then
                return
            end
            for i,v in ipairs(this.vm.data.heroIdList) do
                v.color=i==index and this.color_green or this.color_gray
            end
            this.SetHeroMainInfo(index)


        end
    },
    operate_equipItemBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index=tonumber(param)+1
            if this.equipInIndex~=nil and this.equipInIndex==index then
                return
            end
            for i,v in ipairs(this.vm.data.equipList) do
                v.color=i==index and this.color_green or this.color_gray
            end
            this.vm.data.equip_Id=this.vm.data.equipList[index].id
            this.vm.data.equip_level="1"
            this.vm.data.equip_star="1"
            askData.AdditionalAttrs={}
            this.SetEquipAttr(this.cfg_jobEquip[index],nil);
        end
    },
    operate_equipAttrItemBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index=tonumber(param)+1
            if this.equipInIndex~=nil and this.equipInIndex==index then
                return
            end
            for i,v in ipairs(this.vm.data.equipAttr) do
                v.color=i==index and this.color_green or this.color_gray
            end
            local loc=this.curEquipAttrSelectIndex
            local equipAttr=this.vm.data.equipAttr[index]
            this.vm.data.equipAttrList[loc].attrInfo=equipAttr.attrInfo
            this.vm.data.equipAttrList[loc].attrId=equipAttr.id
            this.hasEquipAttr[equipAttr.id]=1
        end
    },

    talent_AllBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            for i,v in ipairs(this.vm.data.talentList) do
                v.isOn=true
                v.color=this.color_green
            end
        end
    },
    talent_CloseAllBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            for i,v in ipairs(this.vm.data.talentList) do
                v.isOn=false
                v.color=this.color_gray
            end
        end
    },
    talent_IsOn={
        type=XLuaCommandType.Bool,
        execute=function(vm,isOn,param)
            local index=tonumber(param)+1;
            this.vm.data.talentList[index].isOn=isOn;
            this.vm.data.talentList[index].color=isOn and this.color_green or this.color_gray
        end
    },
    talent_OptionIsOn={
        type=XLuaCommandType.Bool,
        execute=function(vm,isOn,param)












            
        end
    },
    talent_confirmBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.data_Talent={}
            for i,v in ipairs(this.vm.data.talentList) do
                local talent={
                    id=v.id,
                    status=v.isOn and 2 or 0,
                    option="",
                }
                if talent.status~=2 then
                    local requireTalent=ConfigMgr.Config.characterTalentMap[talent.id].requireTalent;
                    local unlock=true
                    for p,m in pairs(requireTalent) do
                        if this.data_Talent[m].status~=2 then
                            unlock=false
                            break
                        end
                    end
                    talent.status=unlock and 1 or 0
                end
                if v.talentType == 3 then
                    talent.status = 1
                end
                this.data_Talent[talent.id]=talent
            end
            
            this.vm.data.isTalentPanel=false
            askData.Talent=this.data_Talent
            
        end
        
    },
    talent_cancelBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
           this.vm.data.isTalentPanel=false
        end
    },
    talentOptional_confirmBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.SubmitTalentOptional();
        end
        
    },
    talentOptional_cancelBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
           this.CancelTalentOptional();
        end
    },

    equip_IDBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.isOperate=true
            this.vm.data.isOperate_equip=true
            local list={}
            local textItem=nil
            for i,v in ipairs(this.cfg_jobEquip) do
                textItem={
                    id=v.id,
                    info=string.format("%s(%s)",v.id,LuaMgr.GetLangText(v.NameLan)),
                    color=this.color_gray,
                }
                table.insert(list,textItem)
            end
            table.sort(list,function(a, b) return a.id<b.id end)
            this.vm.data.equipList=list
            this.vm.data.equipContentAnchor=Vector2(0,0)
        end
    },
    equip_attrBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.curEquipAttrSelectIndex=tonumber(param)+1
            this.vm.data.isOperate=true;
            this.vm.data.isOperate_equipAttr=true;
            local list={}
            for i,v in ipairs(this.cfg_jobEquipAttr) do
                if this.hasEquipAttr[v.id]==nil then
                    local attrItem={
                        color=this.color_gray,
                        id=v.id,
                        attrInfo=LuaMgr.GetLangText(v.NameLan),
                        text=string.format("%s(%s)",v.id,LuaMgr.GetLangText(v.NameLan))
                    }
                    table.insert(list,attrItem)
                end
            end
            table.sort(list,function(a,b)return a.id<b.id  end)
            this.vm.data.equipAttr=list
        end
    },
    equip_closeBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.isEquipPanel=false
        end
    },
    equip_confrimBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.isEquipPanel=false

            askData.AdditionalAttrs={}
            for i,v in ipairs(this.vm.data.equipAttrList) do
                local askAttr={
                    id=v.attrId,
                    level=tonumber(v.level)
                }
                table.insert(askData.AdditionalAttrs,askAttr)
            end
            askData.EquipmentID=this.vm.data.equip_Id
            local level=tonumber(this.vm.data.equip_level)
            askData.ELevel=level>60 and 60 or level
            local star=tonumber(this.vm.data.equip_star)
            askData.EStar=star>6 and 6 or star

            local grade = 0
            if level < 15 then
                grade = 0
            elseif level < 30 then
                grade = 1
            elseif level < 45 then
                grade = 2
            else
                grade = 3
            end
            askData.EquipmentGrade=grade
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.callBack=vm.behaviour.Params[0]
        this.ParseData();
    end,
    after_deactive = function(vm)
        if vm.behaviour.Params ~= nil then

        end
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params ~= nil then
            
        end

    end
}

this.ParseData=function()
    askData={
        CharacterID="",
        Level=1,
        Star=1,
        Talent={},
        Prestige=1,
        EquipmentID="",
        ELevel=1,
        EStar=1,
        AdditionalAttrs={},
        Optional={},
        PrestigeLevel=1,
    }
    this.cfg_charactersList={}
    for i,v in pairs(ConfigMgr.Config.characterTable) do
        table.insert(this.cfg_charactersList,v);
    end
    table.sort(this.cfg_charactersList,function(a, b) return a.id<b.id end)
    this.cfg_TalentMap=ConfigMgr.Config.characterTalentMap
    this.cfg_TalentBankMap=ConfigMgr.Config.talentBankMap
    this.cfg_equipMap=ConfigMgr.Config.equipments
    this.cfg_equipAttr=ConfigMgr.Config.additionalAttrs
    this.SetHeroMainInfo(1);
end

this.SetHeroMainInfo=function(index)
    local characterId=this.cfg_charactersList[index].id;
    this.dataCharacter=DataMgr.Player.characters[characterId];
    this.vm.data.hero_ID=characterId
    this.vm.data.hero_Info=string.format("%s(%s)",this.cfg_charactersList[index].id,LuaMgr.GetLangText(this.cfg_charactersList[index].namelan));
    this.vm.data.hero_level=this.dataCharacter~=nil and this.dataCharacter.level or "1"
    this.vm.data.hero_star=this.dataCharacter~=nil and this.dataCharacter.star or "1"
    this.vm.data.hero_PrestigeLevel=this.dataCharacter~=nil and this.dataCharacter.prestigeLevel or "1"
    this.vm.data.hero_Prestige=this.dataCharacter~=nil and this.dataCharacter.prestige or "1"
    this.talentList={}
    local rare=ConfigMgr.Config.characterTable[characterId].rare
    for i,v in pairs(this.cfg_TalentMap) do
        if v.characterId==this.vm.data.hero_ID and (v.colorClass==0 or v.colorClass==rare) then
            table.insert(this.talentList,v)
        end
    end
    table.sort(this.talentList,function(a, b) return a.index<b.index end)
    if this.dataCharacter~=nil  then
        askData.Talent=DataMgr.Player.characters[characterId].talents
    else
        local talentMap={}
        for i,v in ipairs(this.talentList) do
            local talent={
                id=v.id,
                status=0,
                option="",
            }
            talentMap[talent.id]=talent
        end
        askData.Talent=talentMap
    end

    if this.dataCharacter~=nil  then
        askData.Optional=DataMgr.Player.characters[characterId].optional
    end
    
    local constants = ConfigMgr.Config.constants
    this.maxLevel = constants.maxCharacterLevel
    this.vm.data.hero_LevelRandom = string.format(LuaMgr.GetLangText("GMHeroTestPanel_UI_11"),this.maxLevel)
end

this.SetTalentOptional=function (characterId)
    this.vm.data.isTalentOptionalPanel=true;
    local attrConfig = ConfigMgr.Config.characterOptionalMap[characterId]
    local tempObject=this.vm.behaviour.transform:Find("template/talentOptionalItem").gameObject
    local parentTran=this.vm.behaviour.transform:Find("root/Middle/BG/TalentOptional/BG/ScrollView/Viewport/Content")
    for i = 1, #attrConfig, 1 do
        local temp=TalentOptionItem.New(tempObject,parentTran);
        temp:SetData(characterId,i);
        table.insert(this.talentOptionItemList,temp);
    end
end

this.SubmitTalentOptional=function ()
    for key, value in pairs(this.talentOptionItemList) do
        askData.Optional[value.OptionId]=value.dropdown.value
    end
    for key, value in pairs(this.talentOptionItemList) do
        value:Destroy();
    end
    this.talentOptionItemList={};
    this.vm.data.isTalentOptionalPanel=false
end

this.CancelTalentOptional=function ()
    for key, value in pairs(this.talentOptionItemList) do
        value:Destroy();
    end
    this.talentOptionItemList={};
    this.vm.data.isTalentOptionalPanel=false
end

this.GetBeforeAllExp = function(level)
    return ConfigMgr.Config.friendshipLevelUp[tostring(level)]
end

this.SetEquipAttr=function(equip,dataEquip)
    local dataAdditionalAttrs=nil
    if dataEquip~=nil and dataEquip.additionalAttrs~=nil and #dataEquip.additionalAttrs>0 then
        dataAdditionalAttrs=dataEquip.additionalAttrs;
    end
    local list={}
    for i=1,3,1 do
        local item={id="",level="0"}
        if dataAdditionalAttrs~=nil and i<=#dataAdditionalAttrs then
            item=dataAdditionalAttrs[i]
        end
        local attrInfo=item.id~="" and LuaMgr.GetLangText(this.cfg_equipAttr[item.id].NameLan) or ""
        local attrItem={
            attrInfo=attrInfo,
            attrId=item.id,
            level=item.level,
        }
        table.insert(list,attrItem)
    end
    this.vm.data.equipAttrList=list;
    this.hasEquipAttr={}


    this.cfg_jobEquipAttr={}
    for i,v in pairs(this.cfg_equipAttr) do
        if this.IsContainsJob(v.job,equip.job) then
            if equip.rare==2 and v.Rweight>0 then
                table.insert(this.cfg_jobEquipAttr,v)
            elseif equip.rare==3 and v.SRweight >0 then
                table.insert(this.cfg_jobEquipAttr,v)
            elseif equip.rare==4 and v.SSRweight>0 then
                table.insert(this.cfg_jobEquipAttr,v)
            elseif equip.rare==5 and v.URweight>0 then
                table.insert(this.cfg_jobEquipAttr,v)
            end
        end
    end
end

this.IsContainsJob=function(jobs,job)
    for i,v in ipairs(jobs) do
        if v==job then
            return true
        end
    end
    return false
end

return vm(
{
    data = data,
    command = command,
    hook = hook
})