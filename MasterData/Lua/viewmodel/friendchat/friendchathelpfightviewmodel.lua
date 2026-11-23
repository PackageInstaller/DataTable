





require("ViewModel/FriendChat/FriendChat_HelpFightItem")
require("ViewModel/FriendChat/FriendChat_HelpFightInfoItem")
FriendChatHelpFightViewModel = {};
FriendChatHelpFightViewModel.__index = FriendChatHelpFightViewModel;

local objs = {
    noHelpGo={path="noHelpGo",type="GameObject"},
    helpApplyListGo={path="helpApplyListGo",type="GameObject"},
    helpRecordListGo={path="helpRecordListGo",type="GameObject"},
    helpByOtherRecordListGo={path="helpByOtherRecordListGo",type="GameObject"},
    tranApplyContent={path="helpApplyListGo/helpApplyList/Viewport/Content",type="Transform"},
    tranHelpRecordContent={path="helpRecordListGo/helpRecordList/Viewport/Content",type="Transform"},
    tranByOtherHelpRecordContent={path="helpByOtherRecordListGo/helpByOtherRecordList/Viewport/Content",type="Transform"},
    noHelpTipText={path="noHelpGo/noHelpTipText",type="Text"},
}

function FriendChatHelpFightViewModel.New(vm,go,tranContent)
    local self = {};
    setmetatable(self, FriendChatHelpFightViewModel);
    self.rootVm=vm;
    self.tranContent=tranContent;
    self.helpTypeList={LuaMgr.GetLangText("FriendChatHelpFightViewModel_0"),LuaMgr.GetLangText("FriendChatHelpFightViewModel_1"),LuaMgr.GetLangText("FriendChatHelpFightViewModel_2")}
    self.noHelpTipList={LuaMgr.GetLangText("FriendChatHelpFightViewModel_3"),LuaMgr.GetLangText("FriendChatHelpFightViewModel_4"),LuaMgr.GetLangText("FriendChatHelpFightViewModel_5")}
    UITool.Parse(go, self, objs);
    self:Init();
    self.HelpItemCallBack=function(index)
        self:HelpItemCallBackExecute(index);
    end
    return self;
end


function FriendChatHelpFightViewModel:Init()










    self.HelpFightUIList=UIListView.New(self.tranContent);
    self.helpFightItemObj=self.rootVm.behaviour.transform:Find("template/helpFightItem").gameObject;
    self.helpFightApplyUIList=UIListView.New(self.tranApplyContent);
    self.helpFightRecordUIList=UIListView.New(self.tranHelpRecordContent)
    self.tranByOtherHelpRecordUIList=UIListView.New(self.tranByOtherHelpRecordContent);
    self.helpFightInfoItemObj=self.rootVm.behaviour.transform:Find("template/helpFightInfoItem").gameObject;
end

function FriendChatHelpFightViewModel:SetNoHelpTip(index)
    self.noHelpTipText.text=self.noHelpTipList[index];
end

function FriendChatHelpFightViewModel:SetHelpState(index)
    SetActive(self.noHelpGo,index==0);
    SetActive(self.helpApplyListGo,index==1)
    SetActive(self.helpRecordListGo,index==2)
    SetActive(self.helpByOtherRecordListGo,index==3);
end

function FriendChatHelpFightViewModel:Enable()
    self.curHelpFightIndex=-1;
    self:SetData();
end
function FriendChatHelpFightViewModel:SetData()
    self.HelpFightUIList:Clear();
    local list={}
    for i,v in ipairs(self.helpTypeList) do
        local helpItem={
            index=i,
            name=v,
            callBack=self.HelpItemCallBack;
            redId="11005",
        }
        local helpData=UIListData.GetData(self.helpFightItemObj,"FriendChat_HelpFightItem",helpItem);
        table.insert(list,helpData)
    end
    self.HelpFightUIList:SetData(list);
end

function FriendChatHelpFightViewModel:HelpItemCallBackExecute(index)
    if self.curHelpFightIndex==index then return end;
    self.curHelpFightIndex=index;
    for i,v in ipairs(self.HelpFightUIList.itemList) do
        v:SetEnable(i==index);
    end
    if index==1 then
        self.SetHelpFightAgreeList();
    elseif index==2 then
        self.SetHelpFightRecordList();
    elseif index==3 then
        self.SetHelpedByOtherRecordList();
    end
end

function FriendChatHelpFightViewModel:SetHelpFightAgreeList()
    LuaDebug.error("1")
    local applyList=FriendChatMgr.friendMapList.ApplyList;
    if IsNull(applyList) or #applyList==0 then
        self:SetHelpState(0);
        self:SetNoHelpTip(1);
        return;
    end
    self:SetHelpState(1);
    self.helpFightApplyUIList:Clear();
    local list={}
    for i,v in ipairs(applyList) do
        local avatarPath,avatarFrame=FriendChatMgr.GetAvatarAndAvatarFramePath(v.Avatar,v.AvatarFrame);
        local helpItem={
            index=i,
            uid=v.Uid,
            name=v.Name,
            motto=v.Motto,
            avatarPath=avatarPath,
            avatarFrame=avatarFrame,
            lv=v.Lv,








        }
        local helpData=UIListData.GetData(self.helpFightInfoItemObj,"FriendChat_HelpFightInfoItem",helpItem)
        table.insert(list,helpData);
    end
    self.helpFightApplyUIList:SetData(list);
end

function FriendChatHelpFightViewModel:SetHelpFightRecordList()
    LuaDebug.error("2")
end

function FriendChatHelpFightViewModel:SetHelpedByOtherRecordList()
    LuaDebug.error("3")
end

function FriendChatHelpFightViewModel:Clear()
    self.HelpFightUIList:Clear();
    self.helpFightApplyUIList:Clear();
end


function FriendChatHelpFightViewModel:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    UIScrollView.ClearItem("FriendChat_HelpFightItem")
    UIScrollView.ClearItem("FriendChat_HelpFightInfoItem")
end