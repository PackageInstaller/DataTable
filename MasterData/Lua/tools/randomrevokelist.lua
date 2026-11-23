RandomRevokeList = {}
RandomRevokeList.__index = RandomRevokeList


function RandomRevokeList.New(maxStep)
    local self = {}
    setmetatable(self, RandomRevokeList)
    self:InitQueue(maxStep);
    return self
end

function RandomRevokeList:InitQueue(maxStep)
    self.first=0;
    self.last=-1;
self.maxStep=maxStep+5;
self.index=0;
    self.size=0;
    self.randomSeed=nil;
    self.randomIndex=1;
    self.list={
        valueList={},
        randomSeed=nil,
        randomIndex=0,
};
self.nowBlockRandomList={};
self.nowBlockRandomIndex=1;
self.openBlockRandomIndex=1;

    self.randomSeed=tonumber(tostring(os.time()):reverse():sub(1, 7));
self.randomIndex=1;
    math.randomseed(self.randomSeed);
end


function RandomRevokeList:OpenStage()
if self.first==self.index then
        self.nowBlockRandomList={};
        self.openBlockRandomIndex=self.randomIndex;
    else
self.nowBlockRandomList=self.list[self.index-1].valueList;
        self.nowBlockRandomIndex=1;
    end
end


function RandomRevokeList:EndStage(isSave)
if self.first==self.index then
        local data={
            valueList={},
            randomSeed=nil,
            randomIndex=0,
        };
        data.valueList = self.nowBlockRandomList;
        data.randomSeed=self.randomSeed;
        data.randomIndex=self.openBlockRandomIndex;
        self:PrivatePushFirst(data);
        if self.randomIndex>100 then
            self.randomIndex=1;
            self.randomSeed=tonumber(tostring(os.time()):reverse():sub(1, 7));
            math.randomseed(self.randomSeed);
        end
if not isSave then
            self.index=self.index+1;
        end
    else
if isSave then
            self.index=self.index-1;
        end
    end
end


function RandomRevokeList:LoadRamdomList(data)
    for index, value in ipairs(data.backValueList) do
        self:PrivatePushFirst(value);
    end
    self.index=0;
end

function RandomRevokeList:GetRamdomList()
    local data={
        backValueList={},
    };
    for i = self.index-1, self.first, -1 do
        table.insert(data.backValueList,table.Copy(self.list[i]));
    end
    return data;
end

function RandomRevokeList:Size()
    return self.size;
end

function RandomRevokeList:GetRandomValue()
if self.first==self.index then
        local randomValue=math.random(10000);
        self.openBlockRandomIndex=self.openBlockRandomIndex+1;
        table.insert(self.nowBlockRandomList,randomValue);
        return randomValue;
    else
        local data=self.nowBlockRandomList[self.nowBlockRandomIndex];
        self.nowBlockRandomIndex=self.nowBlockRandomIndex+1;
if data==nil then
            data=math.random(10000);
        end
        return data;
    end
end


function RandomRevokeList:RevokeStep(step)
    self.index=self.index+step;
end

function RandomRevokeList:PrivatePushFirst(value)
    self.first=self.first-1;
    self.index=self.index-1;
    self.list[self.first]=value;
    self.size=self.size+1;
if self.size>self.maxStep then
        self:PrivatePopLast();
    end
end

function RandomRevokeList:PrivatePopLast()
    if self.first>self.last then
        return nil;
    end
    local value=self.list[self.last];
    self.list[self.last]=nil;
    self.last=self.last-1;
    self.size=self.size-1;
    return value;
end