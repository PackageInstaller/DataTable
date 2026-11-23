Simulate_BlessingPrayItem = {};

Simulate_BlessingPrayItem.__index = Simulate_BlessingPrayItem;

local objs = {
    imgIcon={path="root/icon",type="Image"},
    txtMsg={path="root/msg",type="Text"},
    txtName={path="root/name",type="Text"},
    goMyBg={path="root/BG/my",type="GameObject"},
    goMyLike={path="root/like/my",type="GameObject"},
    goMyTag={path="root/name/my",type="GameObject"},
    goLiked={path="root/like/liked",type="GameObject"},
    txtLike={path="root/like/count",type="Text"},
    btnLike={path="root/like",type="Button"},
}

function Simulate_BlessingPrayItem.New()
    local self = {};
    setmetatable(self, Simulate_BlessingPrayItem);
    return self;
end

function Simulate_BlessingPrayItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnLike,function()
        if not self.data.isMy and self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
end


function Simulate_BlessingPrayItem:SetData(pdata)
    self.data=pdata.data
    self.imgIcon.sprite=LuaMgr.GetSprite("Simulate",self.data.prayList[1]);
    self.txtName.text=not self.data.isMy  and string.format("<color=#e8cc86>%s</color>",self.data.name) or self.data.name;
    local countColor="";
    if self.data.isMy then
        countColor="e8cc86"
    elseif self.data.isLike then
        countColor="6e5745"
    else
        countColor="962e21"
    end
    self.txtLike.text=string.format("<color=#%s>%s</color>",countColor,LuaMgr.NumFormat(self.data.likeCount));
    SetActive(self.goMyBg,self.data.isMy);
    SetActive(self.goMyLike,self.data.isMy);
    SetActive(self.goMyTag,self.data.isMy)
    SetActive(self.goLiked,not self.data.isMy and self.data.isLike);
    local info="";
for i=2,#self.data.prayList,1 do
        local prayId=self.data.prayList[i];
        local msgLan=ConfigMgr.Config.SimulatePrayMap[prayId].TextLan
        local msg=LuaMgr.GetLangText(msgLan);
        if IsNullOrEmpty(info) then
            info=info..msg;
        else
            info=info..","..msg;
        end
    end
    self.txtMsg.text=not self.data.isMy  and string.format("<color=#e8cc86>%s</color>",info) or info;
end

function Simulate_BlessingPrayItem:SetSelect(isOn)
    SetActive(self.goSelect,isOn);
end

function Simulate_BlessingPrayItem:Clear()
    self.data=nil
end


function Simulate_BlessingPrayItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end

