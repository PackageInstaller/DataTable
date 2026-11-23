Simulate_OtherMsgItem = {};

Simulate_OtherMsgItem.__index = Simulate_OtherMsgItem;

local objs = {
    bgRect={path="root/bg",type="Transform"},
    txtMsg={path="root/bg/Text",type="Text"},
}



function Simulate_OtherMsgItem.New(parent)
    local self = {};
    setmetatable(self, Simulate_OtherMsgItem);
    local path="Assets/_BundleResources/UI/Simulate/msgBuff.prefab";
    self.gameObject = LuaMgr.GetPrefab(path);
    self.transform=self.gameObject.transform;
    if self.gameObject~=nil then
        self.gameObject.transform:SetParent(parent,false);
        self.gameObject.transform.localPosition = Vector3.zero;
        self.gameObject.transform.localScale=Vector3.one;
    end
    self:Init();
    return self;
end


function Simulate_OtherMsgItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end


function Simulate_OtherMsgItem:SetPosition(pos)
    self.transform.anchoredPosition=Vector2(pos.x,pos.y+140);
end

function Simulate_OtherMsgItem:SetMsg(msg,pos,callBack)
    SetActive(self.gameObject,true);
    self:SetPosition(pos);
    self.txtMsg.text= MatchPlayer(msg);
    self.bgRect.sizeDelta=Vector2(177,self.txtMsg.preferredHeight+30)
    local delayTime=RandomNum(12,20)
    self.timerId=NumTool.DelayHandler(function()
        if self~=nil and self.gameObject~=nil then
            SetActive(self.gameObject,false)
            if callBack~=nil then
                callBack();
            end
        end
    end,delayTime)
   
end



function Simulate_OtherMsgItem:Clear()
   
end


function Simulate_OtherMsgItem:Destroy()
    NumTool.RemoveDelayHandler(self.timerId)
    LuaMgr.DestroyImmediateGO(self.gameObject);
end

