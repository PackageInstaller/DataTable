Delegate_RewardGroup = {};

Delegate_RewardGroup.__index = Delegate_RewardGroup;

local cokey=nil
local objs = {
    rootObj={path="root",type="GameObject"},
    rootRect={path="root",type="RectTransform"},
    numText={path = "root/Num/Text", type = "Text"},
    contentTf={path="root/content",type="Transform"},
   
}

function Delegate_RewardGroup.New()
    local self = {};
    setmetatable(self, Delegate_RewardGroup);
    self.itemList = {}
    self.equipList={}
    self.itemPool={}
    self.list={}
    return self;
end

function Delegate_RewardGroup:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function Delegate_RewardGroup:SetData(pdata)
    self.data = pdata;
    self.numText.text=pdata.data.numText

    self.list={}
    self.itemList=pdata.data.itemList
    self.equipList=pdata.data.equipList
    for i,v in ipairs(self.itemList) do
        local item=nil
        if #self.itemPool>0 then
            item=self.itemPool[1];
            table.remove(self.itemPool,1);
        else
            item=Delegate_RewardItem.New(self.contentTf,pdata.data.itemObj)
        end
        v.item=item
        local itemConfig = ConfigMgr.Config.itemMap[v.id]
        v.isSpecial=itemConfig.isSpecial>0
        v.tag=i
        SetActive(v.item.gameObject,true)
        item:SetData(v,1)
        table.insert(self.list,v)
    end
    for i,v in ipairs(self.equipList) do
        local item=nil
        if #self.itemPool>0 then
            item=self.itemPool[1];
            table.remove(self.itemPool,1);
        else
            item=Delegate_RewardItem.New(self.contentTf,pdata.data.itemObj)
        end
        v.item=item
        v.isVisiable=false
        v.isSpecial=false
        SetActive(v.item.gameObject,true)
        item:SetData(v,2)
        table.insert(self.list,v)
    end
    SetActive(self.rootObj,false);
    local rowCount=math.ceil(#self.list/5)
    if rowCount<1 then
        rowCount=1
    end
    local height=100+(rowCount-1)*80
    self.rootRect.sizeDelta=Vector2(496,height)
end

function Delegate_RewardGroup:CoroutineSetActive(callBack,intervaleScale)
    if cokey~=nil then
        coroutine_runner.stop(cokey)
    end
    cokey=coroutine_runner.start(function()
        SetActive(self.rootObj,true);
        coroutine_runner.wait(0.3);
        for i,v in ipairs(self.list) do
            if callBack~=nil then
                callBack(v.id,v.count);
            end



                v.item:SetActiveFX(false,false)

        end
    end)
end

function Delegate_RewardGroup:SetActive(callBack)
    SetActive(self.rootObj,true);
    for i,v in ipairs(self.list) do
        if callBack~=nil then
            callBack(v.id,v.count);
        end
        if v.isSpecial then
            v.item:SetActiveFX(true,false)
        else
            v.item:SetActiveFX(false,false)
        end
    end
end


function Delegate_RewardGroup:Clear()
    self.data = nil;

    for i,v in ipairs(self.itemList) do
        table.insert(self.itemPool,v.item)
        SetActive(v.item.gameObject,false)
    end
    for i,v in ipairs(self.equipList) do
        table.insert(self.itemPool,v.item)
        SetActive(v.item.gameObject,false)
    end



    
end


function Delegate_RewardGroup:Destroy()
    self.data = nil;
    self.rootObj=nil
    self.numText=nil
    self.contentTf=nil
    self.itemPool=nil
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

