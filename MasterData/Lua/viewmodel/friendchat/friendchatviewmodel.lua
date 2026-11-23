




require("ViewModel/FriendChat/FriendChatMgr")
require("ViewModel/FriendChat/FriendChatThemeCfg")
require("ViewModel/FriendChat/FriendChat_FriendTypeItem")
require("ViewModel/FriendChat/FriendChat_StrangeItem")
require("ViewModel/FriendChat/FriendChat_OtherMsgItem")
require("ViewModel/FriendChat/FriendChat_MyMsgItem")
require("ViewModel/FriendChat/FriendChat_HeroItem")
require("ViewModel/FriendChat/FriendChat_StrangeInfoItem")
require("ViewModel/FriendChat/FriendChat_MyOptionItem")
require("ViewModel/FriendChat/FriendChat_AsideItem")
require("ViewModel/FriendChat/FriendChatHelpFightViewModel")

require("ViewModel/FriendChat/FriendChat_AssistItem")

local this = {vm=nil,
              chatScrollView=nil;
              friendUIList=nil;
              heroScrollView=nil;
              strangeUIList=nil;
addStrangeScrollView=nil;
agreeStrangeScrollView=nil;
maskStrangeScrollView=nil;
              
              
              myMsgItemObj=nil;
              otherMsgItemObj=nil;
              friendTypeItemObj=nil;
              strangeItemObj=nil;
              heroItemObj=nil;
              strangeInfoItem=nil;
              myMsgOptionItem=nil;
              asideMsgItemObj=nil;
              assistItemObj=nil;
};

local friendChatHelpFight=nil;

local friendTypeList={};
local strangerTypeList={}
local helpTypeList={}
local friendIsOn=false;
local msgItemText=nil;
local msgNameText=nil;
local friendList={};
local characterList={};
local characterMsgList={};
local curTypeIndex=nil;
local curFriendIndex=nil;
local curCharacterIndex=nil;
local curHeroIndex=nil;
local curHeroHeadIndex=nil;
local curStrangerIndex=nil;
local curFriendInfo=nil;
local lastHeroViewHeight=nil;
local coReply=nil;
local recommendFriends=nil;
local scrollChatIndex=nil;
local onDragBehaviour=nil;
local offVector=nil;
local screenFirstUid=nil;



local localConfig={
    friendType_Height=60,
    friendOp_Height=60,
    friendSpacing=5,
    txtMinWidth=68,
    txtMaxWidth=522;
}

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local goFriendlView = nil;
local goHerolView = nil;
local goFriendInfo = nil;
local goFavorTag = nil;
local goFavorOn = nil;
local goFavorOff = nil;
local goChat = nil;
local goChatView = nil;
local goTips = nil;
local goInput = nil;
local goNoFriend = nil;
local goNoChat = nil;
local goNoFriendApply = nil;
local goNoFriendMask = nil;
local goAgreeStranger = nil;
local goAgreeStrangeView = nil;
local goAddStranger = nil;
local goPush = nil;
local goNoFriendSerch = nil;
local goAddStrangeView = nil;
local goMaskStranger = nil;
local goMaskStrangeView = nil;
local goHelpRoot = nil;
local goFree = nil;
local goPvPreviewContent = nil;
local Right = nil;
local imgHeadIcon = nil;
local imgMyAvatarFrame = nil;
local imgAvatarFrame = nil;
local imgChatOtherHeadFrame = nil;
local btnAddFriend = nil;
local btnAgreeFriend = nil;
local btnRefuseFriend = nil;
local btnDeleteFriend = nil;
local btnMyZoom = nil;
local btnCloseFriendInfo = nil;
local btnRemarks = nil;
local btnZoom = nil;
local btnFavor = nil;
local btnVisit = nil;
local btnDelete = nil;
local btnReport = nil;
local btnFilter = nil;
local btnFace = nil;
local btnSendMsg = nil;
local btnAutoMsg = nil;
local btnAgreenAll = nil;
local btnRefuseAll = nil;
local btnSearchFriend = nil;
local btnNextGroup = nil;
local btnDeleteAll = nil;
local btnClosePvPreview = nil;
local rawImageMyAvatar = nil;
local rawImageAvatar = nil;
local rawImageChatOtherHeadIcon = nil;
local rawImagePvPreview = nil;
local txtMyName = nil;
local txtMySummer = nil;
local txtLv = nil;
local txtName = nil;
local txtSignature = nil;
local txtChatOtherName = nil;
local txtChatOtherSummer = nil;
local txtTipMsgTime = nil;
local txtMaskPro = nil;
local txtClosePvPreview = nil;
local tranFriendContent = nil;
local tranHeroContent = nil;
local tranStrangeContent = nil;
local tranHelpFightContent = nil;
local tranChatContent = nil;
local inputMsg = nil;
local inputNameOrUid = nil;
local goDynamicAvatar = nil;
local tranFriendDynamicAvatar = nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goFriendlView = uiLink:Get("goFriendlView");
    goHerolView = uiLink:Get("goHerolView");
    goFriendInfo = uiLink:Get("goFriendInfo");
    goFavorTag = uiLink:Get("goFavorTag");
    goFavorOn = uiLink:Get("goFavorOn");
    goFavorOff = uiLink:Get("goFavorOff");
    goChat = uiLink:Get("goChat");
    goChatView = uiLink:Get("goChatView");
    goTips = uiLink:Get("goTips");
    goInput = uiLink:Get("goInput");
    goNoFriend = uiLink:Get("goNoFriend");
    goNoChat = uiLink:Get("goNoChat");
    goNoFriendApply = uiLink:Get("goNoFriendApply");
    goNoFriendMask = uiLink:Get("goNoFriendMask");
    goAgreeStranger = uiLink:Get("goAgreeStranger");
    goAgreeStrangeView = uiLink:Get("goAgreeStrangeView");
    goAddStranger = uiLink:Get("goAddStranger");
    goPush = uiLink:Get("goPush");
    goNoFriendSerch = uiLink:Get("goNoFriendSerch");
    goAddStrangeView = uiLink:Get("goAddStrangeView");
    goMaskStranger = uiLink:Get("goMaskStranger");
    goMaskStrangeView = uiLink:Get("goMaskStrangeView");
    goHelpRoot = uiLink:Get("goHelpRoot");
    goFree = uiLink:Get("goFree");
    goPvPreviewContent = uiLink:Get("goPvPreviewContent");
    Right = uiLink:Get("Right");
    imgHeadIcon = uiLink:Get("imgHeadIcon"):GetComponent("Image");
    imgMyAvatarFrame = uiLink:Get("imgMyAvatarFrame"):GetComponent("Image");
    imgAvatarFrame = uiLink:Get("imgAvatarFrame"):GetComponent("Image");
    imgChatOtherHeadFrame = uiLink:Get("imgChatOtherHeadFrame"):GetComponent("Image");
    btnAddFriend = uiLink:Get("btnAddFriend"):GetComponent("Button");
    btnAgreeFriend = uiLink:Get("btnAgreeFriend"):GetComponent("Button");
    btnRefuseFriend = uiLink:Get("btnRefuseFriend"):GetComponent("Button");
    btnDeleteFriend = uiLink:Get("btnDeleteFriend"):GetComponent("Button");
    btnMyZoom = uiLink:Get("btnMyZoom"):GetComponent("Button");
    btnCloseFriendInfo = uiLink:Get("btnCloseFriendInfo"):GetComponent("Button");
    btnRemarks = uiLink:Get("btnRemarks"):GetComponent("Button");
    btnZoom = uiLink:Get("btnZoom"):GetComponent("Button");
    btnFavor = uiLink:Get("btnFavor"):GetComponent("Button");
    btnVisit = uiLink:Get("btnVisit"):GetComponent("Button");
    btnDelete = uiLink:Get("btnDelete"):GetComponent("Button");
    btnReport = uiLink:Get("btnReport"):GetComponent("Button");
    btnFilter = uiLink:Get("btnFilter"):GetComponent("Button");
    btnFace = uiLink:Get("btnFace"):GetComponent("Button");
    btnSendMsg = uiLink:Get("btnSendMsg"):GetComponent("Button");
    btnAutoMsg = uiLink:Get("btnAutoMsg"):GetComponent("Button");
    btnAgreenAll = uiLink:Get("btnAgreenAll"):GetComponent("Button");
    btnRefuseAll = uiLink:Get("btnRefuseAll"):GetComponent("Button");
    btnSearchFriend = uiLink:Get("btnSearchFriend"):GetComponent("Button");
    btnNextGroup = uiLink:Get("btnNextGroup"):GetComponent("Button");
    btnDeleteAll = uiLink:Get("btnDeleteAll"):GetComponent("Button");
    btnClosePvPreview = uiLink:Get("btnClosePvPreview"):GetComponent("Button");
    rawImageMyAvatar = uiLink:Get("rawImageMyAvatar"):GetComponent("RawImage");
    rawImageAvatar = uiLink:Get("rawImageAvatar"):GetComponent("RawImage");
    rawImageChatOtherHeadIcon = uiLink:Get("rawImageChatOtherHeadIcon"):GetComponent("RawImage");
    rawImagePvPreview = uiLink:Get("rawImagePvPreview"):GetComponent("RawImage");
    txtMyName = uiLink:Get("txtMyName"):GetComponent("Text");
    txtMySummer = uiLink:Get("txtMySummer"):GetComponent("Text");
    txtLv = uiLink:Get("txtLv"):GetComponent("Text");
    txtName = uiLink:Get("txtName"):GetComponent("Text");
    txtSignature = uiLink:Get("txtSignature"):GetComponent("Text");
    txtChatOtherName = uiLink:Get("txtChatOtherName"):GetComponent("Text");
    txtChatOtherSummer = uiLink:Get("txtChatOtherSummer"):GetComponent("Text");
    txtTipMsgTime = uiLink:Get("txtTipMsgTime"):GetComponent("Text");
    txtMaskPro = uiLink:Get("txtMaskPro"):GetComponent("Text");
    txtClosePvPreview = uiLink:Get("txtClosePvPreview"):GetComponent("Text");
    tranFriendContent = uiLink:Get("tranFriendContent"):GetComponent("RectTransform");
    tranHeroContent = uiLink:Get("tranHeroContent"):GetComponent("RectTransform");
    tranStrangeContent = uiLink:Get("tranStrangeContent"):GetComponent("RectTransform");
    tranHelpFightContent = uiLink:Get("tranHelpFightContent"):GetComponent("RectTransform");
    tranChatContent = uiLink:Get("tranChatContent"):GetComponent("RectTransform");
    inputMsg = uiLink:Get("inputMsg"):GetComponent("InputField");
    inputNameOrUid = uiLink:Get("inputNameOrUid"):GetComponent("InputField");
    goDynamicAvatar = uiLink:Get("goDynamicAvatar"):GetComponent("PlayerDynamicAvatar");
    tranFriendDynamicAvatar = uiLink:Get("tranFriendDynamicAvatar"):GetComponent("PlayerDynamicAvatar");
    this.AddRigister(uiLink);
end


this.Clear = function()
    PlayerAvatarFrameTool.ClearImage(imgMyAvatarFrame)
    PlayerAvatarFrameTool.ClearImage(imgAvatarFrame)
    PlayerAvatarFrameTool.ClearImage(imgChatOtherHeadFrame)
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    goFriendlView = nil;
    goHerolView = nil;
    goFriendInfo = nil;
    goFavorTag = nil;
    goFavorOn = nil;
    goFavorOff = nil;
    goChat = nil;
    goChatView = nil;
    goTips = nil;
    goInput = nil;
    goNoFriend = nil;
    goNoChat = nil;
    goNoFriendApply = nil;
    goNoFriendMask = nil;
    goAgreeStranger = nil;
    goAgreeStrangeView = nil;
    goAddStranger = nil;
    goPush = nil;
    goNoFriendSerch = nil;
    goAddStrangeView = nil;
    goMaskStranger = nil;
    goMaskStrangeView = nil;
    goHelpRoot = nil;
    goFree = nil;
    goPvPreviewContent = nil;
    Right = nil;
    imgHeadIcon = nil;
    imgMyAvatarFrame = nil;
    imgAvatarFrame = nil;
    imgChatOtherHeadFrame = nil;
    btnAddFriend = nil;
    btnAgreeFriend = nil;
    btnRefuseFriend = nil;
    btnDeleteFriend = nil;
    btnMyZoom = nil;
    btnCloseFriendInfo = nil;
    btnRemarks = nil;
    btnZoom = nil;
    btnFavor = nil;
    btnVisit = nil;
    btnDelete = nil;
    btnReport = nil;
    btnFilter = nil;
    btnFace = nil;
    btnSendMsg = nil;
    btnAutoMsg = nil;
    btnAgreenAll = nil;
    btnRefuseAll = nil;
    btnSearchFriend = nil;
    btnNextGroup = nil;
    btnDeleteAll = nil;
    btnClosePvPreview = nil;
    rawImageMyAvatar = nil;
    rawImageAvatar = nil;
    rawImageChatOtherHeadIcon = nil;
    rawImagePvPreview = nil;
    txtMyName = nil;
    txtMySummer = nil;
    txtLv = nil;
    txtName = nil;
    txtSignature = nil;
    txtChatOtherName = nil;
    txtChatOtherSummer = nil;
    txtTipMsgTime = nil;
    txtMaskPro = nil;
    txtClosePvPreview = nil;
    tranFriendContent = nil;
    tranHeroContent = nil;
    tranStrangeContent = nil;
    tranHelpFightContent = nil;
    tranChatContent = nil;
    inputMsg = nil;
    inputNameOrUid = nil;
    goDynamicAvatar = nil;
    tranFriendDynamicAvatar = nil;

end




this.AddRigister=function(uiLink)
    uiLink:AddClickEvent("btnRemarks",this.BtnRemarksExecute)
    uiLink:AddClickEvent("btnZoom",this.BtnRoomExecute)
    uiLink:AddClickEvent("btnFavor",this.BtnFavorExecute)
    uiLink:AddClickEvent("btnVisit",this.BtnVisitExecute)
    uiLink:AddClickEvent("btnReport",this.BtnReportExecute)
    uiLink:AddClickEvent("btnFilter",this.BtnFilterExecute)
    uiLink:AddClickEvent("btnDelete",this.BtnDeleteExecute)
    uiLink:AddClickEvent("btnCloseFriendInfo",this.BtnCloseFriendInfoExecute)

    uiLink:AddClickEvent("btnSearchFriend",this.BtnSearchFriendExecute)
    uiLink:AddClickEvent("btnNextGroup",this.BtnNextGroupExecute)
    uiLink:AddClickEvent("btnSendMsg",this.BtnSendMsgExecute)
    uiLink:AddClickEvent("btnAutoMsg",this.BtnAutoMsgExecute)
    uiLink:AddClickEvent("btnDeleteAll",function()
        this.StrangerDeleteCallBack(nil)
    end)
    uiLink:AddClickEvent("btnFace",function()
        LuaMgr.ShowLuaPanel(UIName.FriendChatFaceViewModel,this.SendFaceCallBack)
    end)

    uiLink:AddClickEvent("btnAgreenAll",function()
        this.StrangerAgreeOrRefuse(nil,true)
    end)

    uiLink:AddClickEvent("btnRefuseAll",function()
        this.StrangerAgreeOrRefuse(nil,false);
    end)
    uiLink:AddClickEvent("btnMyZoom",function()
        FriendChatMgr.FriendPersonalHome(DataMgr.Player.uid,function(data)
            LuaMgr.ShowLuaPanel(UIName.FriendPlayerInfoViewModel,data)
        end)
    end)

    uiLink:AddClickEvent("btnClosePvPreview",function()
        SetActive(goPvPreviewContent, false)
    end)
end


this.SendFaceCallBack=function(faceName)
    this.BtnSendMsgExecute(faceName)
end


this.BtnRemarksExecute=function()
    if curFriendInfo==nil then return end;
    LuaMgr.ShowLuaPanel(UIName.CommonInputViewModel,LuaMgr.GetLangText("FriendChatViewModel_8"),function(value)




        FriendChatMgr.UpdateRemarkNameOrFavor(curFriendInfo.Uid ,value,curFriendInfo.Special,function()
            LuaMgr.HidePanel(UIName.CommonInputViewModel);
            this.SetHeroScrollView(lastHeroViewHeight)
            if  not IsNullOrEmpty(value) then
                txtName.text=string.format("%s(%s)",value,curFriendInfo.Name);
            else
                txtName.text=string.format("%s",curFriendInfo.Name);
            end
        end);

    end)
    
end


this.BtnRoomExecute=function()
    if curFriendInfo==nil then return end;
    FriendChatMgr.FriendPersonalHome(curFriendInfo.Uid,function(data)
        LuaMgr.ShowLuaPanel(UIName.FriendPlayerInfoViewModel,data,curFriendInfo.CharacterData.CharacterInfoMap)
        this.SetPreSkipInfo();
    end)
end
  

this.BtnFavorExecute=function()
    if curFriendInfo==nil then return end;
    FriendChatMgr.UpdateRemarkNameOrFavor(curFriendInfo.Uid ,curFriendInfo.Remark,not curFriendInfo.Special,function()
        this.SetHeroScrollView(lastHeroViewHeight)
        curFriendInfo.Special=not curFriendInfo.Special;
        this.SetHeroOtherInfo(true);
    end);
end

this.BtnVisitExecute=function()
    if curFriendInfo==nil then return end;
    PlayerFoundationMgr.VisitFriend(curFriendInfo.Uid,false);
    this.SetPreSkipInfo();
end

this.BtnReportExecute=function()
    if curFriendInfo==nil then return end;
    LuaMgr.ShowLuaPanel(UIName.FriendReportViewModel,curFriendInfo.Name,function(data,msg)
        FriendChatMgr.ReportFriend(curFriendInfo.Uid,data,msg,function()
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("17003"))
        end)
    end)
end

this.BtnFilterExecute=function()
    if curFriendInfo==nil then return end;
    if not IsNull(FriendChatMgr.friendMapList.ShieldList) and #FriendChatMgr.friendMapList.ShieldList>0 then
        for i,v in ipairs(FriendChatMgr.friendMapList.ShieldList) do
            if curFriendInfo.Uid==v.Uid then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("17006"))
                return;
            end
        end
    end

    local tip=ConfigMgr.LangGlobal("17007");
    LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tip,function()
        local uids={};
        table.insert(uids,curFriendInfo.Uid)
        FriendChatMgr.ShieldFriend(uids,true,function()
            this.BtnCloseFriendInfoExecute();


            this.UpdateFriendList()
            this.FriendItemCallBack(2,true);
        end)
    end,nil)
end


this.BtnDeleteExecute=function()
    if curFriendInfo==nil then return end;
    local uids={};
    table.insert(uids,curFriendInfo.Uid)
    LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,ConfigMgr.LangGlobal("17005"),function()
        FriendChatMgr.DeleteFriend(uids,function()
            this.BtnCloseFriendInfoExecute();


            this.UpdateFriendList();
            this.FriendItemCallBack(2,true);
        end)
    end,nil);
   
end

this.BtnSearchFriendExecute=function()
    local uid=inputNameOrUid.text;
    if IsNullOrEmpty(uid) then

        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("17019"))
        return;
    else
        FriendChatMgr.FindFriend(uid,this.SetFriendAddList);
        SetActive(btnNextGroup.gameObject,false);
    end
end

this.BtnNextGroupExecute=function()
    FriendChatMgr.FindFriend("",this.SetFriendAddList)
end


this.BtnCloseFriendInfoExecute=function()
    SetActive(goFriendInfo,false);
end

this.BtnSendMsgExecute=function(face)
    local msg=""
    if face==nil then
        msg=inputMsg.text;
    else
        msg=FriendChatMgr.faceTag..face;
    end
    if IsNullOrEmpty(msg) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("17015"))
        return
    end
    if curFriendIndex==nil then 
        LuaDebug.error("curFriendIndex is nil  SendMsg Error")
        return
    end;
    local otherFriend=friendList[curFriendIndex]
    FriendChatMgr.SendMsg(otherFriend.Uid,msg,function(isScu)
        this.SendMsgCallBack(isScu,msg)
    end)
end

this.BtnAutoMsgExecute=function()
    local characterData=this.GetCurCharacterMsgData()
    this.SetReplyMsg(characterData)
    if characterData.ChatType==1 then
        this.StartAutoReply(false);
    end
end

local data={}
local command={}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        RedMgr.Singleton:RegisterViewModel(UIName.FriendChatViewModel);
        this.friendUIList=UIListView.New(tranFriendContent);
        this.heroScrollView=UIScrollView.New(goHerolView);
        this.heroScrollView.scrollCallBack=this.HeroScrollView
        this.chatScrollView=UIScrollView.New(goChatView);
        this.strangeUIList=UIListView.New(tranStrangeContent);
        this.agreeStrangeScrollView=UIScrollView.New(goAgreeStrangeView)
        this.addStrangeScrollView=UIScrollView.New(goAddStrangeView)
        this.maskStrangeScrollView=UIScrollView.New(goMaskStrangeView);
        
        this.strangeItemObj=vm.behaviour.transform:Find("template/strangeItem").gameObject;
        this.friendTypeItemObj=vm.behaviour.transform:Find("template/friendTypeItem").gameObject;
        this.myMsgItemObj=vm.behaviour.transform:Find("template/myMsgItem").gameObject;
        this.otherMsgItemObj=vm.behaviour.transform:Find("template/otherMsgItem").gameObject;
        this.heroItemObj=vm.behaviour.transform:Find("template/heroItem").gameObject
        this.strangeItemInfoObj=vm.behaviour.transform:Find("template/strangeInfoItem").gameObject;
        this.myMsgOptionItem=vm.behaviour.transform:Find("template/myMsgOptionItem").gameObject;
        this.asideMsgItemObj=vm.behaviour.transform:Find("template/asideMsgItem").gameObject;
        this.assistItemObj=vm.behaviour.transform:Find("template/assistItem").gameObject;
        
        msgItemText=this.myMsgItemObj.transform:Find("msg/msgText"):GetComponent("Text");
        msgNameText=this.myMsgItemObj.transform:Find("msg/namebg/msgName"):GetComponent("Text");
        friendTypeList={LuaMgr.GetLangText("FriendChatViewModel_9"),LuaMgr.GetLangText("FriendChatViewModel_10"),LuaMgr.GetLangText("FriendChatViewModel_11")}
        strangerTypeList={LuaMgr.GetLangText("FriendChatViewModel_12"),LuaMgr.GetLangText("FriendChatViewModel_13"),LuaMgr.GetLangText("FriendChatViewModel_14")}
        this.chatScrollView.scrollCallBack=this.ChatScrollViewCallBack;
        onDragBehaviour=goFriendInfo.transform:Find("Group/bg"):GetComponent("OnDragBehaviour");
        onDragBehaviour.onBeginDrag=this.FriendInfoOnBeginDrag
        onDragBehaviour.onDrag=this.FriendInfoOnDrag
      
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            vm.behaviour:UpdateTopBar("", function()
                LuaMgr.Back()
                HeroParameter.FriendSkipInfo=nil;
            end)
            curTypeIndex=nil;
            curFriendIndex=nil;
            curCharacterIndex=nil;
            curHeroIndex=nil;
            curHeroHeadIndex=nil;
            curStrangerIndex=nil;
            friendIsOn=false;
            characterMsgList={};
            friendList={};
            characterList={};
            screenFirstUid=nil;
            SetActive(goHerolView,false)
            SetActive(tranStrangeContent.gameObject,false)
            SetActive(tranHeroContent.gameObject,false)
            SetActive(goFriendInfo,false);
            SetActive(goPvPreviewContent,false);
            PlayerAssistMgr.UpdateFriendList2();
            this.ParseData();
            LuaMgr.AddUIEventListener(UIEventConst.FriendList,this.UpdateFriendList);
            LuaMgr.AddUIEventListener(UIEventConst.FriendMsg,this.UpdateFriendMsg);
            FriendChatMgr.UpdateFriendPlayerInfoRed()
            FriendChatMgr.ReFresh();
            PlayerAssistMgr.ClearCurAssistData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end;
        LuaMgr.RemoveUIEventListener(UIEventConst.FriendList,this.UpdateFriendList);
        LuaMgr.RemoveUIEventListener(UIEventConst.FriendMsg,this.UpdateFriendMsg);
        if coReply~=nil then
            coroutine_runner.stop(coReply);
            coReply=nil;
        end
        this.friendUIList:Clear()
        this.chatScrollView:Clear();
        this.heroScrollView:Clear();
        this.strangeUIList:Clear();
        this.addStrangeScrollView:Clear();
        this.agreeStrangeScrollView:Clear();
        this.maskStrangeScrollView:Clear();
        FriendChatMgr.RemoveTimer();
        if friendChatHelpFight~=nil then
            friendChatHelpFight:Clear();
        end
    end,
    before_destroy=function()
        UIScrollView.ClearItem("FriendChat_OtherMsgItem")
        UIScrollView.ClearItem("FriendChat_MyMsgItem")
        UIScrollView.ClearItem("FriendChat_HeroItem")
        UIListView.ClearItem("FriendChat_FriendTypeItem")
        UIListView.ClearItem("FriendChat_StrangeItem")
        UIScrollView.ClearItem("FriendChat_StrangeInfoItem")
        UIScrollView.ClearItem("FriendChat_MyOptionItem")
        UIScrollView.ClearItem("FriendChat_AsideItem")
        UIListView.ClearItem("FriendChat_AssistItem")
        if friendChatHelpFight~=nil then
            friendChatHelpFight:Destroy();
            friendChatHelpFight=nil;
        end
        this.Clear();
    end
}


this.SetPreSkipInfo=function()
    HeroParameter.FriendSkipInfo={
        heroIndex=curHeroHeadIndex;
        heroPos=tranHeroContent.anchoredPosition;
    }
end


this.UpdateFriendList=function(list)
    if this.friendUIList~=nil and #this.friendUIList.itemList>1 then
        this.friendUIList.itemList[2]:UpdateFriendPro(FriendChatMgr.FriendCount(),ConfigMgr.Config.FriendConstants.MaxFriends);
    end
    if  HeroParameter.FriendSkipInfo~=nil then
        local pos=HeroParameter.FriendSkipInfo.heroPos;
        HeroParameter.FriendSkipInfo=nil
        this.FriendItemCallBack(2,true);
        tranHeroContent.anchoredPosition=pos;
    end
end

this.UpdateFriendMsg=function(msg)
    if curFriendIndex==nil then return end;
    local otherFriend=friendList[curFriendIndex]
    if otherFriend~=nil then
        this.ReceiveNewMsg(otherFriend.Uid);
    end
end

this.ParseData=function()
    this.SetFriendTypeList();

    this.SetMyBaseInfo();
    this.SetFreeState(0);
end


this.SetMyBaseInfo=function()
    local avatarPath,avatarFrame,isDynamicAvatar=FriendChatMgr.GetAvatarAndAvatarFramePath(nil,nil);
    if not isDynamicAvatar then
        rawImageMyAvatar.texture=LuaMgr.GetTexture(avatarPath);
    else

        goDynamicAvatar:AppointAvatar(DataMgr.Player.Avatar)
    end
    SetActive(goDynamicAvatar.gameObject,isDynamicAvatar)
    SetActive(rawImageMyAvatar.gameObject,not isDynamicAvatar)
    PlayerAvatarFrameTool.SetAvatarFrame(imgMyAvatarFrame, avatarFrame)
    txtMyName.text=DataMgr.Player.name;
    txtMySummer.text=DataMgr.Player.motto;
end



this.SetFreeState=function(type)
    SetActive(goFree,type==0);
    SetActive(goNoFriend,type==1)
    SetActive(goNoChat,type==2)
    SetActive(goNoFriendApply,type==3)
    SetActive(goChat,type==4 or type==9)
    SetActive(goInput,type==4);
    SetActive(btnAutoMsg.gameObject,type==9);
    SetActive(goNoFriendMask,type==5)
    SetActive(goAgreeStranger,type==6)
    SetActive(goAddStranger,type==7)
    SetActive(goMaskStranger,type==8)
    SetActive(goHelpRoot,type==10);
end


this.SetFriendTypeList=function()
    this.friendUIList:Clear();
    local list={}
    local height=0;
    for i,v in ipairs(friendTypeList) do
        local friendItem={
            index=i,
            name=v,
            onlineCount=0,
            totalCount=0,
            callBack=this.FriendItemCallBack,
            sortCallBack=this.SortCallBack,
            redId=11001+i;
            posY=height;
        }
        if i==1 then
            friendItem.totalCount=FriendChatMgr.CharacterCount()
        elseif i==2 then
            friendItem.onlineCount=FriendChatMgr.FriendCount();
            if not IsNull(ConfigMgr.Config.FriendConstants) then
                friendItem.totalCount=ConfigMgr.Config.FriendConstants.MaxFriends
            else
                friendItem.onlineCount=0;
            end
        end
        height=height+localConfig.friendOp_Height+localConfig.friendSpacing;
        local friendData=UIListData.GetData(this.friendTypeItemObj,"FriendChat_FriendTypeItem",friendItem);
        table.insert(list,friendData);
    end
    this.friendUIList:SetData(list);
    tranFriendContent.sizeDelta=Vector2(346,height);
end

this.GetOnlineCount=function(type)
   
end



this.UpdateFriendListPosition=function(index,offHeight,isAnimation)
    local height=0;
    for i,v in ipairs(this.friendUIList.itemList) do
        v:SetPosition(-height,isAnimation)
        if index~=#this.friendUIList.itemList and i==index then
            height=height+localConfig.friendOp_Height+localConfig.friendSpacing+offHeight
        else
            height=height+localConfig.friendOp_Height+localConfig.friendSpacing
        end
    end

    tranFriendContent.sizeDelta=Vector2(346,height);
end


this.SortCallBack=function(index)
    if index==1 then
        LuaMgr.ShowLuaPanel(UIName.FriendChatSortViewModel,function()
            FriendChatMgr.SortCharacterChat();
            if curTypeIndex==1 then
                this.SetCharacterScrollView(lastHeroViewHeight);
            end
        end)
    end
end

this.FriendItemCallBack=function(index,isFresh)
    if isFresh==nil and curTypeIndex==index and friendIsOn then
        this.UpdateFriendListPosition(0,0,false)
        friendIsOn=false;
        this.SetSubHeroList(nil)
    else
        curCharacterIndex=nil;
        curFriendIndex=nil;
        curStrangerIndex=nil;
        friendIsOn=true;
        if index==1 and FriendChatMgr.CharacterCount()==0 then
            this.SetFreeState(1);
        elseif index==2 and FriendChatMgr.FriendCount()==0 then
            this.UpdateFriendListPosition(0,0,false)
            if this.heroScrollView~=nil then
                this.heroScrollView:Clear(true);
                SetActive(goHerolView,false);
            end
            this.SetFreeState(1);
        else
            local offHeight=LuaMgr.ScreenHeight()-math.abs(goFriendlView.transform.anchoredPosition.y)-(index+1)*(localConfig.friendType_Height+localConfig.friendSpacing)-localConfig.friendSpacing;
            local curHeight=0;
            if index==1 then
                curHeight=FriendChatMgr.CharacterCount()*92;
            elseif index==2 then
                curHeight=FriendChatMgr.FriendCount()*92;
            else
                curHeight=3*57;
            end
            if offHeight>curHeight then offHeight=curHeight end;
            this.UpdateFriendListPosition(index,offHeight,true)
            local posY=index*(localConfig.friendType_Height+localConfig.friendSpacing)
            this.SetSubHeroList(-posY,offHeight,index)
        end
    end
    curTypeIndex=index;
    for i,v in ipairs(this.friendUIList.itemList) do
        v:SetIsOn(friendIsOn and i==index)
    end
    
end



this.SetSubHeroList=function(posY,height,type)
    if posY==nil then 
        SetActive(goHerolView,false)
        this.SetFreeState(0)
        return
    end;
    SetActive(goHerolView,true);
    goHerolView.transform.anchoredPosition=Vector2(10,posY);
    goHerolView.transform.sizeDelta=Vector2(350,height);
    if type==4 then
        this.SetFreeState(10)
        if friendChatHelpFight==nil then
            friendChatHelpFight=FriendChatHelpFightViewModel.New(this.vm,goHelpRoot,tranHelpFightContent)
        end
        friendChatHelpFight:Enable();
    elseif type==3 then
        this.SetStrangerList();
        FriendChatMgr.UpdateFriendRed();
    elseif type==2 then
        friendList=FriendChatMgr.friendMapList.FriendsList
        this.SetFreeState(2);
        this.SetHeroScrollView(height);
        FriendChatMgr.UpdateHeroRed();
        this.UpdateFriendList();
    elseif type==1 then
        this.SetFreeState(2);
        this.SetCharacterScrollView(height);
        FriendChatMgr.UpdateCharacterRed();
    end
    SetActive(tranHeroContent.gameObject,type<3)
    SetActive(tranStrangeContent.gameObject,type==3);
    SetActive(tranHelpFightContent.gameObject,type==4)
end


this.SetHeroScrollView=function(viewHeight)
    lastHeroViewHeight=viewHeight;
    this.heroScrollView:Clear(true);
    tranHeroContent.anchoredPosition=Vector2(0,0);
    friendList=FriendChatMgr.GetFriendList();
    if IsNull(friendList) or #friendList==0 then


        return
    end;
    local  list={}
    local avatarPath,avatarFrame,isDynamicAvatar = nil,nil,false
    for i,v in ipairs(friendList) do
        avatarPath,avatarFrame,isDynamicAvatar=FriendChatMgr.GetAvatarAndAvatarFramePath(v.Avatar,v.AvatarFrame);
        local heroItem={
            index=i,
            uid=v.Uid,
            name=v.Name,
            remark=v.Remark,
            isOnline=v.Online,
            avatarPath=avatarPath,
            avatarFrame=avatarFrame,
            lastTime=v.OnlineTime,
            summary=v.Summary,
            isOn=false,
            isFavor=v.Special,
            callBack=this.FriendCallBack,
            headCallBack=this.FriendHeadCallBack;
            characterCallBack=nil;
            redId="11003_"..v.Uid,
            isFriend=true;
            isLike=v.Like,
            isDynamicAvatar = isDynamicAvatar,
            avatarId = v.Avatar,
            title = v.Title
        }
        local heroData=UIScrollData.GetData(this.heroItemObj,"FriendChat_HeroItem",328,92,heroItem);
        table.insert(list,heroData);
    end
    this.heroScrollView:SetParams(350,viewHeight)
    this.heroScrollView:SetData(list,false);
    goFriendInfo.transform:SetAsLastSibling();
end

this.HeroScrollView=function(screenData)
    if IsNull(screenData) or #screenData==0 then return end;
    if screenFirstUid~=screenData[1].data.uid then
        RedMgr.Singleton:Refresh();
    end
    screenFirstUid=screenData[1].data.uid;
end



this.SetCharacterScrollView=function(viewHeight)
    lastHeroViewHeight=viewHeight;
    this.heroScrollView:Clear(true);
    tranHeroContent.anchoredPosition=Vector2(0,0);
    characterList=FriendChatMgr.characterTypeList;
    local  list={}
    for i,v in ipairs(characterList) do
        local heroItem={
            index=i,
            uid=v.Uid,
            name=LuaMgr.GetLangText(v.TitleLan),
            remark="",
            isOnline=true,
            avatarPath=v.headPath,
            avatarFrame=v.AvatarFrame,
            lastTime=0,
            summary=v.Summary,
            isOn=false,
            isFavor=false,
            callBack=nil,
            characterCallBack=this.CharacterCallback,
            headCallBack=nil;
            redId="11002_"..v.Uid,
            isFriend=false;
            isLike=false,
            isDynamicAvatar = false
        }
        local heroData=UIScrollData.GetData(this.heroItemObj,"FriendChat_HeroItem",328,92,heroItem);
        table.insert(list,heroData);
    end
    this.heroScrollView:SetParams(350,viewHeight)
    this.heroScrollView:SetData(list,false);
end


this.CharacterCallback=function(index)
    if coReply~=nil then
        coroutine_runner.stop(coReply);
    end
    if curCharacterIndex==index then
        return
    end
    for i,v in ipairs(this.heroScrollView.dataList) do
        v.data.isOn=i==index;
    end
    for i,v in ipairs(this.heroScrollView.screenList) do
        v:IsOn(v.data.index==index);
    end
    curCharacterIndex=index;
    this.SetFreeState(9);
    local key=characterList[curCharacterIndex].Uid
    characterMsgList=FriendChatMgr.characterMsgMap[key]
    local characterInfo=characterList[index];
    this.SetChatMsgInfo(characterInfo,true)
    this.SetChatHisMsgList(characterInfo.Uid);

    SetActive(btnAutoMsg.gameObject,false);
    if not IsNull(this.chatScrollView.dataList) then
        local len=#this.chatScrollView.dataList;
        local lastItem=this.chatScrollView.dataList[len];
        if lastItem~=nil and lastItem.data.chatType==2 and lastItem.data.optionIndex==0 then

            return
        elseif lastItem~=nil and lastItem.data.chatType==5 and not this.CheckRedBagReward(lastItem.data.msgId) then

            return
        end
    end
    this.StartAutoReply(true);
    
end



this.FriendCallBack=function(index)
    if curFriendIndex==index then
        return
    end
    for i,v in ipairs(this.heroScrollView.dataList) do
        v.data.isOn=i==index;
    end
    for i,v in ipairs(this.heroScrollView.screenList) do
        v:IsOn(v.data.index==index);
    end
    curFriendIndex=index;
    this.SetFreeState(4);
    local otherFriend=friendList[curFriendIndex]
    FriendChatMgr.currentSelectFriendTitle = otherFriend.Title
    this.SetChatMsgInfo(otherFriend,false)
    this.SetChatHisMsgList(otherFriend.Uid,otherFriend);
    this.ReceiveNewMsg(otherFriend.Uid)
end


this.FriendHeadCallBack=function(index)
    curHeroHeadIndex=index
    SetActive(goFriendInfo,true);
    local pos=Vector2(0,tranHeroContent.anchoredPosition.y-index*82)
    goFriendInfo.transform.anchoredPosition=Vector2(pos.x+110,pos.y-60);
    curFriendInfo=friendList[index];
    this.SetHeroOtherInfo(true)
end


this.SetHeroOtherInfo=function(isFriend)
    if curFriendInfo==nil then return end;
    local avatarPath,avatarFrame=FriendChatMgr.GetAvatarAndAvatarFramePath(curFriendInfo.Avatar,curFriendInfo.AvatarFrame);
    rawImageAvatar.texture=LuaMgr.GetTexture(avatarPath);
    PlayerAvatarFrameTool.SetAvatarFrame(imgAvatarFrame, avatarFrame)
    txtLv.text=curFriendInfo.Lv;
    SetActive(goFavorOn,not curFriendInfo.Special)
    SetActive(goFavorOff,curFriendInfo.Special)
    SetActive(goFavorTag,curFriendInfo.Special)
    if not IsNullOrEmpty(curFriendInfo.Remark) then
        txtName.text=string.format("%s(%s)",curFriendInfo.Remark,curFriendInfo.Name);
    else
        txtName.text=string.format("%s",curFriendInfo.Name);
    end
    txtSignature.text=curFriendInfo.Motto;
    SetActive(btnRemarks.gameObject,isFriend);
    SetActive(btnFavor.gameObject,isFriend);
    SetActive(btnDelete.gameObject,isFriend)
end



this.SetStrangerList=function()
    this.strangeUIList:Clear();
    local list={}
    for i,v in ipairs(strangerTypeList) do
        local strangerItem={
            index=i,
            name=v,
            callBack=this.StrangerCallBack;
            redId="11004"
        }
        local strangerData=UIListData.GetData(this.strangeItemObj,"FriendChat_StrangeItem",strangerItem);
        table.insert(list,strangerData)
    end
    this.strangeUIList:SetData(list);
end


this.StrangerCallBack=function(index)
    if curStrangerIndex==index then return end;
    curStrangerIndex=index;
    for i,v in ipairs(this.strangeUIList.itemList) do
        v:SetEnable(i==index);
    end
    this.SetFreeState(0);
    if index==1 then
        this.SetFriendAgreeList();
    elseif index==2 then
        this.SetFreeState(7);
        SetActive(goAddStrangeView,false)
        SetActive(btnNextGroup.gameObject,true);
        inputNameOrUid.text="";
        this.BtnNextGroupExecute();
    elseif index==3 then
        this.SetFriendShieldList();
    end
end


this.SetFriendAgreeList=function()
    if FriendChatMgr.FriendApplyListCount()==0 then
        this.SetFreeState(3)
        return
    end
    this.SetFreeState(6);
    this.agreeStrangeScrollView:Clear(false);
    local applyList=FriendChatMgr.friendMapList.ApplyList
    this.SetFriendInfoViewByType(applyList,this.agreeStrangeScrollView,845,498,1)
end


this.SetFriendAddList=function(recommends)
    recommendFriends=recommends;
    this.addStrangeScrollView:Clear(false);
    if IsNull(recommendFriends) or #recommendFriends==0 then
        recommendFriends={};
        SetActive(goPush,false)
        SetActive(goPush,false)
        SetActive(goNoFriendSerch,true)
        return;
    end
    SetActive(goNoFriendSerch,false)
    SetActive(goAddStrangeView,true)
    local viewWidth,viewHeight=0,0
    if #recommendFriends>1 then
        SetActive(goPush,true)
        goAddStrangeView.transform.anchoredPosition=Vector2(11,-213)
        viewWidth=845;
        viewHeight=386;
    else
        SetActive(goPush,false)
        goAddStrangeView.transform.anchoredPosition=Vector2(11,-168)
        viewWidth=845;
        viewHeight=430;
    end
    goAddStrangeView.transform.sizeDelta=Vector2(viewWidth,viewHeight)
    this.SetFriendInfoViewByType(recommendFriends,this.addStrangeScrollView,viewWidth,viewHeight,2)
end




this.SetFriendShieldList=function()
    if FriendChatMgr.FriendShieldListCount()==0 then
        this.SetFreeState(5)
        return
    end
    this.SetFreeState(8)
    this.maskStrangeScrollView:Clear(false)
    local shieldList=FriendChatMgr.friendMapList.ShieldList;
    this.SetFriendInfoViewByType(shieldList,this.maskStrangeScrollView,845,498,3)
end


this.SetFriendInfoViewByType=function(opList,strangeScrollView,viewWidth,viewHeight,type)
   if curStrangerIndex==nil then return end;
    local list={}
    local avatarPath,avatarFrame,isDynamicAvatar=nil,nil,false
    for i,v in ipairs(opList) do
        avatarPath,avatarFrame,isDynamicAvatar=FriendChatMgr.GetAvatarAndAvatarFramePath(v.Avatar,v.AvatarFrame);
        local strangeItem={
            index=i,
            uid=v.Uid,
            name=v.Name,
            motto=v.Motto,
            avatarPath=avatarPath,
            avatarFrame=avatarFrame,
            lv=v.Lv,
            type=type,
            isType1Agree=false,
            isType1Refuse=false,
            isType1Op=0,
            type1AgreeOrRefuse=this.StrangerAgreeOrRefuse,
            isType2Add=false,
            type2AddFriendCallBack=this.StrangerAddFriendCallBack,
            type3DeleteCallBack=this.StrangerDeleteCallBack,
            headCallBack=this.StrangerHeadCallBack,
            assistObj=this.assistItemObj;
            characterData=v.CharacterData;
            isDynamicAvatar = isDynamicAvatar,
            avatarId = v.Avatar,
            title = v.Title
        }
        local strangeData=UIScrollData.GetData(this.strangeItemInfoObj,"FriendChat_StrangeInfoItem",841,88,strangeItem)
        table.insert(list,strangeData);
    end
    strangeScrollView:SetParams(viewWidth,viewHeight)
    strangeScrollView:SetData(list,false);
end

this.StrangerHeadCallBack=function(type,index,itemRect)
    local opInfo=nil;
    if type==1 then
        opInfo=FriendChatMgr.friendMapList.ApplyList[index]
        elseif type==2 then
        opInfo=recommendFriends[index]
        elseif type==3 then
        opInfo=FriendChatMgr.friendMapList.ShieldList[index]
    end
    if opInfo==nil then return end;
    curFriendInfo=opInfo;
    SetActive(goFriendInfo,true);
    local pos=RectTransformTool.ToContainer(itemRect,goFriendlView.transform)
    goFriendInfo.transform.anchoredPosition=Vector2(pos.x+100,pos.y-7);
    this.SetHeroOtherInfo(false)
    
end

this.StrangerDeleteCallBack=function(index)
    local uids={};
    if index~=nil then
        local uid= this.maskStrangeScrollView.dataList[index].data.uid;
        table.insert(uids,uid);
    else
        for i,v in ipairs(this.maskStrangeScrollView.dataList) do
            table.insert(uids,v.data.uid)
        end
    end
    FriendChatMgr.ShieldFriend(uids,false,function()
        this.SetFriendShieldList();
    end)
    
end


this.StrangerAddFriendCallBack=function(index)
    if FriendChatMgr.FriendCount()>=ConfigMgr.Config.FriendConstants.MaxFriends then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("17016"))
        return
    end
    local uid=this.addStrangeScrollView.dataList[index].data.uid;
    FriendChatMgr.AddFriend(uid,function()
        this.addStrangeScrollView.dataList[index].data.isType2Add=true;
        for i,v in ipairs(this.addStrangeScrollView.screenList) do
            if v.data.index==index then
                v:SetType2Added(true);
            end
        end
    end)
end

this.StrangerAgreeOrRefuse=function(index,isAgree)

    local uids={}
    if index~=nil then
        local uid=this.agreeStrangeScrollView.dataList[index].data.uid;
        table.insert(uids,uid)
    else
        if IsNull(FriendChatMgr.friendMapList.ApplyList) or #FriendChatMgr.friendMapList.ApplyList==0 then
            return;
        end
        for i,v in ipairs(FriendChatMgr.friendMapList.ApplyList) do
            table.insert(uids,v.Uid)
        end
    end
    FriendChatMgr.AgreeOrRefuseFriend(uids,isAgree,function()
        if index~=nil then
            for i,v in ipairs(this.agreeStrangeScrollView.screenList) do
                if v.data.isType1Op==0 and v.data.index==index then
                    v:SetType1Agree(isAgree);
                end
            end
            local dataItem=this.agreeStrangeScrollView.dataList[index];
            if dataItem.data.isType1Op==0 then
                dataItem.data.isType1Agree=isAgree;
                dataItem.data.isType1Refuse=not isAgree;
                dataItem.data.isType1Op=1;
            end
        else
            for i,v in ipairs(this.agreeStrangeScrollView.screenList) do
                if v.data.isType1Op==0 then
                    v:SetType1Agree(isAgree);
                end
            end
            for i,v in ipairs(this.agreeStrangeScrollView.dataList) do
                if v.data.isType1Op==0 then
                    v.data.isType1Agree=isAgree;
                    v.data.isType1Refuse=not isAgree;
                    v.data.isType1Op=1;
                end
            end
        end
        if isAgree then
            this.UpdateFriendList(nil)
        end
    end)
end


this.SetChatMsgInfo=function(otherFriend,isCharacter)
    local avatarPath,avatarFrame,isDynamicAvatar=nil,nil,false
    if isCharacter then
        avatarPath=otherFriend.headPath;
        avatarFrame=otherFriend.AvatarFrame
        txtChatOtherName.text=LuaMgr.GetLangText(otherFriend.TitleLan);
    else
        avatarPath,avatarFrame,isDynamicAvatar=FriendChatMgr.GetAvatarAndAvatarFramePath(otherFriend.Avatar,otherFriend.AvatarFrame);
        local name=IsNullOrEmpty(otherFriend.Remark) and otherFriend.Name or otherFriend.Remark
        txtChatOtherName.text=name;
    end
    local isShow = isDynamicAvatar and otherFriend.Online and not isCharacter
    if isShow then
        tranFriendDynamicAvatar:AppointAvatar(otherFriend.Avatar)
    else
        rawImageChatOtherHeadIcon.texture=LuaMgr.GetTexture(avatarPath);
    end
    SetActive(tranFriendDynamicAvatar.gameObject,isShow)
    SetActive(rawImageChatOtherHeadIcon.gameObject,not isShow)
    PlayerAvatarFrameTool.SetAvatarFrame(imgChatOtherHeadFrame, avatarFrame)

    txtChatOtherSummer.text=otherFriend.Summary;
    txtTipMsgTime.text=ConfigMgr.LangGlobal("17014");
end



this.SetChatHisMsgList=function(uid,otherFriend,title)
    this.chatScrollView:Clear(true);
    local hisChatList=FriendChatMgr.ReadLocalData(uid);
    if hisChatList==nil or #hisChatList==0 then
        this.chatScrollView:SetParams(870,470)
        scrollChatIndex=0;
         return
    end
    scrollChatIndex=0;
    local list={}
    for i=1,#hisChatList,1 do
        local msgInfo=hisChatList[i];
        if otherFriend~=nil then
            this.CheckUpdateHeroMsgInfo(msgInfo,otherFriend);
        else
            this.CheckUpdateCharacterMsgInfo(msgInfo);
        end
        local msgData=this.CreateMsgItem(msgInfo.msgId,msgInfo.chatType,msgInfo.name,msgInfo.msg,msgInfo.position,
                msgInfo.headPath,msgInfo.headFrame,msgInfo.time,msgInfo.web,msgInfo.optionIndex,0,otherFriend ~= nil)
        table.insert(list,msgData);
    end
    this.chatScrollView:SetParams(870,470)
    this.chatScrollView:SetData(list,false);
    this.UpdateChatListPosition();
end

this.CheckUpdateCharacterMsgInfo=function(hisInfo)
    if hisInfo.position==2 then
        local avatarPath,avatarFrame=FriendChatMgr.GetAvatarAndAvatarFramePath();
        hisInfo.headPath=avatarPath;
        hisInfo.headFrame=avatarFrame;
        hisInfo.name=DataMgr.Player.name;
    end
end

this.CheckUpdateHeroMsgInfo=function(hisInfo,otherFriend)

    if hisInfo.uid==otherFriend.Uid then
        local avatarPath,avatarFrame=FriendChatMgr.GetAvatarAndAvatarFramePath(otherFriend.Avatar,otherFriend.AvatarFrame);
        hisInfo.headPath=avatarPath;
        hisInfo.headFrame=avatarFrame;
        hisInfo.name=otherFriend.Name;
    else
        local avatarPath,avatarFrame=FriendChatMgr.GetAvatarAndAvatarFramePath();
        hisInfo.headPath=avatarPath;
        hisInfo.headFrame=avatarFrame;
        hisInfo.name=DataMgr.Player.name;
    end
end

    
this.UpdateChatListPosition=function()
    local posY=tranChatContent.sizeDelta.y-470;
    if posY<0 then
        posY=0;
    end
    tranChatContent.anchoredPosition=Vector2(0,posY)
end

this.GetMsgTextPreferWidthAndHeight=function(text)
    if string.starts(text,FriendChatMgr.faceTag) then
        return 150,150;
    end
    msgItemText.text=text;
    local width,height=math.ceil(msgItemText.preferredWidth),math.ceil(msgItemText.preferredHeight);
    width=width+msgItemText.fontSize*2;
    if width<localConfig.txtMinWidth then width=localConfig.txtMinWidth end;
    if width>localConfig.txtMaxWidth then width=localConfig.txtMaxWidth end;
    height=height+msgItemText.fontSize*1.5
    return width,height;
end

this.GetMsgNameWidth=function(text)
    msgNameText.text=text;
    return math.ceil(msgNameText.preferredWidth)+20
end

this.ReceiveNewMsg=function(uid)
    if FriendChatMgr.friendsMsgMap[uid]==nil  then  return end;
    local uidMsgs=FriendChatMgr.friendsMsgMap[uid];
    if IsNull(uidMsgs) or #uidMsgs==0 then return end;
    local friendInfo=FriendChatMgr.GetFriendByUid(uid);
    if friendInfo==nil then
        LuaDebug.error("receiveNewMsg not find Friend")
        return;
    end
    local newMsgs=FriendChatMgr.friendsMsgMap[uid];
    local writeDataList={}
    for i,v in ipairs(newMsgs) do
        local avatarPath,avatarFrame=FriendChatMgr.GetAvatarAndAvatarFramePath(friendInfo.Avatar,friendInfo.AvatarFrame);
        local msgData=this.CreateMsgItem(uid,1,friendInfo.Name,v.Msg,1,avatarPath,avatarFrame,LuaMgr.Timestamp(),"",nil,2,true)
        table.insert(writeDataList,{uid=uid,
                                    chatType=1,
                                    position=1,
                                    headPath=avatarPath,
                                    headFrame=avatarFrame,
                                    msgId="",
                                    name=friendInfo.Name,
                                    msg=v.Msg,
                                    time=LuaMgr.Timestamp(),
                                    web=""
        })
        this.chatScrollView:AddData(msgData,true);
    end
    FriendChatMgr.WriteLocalData(writeDataList);
    this.UpdateChatListPosition();
    FriendChatMgr.DeleteFriendMsg(uid,function()
        FriendChatMgr.UpdateHeroRed();
    end);
    FriendChatMgr.friendsMsgMap[uid]=nil;
end
    


this.SendMsgCallBack=function(isScu,msg)
    if not isScu then
        return
    end
    inputMsg.text="";
    local avatarPath,avatarFrame=FriendChatMgr.GetAvatarAndAvatarFramePath(nil,nil);
    local msgData=this.CreateMsgItem(DataMgr.Player.uid,1,DataMgr.Player.name,msg,2,avatarPath,avatarFrame,LuaMgr.Timestamp(),"",nil,2,true)
    local writeData={};
    table.insert(writeData,{uid=DataMgr.Player.uid,
                            chatType=1,
                            position=2,
                            headPath=avatarPath,
                            headFrame=avatarFrame,
                            msgId="",
                            name=DataMgr.Player.name,
                            msg=msg,
                            time=LuaMgr.Timestamp(),
                            web=""
    })
    FriendChatMgr.WriteLocalData(writeData);
    this.chatScrollView:AddData(msgData,true);
    this.UpdateChatListPosition();
end

this.SetReplyMsg=function(curCharacterData)
    SetActive(btnAutoMsg.gameObject,false);
    if curCharacterData==nil or curCharacterIndex==nil then
        return
    end;
    if not IsNull(curCharacterData.TextNext) and #curCharacterData.TextNext>0 then
        local nextId=curCharacterData.TextNext[1];
        if characterMsgList[nextId]~=nil and characterMsgList[nextId].Position==2  then
            SetActive(btnAutoMsg.gameObject,true);
        end
    end
    local msg=LuaMgr.GetLangText(curCharacterData.TextLan);
    local name=LuaMgr.GetLangText(curCharacterData.ChatacterNameLan)
    local headFrame=curCharacterData.AvatarFrame
    local headPath=nil;
    if not IsNullOrEmpty(curCharacterData.Speaker) then
        headPath=ConfigHelper.GetCharacterAvatarPath(curCharacterData.Speaker)
    elseif not IsNullOrEmpty(curCharacterData.ChatacterHead) then
        headPath=curCharacterData.ChatacterHead;
    else
        headPath,headFrame=FriendChatMgr.GetAvatarAndAvatarFramePath();
        name=DataMgr.Player.name;
    end
    local animatorType=0;
    if tranChatContent.sizeDelta.y-470-tranChatContent.anchoredPosition.y<100 then
        animatorType=1;
    end
    local characterData=this.CreateMsgItem(curCharacterData.Id,curCharacterData.ChatType,name,msg,
            curCharacterData.Position,headPath,headFrame,LuaMgr.Timestamp(),curCharacterData.Website,nil,animatorType,false);
    local writeData={};
    table.insert(writeData,{
        uid=characterList[curCharacterIndex].Uid,
        chatType=curCharacterData.ChatType,
        position=curCharacterData.Position,
        headPath=headPath,
        headFrame=headFrame,
        msgId=curCharacterData.Id,
        name=name,
        msg=msg,
        time=LuaMgr.Timestamp(),
        web=curCharacterData.Website,
    });
    FriendChatMgr.WriteLocalData(writeData,curCharacterData.GroupType);
    FriendChatMgr.UpdateCharacterRed();
    this.chatScrollView:AddData(characterData,true);
    if animatorType==1 then
        this.UpdateChatListPosition();
    end
end
    



this.StartAutoReply=function(isNow)
    if coReply~=nil then
        coroutine_runner.stop(coReply);
    end
    coReply=coroutine_runner.start(function()
        while(true)
        do
            local characterData=this.GetCurCharacterMsgData();
            if characterData~=nil and characterData.Position~=2  then
                if not isNow  then
                    coroutine_runner.wait(2)
                else
                    coroutine_runner.wait(0.5)
                end
                isNow=false;
                this.SetReplyMsg(characterData);
                if characterData.ChatType==5 and not this.CheckRedBagReward(characterData.Id) then

                    break
                end
            else
                SetActive(btnAutoMsg.gameObject,characterData~=nil and characterData.Position==2);
                break;
            end
        end
    end)
    
end
    


this.GetCurCharacterMsgData=function(index)
    local characterData=nil;
    if curCharacterIndex==nil or IsNull(characterMsgList) then return nil end;
    if IsNull(this.chatScrollView.dataList) or #this.chatScrollView.dataList==0 then

        local key=characterList[curCharacterIndex].Uid.."001";
        characterData=characterMsgList[key]
    end
    if characterData==nil then
        local locIndex=index==nil and 1 or index;
        local lastId=this.chatScrollView.dataList[#this.chatScrollView.dataList].data.msgId;
        local lastMsgItem=characterMsgList[lastId];
        if not IsNull(lastMsgItem.TextNext) and #lastMsgItem.TextNext>0 then
            characterData=characterMsgList[lastMsgItem.TextNext[locIndex]];
        end
    end
    return characterData;
end


this.RePlaceByPlayerName=function(text)
   return LuaMgr.Replace(text,"<player>",DataMgr.Player.name)
end


this.CreateMsgItem=function(msgId,chatType,name,msg,loc,headPath,headFrame,time,webSite,optionIndex,animatorType,isPlayer)
    name=this.RePlaceByPlayerName(name);
    msg=this.RePlaceByPlayerName(msg);
    local width,height=this.GetMsgTextPreferWidthAndHeight(msg);
    scrollChatIndex=scrollChatIndex+1;
    local msgItem={
        msgId=msgId;
        avatarPath=headPath;
        avatarFrame=headFrame,
        msg=msg,
        txtWidth=width,
        txtHeight=height;
        chName=name;
        txtNameWidth=this.GetMsgNameWidth(name),
        anwserCallBack=this.AnwserCallback;
        linkCallBack=this.LinkCallBack;
        redBagCallBack=this.RedBagCallBack;
        pvPreviewCallBack=this.PvPreviewCallBack;
        lastTime=time;
        chatType=chatType;
        web=webSite,
        index=scrollChatIndex,
        optionIndex=optionIndex==nil and 0 or optionIndex,
        animatorType=animatorType==nil and 0 or animatorType;
        isPlayer = isPlayer
    }
    local msgData=nil;
if chatType==1 or chatType==4 or chatType==5 or chatType == 6 then
        if chatType==4 then
            height=116;
        elseif chatType==5 then
            height=116;
            msgItem.optionIndex=this.CheckRedBagReward(msgId) and 1 or 0;
        elseif chatType==6 then
            height=180;
        end
        if loc==2 then
            msgData=UIScrollData.GetData(this.myMsgItemObj,"FriendChat_MyMsgItem",840,height+50,msgItem);
        else
            msgData=UIScrollData.GetData(this.otherMsgItemObj,"FriendChat_OtherMsgItem",840,height+50,msgItem);
        end
elseif chatType==2 then
        msgData=UIScrollData.GetData(this.myMsgOptionItem,"FriendChat_MyOptionItem",840,165+50,msgItem);
elseif chatType==3 then
        msgData=UIScrollData.GetData(this.asideMsgItemObj,"FriendChat_AsideItem",840,60,msgItem);
    end
    return msgData;
    
end

this.CheckRedBagReward=function(msgId)
    if IsNull(DataMgr.Player.Friends) or IsNull(DataMgr.Player.Friends.ServicePos) then
        return false;
    end
    return DataMgr.Player.Friends.ServicePos[msgId]~=nil;
end

this.AnwserCallback=function(index,answerIndex)
    local characterData=this.GetCurCharacterMsgData(answerIndex)
    this.SetReplyMsg(characterData);
    this.StartAutoReply(false);
    this.chatScrollView.dataList[index].data.optionIndex=answerIndex;
    FriendChatMgr.UpdateDataOptionIndex(index,answerIndex)
    for i,v in ipairs(this.chatScrollView.screenList) do
        if v.data.index==index then
            v:UpdateOption(answerIndex);
            return
        end
    end
end

this.LinkCallBack=function(web)
    if not IsNullOrEmpty(web) then
        LuaMgr.OpenURL(web);
    end
    
end

this.AskServiceChatPos=function(id)
    local askData={Id=id};
    ApiMgr.Request("friends/chat/servicePosReward",askData,true,function()  end,nil,true);
end


this.RedBagCallBack=function(index,msgId)
    local chatItem=ConfigMgr.Config.CharacterChatMap[msgId]
    if chatItem==nil or IsNull(chatItem.Reward) then return end;
    if this.CheckRedBagReward(msgId) then
        return;
    end
    local askData={Id=msgId}
    ApiMgr.Request("friends/chat/servicePosReward",askData,true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result.Rewards);
        LuaMgr.ShowItemRewared(data);
        this.chatScrollView.dataList[index].data.optionIndex=1;
        FriendChatMgr.UpdateDataOptionIndex(index,1)
        this.chatScrollView:Refresh();
        this.StartAutoReply(false);
    end,nil,true)
end

this.PvPreviewCallBack = function(msg)
    SetActive(goPvPreviewContent, true)
    rawImagePvPreview.texture=LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/FriendChat/PvPreview/%s.png", msg));
    txtClosePvPreview = ConfigMgr.LangGlobal("7123")
end

this.ChatScrollViewCallBack=function(screenList)
    if not IsNull(screenList) and #screenList>0 then
        local passTime=LuaMgr.Timestamp()-screenList[1].data.lastTime
        local tip="";
        local day,hour,min=GetTimeDHM2(passTime)
        if day>=30 then
            tip=string.format(ConfigMgr.LangGlobal("17013"));
        elseif day>0 then
            tip=string.format(ConfigMgr.LangGlobal("17012"),day);
        elseif hour>0 then
            tip=string.format(ConfigMgr.LangGlobal("17011"),hour);
        elseif min>0 then
            tip=string.format(ConfigMgr.LangGlobal("17010"),min);
        else
            tip=ConfigMgr.LangGlobal("17014");
        end
        txtTipMsgTime.text=tip;
    end
end

this.FriendInfoOnBeginDrag=function(evenData)
    local pos=LuaMgr.Screen2Local(evenData.position,goFriendlView.transform)
    offVector=goFriendInfo.transform.anchoredPosition-pos;
end

this.FriendInfoOnDrag=function(evenData)
    local screenPos=evenData.position;
    local scrX=screenPos.x;
    local scrY=screenPos.y;
    if scrX<0 then
        scrX=0;
    end
    if scrX>UnityEngine.Screen.width then
        scrX=UnityEngine.Screen.width ;
    end
    if scrY<0 then
        scrY=0
    end
    if scrY>UnityEngine.Screen.height then
        scrY=UnityEngine.Screen.height
    end
    local curPos=LuaMgr.Screen2Local(Vector2(scrX,scrY),goFriendlView.transform)
    goFriendInfo.transform.anchoredPosition=curPos+offVector;
end


return vm({
    data = data,
    command = command,
    hook = hook
})