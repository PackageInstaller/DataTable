






local this = {vm=nil};
local data = {
    activityBarList={{on=false,off=false,name="",panel="",offset=Vector2(0,0),redId="",key="",order=0,onIcon=DefaultSprite,offIcon=DefaultSprite}},
    bgTexture=DefaultTexture;
    showNomalBg=false;        
    contentAnchorPos = Vector2(0, 0);
}
local curIndex=0;
local curPopPanelName=nil;
local questIndex=0;
local activityBarNames={}
local path="Images/Activity/";
local command = {

    activityBarBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local NO=tonumber(param)+1;
            if(NO==curIndex) then return end;
            local key=this.vm.data.activityBarList[NO].key;
            if not ActivityMgr.ActivityRuning(key) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"))
                return
            end
            curIndex=NO;
            for i=1,#this.vm.data.activityBarList,1 do
                this.vm.data.activityBarList[i].on=i==NO;
                this.vm.data.activityBarList[i].off=i~=NO;
            end
            RedMgr.Singleton:Refresh();
            this.SwitchPanel(NO);
        end
    },
    
}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        RedMgr.Singleton:RegisterViewModel(UIName.ActivityOnViewModel);
        print("before_awake");
    end,
    before_active = function(vm)
        print("before_active");
        PlayerRhythmGameMgr.CheckPanleEntranceRedDot()
        PlayerSlgMgr.CheckEntranceRedAndNewDot()
        if (vm.behaviour.Params ~= nil) then
            vm.behaviour:UpdateTopBar("",this.OnBack);
            activityBarNames=ActivityMgr.activityKeyList;
            table.sort(activityBarNames,function(a,b) 
                return a.orderSum<b.orderSum;
            end)
            local page=nil;
            if HeroParameter.activityKey~=nil then
                page=HeroParameter.activityKey;
                HeroParameter.EmptyActivityKey();
this.vm.data.contentAnchorPos=Vector2(0,0);
            elseif vm.behaviour.Params.Length>0 then
                page=tostring(vm.behaviour.Params[0]);
            else
                page=ConfigMgr.Config.constants.DefaultActivityKey;
                if page==nil or page=="" then
                   page="travel";
                end
                if not ActivityMgr.ActivityRuning(page) then
                    page=ActivityMgr.ActivityRunningAnyOne();
                end
this.vm.data.contentAnchorPos=Vector2(0,0);
            end
            ActivityMgr.surveying=false;
            this.ParseData(page);
HeroRedDataHelper.InitCanFinishRedData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        curIndex=0
        LuaMgr.HidePanels();
    end,
}


this.OnBack=function()
    if(ActivityMgr.surveying) then
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,LuaMgr.GetLangText("ActivityOnViewModel_6"),function()
            ActivityMgr.surveying=false;
            this.CloseTopPanel();
            LuaMgr.Back()
        end,nil)
    else
        this.CloseTopPanel();
        LuaMgr.Back()
    end
end


this.CloseTopPanel=function()
    if(curPopPanelName~=nil) then
        LuaMgr.HidePanel(curPopPanelName);
    end
end

this.ParseData=function(page)
    local runActivityBarNames={};
    for i,v in ipairs(activityBarNames) do
        if  ActivityMgr.ActivityRuning(v.key) then
            table.insert(runActivityBarNames,v);
        end
    end
    activityBarNames=runActivityBarNames;
    local NO=1;
    for i,v in ipairs(activityBarNames) do
        if v.key==page then
            NO=i;
            break;
        end
    end
    this.RefrushActivityBar(NO,true);
end





this.RefrushActivityBar=function(NO,show)
    this.vm.data.activityBarList={};
    local list={};
    local index=1;



    for i,v in ipairs(activityBarNames) do
        local item={
            name=v.name,
            on=i==NO,
            off=i~=NO,
            panel=v.panel,
            offset=Vector2(0,0),
            redId=v.RedId,
            key=v.key,
            onIcon=LuaMgr.GetSprite("ActivePanelIcon", "ui_hd_icon_"..v.key),
            offIcon=LuaMgr.GetSprite("ActivePanelIcon", "ui_hd_icon_"..v.key.."_1"),
        }
        if i==NO then
            curIndex=index;
        end
        index=index+1;
        if v.key == ActivityKey.RogueLike and not IsNullOrEmpty(v.text) and RogueMgr.CheckRogueLike2IsOpen() then
            item.onIcon = LuaMgr.GetSprite("ActivePanelIcon", "ui_hd_icon_" .. v.text)
            item.offIcon = LuaMgr.GetSprite("ActivePanelIcon", "ui_hd_icon_" .. v.text .. "_1")
        end
        table.insert(list,item);

        if v.key=="questionnaire" then
            questIndex=i;
        end
    end
    this.vm.data.activityBarList=list;
    if(show) then
        local sub=activityBarNames[NO];
        this.ShowPanel(sub);
    end
end



this.ShowPanel=function(sub)
    if(curPopPanelName~=nil) then
        LuaMgr.HidePanel(curPopPanelName);
    end
    this.SetBGTexture(sub);
    LuaMgr.ShowLuaPanel(sub.panel);
    curPopPanelName=sub.panel;
    this.closeRedData(sub);
end

this.SetBGTexture=function(sub)
    this.vm.data.showNomalBg=false;
    if sub.panel==UIName.ActivityQuestionsurveyViewModel then
        this.vm.data.bgTexture=LuaMgr.GetTexture(path.."ui_hd_dcwj_bj.png")
    elseif sub.panel==UIName.ActivityTourismViewModel then
        this.vm.data.bgTexture=LuaMgr.GetTexture(path.."ui_yysh_bj02.png")
    elseif sub.panel==UIName.ActivitySlgViewModel then
        this.vm.data.bgTexture = LuaMgr.GetTexture("Assets/_BundleResources/Images/Slg/ui_hd_dq_rk_bj.jpg");
    elseif sub.panel==UIName.WalkMountActivityViewModel then
        this.vm.data.bgTexture=LuaMgr.GetTexture(path.."ui_sgwcs_rk_bj.png")
    elseif sub.panel==UIName.ActivityFlowerViewModel then
        this.vm.data.bgTexture=LuaMgr.GetTexture(path.."ui_hd_hzj_rk_bj.png")
    elseif sub.panel==UIName.ActivityUpactorTempOneViewModel or sub.panel==UIName.ActivityUpactorTempTwoViewModel 
            or sub.panel==UIName.ActivityUpactorTempThreeViewModel  or sub.panel==UIName.ActivityUpactorTempFourViewModel then
        this.vm.data.bgTexture=LuaMgr.GetTexture(path.."ui_sy_ty_bj.jpg")
    elseif  sub.panel==UIName.ActivityCZFLRechargeViewModel then
        this.vm.data.bgTexture=LuaMgr.GetTexture(path.."ui_hd_lcjk_bg.png")
    elseif sub.panel==UIName.ActivitySignInJinYuZhuRiViewModel then
        this.vm.data.bgTexture=LuaMgr.GetTexture(path.."ui_hd_qd_jyzr_bj.png")
    else
        this.vm.data.bgTexture=LuaMgr.GetTexture(path.."ui_hd_bj.png")
this.vm.data.showNomalBg=false;
    end
end


this.closeRedData=function(sub)
    if(sub.key=="cdkey") then
        RedMgr.Singleton:UpdateClientRedData("1015",0);
        RedMgr.Singleton:FrushRedCondition("1015")
    elseif(sub.key=="questionnaire") then
        RedMgr.Singleton:UpdateClientRedData("1016",0);


    end
    RedMgr.Singleton:Refresh();
end



this.SwitchPanel=function(NO)
    if(ActivityMgr.surveying) then
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,LuaMgr.GetLangText("ActivityOnViewModel_7"),function()
            ActivityMgr.surveying=false;
            local sub=this.vm.data.activityBarList[NO];
            this.ShowPanel(sub);
        end,function()
            curIndex=questIndex;
            this.RefrushActivityBar(questIndex);
        end)
    else
        local sub=this.vm.data.activityBarList[NO];
        this.ShowPanel(sub)
    end
end


return vm({
    data = data,
    command = command,
    hook = hook
})