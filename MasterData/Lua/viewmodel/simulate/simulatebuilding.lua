SimulateBuilding = {};

SimulateBuilding.__index = SimulateBuilding;

SimulateBuilding.New = function(container,buildId)
    local self = {};
    setmetatable(self, SimulateBuilding);
    self.container=container
    self.buildId=buildId;
    return self;
end

function SimulateBuilding:SetData(buildName,level)
    self.buildName=buildName;
    local names=NumTool.split(buildName,"_");
    self.buildNamePre=names[1];
    self.buildLevel=level;
    self:SetBuildingByLevel(level)
end



function SimulateBuilding:SetBuildingByLevel(level)
    for i=1,3,1 do
        local childTF_i=self.container:GetChild(i-1);
        local childName=string.format("%s_%s",self.buildNamePre,10*i)
        local buildObj_index=childTF_i:Find(childName)
        SetActive(buildObj_index.gameObject,level==i)
    end
end

function SimulateBuilding:UpLevel(level)
    for i=1,3,1 do
        local childTF_i=self.container:GetChild(i-1);
        local childName=string.format("%s_%s",self.buildNamePre,10*i)
        local buildObj_index=childTF_i:Find(childName)
        SetActive(buildObj_index.gameObject,level==i)
        if i==level then
            self.upFX=buildObj_index:Find("eff_levelup")
            if self.upFX~=nil then
                SetActive(self.upFX.gameObject,true);
            end
        end
    end
end


function SimulateBuilding:Clear()
    self.container=nil;
end

function SimulateBuilding:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
end 