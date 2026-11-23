KZRYExplore_CityItem = {};

KZRYExplore_CityItem.__index = KZRYExplore_CityItem;
local objs = {
    imgTag={ path = "root/tagImg", type = "Image" },
    imgName={ path = "root/nameImg", type = "Image" },
    norObj={ path = "root/nor", type = "GameObject" },
    lockObj={ path = "root/lock", type = "GameObject" },
    txtPro={ path = "root/nor/pro/text", type = "Text" },
    txtLock={ path = "root/lock/bg/text", type = "Text" },
    btnClick={ path = "root/btnClick", type = "Button" },
    unlockEffc={ path = "root/nor/vfx_unlock", type = "GameObject" },
}

function KZRYExplore_CityItem.New()
    local self = {};
    setmetatable(self, KZRYExplore_CityItem);
    return self;
end

function KZRYExplore_CityItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnClick,function()
        if self.data.isLock then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,self.data.lockInfoTips)
        else
            if self.data.callBack~=nil then
                self.data.callBack(self.data.index);
            end
        end
    end)
end


function KZRYExplore_CityItem:SetData(pdata)
    self.data = pdata.data
    self.transform.anchoredPosition=self.data.locPos;
    self:SetLock(self.data.isLock)
    SetActive(self.unlockEffc,false)
end

function KZRYExplore_CityItem:ShowUnlockEff()
    SetActive(self.unlockEffc,true)
end
    

function KZRYExplore_CityItem:SetLock(lock)
    SetActive(self.norObj,not lock)
    SetActive(self.lockObj,lock)
    self.imgTag.sprite=lock and LuaMgr.GetSprite("KZRY","ui_hd_kz_zx_gk_0") or LuaMgr.GetSprite("KZRY","ui_hd_kz_zx_gk_1")
    local cityName=string.format("ui_hd_kz_zx_gk_st%s_%s",self.data.index,lock and "0" or "1")
    self.imgName.sprite= LuaMgr.GetSprite("KZRY",cityName);
    if lock then
        self.txtLock.text=self.data.lockInfo;
    else
        self.txtPro.text=self.data.proInfo;
    end
end

function KZRYExplore_CityItem:Clear()
    self.data = nil;
end

function KZRYExplore_CityItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
end