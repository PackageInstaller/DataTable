module("battleMap.MainMapFinishView", Class.impl(View))

panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isAdapta = 0
destroyTime = 0
escapeClose = 0

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 取父容器
function getParentTrans(self)
    return GameView.msg
end

function initData(self)

end

function configUI(self)
    -- self.mImgFinishBG= self:getChildGO("mImgFinishBg"):GetComponent(ty.AutoRefImage)
    -- self.mImgNumBg = self:getChildGO("mImgNumBg"):GetComponent(ty.AutoRefImage)
    -- self.mImgNum = self:getChildGO("mImgNum"):GetComponent(ty.AutoRefImage)
    -- self.mImgName = self:getChildGO("mImgName"):GetComponent(ty.AutoRefImage)
    -- self.mImgTips = self:getChildGO("mImgTips"):GetComponent(ty.AutoRefImage)
end

function setCallFinish(self,call)
    self.call = call
end

function active(self, args)
    super.active(self, args)

    self:showFisish()
end

function showFisish(self)
    -- local idStr = ""
    -- if id < 10 then
    --     idStr = "0"..id
    -- else
    --     idStr = id
    -- end
    -- self.mImgFinishBG:SetImg(UrlManager:getBgPath("mainMap/mainMap_finish_"..idStr..".jpg"),false)
    -- self.mImgNumBg:SetImg(UrlManager:getPackPath("mainMapFinish/chapter_titlebg_"..idStr..".png"),false)
    -- self.mImgNum:SetImg(UrlManager:getPackPath("mainMapFinish/chapter_num_"..idStr..".png"),false)
    -- self.mImgName:SetImg(UrlManager:getPackPath("mainMapFinish/chapter_name_"..idStr..".png"),false)
    -- self.mImgTips:SetImg(UrlManager:getPackPath("mainMapFinish/chapter_tips_"..idStr..".png"),false)
    

    local function closeSelf()
        self:onClickClose()
    end
    LoopManager:setTimeout(4.5, nil, closeSelf)
end

function deActive(self)
    super.deActive(self)

    if(self.call) then
        self.call()
        self.call = nil
    end
end

return _M
