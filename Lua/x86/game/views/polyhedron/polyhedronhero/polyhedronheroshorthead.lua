local var_0_0 = class("PolyhedronHeroShortHead", HeroShortHead)

function var_0_0.GetHeroUnLock(arg_1_0)
	return PolyhedronData:GetPolyhedronHeroUnlock(arg_1_0.heroInfo_.id)
end

function var_0_0.SetHeroData(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.SetHeroData(arg_2_0, arg_2_1, arg_2_2)

	arg_2_0.headIcon_.sprite = HeroTools.GetHeadSprite(arg_2_0.heroInfo_.using_skin)

	if PolyhedronAction:GetPolyhedronHeroRedPointCount(arg_2_0.heroId_) > 0 then
		manager.redPoint:SetRedPointIndependent(arg_2_0.noticePos_, true)
	else
		manager.redPoint:SetRedPointIndependent(arg_2_0.noticePos_, false)
	end
end

function var_0_0.SetRedPoint(arg_3_0)
	local var_3_0 = PolyhedronAction:GetPolyhedronHeroRedPointCount(arg_3_0.heroId_) > 0

	SetActive(arg_3_0.noticePos_.gameObject, var_3_0)
end

return var_0_0
