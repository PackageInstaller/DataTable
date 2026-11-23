RhythmGameTime = {}

local this = {
    startFillAmount = 0.188,
    endFillAmount = 0.314,
    distance = 0,
    startDir = nil,
    angle = 0,
};

local objs = {
    time = { path = "Group/Bar", type = "Image" },
    startTF = { path = "Group/Start", type = "RectTransform" },
    endTF = { path = "Group/End", type = "RectTransform" },
    dotTF = { path = "Group/Dot", type = "RectTransform" },
    ballTF = { path = "Group/Ball", type = "RectTransform" },
}

RhythmGameTime.Init = function(gameObject)
    UITool.Parse(gameObject, this, objs);
    local startPos = this.startTF.localPosition;
    this.distance = startPos.magnitude;
    this.startDir = startPos.normalized;
    local endDir = this.endTF.localPosition.normalized;
    this.angle = Vector3.Angle(this.startDir, endDir);
    this.startDir.z = this.startDir.y;
    this.startDir.y = 0;
end

RhythmGameTime.Clear = function()
    
end

RhythmGameTime.Update = function(rate)
    local fillAmount = (this.endFillAmount - this.startFillAmount) * rate;
    this.time.fillAmount = fillAmount + this.startFillAmount;
    local addAngle = this.angle * rate;
    local pos = Quaternion.AngleAxis(-addAngle, Vector3.up) * this.startDir * this.distance;
    pos.y = pos.z;
    pos.z = 0;
    this.dotTF.localPosition = pos;
    pos.y = pos.y + 30;
    this.ballTF.localPosition = pos;
end