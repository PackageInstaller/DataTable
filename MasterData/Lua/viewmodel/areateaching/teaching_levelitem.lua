Teaching_LevelItem = {};

Teaching_LevelItem.__index = Teaching_LevelItem;
local objs = {
    bg1Sprite={path="root/bg/bg1",type="Image"},
    bg2Sprite={path="root/bg/bg2",type="Image"},
    bg3Sprite={path="root/bg/bg3",type="Image"},
    bg4Sprite={path="root/bg/bg4",type="Image"},
    bg5Sprite={path="root/bg/bg5",type="Image"},
    bg6Sprite={path="root/bg/bg6",type="Image"},
    bgBtn={path="root",type="UIButtonClick"},
    lockObj={path = "root/lock", type = "GameObject"},
    lockText={path = "root/lock/Text", type = "Text"},
    listObj={path = "root/list", type = "GameObject"},
    qrSprite={path = "root/list/qr", type = "Image"},
    yjSprite={path = "root/list/yj", type = "Image"},
    gsSprite={path = "root/list/gs", type = "Image"},
    zlSprite={path = "root/list/zl", type = "Image"},
    swSprite={path = "root/list/sw", type = "Image"},
    levelInfoObj={path = "root/levelInfo", type = "GameObject"},
    curText={path = "root/levelInfo/cur", type = "Text"},
    maxText={path = "root/levelInfo/max", type = "Text"},
    sliderValue={path = "root/levelInfo/slider/value", type = "Image"},
    proText={path = "root/levelInfo/pro", type = "Text"},
    redListener={path="root",type="RedIconListener"},
}

   

function Teaching_LevelItem.New()
    local self = {};
    setmetatable(self, Teaching_LevelItem);
    return self;
end

function Teaching_LevelItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.jobSprites={}
    table.insert(self.jobSprites,self.qrSprite)
    table.insert(self.jobSprites,self.yjSprite)
    table.insert(self.jobSprites,self.gsSprite)
    table.insert(self.jobSprites,self.zlSprite)
    table.insert(self.jobSprites,self.swSprite)
end


function Teaching_LevelItem:SetData(pdata)
    self.data = pdata;
    self.redListener.RedId=pdata.data.redId
    self.gameObject.transform.anchoredPosition=pdata.data.pos
    self.bg1Sprite.sprite= LuaMgr.GetSprite("JoinJob",string.format("ui_rz_szxl_%s_iconbg",pdata.data.tag))
    self.bg2Sprite.sprite= LuaMgr.GetSprite("JoinJob",string.format("ui_rz_szxl_%s_icon",pdata.data.tag))
    self.bg3Sprite.sprite= LuaMgr.GetSprite("JoinJob",string.format("ui_rz_szxl_%s_graphic",pdata.data.tag))
    self.bg4Sprite.sprite= LuaMgr.GetSprite("JoinJob",string.format("ui_rz_szxl_%s_title_bg",pdata.data.tag))
    self.bg5Sprite.sprite= LuaMgr.GetSprite("JoinJob",string.format("ui_rz_szxl_%s_title",pdata.data.tag))
    self.bg6Sprite.sprite= LuaMgr.GetSprite("JoinJob",string.format("ui_rz_szxl_%s_hg",pdata.data.tag))
    self.bgBtnCommand=function()
        if  pdata.data.isLock then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,pdata.data.text)
            return
        end
        if self.data.data.callBack~=nil then
            self.data.data.callBack(self.data.data.type);
        end
    end
    LuaMgr.AddClick(self.bgBtn,self.bgBtnCommand)
    SetActive(self.levelInfoObj,false)
    SetActive(self.listObj,false)
    SetActive(self.lockObj,pdata.data.isLock)
    if pdata.data.isLock then
        self.lockText.text=pdata.data.text
        return
    end
    if pdata.data.type<3 then
        SetActive(self.listObj,true);
        for i,v in ipairs(pdata.data.events) do
            local  pass=DataMgr.Player.dungeonRecords[v.id]~=nil and DataMgr.Player.dungeonRecords[v.id].completeCount>0 ;
            if pdata.data.type==1 then
                self.jobSprites[i].sprite=pass and LuaMgr.GetSprite("JoinJob","ui_rz_szxl_jc_jdt_"..v.icon) or LuaMgr.GetSprite("JoinJob","ui_rz_szxl_jdt_"..v.icon)
            elseif pdata.data.type==2 then
                self.jobSprites[i].sprite=pass and LuaMgr.GetSprite("JoinJob","ui_rz_szxl_jj_jdt_"..v.icon) or LuaMgr.GetSprite("JoinJob","ui_rz_szxl_jdt_"..v.icon)
            end
        end
    elseif pdata.data.type==3 then
        SetActive(self.levelInfoObj,true)
        self.curText.text=pdata.data.zzInfo.cur
        self.maxText.text=pdata.data.zzInfo.max
        self.proText.text=string.format("<color=#CD402F><size=26>%s</size></color>/%s",pdata.data.zzInfo.getCount,pdata.data.zzInfo.maxCount)
        self.sliderValue.fillAmount=pdata.data.zzInfo.cur/pdata.data.zzInfo.max
    end
   
end


function Teaching_LevelItem:DoMove(index,dir,time,callBack)
    local tarPos=nil;
    if index==1 then
        if self.data.data.type==1 then
            tarPos=dir>0 and self.data.data.pos+Vector2(-347/2-50,0) or self.data.data.pos
        elseif self.data.data.type==2 then
            tarPos=dir>0 and self.data.data.pos+Vector2(347+347/2+100,0) or self.data.data.pos;
        elseif self.data.data.type==3 then
            tarPos=dir>0 and self.data.data.pos+Vector2(347+347/2+100,0) or self.data.data.pos;
        end
    elseif index==2 then
        if self.data.data.type==1 then
            tarPos=dir>0 and self.data.data.pos+Vector2(-347-347/2-150,0) or self.data.data.pos
        elseif self.data.data.type==2 then
            tarPos=dir>0 and self.data.data.pos+Vector2(-347-347/2-150,0) or self.data.data.pos;
        elseif self.data.data.type==3 then
            tarPos=dir>0 and self.data.data.pos+Vector2(347-100,0) or self.data.data.pos;
        end
    elseif index==3 then
        if self.data.data.type==1 then
            tarPos=dir>0 and self.data.data.pos+Vector2(-347*2-150,0) or self.data.data.pos
        elseif self.data.data.type==2 then
            tarPos=dir>0 and self.data.data.pos+Vector2(-347*2-150,0) or self.data.data.pos;
        elseif self.data.data.type==3 then
            tarPos=dir>0 and self.data.data.pos+Vector2(-347*2-150,0) or self.data.data.pos;
        end
    end
    DOTWeen.To(function()return self.gameObject.transform.anchoredPosition  end,function(vetor)
        self.gameObject.transform.anchoredPosition=vetor
    end,tarPos,time).onComplete=function()
        if self.data.data.type==index and callBack~=nil then
            callBack()
        end
    end
    
end
    


function Teaching_LevelItem:Clear()
    if self.bgBtnCommand~=nil then
        LuaMgr.RemoveClick(self.bgBtn,self.bgBtnCommand)
    end
    self.data=nil
end

function Teaching_LevelItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

