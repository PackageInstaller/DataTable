





local this = {
    vm=nil,
    noticeList={},
    curType=nil,
    whiteColor=UnityEngine.Color(217/255,217/255,217/255,1),
    blackColor=UnityEngine.Color(38/255,36/255,41/255,1),
    curBarIndex=nil,
    text_linkText=nil,
    textImage_linkText=nil,
    img_tarURL=nil,
    textImg_tarURL=nil,
    textConetentRect=nil,
    textImageContentRect=nil,
    gameScene=nil,
    isGuestPop=false,
    isFirst=false;
}

local data = {
    noticeBarList={
        {
            select=false;
            barName="";
            color=this.whiteColor;
            redId="";
        }  
    },
    noticeTypeList={
        {
            isOn=false;
            colorText=this.whiteColor;
        },
        {
            isOn=false;
            colorText=this.whiteColor;
        },
        {
            isOn=false;
            colorText=this.whiteColor;
        }
    },
    middleBool=true;
    panelType={false,false,false};

    text_date="",
    text_dateLunar="",
    text_dataLunarMonth="",
    

    text_Title="";
    text_Body="";
    text_linkText=nil;
    text_contentAnchor=Vector2(0,0);
    

    imageURl="",
    

    
    textImageURL="",
    textImage_text="",
    textImage_contentAnchor=Vector2(-406,0);
    
    animaName="",
}

local command = {
    imageGoBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          if this.img_tarURL~=nil and this.img_tarURL~="" then
              LuaMgr.HidePanel(UIName.NoticeNormalViewModel)
              NoticeMgr.GoToPanel(this.img_tarURL);
          end
      end
    },
    textImageGotoBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if this.textImg_tarURL~=nil and this.textImg_tarURL~="" then
                LuaMgr.HidePanel(UIName.NoticeNormalViewModel)
                NoticeMgr.GoToPanel(this.textImg_tarURL);
            end
        end
    },
    noticeBarBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local barIndex=tonumber(param)+1;
            if this.curBarIndex==barIndex then return end;
            this.curBarIndex=barIndex;
            local noticeItem=this.noticeList[this.curType][barIndex]
            for i,v in ipairs(this.vm.data.noticeBarList) do
                v.select=i==this.curBarIndex;
                v.color=i==this.curBarIndex and this.whiteColor or this.blackColor;
            end
            this.ShowNotice(noticeItem);
        end
    },
    noticeTypeBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param);
            this.curType=index;
            this.curBarIndex=1;
            this.ShowNoticeByType();
        end
    },
    closeBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.animaName="UI_NoticePanel_02";
            coroutine_runner.start(function()
                coroutine_runner.wait(0.5);
                RedMgr.Singleton:RefreshOtherViewModel(UIName.MainPageViewModel);
                LuaMgr.HidePanel(UIName.NoticeNormalViewModel);
                
            end)
        end
    }
    
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        RedMgr.Singleton:RegisterViewModel(UIName.NoticeNormalViewModel);
        this.textConetentRect=vm.behaviour.transform:Find("root/Middle/Bg/NoticePanels/TextType/Viewport/Content/"):GetComponent("RectTransform");
        this.textImageContentRect=vm.behaviour.transform:Find("root/Middle/Bg/NoticePanels/ImgeAndTextType/Viewport/Content/"):GetComponent("RectTransform");
        this.text_linkText=vm.behaviour.transform:Find("root/Middle/Bg/NoticePanels/TextType/Viewport/Content/Body"):GetComponent("HyperlinkText");
        this.textImage_linkText=vm.behaviour.transform:Find("root/Middle/Bg/NoticePanels/ImgeAndTextType/Viewport/Content/Body"):GetComponent("HyperlinkText");
        this.text_linkText.onHrefClick:AddListener(this.OnOpenUrl);
        this.textImage_linkText.onHrefClick:AddListener(this.OnOpenUrl);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.isGuestPop=false;
        if  vm.behaviour.Params.Length>0 then
            local data=vm.behaviour.Params;
            this.gameScene=data[0];
            if vm.behaviour.Params.Length>1 then
                this.isGuestPop=data[1]=="guest";
            end
        end
        this.curType=2;
        this.curBarIndex=1;
        this.vm.data.animaName="UI_NoticePanel_01";
        this.isFirst=true;
        this.ParseData();

    end,
    before_deactive = function(vm)
        this.curBarIndex=nil;
        this.noticeList={};
        this.vm.data.textImage_contentAnchor=Vector2(-406,0)
        this.vm.data.text_contentAnchor=Vector2(0,0);


    end
}

this.ParseData=function()
    this.ShowDate();
    this.noticeList=NoticeMgr.normalNotices;
    if this.isGuestPop then
        this.noticeList=this.CheckGuestPopup(this.noticeList)
    end



    this.ShowNoticeByType();
    
end

this.ShowDate=function()
    this.vm.data.text_date=LuaMgr.GetUnitxDate(NoticeMgr.serverTimeStamp);
    this.vm.data.text_dataLunarMonth=LuaMgr.GetLunarDateByMD(NoticeMgr.serverTimeStamp);
    this.vm.data.text_dateLunar=LuaMgr.GetDataByChEraLunar(NoticeMgr.serverTimeStamp);
end



this.OnOpenUrl=function(url)
    LuaMgr.OpenURL(url);
end


this.CheckGuestPopup=function(notices)
    local newNoticeList={}
    if notices==nil or #notices==0 then return notices end;
    for i,v in ipairs(notices) do
        local list={}
        for p,m in ipairs(v) do
            if m.PopupType==1 then
                table.insert(list,m);
            else
                NoticeMgr.normalNoticesRed[i][m.ID]=0;
            end
        end
        table.insert(newNoticeList,list);
    end
    return newNoticeList;
end


this.SetNoticeBar=function()
    this.vm.data.noticeBarList={};
    local curTypeNoticeList = this.noticeList[this.curType]
    if curTypeNoticeList==nil then return end;
    local list={};
    for i,v in ipairs(curTypeNoticeList) do
        local noticeBarItem={
            select=i==1;
            barName=v.Title;
            color=i==1 and this.whiteColor or this.blackColor;
            redId="1003_"..v.ID;
        }
        table.insert(list,noticeBarItem);
        local redNum=NoticeMgr.normalNoticesRed[this.curType][v.ID];
        RedMgr.Singleton:UpdateClientRedData("1003_"..v.ID,redNum);
    end

    this.vm.data.noticeBarList=list;
    RedMgr.Singleton:Refresh();
    local noticeItem=curTypeNoticeList[1]
    this.ShowNotice(noticeItem);
    
end


this.ShowNoticeByType=function()
    for i,v in ipairs(this.vm.data.noticeTypeList) do
        v.isOn=this.curType==i;
        v.colorText=this.curType==i  and this.whiteColor or this.blackColor;
    end
    this.SetNoticeBar();
end



this.ShowNotice=function(notice)
    if notice==nil then
this.vm.data.panelType[1]=false;
this.vm.data.panelType[2]=false;
this.vm.data.panelType[3]=false;
        return
    end;
this.vm.data.panelType[1]=notice.Template==1;
this.vm.data.panelType[2]=notice.Template==2;
this.vm.data.panelType[3]=notice.Template==3;

    if this.gameScene==1 and NoticeMgr.normalNoticesRed[this.curType][notice.ID]==1 then
        NoticeMgr.CompleteNotice(notice.ID,1,1)
    end
    NoticeMgr.ClearRedData(this.curType,notice.ID,this.gameScene);

    if notice.Template==1 then
        this.ShowNotice_Text(notice)
    elseif notice.Template==2 then
        this.ShowNotice_Image(notice)
    elseif notice.Template==3 then
        this.ShowNoitce_ImageText(notice);
    end
    
end
    





this.ShowNotice_Text=function(notice)
    this.vm.data.text_contentAnchor=Vector2(0,0);
    local content=LuaMgr.TextNo_BreakingSpace(notice.Contents);
    this.vm.data.text_Title=notice.Subtitle;
    this.vm.data.text_Body=content;
    if this.isFirst then
        this.isFirst=false;
        LuaMgr.NextFrame(function()
            RectTool.RebuildLayoutImmediate(this.textConetentRect);
        end)
    else
        RectTool.RebuildLayoutImmediate(this.textConetentRect);
    end
    
end



this.ShowNotice_Image=function(notice)
    this.img_tarURL=notice.ImgHref;
    this.vm.data.imageURl=notice.Img;
end


this.ShowNoitce_ImageText=function(notice)
    this.vm.data.textImage_contentAnchor=Vector2(-406,0)
    this.textImg_tarURL=notice.ImgHref;
    this.vm.data.textImageURL=notice.Img;
    this.vm.data.textImage_text=LuaMgr.TextNo_BreakingSpace(notice.Contents);
    if this.isFirst then
        this.isFirst=false;
        LuaMgr.NextFrame(function()
            RectTool.RebuildLayoutImmediate(this.textImageContentRect);
        end)
    else
        RectTool.RebuildLayoutImmediate(this.textImageContentRect);
    end
end


return vm({
    data = data,
    command = command,
    hook = hook
})