VoyageRichManSceneMgr = {};

local this = {
    camera = nil,
    cameraTF = nil,
    cameraPos = nil,
    isDrag = false,
    minX = 0,
    maxX = 0,
    downPos = nil,
    recordPos = nil,
};


VoyageRichManSceneMgr.Init = function(camera, minX, maxX)
    this.camera = camera;
    this.cameraTF = camera.transform;
    this.minX = minX;
    this.maxX = maxX;
    this.isDrag = true;
end


VoyageRichManSceneMgr.Clear = function()
    this.camera = nil;
    this.cameraTF = nil;
    this.isDrag = false;
    this.downPos = nil;
    this.cameraPos = nil;
end


VoyageRichManSceneMgr.SetDrag = function(isDrag)
    this.isDrag = isDrag;
    if (isDrag) then return end
    
    this.ClearMove();
end


this.ClearMove = function()
    this.downPos = nil;
    this.cameraPos = nil;
end


VoyageRichManSceneMgr.Goto = function(x)
    local cameraPos = this.cameraTF.localPosition;
    cameraPos.x = x;
    this.cameraTF.localPosition = cameraPos;
end


VoyageRichManSceneMgr.Record = function()
    this.recordPos = this.cameraTF.localPosition;
end


VoyageRichManSceneMgr.Resume = function()
    this.cameraTF.localPosition = this.recordPos;
end


VoyageRichManSceneMgr.Update = function()
    if (this.isDrag) then
        local isPointerOverGameObject = RaycastTool.IsPointerOverGameObject();
        if (RaycastTool.GetMouseButtonDown(0)) then
            if (not isPointerOverGameObject) then
                this.downPos = RaycastTool.GetMousePosition();
                this.cameraPos = this.cameraTF.localPosition;
                this.isMove = false;
            end
            return;
        elseif (RaycastTool.GetMouseButtonUp(0)) then
            this.ClearMove();
            return;
        end
        if (this.downPos ~= nil) then
            local cpos = RaycastTool.GetMousePosition();
            cpos = Vector3(cpos.x, cpos.y, this.cameraPos.z);
            cpos = this.camera:ScreenToWorldPoint(cpos);
            local dpos = Vector3(this.downPos.x, this.downPos.y, this.cameraPos.z);
            dpos = this.camera:ScreenToWorldPoint(dpos);
            local pos = Vector3(this.cameraPos.x + (dpos.x - cpos.x), this.cameraPos.y, this.cameraPos.z);
            if (pos.x < this.minX) then
                pos.x = this.minX;
            elseif (pos.x > this.maxX) then
                pos.x = this.maxX;
            end
            this.cameraTF.localPosition = pos;
        end
    end
end