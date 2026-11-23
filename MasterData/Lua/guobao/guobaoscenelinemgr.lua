GuoBaoSceneLineMgr = {};

local this = {
    lines = nil,
    useLines = nil,
};


GuoBaoSceneLineMgr.Init = function(lines)
    this.InitLines(lines);
end


GuoBaoSceneLineMgr.Clear = function()
    this.lines = nil;
    this.useLines = nil;
end


this.InitLines = function(transform)
    local lineTF;
    local lineData;
    local point;
    this.lines = {};
    this.useLines = {};
    for i = 1, 100 do
        lineTF = transform:Find("Line" .. i);
        if (lineTF == nil) then break end

        lineData = {id=i, points={}};
        this.lines[i] = lineData;
        for j = 1, 100 do
            point = lineTF:Find("Point" .. j);
            if (point == nil) then break end

            lineData.points[j] = point.localPosition;
        end
    end
end


GuoBaoSceneLineMgr.FindLine = function()
    local len = #this.lines;
    if (len > 0) then
        local index = math.random(1, len);
        local lineData = this.lines[index];
        table.remove(this.lines, index);
        table.insert(this.useLines, lineData);
        return lineData;
    end
    return nil;
end


GuoBaoSceneLineMgr.RevertLine = function(lineData)
    if (lineData == nil) then return end
    
    local line;
    local len = #this.useLines;
    for i = 1, len do
        line = this.useLines[i];
        if (line.id == lineData.id) then
            table.remove(this.useLines, i);
            table.insert(this.lines, lineData);
            break;
        end
    end
end