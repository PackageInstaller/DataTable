--[[ 
-----------------------------------------------------
@filename       : DormitorySettledHeroItem
@Description    : 宿舍选择战员入住item
@date           : 2022-03-08 19:42:29
@Author         : Jacob
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.view.item.DormitorySettledHeroItem', Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mImgHead = self:getChildGO("mImgHead"):GetComponent(ty.AutoRefImage)
    self.mImgSelectBg = self:getChildGO("mImgSelectBg")
    self.mGroup = self:getChildGO("mGroup")
    self.mImgBg = self.mGroup:GetComponent(ty.AutoRefImage)
    self.mImgDisable = self:getChildGO("mImgDisable")

    self:addOnClick(self.mGroup, self.onSelect)
end

function setData(self, param)
    super.setData(self, param)
    self.heroVo = self.data:getDataVo()

    local roomConfigData = buildBase.BuildBaseManager:getBuildBasePosDataByPos(dormitory.DormitoryManager:getRoomId())
    local levelsData = buildBase.BuildBaseManager:getBuildBaseLevelNeedData(roomConfigData.buildType)

    local roomData = buildBase.BuildBaseManager:getBuildBaseData(dormitory.DormitoryManager:getRoomId())
    local roomLevelConfigData = levelsData:getLevelDataVo(roomData.lv)

    self.maxNum = roomLevelConfigData:getNum()

    self:setGuideTrans("guide_DormitorySettled_"..self.heroVo.tid, self.mGroup.transform)
    
    self.mImgHead:SetImg(UrlManager:getHeroHeadUrl(self.heroVo.tid), false)

    self.mImgSelectBg:SetActive(self.data:getSelect())

    local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.heroVo.tid)
    self.mImgBg:SetImg(UrlManager:getHeroColorIconUrl_1(heroConfigVo.color), false)

    local config = hero.HeroCuteManager:getHeroCuteConfigVo(self.heroVo.tid)
    self.mImgDisable:SetActive(config == nil)
end

function onSelect(self)
    local config = hero.HeroCuteManager:getHeroCuteConfigVo(self.heroVo.tid)
    if config == nil then 
        gs.Message.Show(_TT(49717))
        return
    end

    if dormitory.DormitoryManager:getSettledHeroPos(self.heroVo.tid) then
        self:setSelectState()
    else
        local dic = dormitory.DormitoryManager:getSelectHeroDic()
        if table.nums(dic) >= self.maxNum then
            gs.Message.Show(_TT(49715))
        else
            self:setSelectState()
        end
    end
end

-- 设置选中状态
function setSelectState(self)
    local isSelect = not self.mImgSelectBg.activeSelf
    self.data:setSelect(isSelect)
    self.mImgSelectBg:SetActive(isSelect)
    dormitory.DormitoryManager:setSettledHeroId(self.heroVo.tid)
end


function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
    self:removeOnClick(self.mGroup)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(49717):	"暂无资源，敬请期待"
	语言包: _TT(49715):	"最多入住三位战员"
]]
