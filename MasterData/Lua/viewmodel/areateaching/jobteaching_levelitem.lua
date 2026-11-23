JobTeaching_LevelItem = {};

JobTeaching_LevelItem.__index = JobTeaching_LevelItem;
local objs = {
    imgBg={path="bg",type="Image"},
    imgJob={path="job",type="Image"},
    textName={path="text",type="Text"},
    goods={path="goods",type="Transform"},
    goSuo={path="suo",type="GameObject"},
    goDone={path="done",type="GameObject"},
    btnIcon={path="bg",type="Button"},
    textNum={path="num",type="Text"},
}

   

function JobTeaching_LevelItem.New()
    local self = {};
    setmetatable(self, JobTeaching_LevelItem);
    return self;
end

function JobTeaching_LevelItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end


function JobTeaching_LevelItem:SetData(pdata)
    self.data=pdata.data;
    self.imgBg.sprite=LuaMgr.GetSprite("JobTeaching","ui_qydt_jx_tcdi_jj_0"..self.data.levelIndex)
    self.textName.text=self.data.name;
    SetActive(self.goSuo,self.data.isLock)
    SetActive(self.goDone,self.data.isDone)
    SetActive(self.goods.gameObject,not self.data.isDone)
    if self.data.levelIndex<=2 then
        SetActive(self.imgJob.gameObject,true)
        SetActive(self.textNum.gameObject,false)
        local jobName=string.format("ui_qydt_jx_tcicon_%s%s",self.data.icon,self.data.levelIndex==2 and "_2" or "")
        self.imgJob.sprite=LuaMgr.GetSprite("JobTeaching",jobName)
    else
        SetActive(self.textNum.gameObject,true)
        SetActive(self.imgJob.gameObject,false)
        self.textNum.text=self.data.index;
    end
    self.btnIconCommand=function()
        if self.data.callBack~=nil then
            self.data.callBack(tonumber(self.data.index));
        end
    end
    LuaMgr.AddClick(self.btnIcon,self.btnIconCommand)
    
    if self.data.isDone then 
        return
    end;
    local reward=self.data.reward;
    if self.item==nil then
        self.item=GoodsDataItem.New(self.goods)
    end
    local itemConfig = ConfigMgr.Config.itemMap[reward.id]
    itemConfig["count0"] = reward.count
    self.item:SetData(1,itemConfig,1,false,Vector3(0.32,0.32,1),false)
end


function JobTeaching_LevelItem:Clear()
    if self.bgBtnCommand~=nil then
        LuaMgr.RemoveClick(self.btnIcon,self.btnIconCommand)
    end
    self.data=nil
end

function JobTeaching_LevelItem:Destroy()
    self.data=nil;
    self.imgBg=nil;
    self.imgJob=nil;
    self.textName=nil;
    self.goods=nil;
    self.goSuo=nil;
    self.goDone=nil;
    self.btnIcon=nil;
    self.textNum=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

