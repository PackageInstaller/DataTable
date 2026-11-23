Qin2Task_ItemGroup = {};

Qin2Task_ItemGroup.__index = Qin2Task_ItemGroup;
local objs = {
    iconSprite={ path = "root/line/icon", type = "Image" },
    rtName={ path = "root/line/rtName", type = "Transform" },
    nameText={ path = "root/line/rtName/nameText", type = "Text" },
    rewardBg={ path = "root/line/reward", type = "Image" },
    rewardText={ path = "root/line/reward/Text", type = "Text" },
    goodsTF={ path = "root/line/reward/goods", type = "Transform" },
    rewardedObj={ path = "root/line/reward/done", type = "GameObject" },
    taskContent={path="root/line/taskContent",type="Transform"},
    rewardBtn={ path = "root/line/reward", type = "Button" },
}

function Qin2Task_ItemGroup.New()
    local self = {};
    setmetatable(self, Qin2Task_ItemGroup);
    return self;
end

function Qin2Task_ItemGroup:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.TaskUIList=UIListView.New(self.taskContent);
    LuaMgr.AddClick(self.rewardBtn,function()
        if  self.data.rewardCallBack~=nil then
            self.data.rewardCallBack(self.data.groupId);
        end
    end)
    self.JumpCallBack=function(skipPage)
        if self.data.jumpCallBack~=nil then
            self.data.jumpCallBack(skipPage);
        end
    end
    self.childRewardCallBack=function(id)
        if  self.data.rewardCallBack~=nil then
            self.data.rewardCallBack(id);
        end
    end
end











function Qin2Task_ItemGroup:SetData(pdata)
    self.data = pdata.data
    self.iconSprite.sprite=LuaMgr.GetSprite("Qin2",self.data.groupIcon)
    self.nameText.text=self.data.groupName;
    self.rtName.sizeDelta=Vector2(self.nameText.preferredWidth+58,48);
    local awardState=self:CheckTaskState(self.data.groupId);
    self.rewardBg.sprite=awardState==3 and LuaMgr.GetSprite("Qin2","ui_hd_dqww_rw_dj2") or LuaMgr.GetSprite("Qin2","ui_hd_dqww_rw_dj") 
    SetActive(self.rewardedObj,awardState==3);
    local rewardDes="";
    if awardState==1 then
        rewardDes=LuaMgr.GetLangText("Qin2Task_ItemGroup_0")
    elseif awardState==2 then
        rewardDes=LuaMgr.GetLangText("Qin2Task_ItemGroup_1")
    else
        rewardDes=LuaMgr.GetLangText("Qin2Task_ItemGroup_2")
    end
    self.rewardText.text=rewardDes;
    if self.item==nil then
        self.item=GoodsDataItem.New(self.goodsTF);
    end
    local itemConfig = ConfigMgr.Config.itemMap[self.data.award[1].id]
    itemConfig["count0"] = self.data.award[1].count
    self.item:SetData(1,itemConfig,1,false,Vector3(0.6,0.6,1),false)
    SetActive(self.sellOutObj,self.data.isSellOut);
    self:SetTaskList()
end


function Qin2Task_ItemGroup:CheckTaskState(taskId)
    local dataTask= DataMgr.Player.quests[taskId];
    if dataTask~=nil then
        return dataTask.state,dataTask.progress
    else
        return 1,0;
    end
end


function Qin2Task_ItemGroup:SetTaskList()
    local list={}
    table.sort(self.data.childTaskList,function(a, b) return a.sort<b.sort end)
    for i,v in ipairs(self.data.childTaskList) do
        local taskState,pro=self:CheckTaskState(v.id)
        local childItem={
            id=v.id,
            name=LuaMgr.GetLangText(v.namelan),
            pro=string.format("<color=#b34a18>%s</color>/%s",pro,v.progress),
            proValue=pro/v.progress,
            state=taskState,
            awards=v.showReward,
            skipPage=v.skipPage,
            jumpCallBack=self.JumpCallBack,
            rewardCallBack=self.childRewardCallBack,
        }
        local childData=UIListData.GetData(self.data.childObj,"Qin2Task_Item",childItem)
        table.insert(list,childData)
    end
    self.TaskUIList:SetData(list);
end





function Qin2Task_ItemGroup:Clear()
    self.data = nil;
    self.TaskUIList:Clear();
end

function Qin2Task_ItemGroup:Destroy()
    self.iconSprite=nil;
    self.rtName=nil;
    self.nameText=nil;
    self.rewardBg=nil;
    self.rewardText=nil;
    self.goodsTF=nil;
    self.rewardedObj=nil;
    self.taskContent=nil;
    self.TaskUIList=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
end