BetaList_ActItem = {};

BetaList_ActItem.__index = BetaList_ActItem;

local objs = {
    tagTxt = {path = "root/title/tag", type = "Text"},
    titleSprite={path = "root/title", type = "Image"},
    nameTxt= {path = "root/name", type = "Text"},
    timeTxt={path = "root/time/Text", type = "Text"},
    tranRewards={path = "root/rewardContent", type = "Transform"},
    jumpBtn = {path = "root/jump", type = "Button"},
}
function BetaList_ActItem.New()
    local self = {};
    setmetatable(self, BetaList_ActItem);
    return self;
end

function BetaList_ActItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.itemVMList = {};
    self.OnClick = function()
        if self.data.jumpCallBack~=nil then
            self.data.jumpCallBack(self.data.index);
        end 
    end
    LuaMgr.AddClick(self.jumpBtn, self.OnClick);
end

function BetaList_ActItem:SetData(data)
    self.data = data.data;
    self.tagTxt.text=self.data.tagName;
    self.nameTxt.text=self.data.name;

    local posX=self.tagTxt.preferredWidth+50;
    self.nameTxt.transform.anchoredPosition=Vector2(posX,-24);
    self.titleSprite.sprite=LuaMgr.GetSprite("BetaActivity","ui_yyhd_dl_tm_tag_"..self.data.tagType)
    if self.data.endTime==nil then
        self.timeTxt.text=LuaMgr.GetLangText("BetaList_ActItem_0");
    else
        local remainTime=self.data.endTime-LuaMgr.Timestamp();
        remainTime=remainTime<0 and 0 or remainTime;
        local day,hour,min=GetTimeDHM2(remainTime)
        self.timeTxt.text=string.format(LuaMgr.GetLangText("BetaList_ActItem_1"),day,hour,min);
    end
    if  #self.itemVMList>#self.data.rewardIds then
        for i=#self.data.rewardIds+1,#self.itemVMList,1 do
            SetActive(self.itemVMList[i].transform.gameObject,false);
        end
    end
    if #self.data.rewardIds>0 then
        for i=1,#self.data.rewardIds,1 do
            if i>#self.itemVMList then
                local vmItem=GoodsDataItem.New(self.tranRewards)
                table.insert(self.itemVMList,vmItem);
            end
            local itemVM=self.itemVMList[i];
            local itemConfig = table.Copy(ConfigMgr.Config.itemMap[self.data.rewardIds[i]]);
            itemConfig.count0 = 0;
            itemVM:SetData(1, itemConfig, 1, false, Vector3(0.56,0.56,1), false,true);
        end
    end
end

function BetaList_ActItem:Clear()
    self.data = nil;
    if (self.item ~= nil) then
        self.item:Hide();
    end
end

function BetaList_ActItem:Destroy()
    self.itemList =nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end