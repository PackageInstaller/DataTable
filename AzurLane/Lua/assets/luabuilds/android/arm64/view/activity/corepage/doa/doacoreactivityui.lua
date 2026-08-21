local var_0_0 = class("DOACoreActivityUI", import("view.activity.CorePage.MoscowUR.MoscowURCoreActivityUI"))

function var_0_0.getUIName(arg_1_0)
	return "DOACoreActivityUI"
end

function var_0_0.loadingQueue(arg_2_0)
	if PlayerPrefs.GetInt("play_jiarihangxianshanyaohaibin" .. getProxy(PlayerProxy):getPlayerId(), 0) == 1 then
		return nil
	else
		return function(arg_3_0)
			pg.SceneAnimMgr.GetInstance():CommonSceneChange("jiarihangxianshanyaohaibin", function(arg_4_0)
				return arg_3_0(function()
					PlayerPrefs.SetInt(var_0, 1)
					existCall(arg_4_0)

					return
				end)
			end)

			return
		end
	end

	return
end

function var_0_0.OnAnimations(arg_6_0, arg_6_1, arg_6_2)
	SetActive(arg_6_0._tf:Find("adapt/logo2"), arg_6_2.id == 16 or arg_6_2.id == 12)
	SetActive(arg_6_0._tf:Find("adapt/logo"), arg_6_2.id ~= 16 and arg_6_2.id ~= 12)
	SetActive(arg_6_0._tf:Find("left_bg"), arg_6_2.id == 9)
	SetActive(arg_6_0._tf:Find("decorate"), arg_6_2.id == 9)

	return
end

function var_0_0.OnToggleName(arg_7_0, arg_7_1, arg_7_2)
	return
end

return var_0_0
