VoyageRichManTimeMgr = {}

local this = {
    nowTime = 0,
    timeList = {},
};

VoyageRichManTimeMgr.Clear = function()
    this.timeList = {};
end


VoyageRichManTimeMgr.GetTime = function()
    return this.nowTime;
end


VoyageRichManTimeMgr.AddTime = function(time, callback, data)
    table.insert(this.timeList, {time=this.nowTime+time, callback=callback, data=data});
end


this.CheckTime = function()
    local len = #this.timeList;
    if (len <= 0) then return end
    
    local item;
    local index = 1;
    while (index <= len) do
        item = this.timeList[index];
        if (this.nowTime > item.time) then
            table.remove(this.timeList, index);
            len = len - 1;
            item.callback(item.data);
        else
            index = index + 1;
        end
    end
end


VoyageRichManTimeMgr.Update = function()
    this.nowTime = CS.UnityEngine.Time.realtimeSinceStartup;
    this.CheckTime();
end