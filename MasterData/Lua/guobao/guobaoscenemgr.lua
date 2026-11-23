GuoBaoSceneMgr = {};

local this = {
    camera = nil,
    cameraTF = nil,
    cameraPos = nil,
    isDrag = false,
    minX = 0,
    maxX = 0,
    downPos = nil,
    isMove = false,
    screenWidth = 0,
    moveValue = 0,
};


GuoBaoSceneMgr.Init = function(camera, minX, maxX)
    this.camera = camera;
    this.cameraTF = camera.transform;
    this.minX = minX;
    this.maxX = maxX;
    this.isDrag = true;
    this.isMove = false;
    this.screenWidth = UnityEngine.Screen.width - 10;
end


GuoBaoSceneMgr.Clear = function()
    this.camera = nil;
    this.cameraTF = nil;
    this.isDrag = false;
    this.isMove = false;
    this.downPos = nil;
    this.cameraPos = nil;
    this.moveValue = 0;
end


GuoBaoSceneMgr.IsMove = function()
    local isMove = this.isMove;
    this.isMove = false;
    return isMove;
end


GuoBaoSceneMgr.SetDrag = function(isDrag)
    this.isDrag = isDrag;
end


GuoBaoSceneMgr.ClearMove = function()
    this.downPos = nil;
    this.cameraPos = nil;
end


GuoBaoSceneMgr.Goto = function(x)
    local cameraPos = this.cameraTF.localPosition;
    cameraPos.x = x;
    this.cameraTF.localPosition = cameraPos;
end


GuoBaoSceneMgr.OutOfScreen = function(pos)
    if (pos.x <= 10) then
        this.moveValue = 0.05;
    elseif (pos.x >= this.screenWidth) then
        this.moveValue = -0.05;
    else
        this.moveValue = 0;
    end
end


GuoBaoSceneMgr.Update = function()
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
            GuoBaoSceneMgr.ClearMove();
            return;
        end
        if (this.downPos ~= nil) then
            local cpos = RaycastTool.GetMousePosition();
            local distance = math.abs(this.downPos.x - cpos.x);
            if (distance > 1) then
                this.isMove = true;
            end
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
    elseif (this.moveValue ~= 0) then
        local pos = this.cameraTF.localPosition;
        pos.x = pos.x + this.moveValue;
        if (pos.x < this.minX) then
            pos.x = this.minX;
        elseif (pos.x > this.maxX) then
            pos.x = this.maxX;
        end
        this.cameraTF.localPosition = pos;
    end
end


GuoBaoSceneMgr.Click = function(camera, distance, layerMask)
    if (LuaMgr.IsGuide()) then
        camera = LuaMgr.SetGuideCamera(camera);
        layerMask = "3DToUI";
    end
    return RaycastTool.GetClickInfo(camera, distance, layerMask);
end