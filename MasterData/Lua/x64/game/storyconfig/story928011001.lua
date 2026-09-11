return {
	Play928011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 928011001
		arg_1_1.duration_ = 2

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play928011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.STblack == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_4_0.name = "STblack"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STblack = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 0.133333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.133333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_dream01", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = true,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				contentID = 928011001,
				charCount = 15,
				enableEffect = true,
				enableLayoutChange = true,
				duration = 1,
				groupID = "111",
				startTime = 0.7,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 100,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 160,
					paragraphSpacing = 30,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				bgData = {
					bgActionType = StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.ENABLE,
					bgColor = Color.New(0, 0, 0, 0.5)
				},
				textComProperty = {
					fontSize = 40,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1.3,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play928011002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 928011002
		arg_6_1.duration_ = 3.13

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play928011003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			return
		end

		arg_6_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = true,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				contentID = 928011002,
				charCount = 31,
				enableEffect = true,
				enableLayoutChange = true,
				duration = 2.06666666666667,
				groupID = "111",
				startTime = 1.05861210217699,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 100,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 160,
					paragraphSpacing = 30,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				bgData = {
					bgActionType = StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.ENABLE,
					bgColor = Color.New(0, 0, 0, 0.5)
				},
				textComProperty = {
					fontSize = 40,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1.3,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_6_1:InitPlayNodeList()
	end,
	Play928011003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 928011003
		arg_10_1.duration_ = 2.43

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play928011004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			return
		end

		arg_10_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = true,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				contentID = 928011003,
				charCount = 29,
				enableEffect = true,
				enableLayoutChange = true,
				duration = 1.93333333333333,
				groupID = "111",
				startTime = 0.5,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 100,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 160,
					paragraphSpacing = 30,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				bgData = {
					bgActionType = StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.ENABLE,
					bgColor = Color.New(0, 0, 0, 0.5)
				},
				textComProperty = {
					fontSize = 40,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1.3,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_10_1:InitPlayNodeList()
	end,
	Play928011004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 928011004
		arg_14_1.duration_ = 2.63

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play928011005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.allBtn_.enabled = false
			end

			if arg_14_1.time_ >= 0 + 1.66666666666667 and arg_14_1.time_ < 0 + 1.66666666666667 + arg_17_0 then
				arg_14_1.allBtn_.enabled = true
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = true,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				contentID = 928011004,
				charCount = 32,
				enableEffect = true,
				enableLayoutChange = true,
				duration = 2.13333333333333,
				groupID = "111",
				startTime = 0.5,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 100,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 160,
					paragraphSpacing = 30,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				bgData = {
					bgActionType = StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.ENABLE,
					bgColor = Color.New(0, 0, 0, 0.5)
				},
				textComProperty = {
					fontSize = 40,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1.3,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play928011005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 928011005
		arg_18_1.duration_ = 8.17

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play928011006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if arg_18_1.bgs_.ST0103 == nil then
				local var_21_0 = Object.Instantiate(arg_18_1.paintGo_)

				var_21_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0103")
				var_21_0.name = "ST0103"
				var_21_0.transform.parent = arg_18_1.stage_.transform
				var_21_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_18_1.bgs_.ST0103 = var_21_0
			end

			if 1.46666666666667 < arg_18_1.time_ and arg_18_1.time_ <= 1.46666666666667 + arg_21_0 then
				local var_21_1 = arg_18_1.bgs_.ST0103

				arg_18_1.bgs_.ST0103.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_21_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_21_2 = var_21_1:GetComponent("SpriteRenderer")

				if var_21_2 and var_21_2.sprite then
					local var_21_3 = 2 * (var_21_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_21_1.transform.localScale = Vector3.New(var_21_3 / var_21_2.sprite.bounds.size.y < var_21_3 * manager.ui.mainCameraCom_.aspect / var_21_2.sprite.bounds.size.x and var_21_3 * manager.ui.mainCameraCom_.aspect / var_21_2.sprite.bounds.size.x or var_21_3 / var_21_2.sprite.bounds.size.y, var_21_3 / var_21_2.sprite.bounds.size.y < var_21_3 * manager.ui.mainCameraCom_.aspect / var_21_2.sprite.bounds.size.x and var_21_3 * manager.ui.mainCameraCom_.aspect / var_21_2.sprite.bounds.size.x or var_21_3 / var_21_2.sprite.bounds.size.y, 0)
				end

				for iter_21_0, iter_21_1 in pairs(arg_18_1.bgs_) do
					if iter_21_0 ~= "ST0103" then
						iter_21_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_21_4 = 0

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_4 + arg_21_0 then
				arg_18_1.allBtn_.enabled = false
			end

			if arg_18_1.time_ >= var_21_4 + 0.3 and arg_18_1.time_ < var_21_4 + 0.3 + arg_21_0 then
				arg_18_1.allBtn_.enabled = true
			end

			local var_21_5 = 0

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_5 + arg_21_0 then
				arg_18_1.mask_.enabled = true
				arg_18_1.mask_.raycastTarget = true

				arg_18_1:SetGaussion(false)
			end

			local var_21_6 = 1.46666666666667

			if var_21_5 <= arg_18_1.time_ and arg_18_1.time_ < var_21_5 + var_21_6 then
				local var_21_7 = Color.New(0, 0, 0)

				var_21_7.a = Mathf.Lerp(0, 1, (arg_18_1.time_ - var_21_5) / var_21_6)
				arg_18_1.mask_.color = var_21_7
			end

			if arg_18_1.time_ >= var_21_5 + var_21_6 and arg_18_1.time_ < var_21_5 + var_21_6 + arg_21_0 then
				local var_21_8 = Color.New(0, 0, 0)

				var_21_8.a = 1
				arg_18_1.mask_.color = var_21_8
			end

			local var_21_9 = 1.46666666666667

			if 1.46666666666667 < arg_18_1.time_ and arg_18_1.time_ <= var_21_9 + arg_21_0 then
				arg_18_1.mask_.enabled = true
				arg_18_1.mask_.raycastTarget = true

				arg_18_1:SetGaussion(false)
			end

			local var_21_10 = 1.53333333333333

			if var_21_9 <= arg_18_1.time_ and arg_18_1.time_ < var_21_9 + var_21_10 then
				local var_21_11 = Color.New(0, 0, 0)

				var_21_11.a = Mathf.Lerp(1, 0, (arg_18_1.time_ - var_21_9) / var_21_10)
				arg_18_1.mask_.color = var_21_11
			end

			if arg_18_1.time_ >= var_21_9 + var_21_10 and arg_18_1.time_ < var_21_9 + var_21_10 + arg_21_0 then
				local var_21_12 = Color.New(0, 0, 0)

				arg_18_1.mask_.enabled = false
				var_21_12.a = 0
				arg_18_1.mask_.color = var_21_12
			end

			if 0.133333333333333 < arg_18_1.time_ and arg_18_1.time_ <= 0.133333333333333 + arg_21_0 then
				arg_18_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_dream01", "")
			end

			if 1 < arg_18_1.time_ and arg_18_1.time_ <= 1 + arg_21_0 then
				arg_18_1:AudioAction("play", "effect", "se_story_side_1061", "se_story_side_1061_amb_train", "")
			end

			if 1 < arg_18_1.time_ and arg_18_1.time_ <= 1 + arg_21_0 then
				arg_18_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_21_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_18_1.bgmTxt_.text ~= var_21_18 and arg_18_1.bgmTxt_.text ~= "" then
						if arg_18_1.bgmTxt2_.text ~= "" then
							arg_18_1.bgmTxt_.text = arg_18_1.bgmTxt2_.text
						end

						arg_18_1.bgmTxt2_.text = var_21_18

						arg_18_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_18_1.bgmTxt_.text = var_21_18
						arg_18_1.bgmTxt2_.text = var_21_18
					end

					if arg_18_1.bgmTimer then
						arg_18_1.bgmTimer:Stop()

						arg_18_1.bgmTimer = nil
					end

					if arg_18_1.settingData.show_music_name == 1 then
						arg_18_1.musicController:SetSelectedState("show")
						arg_18_1.musicAnimator_:Play("open", 0, 0)

						if arg_18_1.settingData.music_time ~= 0 then
							arg_18_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_18_1.settingData.music_time), function()
								if arg_18_1 == nil or isNil(arg_18_1.bgmTxt_) then
									return
								end

								arg_18_1.musicController:SetSelectedState("hide")
								arg_18_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.46666666666667 < arg_18_1.time_ and arg_18_1.time_ <= 1.46666666666667 + arg_21_0 then
				arg_18_1:AudioAction("play", "music", "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_21_21 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

				if "" ~= "" then
					if arg_18_1.bgmTxt_.text ~= var_21_21 and arg_18_1.bgmTxt_.text ~= "" then
						if arg_18_1.bgmTxt2_.text ~= "" then
							arg_18_1.bgmTxt_.text = arg_18_1.bgmTxt2_.text
						end

						arg_18_1.bgmTxt2_.text = var_21_21

						arg_18_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_18_1.bgmTxt_.text = var_21_21
						arg_18_1.bgmTxt2_.text = var_21_21
					end

					if arg_18_1.bgmTimer then
						arg_18_1.bgmTimer:Stop()

						arg_18_1.bgmTimer = nil
					end

					if arg_18_1.settingData.show_music_name == 1 then
						arg_18_1.musicController:SetSelectedState("show")
						arg_18_1.musicAnimator_:Play("open", 0, 0)

						if arg_18_1.settingData.music_time ~= 0 then
							arg_18_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_18_1.settingData.music_time), function()
								if arg_18_1 == nil or isNil(arg_18_1.bgmTxt_) then
									return
								end

								arg_18_1.musicController:SetSelectedState("hide")
								arg_18_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_18_1.frameCnt_ <= 1 then
				arg_18_1.dialog_:SetActive(false)
			end

			local var_21_22 = 3.16666666666667
			local var_21_23 = 0.85

			if 3.16666666666667 < arg_18_1.time_ and arg_18_1.time_ <= var_21_22 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				arg_18_1.dialog_:SetActive(true)

				arg_18_1.dialogCg_.alpha = 0

				local var_21_24 = LeanTween.value(arg_18_1.dialog_, 0, 1, 0.3)

				var_21_24:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_18_1.dialogCg_.alpha = arg_24_0
				end))
				var_21_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_18_1.dialog_)
					var_21_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_18_1.duration_ = arg_18_1.duration_ + 0.3

				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_25 = arg_18_1:FormatText(arg_18_1:GetWordFromCfg(928011005).content)

				arg_18_1.text_.text = var_21_25

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_27 = 34 <= 0 and var_21_23 or var_21_23 * (utf8.len(var_21_25) / 34)

				if (34 <= 0 and var_21_23 or var_21_23 * (utf8.len(var_21_25) / 34)) > 0 and var_21_23 < var_21_27 then
					arg_18_1.talkMaxDuration = var_21_27
					var_21_22 = var_21_22 + 0.3

					if var_21_27 + var_21_22 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_27 + var_21_22
					end
				end

				arg_18_1.text_.text = var_21_25
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_28 = var_21_22 + 0.3
			local var_21_29 = math.max(var_21_23, arg_18_1.talkMaxDuration)

			if var_21_22 + 0.3 <= arg_18_1.time_ and arg_18_1.time_ < var_21_28 + var_21_29 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_28) / var_21_29

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_28 + var_21_29 and arg_18_1.time_ < var_21_28 + var_21_29 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				groupID = "111",
				duration = 0.366666666666667,
				className = "StoryTextGroupNode",
				startTime = 1.46666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play928011006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 928011006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play928011007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.45

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_1 = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(928011006).content)

				arg_26_1.text_.text = var_29_1

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_3 = 18 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_1) / 18)

				if (18 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_1) / 18)) > 0 and var_29_0 < var_29_3 then
					arg_26_1.talkMaxDuration = var_29_3

					if var_29_3 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_3 + 0
					end
				end

				arg_26_1.text_.text = var_29_1
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_4 = math.max(var_29_0, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_4 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - 0) / var_29_4

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_4 and arg_26_1.time_ < 0 + var_29_4 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play928011007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 928011007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play928011008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0.625

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_1 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(928011007).content)

				arg_30_1.text_.text = var_33_1

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_3 = 25 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 25)

				if (25 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 25)) > 0 and var_33_0 < var_33_3 then
					arg_30_1.talkMaxDuration = var_33_3

					if var_33_3 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_3 + 0
					end
				end

				arg_30_1.text_.text = var_33_1
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_4 = math.max(var_33_0, arg_30_1.talkMaxDuration)

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_4 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - 0) / var_33_4

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= 0 + var_33_4 and arg_30_1.time_ < 0 + var_33_4 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play928011008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 928011008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play928011009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0.975

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_1 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(928011008).content)

				arg_34_1.text_.text = var_37_1

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_3 = 39 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_1) / 39)

				if (39 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_1) / 39)) > 0 and var_37_0 < var_37_3 then
					arg_34_1.talkMaxDuration = var_37_3

					if var_37_3 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_3 + 0
					end
				end

				arg_34_1.text_.text = var_37_1
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_4 = math.max(var_37_0, arg_34_1.talkMaxDuration)

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_4 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - 0) / var_37_4

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= 0 + var_37_4 and arg_34_1.time_ < 0 + var_37_4 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play928011009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 928011009
		arg_38_1.duration_ = 5.2

		local var_38_0 = {
			zh = 4.666,
			ja = 5.2
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play928011010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if arg_38_1.actors_["1085ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1085ui_story"))) then
				local var_41_0 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_38_1.stage_.transform)

				var_41_0.name = "1085ui_story"
				var_41_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_38_1.actors_["1085ui_story"] = var_41_0

				local var_41_1 = var_41_0:GetComponentInChildren(typeof(CharacterEffect))

				var_41_1.enabled = true

				local var_41_2 = GameObjectTools.GetOrAddComponent(var_41_0, typeof(DynamicBoneHelper))

				if var_41_2 then
					var_41_2:EnableDynamicBone(false)
				end

				arg_38_1:ShowWeapon(var_41_1.transform, false)

				arg_38_1.var_["1085ui_story" .. "Animator"] = var_41_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_38_1.var_["1085ui_story" .. "Animator"].applyRootMotion = true
				arg_38_1.var_["1085ui_story" .. "LipSync"] = var_41_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_41_3 = arg_38_1.actors_["1085ui_story"].transform

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos1085ui_story = var_41_3.localPosition
			end

			local var_41_4 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_4 then
				var_41_3.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_38_1.time_ - 0) / var_41_4)
				var_41_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_41_3.position).x, (manager.ui.mainCamera.transform.position - var_41_3.position).y, (manager.ui.mainCamera.transform.position - var_41_3.position).z)
				var_41_3.localEulerAngles.z = 0
				var_41_3.localEulerAngles.x = 0
				var_41_3.localEulerAngles = var_41_3.localEulerAngles
			end

			if arg_38_1.time_ >= 0 + var_41_4 and arg_38_1.time_ < 0 + var_41_4 + arg_41_0 then
				var_41_3.localPosition = Vector3.New(0, -1.01, -5.83)
				var_41_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_41_3.position).x, (manager.ui.mainCamera.transform.position - var_41_3.position).y, (manager.ui.mainCamera.transform.position - var_41_3.position).z)
				var_41_3.localEulerAngles.z = 0
				var_41_3.localEulerAngles.x = 0
				var_41_3.localEulerAngles = var_41_3.localEulerAngles
			end

			local var_41_5 = arg_38_1.actors_["1085ui_story"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_5) and arg_38_1.var_.characterEffect1085ui_story == nil then
				arg_38_1.var_.characterEffect1085ui_story = var_41_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_6 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_6 and not isNil(var_41_5) then
				if arg_38_1.var_.characterEffect1085ui_story and not isNil(var_41_5) then
					arg_38_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= 0 + var_41_6 and arg_38_1.time_ < 0 + var_41_6 + arg_41_0 and not isNil(var_41_5) and arg_38_1.var_.characterEffect1085ui_story then
				arg_38_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_41_8 = 0
			local var_41_9 = 0.35

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_8 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_10 = arg_38_1:GetWordFromCfg(928011009)
				local var_41_11 = arg_38_1:FormatText(var_41_10.content)

				arg_38_1.text_.text = var_41_11

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_13 = 14 <= 0 and var_41_9 or var_41_9 * (utf8.len(var_41_11) / 14)

				if (14 <= 0 and var_41_9 or var_41_9 * (utf8.len(var_41_11) / 14)) > 0 and var_41_9 < var_41_13 then
					arg_38_1.talkMaxDuration = var_41_13

					if var_41_13 + var_41_8 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_13 + var_41_8
					end
				end

				arg_38_1.text_.text = var_41_11
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011009", "story_v_side_old_928011.awb") ~= 0 then
					local var_41_14 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011009", "story_v_side_old_928011.awb") / 1000

					if var_41_14 + var_41_8 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_14 + var_41_8
					end

					if var_41_10.prefab_name ~= "" and arg_38_1.actors_[var_41_10.prefab_name] ~= nil then
						local var_41_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_10.prefab_name].transform, "story_v_side_old_928011", "928011009", "story_v_side_old_928011.awb")

						arg_38_1:RecordAudio("928011009", var_41_15)
						arg_38_1:RecordAudio("928011009", var_41_15)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011009", "story_v_side_old_928011.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011009", "story_v_side_old_928011.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_16 = math.max(var_41_9, arg_38_1.talkMaxDuration)

			if var_41_8 <= arg_38_1.time_ and arg_38_1.time_ < var_41_8 + var_41_16 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_8) / var_41_16

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_8 + var_41_16 and arg_38_1.time_ < var_41_8 + var_41_16 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play928011010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 928011010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play928011011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["1085ui_story"]) and arg_42_1.var_.characterEffect1085ui_story == nil then
				arg_42_1.var_.characterEffect1085ui_story = arg_42_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_0 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["1085ui_story"]) then
				if arg_42_1.var_.characterEffect1085ui_story and not isNil(arg_42_1.actors_["1085ui_story"]) then
					arg_42_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_42_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_42_1.time_ - 0) / var_45_0)
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["1085ui_story"]) and arg_42_1.var_.characterEffect1085ui_story then
				arg_42_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_42_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_45_1 = 0
			local var_45_2 = 0.625

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_3 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(928011010).content)

				arg_42_1.text_.text = var_45_3

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_5 = 25 <= 0 and var_45_2 or var_45_2 * (utf8.len(var_45_3) / 25)

				if (25 <= 0 and var_45_2 or var_45_2 * (utf8.len(var_45_3) / 25)) > 0 and var_45_2 < var_45_5 then
					arg_42_1.talkMaxDuration = var_45_5

					if var_45_5 + var_45_1 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_5 + var_45_1
					end
				end

				arg_42_1.text_.text = var_45_3
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_6 = math.max(var_45_2, arg_42_1.talkMaxDuration)

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_6 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_1) / var_45_6

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_1 + var_45_6 and arg_42_1.time_ < var_45_1 + var_45_6 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play928011011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 928011011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play928011012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos1085ui_story = arg_46_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_49_0 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 then
				arg_46_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_46_1.time_ - 0) / var_49_0)
				arg_46_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_46_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1085ui_story"].transform.position).z)
				arg_46_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_46_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_46_1.actors_["1085ui_story"].transform.localEulerAngles = arg_46_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 then
				arg_46_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_46_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_46_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1085ui_story"].transform.position).z)
				arg_46_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_46_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_46_1.actors_["1085ui_story"].transform.localEulerAngles = arg_46_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_49_1 = 0
			local var_49_2 = 1.075

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_3 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(928011011).content)

				arg_46_1.text_.text = var_49_3

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 43 <= 0 and var_49_2 or var_49_2 * (utf8.len(var_49_3) / 43)

				if (43 <= 0 and var_49_2 or var_49_2 * (utf8.len(var_49_3) / 43)) > 0 and var_49_2 < var_49_5 then
					arg_46_1.talkMaxDuration = var_49_5

					if var_49_5 + var_49_1 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + var_49_1
					end
				end

				arg_46_1.text_.text = var_49_3
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_6 = math.max(var_49_2, arg_46_1.talkMaxDuration)

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_6 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_1) / var_49_6

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_1 + var_49_6 and arg_46_1.time_ < var_49_1 + var_49_6 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play928011012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 928011012
		arg_50_1.duration_ = 6.8

		local var_50_0 = {
			zh = 5.666,
			ja = 6.8
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play928011013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1085ui_story = arg_50_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_53_0 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 then
				arg_50_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_50_1.time_ - 0) / var_53_0)
				arg_50_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1085ui_story"].transform.position).z)
				arg_50_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["1085ui_story"].transform.localEulerAngles = arg_50_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 then
				arg_50_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_50_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1085ui_story"].transform.position).z)
				arg_50_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["1085ui_story"].transform.localEulerAngles = arg_50_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_53_1 = arg_50_1.actors_["1085ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_1) and arg_50_1.var_.characterEffect1085ui_story == nil then
				arg_50_1.var_.characterEffect1085ui_story = var_53_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_2 and not isNil(var_53_1) then
				if arg_50_1.var_.characterEffect1085ui_story and not isNil(var_53_1) then
					arg_50_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_2 and arg_50_1.time_ < 0 + var_53_2 + arg_53_0 and not isNil(var_53_1) and arg_50_1.var_.characterEffect1085ui_story then
				arg_50_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_53_4 = 0
			local var_53_5 = 0.55

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_4 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_6 = arg_50_1:GetWordFromCfg(928011012)
				local var_53_7 = arg_50_1:FormatText(var_53_6.content)

				arg_50_1.text_.text = var_53_7

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_9 = 22 <= 0 and var_53_5 or var_53_5 * (utf8.len(var_53_7) / 22)

				if (22 <= 0 and var_53_5 or var_53_5 * (utf8.len(var_53_7) / 22)) > 0 and var_53_5 < var_53_9 then
					arg_50_1.talkMaxDuration = var_53_9

					if var_53_9 + var_53_4 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_9 + var_53_4
					end
				end

				arg_50_1.text_.text = var_53_7
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011012", "story_v_side_old_928011.awb") ~= 0 then
					local var_53_10 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011012", "story_v_side_old_928011.awb") / 1000

					if var_53_10 + var_53_4 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_4
					end

					if var_53_6.prefab_name ~= "" and arg_50_1.actors_[var_53_6.prefab_name] ~= nil then
						local var_53_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_6.prefab_name].transform, "story_v_side_old_928011", "928011012", "story_v_side_old_928011.awb")

						arg_50_1:RecordAudio("928011012", var_53_11)
						arg_50_1:RecordAudio("928011012", var_53_11)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011012", "story_v_side_old_928011.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011012", "story_v_side_old_928011.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_12 = math.max(var_53_5, arg_50_1.talkMaxDuration)

			if var_53_4 <= arg_50_1.time_ and arg_50_1.time_ < var_53_4 + var_53_12 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_4) / var_53_12

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_4 + var_53_12 and arg_50_1.time_ < var_53_4 + var_53_12 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play928011013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 928011013
		arg_54_1.duration_ = 12

		local var_54_0 = {
			zh = 12,
			ja = 11.466
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play928011014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 1.025

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_1 = arg_54_1:GetWordFromCfg(928011013)
				local var_57_2 = arg_54_1:FormatText(var_57_1.content)

				arg_54_1.text_.text = var_57_2

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 41 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 41)

				if (41 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 41)) > 0 and var_57_0 < var_57_4 then
					arg_54_1.talkMaxDuration = var_57_4

					if var_57_4 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_4 + 0
					end
				end

				arg_54_1.text_.text = var_57_2
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011013", "story_v_side_old_928011.awb") ~= 0 then
					local var_57_5 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011013", "story_v_side_old_928011.awb") / 1000

					if var_57_5 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + 0
					end

					if var_57_1.prefab_name ~= "" and arg_54_1.actors_[var_57_1.prefab_name] ~= nil then
						local var_57_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_1.prefab_name].transform, "story_v_side_old_928011", "928011013", "story_v_side_old_928011.awb")

						arg_54_1:RecordAudio("928011013", var_57_6)
						arg_54_1:RecordAudio("928011013", var_57_6)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011013", "story_v_side_old_928011.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011013", "story_v_side_old_928011.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_7 and arg_54_1.time_ < 0 + var_57_7 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play928011014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 928011014
		arg_58_1.duration_ = 7.6

		local var_58_0 = {
			zh = 7.1,
			ja = 7.6
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play928011015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_61_0 = 0
			local var_61_1 = 0.675

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_2 = arg_58_1:GetWordFromCfg(928011014)
				local var_61_3 = arg_58_1:FormatText(var_61_2.content)

				arg_58_1.text_.text = var_61_3

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 28 <= 0 and var_61_1 or var_61_1 * (utf8.len(var_61_3) / 28)

				if (28 <= 0 and var_61_1 or var_61_1 * (utf8.len(var_61_3) / 28)) > 0 and var_61_1 < var_61_5 then
					arg_58_1.talkMaxDuration = var_61_5

					if var_61_5 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_3
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011014", "story_v_side_old_928011.awb") ~= 0 then
					local var_61_6 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011014", "story_v_side_old_928011.awb") / 1000

					if var_61_6 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_6 + var_61_0
					end

					if var_61_2.prefab_name ~= "" and arg_58_1.actors_[var_61_2.prefab_name] ~= nil then
						local var_61_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_2.prefab_name].transform, "story_v_side_old_928011", "928011014", "story_v_side_old_928011.awb")

						arg_58_1:RecordAudio("928011014", var_61_7)
						arg_58_1:RecordAudio("928011014", var_61_7)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011014", "story_v_side_old_928011.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011014", "story_v_side_old_928011.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_8 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_8 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_0) / var_61_8

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_8 and arg_58_1.time_ < var_61_0 + var_61_8 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play928011015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 928011015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play928011016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["1085ui_story"]) and arg_62_1.var_.characterEffect1085ui_story == nil then
				arg_62_1.var_.characterEffect1085ui_story = arg_62_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["1085ui_story"]) then
				if arg_62_1.var_.characterEffect1085ui_story and not isNil(arg_62_1.actors_["1085ui_story"]) then
					arg_62_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_0)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["1085ui_story"]) and arg_62_1.var_.characterEffect1085ui_story then
				arg_62_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_65_1 = 0
			local var_65_2 = 0.85

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_3 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(928011015).content)

				arg_62_1.text_.text = var_65_3

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 34 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_3) / 34)

				if (34 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_3) / 34)) > 0 and var_65_2 < var_65_5 then
					arg_62_1.talkMaxDuration = var_65_5

					if var_65_5 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + var_65_1
					end
				end

				arg_62_1.text_.text = var_65_3
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_6 = math.max(var_65_2, arg_62_1.talkMaxDuration)

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_6 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_1) / var_65_6

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_1 + var_65_6 and arg_62_1.time_ < var_65_1 + var_65_6 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play928011016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 928011016
		arg_66_1.duration_ = 7.2

		local var_66_0 = {
			zh = 6.833,
			ja = 7.2
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play928011017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["1085ui_story"]) and arg_66_1.var_.characterEffect1085ui_story == nil then
				arg_66_1.var_.characterEffect1085ui_story = arg_66_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["1085ui_story"]) then
				if arg_66_1.var_.characterEffect1085ui_story and not isNil(arg_66_1.actors_["1085ui_story"]) then
					arg_66_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["1085ui_story"]) and arg_66_1.var_.characterEffect1085ui_story then
				arg_66_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_69_2 = 0
			local var_69_3 = 0.625

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_2 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_4 = arg_66_1:GetWordFromCfg(928011016)
				local var_69_5 = arg_66_1:FormatText(var_69_4.content)

				arg_66_1.text_.text = var_69_5

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_7 = 25 <= 0 and var_69_3 or var_69_3 * (utf8.len(var_69_5) / 25)

				if (25 <= 0 and var_69_3 or var_69_3 * (utf8.len(var_69_5) / 25)) > 0 and var_69_3 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_2 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_2
					end
				end

				arg_66_1.text_.text = var_69_5
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011016", "story_v_side_old_928011.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011016", "story_v_side_old_928011.awb") / 1000

					if var_69_8 + var_69_2 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_2
					end

					if var_69_4.prefab_name ~= "" and arg_66_1.actors_[var_69_4.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_4.prefab_name].transform, "story_v_side_old_928011", "928011016", "story_v_side_old_928011.awb")

						arg_66_1:RecordAudio("928011016", var_69_9)
						arg_66_1:RecordAudio("928011016", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011016", "story_v_side_old_928011.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011016", "story_v_side_old_928011.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_10 = math.max(var_69_3, arg_66_1.talkMaxDuration)

			if var_69_2 <= arg_66_1.time_ and arg_66_1.time_ < var_69_2 + var_69_10 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_2) / var_69_10

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_2 + var_69_10 and arg_66_1.time_ < var_69_2 + var_69_10 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play928011017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 928011017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play928011018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1085ui_story"]) and arg_70_1.var_.characterEffect1085ui_story == nil then
				arg_70_1.var_.characterEffect1085ui_story = arg_70_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1085ui_story"]) then
				if arg_70_1.var_.characterEffect1085ui_story and not isNil(arg_70_1.actors_["1085ui_story"]) then
					arg_70_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_0)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1085ui_story"]) and arg_70_1.var_.characterEffect1085ui_story then
				arg_70_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_73_1 = 0
			local var_73_2 = 0.5

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_3 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(928011017).content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 20 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 20)

				if (20 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 20)) > 0 and var_73_2 < var_73_5 then
					arg_70_1.talkMaxDuration = var_73_5

					if var_73_5 + var_73_1 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + var_73_1
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_6 = math.max(var_73_2, arg_70_1.talkMaxDuration)

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_6 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_1) / var_73_6

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_1 + var_73_6 and arg_70_1.time_ < var_73_1 + var_73_6 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play928011018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 928011018
		arg_74_1.duration_ = 2

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play928011019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["1085ui_story"]) and arg_74_1.var_.characterEffect1085ui_story == nil then
				arg_74_1.var_.characterEffect1085ui_story = arg_74_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["1085ui_story"]) then
				if arg_74_1.var_.characterEffect1085ui_story and not isNil(arg_74_1.actors_["1085ui_story"]) then
					arg_74_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["1085ui_story"]) and arg_74_1.var_.characterEffect1085ui_story then
				arg_74_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_77_2 = 0
			local var_77_3 = 0.075

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_2 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_4 = arg_74_1:GetWordFromCfg(928011018)
				local var_77_5 = arg_74_1:FormatText(var_77_4.content)

				arg_74_1.text_.text = var_77_5

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_7 = 3 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_5) / 3)

				if (3 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_5) / 3)) > 0 and var_77_3 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_2
					end
				end

				arg_74_1.text_.text = var_77_5
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011018", "story_v_side_old_928011.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011018", "story_v_side_old_928011.awb") / 1000

					if var_77_8 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_2
					end

					if var_77_4.prefab_name ~= "" and arg_74_1.actors_[var_77_4.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_4.prefab_name].transform, "story_v_side_old_928011", "928011018", "story_v_side_old_928011.awb")

						arg_74_1:RecordAudio("928011018", var_77_9)
						arg_74_1:RecordAudio("928011018", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011018", "story_v_side_old_928011.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011018", "story_v_side_old_928011.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_3, arg_74_1.talkMaxDuration)

			if var_77_2 <= arg_74_1.time_ and arg_74_1.time_ < var_77_2 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_2) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_2 + var_77_10 and arg_74_1.time_ < var_77_2 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play928011019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 928011019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play928011020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos1085ui_story = arg_78_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_81_0 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 then
				arg_78_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_78_1.time_ - 0) / var_81_0)
				arg_78_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_78_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["1085ui_story"].transform.position).z)
				arg_78_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_78_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_78_1.actors_["1085ui_story"].transform.localEulerAngles = arg_78_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 then
				arg_78_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_78_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_78_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["1085ui_story"].transform.position).z)
				arg_78_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_78_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_78_1.actors_["1085ui_story"].transform.localEulerAngles = arg_78_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_81_1 = arg_78_1.actors_["1085ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_1) and arg_78_1.var_.characterEffect1085ui_story == nil then
				arg_78_1.var_.characterEffect1085ui_story = var_81_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_2 and not isNil(var_81_1) then
				if arg_78_1.var_.characterEffect1085ui_story and not isNil(var_81_1) then
					arg_78_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_2)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_2 and arg_78_1.time_ < 0 + var_81_2 + arg_81_0 and not isNil(var_81_1) and arg_78_1.var_.characterEffect1085ui_story then
				arg_78_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_81_3 = 0
			local var_81_4 = 0.875

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_3 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_5 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(928011019).content)

				arg_78_1.text_.text = var_81_5

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_7 = 35 <= 0 and var_81_4 or var_81_4 * (utf8.len(var_81_5) / 35)

				if (35 <= 0 and var_81_4 or var_81_4 * (utf8.len(var_81_5) / 35)) > 0 and var_81_4 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_3 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_3
					end
				end

				arg_78_1.text_.text = var_81_5
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_8 = math.max(var_81_4, arg_78_1.talkMaxDuration)

			if var_81_3 <= arg_78_1.time_ and arg_78_1.time_ < var_81_3 + var_81_8 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_3) / var_81_8

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_3 + var_81_8 and arg_78_1.time_ < var_81_3 + var_81_8 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play928011020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 928011020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play928011021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.4

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_1 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(928011020).content)

				arg_82_1.text_.text = var_85_1

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_3 = 16 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 16)

				if (16 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 16)) > 0 and var_85_0 < var_85_3 then
					arg_82_1.talkMaxDuration = var_85_3

					if var_85_3 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_3 + 0
					end
				end

				arg_82_1.text_.text = var_85_1
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_4 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_4

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play928011021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 928011021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play928011022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.65

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_1 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(928011021).content)

				arg_86_1.text_.text = var_89_1

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_3 = 26 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_1) / 26)

				if (26 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_1) / 26)) > 0 and var_89_0 < var_89_3 then
					arg_86_1.talkMaxDuration = var_89_3

					if var_89_3 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_3 + 0
					end
				end

				arg_86_1.text_.text = var_89_1
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_4 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_4

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play928011022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 928011022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play928011023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.65

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_1 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(928011022).content)

				arg_90_1.text_.text = var_93_1

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_3 = 26 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_1) / 26)

				if (26 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_1) / 26)) > 0 and var_93_0 < var_93_3 then
					arg_90_1.talkMaxDuration = var_93_3

					if var_93_3 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_3 + 0
					end
				end

				arg_90_1.text_.text = var_93_1
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_4 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_4

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play928011023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 928011023
		arg_94_1.duration_ = 8.3

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play928011024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if arg_94_1.bgs_.ST2201 == nil then
				local var_97_0 = Object.Instantiate(arg_94_1.paintGo_)

				var_97_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2201")
				var_97_0.name = "ST2201"
				var_97_0.transform.parent = arg_94_1.stage_.transform
				var_97_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_94_1.bgs_.ST2201 = var_97_0
			end

			if 1.7 < arg_94_1.time_ and arg_94_1.time_ <= 1.7 + arg_97_0 then
				local var_97_1 = arg_94_1.bgs_.ST2201

				arg_94_1.bgs_.ST2201.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_97_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_97_2 = var_97_1:GetComponent("SpriteRenderer")

				if var_97_2 and var_97_2.sprite then
					local var_97_3 = 2 * (var_97_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_97_1.transform.localScale = Vector3.New(var_97_3 / var_97_2.sprite.bounds.size.y < var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x and var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x or var_97_3 / var_97_2.sprite.bounds.size.y, var_97_3 / var_97_2.sprite.bounds.size.y < var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x and var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x or var_97_3 / var_97_2.sprite.bounds.size.y, 0)
				end

				for iter_97_0, iter_97_1 in pairs(arg_94_1.bgs_) do
					if iter_97_0 ~= "ST2201" then
						iter_97_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_97_4 = 0

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1.allBtn_.enabled = false
			end

			if arg_94_1.time_ >= var_97_4 + 0.3 and arg_94_1.time_ < var_97_4 + 0.3 + arg_97_0 then
				arg_94_1.allBtn_.enabled = true
			end

			local var_97_5 = 0

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 then
				arg_94_1.mask_.enabled = true
				arg_94_1.mask_.raycastTarget = true

				arg_94_1:SetGaussion(false)
			end

			local var_97_6 = 1.7

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_6 then
				local var_97_7 = Color.New(0, 0, 0)

				var_97_7.a = Mathf.Lerp(0, 1, (arg_94_1.time_ - var_97_5) / var_97_6)
				arg_94_1.mask_.color = var_97_7
			end

			if arg_94_1.time_ >= var_97_5 + var_97_6 and arg_94_1.time_ < var_97_5 + var_97_6 + arg_97_0 then
				local var_97_8 = Color.New(0, 0, 0)

				var_97_8.a = 1
				arg_94_1.mask_.color = var_97_8
			end

			local var_97_9 = 1.7

			if 1.7 < arg_94_1.time_ and arg_94_1.time_ <= var_97_9 + arg_97_0 then
				arg_94_1.mask_.enabled = true
				arg_94_1.mask_.raycastTarget = true

				arg_94_1:SetGaussion(false)
			end

			local var_97_10 = 2

			if var_97_9 <= arg_94_1.time_ and arg_94_1.time_ < var_97_9 + var_97_10 then
				local var_97_11 = Color.New(0, 0, 0)

				var_97_11.a = Mathf.Lerp(1, 0, (arg_94_1.time_ - var_97_9) / var_97_10)
				arg_94_1.mask_.color = var_97_11
			end

			if arg_94_1.time_ >= var_97_9 + var_97_10 and arg_94_1.time_ < var_97_9 + var_97_10 + arg_97_0 then
				local var_97_12 = Color.New(0, 0, 0)

				arg_94_1.mask_.enabled = false
				var_97_12.a = 0
				arg_94_1.mask_.color = var_97_12
			end

			if 0.133333333333333 < arg_94_1.time_ and arg_94_1.time_ <= 0.133333333333333 + arg_97_0 then
				arg_94_1:AudioAction("stop", "effect", "se_story_side_1061", "se_story_side_1061_amb_train", "")
			end

			if 0.133333333333333 < arg_94_1.time_ and arg_94_1.time_ <= 0.133333333333333 + arg_97_0 then
				arg_94_1:AudioAction("stop", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if 1.3 < arg_94_1.time_ and arg_94_1.time_ <= 1.3 + arg_97_0 then
				arg_94_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 0.133333333333333 < arg_94_1.time_ and arg_94_1.time_ <= 0.133333333333333 + arg_97_0 then
				arg_94_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_97_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_94_1.bgmTxt_.text ~= var_97_18 and arg_94_1.bgmTxt_.text ~= "" then
						if arg_94_1.bgmTxt2_.text ~= "" then
							arg_94_1.bgmTxt_.text = arg_94_1.bgmTxt2_.text
						end

						arg_94_1.bgmTxt2_.text = var_97_18

						arg_94_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_94_1.bgmTxt_.text = var_97_18
						arg_94_1.bgmTxt2_.text = var_97_18
					end

					if arg_94_1.bgmTimer then
						arg_94_1.bgmTimer:Stop()

						arg_94_1.bgmTimer = nil
					end

					if arg_94_1.settingData.show_music_name == 1 then
						arg_94_1.musicController:SetSelectedState("show")
						arg_94_1.musicAnimator_:Play("open", 0, 0)

						if arg_94_1.settingData.music_time ~= 0 then
							arg_94_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_94_1.settingData.music_time), function()
								if arg_94_1 == nil or isNil(arg_94_1.bgmTxt_) then
									return
								end

								arg_94_1.musicController:SetSelectedState("hide")
								arg_94_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_94_1.frameCnt_ <= 1 then
				arg_94_1.dialog_:SetActive(false)
			end

			local var_97_19 = 3.3
			local var_97_20 = 1.125

			if 3.3 < arg_94_1.time_ and arg_94_1.time_ <= var_97_19 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0

				arg_94_1.dialog_:SetActive(true)

				arg_94_1.dialogCg_.alpha = 0

				local var_97_21 = LeanTween.value(arg_94_1.dialog_, 0, 1, 0.3)

				var_97_21:setOnUpdate(LuaHelper.FloatAction(function(arg_99_0)
					arg_94_1.dialogCg_.alpha = arg_99_0
				end))
				var_97_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_94_1.dialog_)
					var_97_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_94_1.duration_ = arg_94_1.duration_ + 0.3

				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_22 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(928011023).content)

				arg_94_1.text_.text = var_97_22

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_24 = 45 <= 0 and var_97_20 or var_97_20 * (utf8.len(var_97_22) / 45)

				if (45 <= 0 and var_97_20 or var_97_20 * (utf8.len(var_97_22) / 45)) > 0 and var_97_20 < var_97_24 then
					arg_94_1.talkMaxDuration = var_97_24
					var_97_19 = var_97_19 + 0.3

					if var_97_24 + var_97_19 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_24 + var_97_19
					end
				end

				arg_94_1.text_.text = var_97_22
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_25 = var_97_19 + 0.3
			local var_97_26 = math.max(var_97_20, arg_94_1.talkMaxDuration)

			if var_97_19 + 0.3 <= arg_94_1.time_ and arg_94_1.time_ < var_97_25 + var_97_26 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_25) / var_97_26

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_25 + var_97_26 and arg_94_1.time_ < var_97_25 + var_97_26 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play928011024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 928011024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play928011025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0.433333333333333 < arg_101_1.time_ and arg_101_1.time_ <= 0.433333333333333 + arg_104_0 then
				arg_101_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_keyboard", "")
			end

			local var_104_1 = 0
			local var_104_2 = 1.125

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(928011024).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 45 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 45)

				if (45 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 45)) > 0 and var_104_2 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_6 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_6 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_6

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_6 and arg_101_1.time_ < var_104_1 + var_104_6 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play928011025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 928011025
		arg_105_1.duration_ = 6.07

		local var_105_0 = {
			zh = 6.066,
			ja = 6.033
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play928011026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if arg_105_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_108_0 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_105_1.stage_.transform)

				var_108_0.name = "1066ui_story"
				var_108_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_["1066ui_story"] = var_108_0

				local var_108_1 = var_108_0:GetComponentInChildren(typeof(CharacterEffect))

				var_108_1.enabled = true

				local var_108_2 = GameObjectTools.GetOrAddComponent(var_108_0, typeof(DynamicBoneHelper))

				if var_108_2 then
					var_108_2:EnableDynamicBone(false)
				end

				arg_105_1:ShowWeapon(var_108_1.transform, false)

				arg_105_1.var_["1066ui_story" .. "Animator"] = var_108_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_105_1.var_["1066ui_story" .. "Animator"].applyRootMotion = true
				arg_105_1.var_["1066ui_story" .. "LipSync"] = var_108_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_108_3 = arg_105_1.actors_["1066ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1066ui_story = var_108_3.localPosition
			end

			local var_108_4 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				var_108_3.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_105_1.time_ - 0) / var_108_4)
				var_108_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_3.position).x, (manager.ui.mainCamera.transform.position - var_108_3.position).y, (manager.ui.mainCamera.transform.position - var_108_3.position).z)
				var_108_3.localEulerAngles.z = 0
				var_108_3.localEulerAngles.x = 0
				var_108_3.localEulerAngles = var_108_3.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				var_108_3.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				var_108_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_3.position).x, (manager.ui.mainCamera.transform.position - var_108_3.position).y, (manager.ui.mainCamera.transform.position - var_108_3.position).z)
				var_108_3.localEulerAngles.z = 0
				var_108_3.localEulerAngles.x = 0
				var_108_3.localEulerAngles = var_108_3.localEulerAngles
			end

			local var_108_5 = arg_105_1.actors_["1066ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.characterEffect1066ui_story == nil then
				arg_105_1.var_.characterEffect1066ui_story = var_108_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_6 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_6 and not isNil(var_108_5) then
				if arg_105_1.var_.characterEffect1066ui_story and not isNil(var_108_5) then
					arg_105_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_6 and arg_105_1.time_ < 0 + var_108_6 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.characterEffect1066ui_story then
				arg_105_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_108_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_105_1.bgmTxt_.text ~= var_108_10 and arg_105_1.bgmTxt_.text ~= "" then
						if arg_105_1.bgmTxt2_.text ~= "" then
							arg_105_1.bgmTxt_.text = arg_105_1.bgmTxt2_.text
						end

						arg_105_1.bgmTxt2_.text = var_108_10

						arg_105_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_105_1.bgmTxt_.text = var_108_10
						arg_105_1.bgmTxt2_.text = var_108_10
					end

					if arg_105_1.bgmTimer then
						arg_105_1.bgmTimer:Stop()

						arg_105_1.bgmTimer = nil
					end

					if arg_105_1.settingData.show_music_name == 1 then
						arg_105_1.musicController:SetSelectedState("show")
						arg_105_1.musicAnimator_:Play("open", 0, 0)

						if arg_105_1.settingData.music_time ~= 0 then
							arg_105_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_105_1.settingData.music_time), function()
								if arg_105_1 == nil or isNil(arg_105_1.bgmTxt_) then
									return
								end

								arg_105_1.musicController:SetSelectedState("hide")
								arg_105_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_105_1.time_ and arg_105_1.time_ <= 0.3 + arg_108_0 then
				arg_105_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_108_13 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if "" ~= "" then
					if arg_105_1.bgmTxt_.text ~= var_108_13 and arg_105_1.bgmTxt_.text ~= "" then
						if arg_105_1.bgmTxt2_.text ~= "" then
							arg_105_1.bgmTxt_.text = arg_105_1.bgmTxt2_.text
						end

						arg_105_1.bgmTxt2_.text = var_108_13

						arg_105_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_105_1.bgmTxt_.text = var_108_13
						arg_105_1.bgmTxt2_.text = var_108_13
					end

					if arg_105_1.bgmTimer then
						arg_105_1.bgmTimer:Stop()

						arg_105_1.bgmTimer = nil
					end

					if arg_105_1.settingData.show_music_name == 1 then
						arg_105_1.musicController:SetSelectedState("show")
						arg_105_1.musicAnimator_:Play("open", 0, 0)

						if arg_105_1.settingData.music_time ~= 0 then
							arg_105_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_105_1.settingData.music_time), function()
								if arg_105_1 == nil or isNil(arg_105_1.bgmTxt_) then
									return
								end

								arg_105_1.musicController:SetSelectedState("hide")
								arg_105_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_108_14 = 0
			local var_108_15 = 0.575

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_14 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_16 = arg_105_1:GetWordFromCfg(928011025)
				local var_108_17 = arg_105_1:FormatText(var_108_16.content)

				arg_105_1.text_.text = var_108_17

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_19 = 23 <= 0 and var_108_15 or var_108_15 * (utf8.len(var_108_17) / 23)

				if (23 <= 0 and var_108_15 or var_108_15 * (utf8.len(var_108_17) / 23)) > 0 and var_108_15 < var_108_19 then
					arg_105_1.talkMaxDuration = var_108_19

					if var_108_19 + var_108_14 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_19 + var_108_14
					end
				end

				arg_105_1.text_.text = var_108_17
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011025", "story_v_side_old_928011.awb") ~= 0 then
					local var_108_20 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011025", "story_v_side_old_928011.awb") / 1000

					if var_108_20 + var_108_14 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_20 + var_108_14
					end

					if var_108_16.prefab_name ~= "" and arg_105_1.actors_[var_108_16.prefab_name] ~= nil then
						local var_108_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_16.prefab_name].transform, "story_v_side_old_928011", "928011025", "story_v_side_old_928011.awb")

						arg_105_1:RecordAudio("928011025", var_108_21)
						arg_105_1:RecordAudio("928011025", var_108_21)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011025", "story_v_side_old_928011.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011025", "story_v_side_old_928011.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_22 = math.max(var_108_15, arg_105_1.talkMaxDuration)

			if var_108_14 <= arg_105_1.time_ and arg_105_1.time_ < var_108_14 + var_108_22 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_14) / var_108_22

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_14 + var_108_22 and arg_105_1.time_ < var_108_14 + var_108_22 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play928011026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 928011026
		arg_111_1.duration_ = 12.7

		local var_111_0 = {
			zh = 8.9,
			ja = 12.7
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play928011027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if arg_111_1.actors_["1033ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1033ui_story"))) then
				local var_114_0 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_111_1.stage_.transform)

				var_114_0.name = "1033ui_story"
				var_114_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.actors_["1033ui_story"] = var_114_0

				local var_114_1 = var_114_0:GetComponentInChildren(typeof(CharacterEffect))

				var_114_1.enabled = true

				local var_114_2 = GameObjectTools.GetOrAddComponent(var_114_0, typeof(DynamicBoneHelper))

				if var_114_2 then
					var_114_2:EnableDynamicBone(false)
				end

				arg_111_1:ShowWeapon(var_114_1.transform, false)

				arg_111_1.var_["1033ui_story" .. "Animator"] = var_114_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_111_1.var_["1033ui_story" .. "Animator"].applyRootMotion = true
				arg_111_1.var_["1033ui_story" .. "LipSync"] = var_114_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_114_3 = arg_111_1.actors_["1033ui_story"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1033ui_story = var_114_3.localPosition
			end

			local var_114_4 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				var_114_3.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_111_1.time_ - 0) / var_114_4)
				var_114_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_3.position).x, (manager.ui.mainCamera.transform.position - var_114_3.position).y, (manager.ui.mainCamera.transform.position - var_114_3.position).z)
				var_114_3.localEulerAngles.z = 0
				var_114_3.localEulerAngles.x = 0
				var_114_3.localEulerAngles = var_114_3.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				var_114_3.localPosition = Vector3.New(0.7, -1.01, -6.13)
				var_114_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_3.position).x, (manager.ui.mainCamera.transform.position - var_114_3.position).y, (manager.ui.mainCamera.transform.position - var_114_3.position).z)
				var_114_3.localEulerAngles.z = 0
				var_114_3.localEulerAngles.x = 0
				var_114_3.localEulerAngles = var_114_3.localEulerAngles
			end

			local var_114_5 = arg_111_1.actors_["1033ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.characterEffect1033ui_story == nil then
				arg_111_1.var_.characterEffect1033ui_story = var_114_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_6 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_6 and not isNil(var_114_5) then
				if arg_111_1.var_.characterEffect1033ui_story and not isNil(var_114_5) then
					arg_111_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_6 and arg_111_1.time_ < 0 + var_114_6 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.characterEffect1033ui_story then
				arg_111_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_114_8 = arg_111_1.actors_["1066ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_8) and arg_111_1.var_.characterEffect1066ui_story == nil then
				arg_111_1.var_.characterEffect1066ui_story = var_114_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_9 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_9 and not isNil(var_114_8) then
				if arg_111_1.var_.characterEffect1066ui_story and not isNil(var_114_8) then
					arg_111_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_9)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_9 and arg_111_1.time_ < 0 + var_114_9 + arg_114_0 and not isNil(var_114_8) and arg_111_1.var_.characterEffect1066ui_story then
				arg_111_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_114_10 = 0
			local var_114_11 = 1.025

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_12 = arg_111_1:GetWordFromCfg(928011026)
				local var_114_13 = arg_111_1:FormatText(var_114_12.content)

				arg_111_1.text_.text = var_114_13

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_15 = 41 <= 0 and var_114_11 or var_114_11 * (utf8.len(var_114_13) / 41)

				if (41 <= 0 and var_114_11 or var_114_11 * (utf8.len(var_114_13) / 41)) > 0 and var_114_11 < var_114_15 then
					arg_111_1.talkMaxDuration = var_114_15

					if var_114_15 + var_114_10 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_15 + var_114_10
					end
				end

				arg_111_1.text_.text = var_114_13
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011026", "story_v_side_old_928011.awb") ~= 0 then
					local var_114_16 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011026", "story_v_side_old_928011.awb") / 1000

					if var_114_16 + var_114_10 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_16 + var_114_10
					end

					if var_114_12.prefab_name ~= "" and arg_111_1.actors_[var_114_12.prefab_name] ~= nil then
						local var_114_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_12.prefab_name].transform, "story_v_side_old_928011", "928011026", "story_v_side_old_928011.awb")

						arg_111_1:RecordAudio("928011026", var_114_17)
						arg_111_1:RecordAudio("928011026", var_114_17)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011026", "story_v_side_old_928011.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011026", "story_v_side_old_928011.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_18 = math.max(var_114_11, arg_111_1.talkMaxDuration)

			if var_114_10 <= arg_111_1.time_ and arg_111_1.time_ < var_114_10 + var_114_18 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_10) / var_114_18

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_10 + var_114_18 and arg_111_1.time_ < var_114_10 + var_114_18 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play928011027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 928011027
		arg_115_1.duration_ = 5.7

		local var_115_0 = {
			zh = 5.7,
			ja = 5.366
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play928011028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["1066ui_story"]) and arg_115_1.var_.characterEffect1066ui_story == nil then
				arg_115_1.var_.characterEffect1066ui_story = arg_115_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["1066ui_story"]) then
				if arg_115_1.var_.characterEffect1066ui_story and not isNil(arg_115_1.actors_["1066ui_story"]) then
					arg_115_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["1066ui_story"]) and arg_115_1.var_.characterEffect1066ui_story then
				arg_115_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_118_2 = arg_115_1.actors_["1033ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.characterEffect1033ui_story == nil then
				arg_115_1.var_.characterEffect1033ui_story = var_118_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_3 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_3 and not isNil(var_118_2) then
				if arg_115_1.var_.characterEffect1033ui_story and not isNil(var_118_2) then
					arg_115_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_3)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_3 and arg_115_1.time_ < 0 + var_118_3 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.characterEffect1033ui_story then
				arg_115_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_2")
			end

			local var_118_4 = 0
			local var_118_5 = 0.6

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_6 = arg_115_1:GetWordFromCfg(928011027)
				local var_118_7 = arg_115_1:FormatText(var_118_6.content)

				arg_115_1.text_.text = var_118_7

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_9 = 24 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 24)

				if (24 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 24)) > 0 and var_118_5 < var_118_9 then
					arg_115_1.talkMaxDuration = var_118_9

					if var_118_9 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_9 + var_118_4
					end
				end

				arg_115_1.text_.text = var_118_7
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011027", "story_v_side_old_928011.awb") ~= 0 then
					local var_118_10 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011027", "story_v_side_old_928011.awb") / 1000

					if var_118_10 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_4
					end

					if var_118_6.prefab_name ~= "" and arg_115_1.actors_[var_118_6.prefab_name] ~= nil then
						local var_118_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_6.prefab_name].transform, "story_v_side_old_928011", "928011027", "story_v_side_old_928011.awb")

						arg_115_1:RecordAudio("928011027", var_118_11)
						arg_115_1:RecordAudio("928011027", var_118_11)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011027", "story_v_side_old_928011.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011027", "story_v_side_old_928011.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_12 = math.max(var_118_5, arg_115_1.talkMaxDuration)

			if var_118_4 <= arg_115_1.time_ and arg_115_1.time_ < var_118_4 + var_118_12 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_4) / var_118_12

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_4 + var_118_12 and arg_115_1.time_ < var_118_4 + var_118_12 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play928011028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 928011028
		arg_119_1.duration_ = 8.8

		local var_119_0 = {
			zh = 5.966,
			ja = 8.8
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play928011029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["1033ui_story"]) and arg_119_1.var_.characterEffect1033ui_story == nil then
				arg_119_1.var_.characterEffect1033ui_story = arg_119_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["1033ui_story"]) then
				if arg_119_1.var_.characterEffect1033ui_story and not isNil(arg_119_1.actors_["1033ui_story"]) then
					arg_119_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["1033ui_story"]) and arg_119_1.var_.characterEffect1033ui_story then
				arg_119_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_122_2 = arg_119_1.actors_["1066ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.characterEffect1066ui_story == nil then
				arg_119_1.var_.characterEffect1066ui_story = var_122_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_3 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.characterEffect1066ui_story and not isNil(var_122_2) then
					arg_119_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_3)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.characterEffect1066ui_story then
				arg_119_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_122_4 = 0
			local var_122_5 = 0.825

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_6 = arg_119_1:GetWordFromCfg(928011028)
				local var_122_7 = arg_119_1:FormatText(var_122_6.content)

				arg_119_1.text_.text = var_122_7

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_9 = 33 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 33)

				if (33 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 33)) > 0 and var_122_5 < var_122_9 then
					arg_119_1.talkMaxDuration = var_122_9

					if var_122_9 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_4
					end
				end

				arg_119_1.text_.text = var_122_7
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011028", "story_v_side_old_928011.awb") ~= 0 then
					local var_122_10 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011028", "story_v_side_old_928011.awb") / 1000

					if var_122_10 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_4
					end

					if var_122_6.prefab_name ~= "" and arg_119_1.actors_[var_122_6.prefab_name] ~= nil then
						local var_122_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_6.prefab_name].transform, "story_v_side_old_928011", "928011028", "story_v_side_old_928011.awb")

						arg_119_1:RecordAudio("928011028", var_122_11)
						arg_119_1:RecordAudio("928011028", var_122_11)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011028", "story_v_side_old_928011.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011028", "story_v_side_old_928011.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_12 = math.max(var_122_5, arg_119_1.talkMaxDuration)

			if var_122_4 <= arg_119_1.time_ and arg_119_1.time_ < var_122_4 + var_122_12 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_4) / var_122_12

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_4 + var_122_12 and arg_119_1.time_ < var_122_4 + var_122_12 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play928011029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 928011029
		arg_123_1.duration_ = 6.7

		local var_123_0 = {
			zh = 3.866,
			ja = 6.7
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play928011030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_2")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_126_0 = 0
			local var_126_1 = 0.525

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_2 = arg_123_1:GetWordFromCfg(928011029)
				local var_126_3 = arg_123_1:FormatText(var_126_2.content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 21 <= 0 and var_126_1 or var_126_1 * (utf8.len(var_126_3) / 21)

				if (21 <= 0 and var_126_1 or var_126_1 * (utf8.len(var_126_3) / 21)) > 0 and var_126_1 < var_126_5 then
					arg_123_1.talkMaxDuration = var_126_5

					if var_126_5 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011029", "story_v_side_old_928011.awb") ~= 0 then
					local var_126_6 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011029", "story_v_side_old_928011.awb") / 1000

					if var_126_6 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_0
					end

					if var_126_2.prefab_name ~= "" and arg_123_1.actors_[var_126_2.prefab_name] ~= nil then
						local var_126_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_2.prefab_name].transform, "story_v_side_old_928011", "928011029", "story_v_side_old_928011.awb")

						arg_123_1:RecordAudio("928011029", var_126_7)
						arg_123_1:RecordAudio("928011029", var_126_7)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011029", "story_v_side_old_928011.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011029", "story_v_side_old_928011.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_8 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_8 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_8

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_8 and arg_123_1.time_ < var_126_0 + var_126_8 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play928011030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 928011030
		arg_127_1.duration_ = 12.6

		local var_127_0 = {
			zh = 7.7,
			ja = 12.6
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play928011031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1066ui_story"]) and arg_127_1.var_.characterEffect1066ui_story == nil then
				arg_127_1.var_.characterEffect1066ui_story = arg_127_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1066ui_story"]) then
				if arg_127_1.var_.characterEffect1066ui_story and not isNil(arg_127_1.actors_["1066ui_story"]) then
					arg_127_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1066ui_story"]) and arg_127_1.var_.characterEffect1066ui_story then
				arg_127_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_130_2 = arg_127_1.actors_["1033ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.characterEffect1033ui_story == nil then
				arg_127_1.var_.characterEffect1033ui_story = var_130_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_3 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_3 and not isNil(var_130_2) then
				if arg_127_1.var_.characterEffect1033ui_story and not isNil(var_130_2) then
					arg_127_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_3)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_3 and arg_127_1.time_ < 0 + var_130_3 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.characterEffect1033ui_story then
				arg_127_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_130_4 = 0
			local var_130_5 = 0.8

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_6 = arg_127_1:GetWordFromCfg(928011030)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 32 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 32)

				if (32 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 32)) > 0 and var_130_5 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011030", "story_v_side_old_928011.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011030", "story_v_side_old_928011.awb") / 1000

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end

					if var_130_6.prefab_name ~= "" and arg_127_1.actors_[var_130_6.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_6.prefab_name].transform, "story_v_side_old_928011", "928011030", "story_v_side_old_928011.awb")

						arg_127_1:RecordAudio("928011030", var_130_11)
						arg_127_1:RecordAudio("928011030", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011030", "story_v_side_old_928011.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011030", "story_v_side_old_928011.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_12 = math.max(var_130_5, arg_127_1.talkMaxDuration)

			if var_130_4 <= arg_127_1.time_ and arg_127_1.time_ < var_130_4 + var_130_12 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_4) / var_130_12

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_4 + var_130_12 and arg_127_1.time_ < var_130_4 + var_130_12 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play928011031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 928011031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play928011032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1066ui_story"]) and arg_131_1.var_.characterEffect1066ui_story == nil then
				arg_131_1.var_.characterEffect1066ui_story = arg_131_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1066ui_story"]) then
				if arg_131_1.var_.characterEffect1066ui_story and not isNil(arg_131_1.actors_["1066ui_story"]) then
					arg_131_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_0)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1066ui_story"]) and arg_131_1.var_.characterEffect1066ui_story then
				arg_131_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_134_1 = 0
			local var_134_2 = 0.5

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_3 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(928011031).content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 20 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_3) / 20)

				if (20 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_3) / 20)) > 0 and var_134_2 < var_134_5 then
					arg_131_1.talkMaxDuration = var_134_5

					if var_134_5 + var_134_1 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + var_134_1
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_6 = math.max(var_134_2, arg_131_1.talkMaxDuration)

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_6 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_1) / var_134_6

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_1 + var_134_6 and arg_131_1.time_ < var_134_1 + var_134_6 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play928011032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 928011032
		arg_135_1.duration_ = 10.1

		local var_135_0 = {
			zh = 5.866,
			ja = 10.1
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play928011033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1033ui_story"]) and arg_135_1.var_.characterEffect1033ui_story == nil then
				arg_135_1.var_.characterEffect1033ui_story = arg_135_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1033ui_story"]) then
				if arg_135_1.var_.characterEffect1033ui_story and not isNil(arg_135_1.actors_["1033ui_story"]) then
					arg_135_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1033ui_story"]) and arg_135_1.var_.characterEffect1033ui_story then
				arg_135_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_138_2 = 0
			local var_138_3 = 0.65

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_4 = arg_135_1:GetWordFromCfg(928011032)
				local var_138_5 = arg_135_1:FormatText(var_138_4.content)

				arg_135_1.text_.text = var_138_5

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_7 = 26 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_5) / 26)

				if (26 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_5) / 26)) > 0 and var_138_3 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_2
					end
				end

				arg_135_1.text_.text = var_138_5
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011032", "story_v_side_old_928011.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011032", "story_v_side_old_928011.awb") / 1000

					if var_138_8 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_2
					end

					if var_138_4.prefab_name ~= "" and arg_135_1.actors_[var_138_4.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_4.prefab_name].transform, "story_v_side_old_928011", "928011032", "story_v_side_old_928011.awb")

						arg_135_1:RecordAudio("928011032", var_138_9)
						arg_135_1:RecordAudio("928011032", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011032", "story_v_side_old_928011.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011032", "story_v_side_old_928011.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_3, arg_135_1.talkMaxDuration)

			if var_138_2 <= arg_135_1.time_ and arg_135_1.time_ < var_138_2 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_2) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_2 + var_138_10 and arg_135_1.time_ < var_138_2 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play928011033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 928011033
		arg_139_1.duration_ = 8.37

		local var_139_0 = {
			zh = 6.166,
			ja = 8.366
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play928011034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1066ui_story"]) and arg_139_1.var_.characterEffect1066ui_story == nil then
				arg_139_1.var_.characterEffect1066ui_story = arg_139_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1066ui_story"]) then
				if arg_139_1.var_.characterEffect1066ui_story and not isNil(arg_139_1.actors_["1066ui_story"]) then
					arg_139_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1066ui_story"]) and arg_139_1.var_.characterEffect1066ui_story then
				arg_139_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_142_2 = arg_139_1.actors_["1033ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.characterEffect1033ui_story == nil then
				arg_139_1.var_.characterEffect1033ui_story = var_142_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_3 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_3 and not isNil(var_142_2) then
				if arg_139_1.var_.characterEffect1033ui_story and not isNil(var_142_2) then
					arg_139_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_3)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_3 and arg_139_1.time_ < 0 + var_142_3 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.characterEffect1033ui_story then
				arg_139_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action442")
			end

			local var_142_4 = 0
			local var_142_5 = 0.75

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_6 = arg_139_1:GetWordFromCfg(928011033)
				local var_142_7 = arg_139_1:FormatText(var_142_6.content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 30 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 30)

				if (30 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 30)) > 0 and var_142_5 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011033", "story_v_side_old_928011.awb") ~= 0 then
					local var_142_10 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011033", "story_v_side_old_928011.awb") / 1000

					if var_142_10 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_4
					end

					if var_142_6.prefab_name ~= "" and arg_139_1.actors_[var_142_6.prefab_name] ~= nil then
						local var_142_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_6.prefab_name].transform, "story_v_side_old_928011", "928011033", "story_v_side_old_928011.awb")

						arg_139_1:RecordAudio("928011033", var_142_11)
						arg_139_1:RecordAudio("928011033", var_142_11)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011033", "story_v_side_old_928011.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011033", "story_v_side_old_928011.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_12 = math.max(var_142_5, arg_139_1.talkMaxDuration)

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_12 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_4) / var_142_12

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_4 + var_142_12 and arg_139_1.time_ < var_142_4 + var_142_12 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play928011034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 928011034
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play928011035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1066ui_story"]) and arg_143_1.var_.characterEffect1066ui_story == nil then
				arg_143_1.var_.characterEffect1066ui_story = arg_143_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1066ui_story"]) then
				if arg_143_1.var_.characterEffect1066ui_story and not isNil(arg_143_1.actors_["1066ui_story"]) then
					arg_143_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1066ui_story"]) and arg_143_1.var_.characterEffect1066ui_story then
				arg_143_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_146_1 = 0
			local var_146_2 = 0.65

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_3 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(928011034).content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 26 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 26)

				if (26 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 26)) > 0 and var_146_2 < var_146_5 then
					arg_143_1.talkMaxDuration = var_146_5

					if var_146_5 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_6 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_6 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_6

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_6 and arg_143_1.time_ < var_146_1 + var_146_6 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play928011035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 928011035
		arg_147_1.duration_ = 8.4

		local var_147_0 = {
			zh = 8.4,
			ja = 7.266
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play928011036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1033ui_story"]) and arg_147_1.var_.characterEffect1033ui_story == nil then
				arg_147_1.var_.characterEffect1033ui_story = arg_147_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1033ui_story"]) then
				if arg_147_1.var_.characterEffect1033ui_story and not isNil(arg_147_1.actors_["1033ui_story"]) then
					arg_147_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1033ui_story"]) and arg_147_1.var_.characterEffect1033ui_story then
				arg_147_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_2")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_150_2 = 0
			local var_150_3 = 0.85

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_2 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_4 = arg_147_1:GetWordFromCfg(928011035)
				local var_150_5 = arg_147_1:FormatText(var_150_4.content)

				arg_147_1.text_.text = var_150_5

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_7 = 34 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_5) / 34)

				if (34 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_5) / 34)) > 0 and var_150_3 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_2
					end
				end

				arg_147_1.text_.text = var_150_5
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011035", "story_v_side_old_928011.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011035", "story_v_side_old_928011.awb") / 1000

					if var_150_8 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_2
					end

					if var_150_4.prefab_name ~= "" and arg_147_1.actors_[var_150_4.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_4.prefab_name].transform, "story_v_side_old_928011", "928011035", "story_v_side_old_928011.awb")

						arg_147_1:RecordAudio("928011035", var_150_9)
						arg_147_1:RecordAudio("928011035", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011035", "story_v_side_old_928011.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011035", "story_v_side_old_928011.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_3, arg_147_1.talkMaxDuration)

			if var_150_2 <= arg_147_1.time_ and arg_147_1.time_ < var_150_2 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_2) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_2 + var_150_10 and arg_147_1.time_ < var_150_2 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play928011036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 928011036
		arg_151_1.duration_ = 6.6

		local var_151_0 = {
			zh = 4.2,
			ja = 6.6
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play928011037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1066ui_story"]) and arg_151_1.var_.characterEffect1066ui_story == nil then
				arg_151_1.var_.characterEffect1066ui_story = arg_151_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1066ui_story"]) then
				if arg_151_1.var_.characterEffect1066ui_story and not isNil(arg_151_1.actors_["1066ui_story"]) then
					arg_151_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1066ui_story"]) and arg_151_1.var_.characterEffect1066ui_story then
				arg_151_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_154_2 = arg_151_1.actors_["1033ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.characterEffect1033ui_story == nil then
				arg_151_1.var_.characterEffect1033ui_story = var_154_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_3 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_3 and not isNil(var_154_2) then
				if arg_151_1.var_.characterEffect1033ui_story and not isNil(var_154_2) then
					arg_151_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_3)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_3 and arg_151_1.time_ < 0 + var_154_3 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.characterEffect1033ui_story then
				arg_151_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_2")
			end

			local var_154_4 = 0
			local var_154_5 = 0.425

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_6 = arg_151_1:GetWordFromCfg(928011036)
				local var_154_7 = arg_151_1:FormatText(var_154_6.content)

				arg_151_1.text_.text = var_154_7

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 17 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 17)

				if (17 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 17)) > 0 and var_154_5 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_7
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011036", "story_v_side_old_928011.awb") ~= 0 then
					local var_154_10 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011036", "story_v_side_old_928011.awb") / 1000

					if var_154_10 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_4
					end

					if var_154_6.prefab_name ~= "" and arg_151_1.actors_[var_154_6.prefab_name] ~= nil then
						local var_154_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_6.prefab_name].transform, "story_v_side_old_928011", "928011036", "story_v_side_old_928011.awb")

						arg_151_1:RecordAudio("928011036", var_154_11)
						arg_151_1:RecordAudio("928011036", var_154_11)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011036", "story_v_side_old_928011.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011036", "story_v_side_old_928011.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_12 = math.max(var_154_5, arg_151_1.talkMaxDuration)

			if var_154_4 <= arg_151_1.time_ and arg_151_1.time_ < var_154_4 + var_154_12 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_4) / var_154_12

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_4 + var_154_12 and arg_151_1.time_ < var_154_4 + var_154_12 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play928011037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 928011037
		arg_155_1.duration_ = 5.8

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play928011038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_9000

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1066ui_story = arg_155_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1066ui_story"].transform.position).z)
				arg_155_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1066ui_story"].transform.localEulerAngles = arg_155_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_155_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1066ui_story"].transform.position).z)
				arg_155_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1066ui_story"].transform.localEulerAngles = arg_155_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_158_1 = arg_155_1.actors_["1033ui_story"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1033ui_story = var_158_1.localPosition
			end

			local var_158_2 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 then
				var_158_1.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 0) / var_158_2)
				var_158_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_1.position).x, (manager.ui.mainCamera.transform.position - var_158_1.position).y, (manager.ui.mainCamera.transform.position - var_158_1.position).z)
				var_158_1.localEulerAngles.z = 0
				var_158_1.localEulerAngles.x = 0
				var_158_1.localEulerAngles = var_158_1.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 then
				var_158_1.localPosition = Vector3.New(0, 100, 0)
				var_158_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_1.position).x, (manager.ui.mainCamera.transform.position - var_158_1.position).y, (manager.ui.mainCamera.transform.position - var_158_1.position).z)
				var_158_1.localEulerAngles.z = 0
				var_158_1.localEulerAngles.x = 0
				var_158_1.localEulerAngles = var_158_1.localEulerAngles
			end

			local var_158_3 = arg_155_1.actors_["1066ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_3) and arg_155_1.var_.characterEffect1066ui_story == nil then
				arg_155_1.var_.characterEffect1066ui_story = var_158_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_4 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 and not isNil(var_158_3) then
				if arg_155_1.var_.characterEffect1066ui_story and not isNil(var_158_3) then
					arg_155_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_4)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 and not isNil(var_158_3) and arg_155_1.var_.characterEffect1066ui_story then
				arg_155_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				local var_158_5 = arg_155_1.var_.effect3e42

				if not arg_155_1.var_.effect3e42 then
					var_158_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_158_5.name = "3e42"
					arg_155_1.var_.effect3e42 = var_158_5
				else
					var_158_5.transform:SetParent(var_158_9000)
				end

				var_158_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_158_5.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_158_7 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_158_0, iter_158_1 in ipairs((var_158_5.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_158_1.transform.localScale = Vector3.New(iter_158_1.transform.localScale.x / var_158_7 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_158_1.transform.localScale.y / var_158_7, iter_158_1.transform.localScale.z)
				end
			end

			local var_158_9 = 0

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_9 + arg_158_0 then
				arg_155_1.allBtn_.enabled = false
			end

			if arg_155_1.time_ >= var_158_9 + 0.8 and arg_155_1.time_ < var_158_9 + 0.8 + arg_158_0 then
				arg_155_1.allBtn_.enabled = true
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:AudioAction("play", "effect", "se_story_140", "se_story_140_data03", "")
			end

			if arg_155_1.frameCnt_ <= 1 then
				arg_155_1.dialog_:SetActive(false)
			end

			local var_158_11 = 0.8
			local var_158_12 = 1.075

			if 0.8 < arg_155_1.time_ and arg_155_1.time_ <= var_158_11 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				arg_155_1.dialog_:SetActive(true)

				arg_155_1.dialogCg_.alpha = 0

				local var_158_13 = LeanTween.value(arg_155_1.dialog_, 0, 1, 0.3)

				var_158_13:setOnUpdate(LuaHelper.FloatAction(function(arg_159_0)
					arg_155_1.dialogCg_.alpha = arg_159_0
				end))
				var_158_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_155_1.dialog_)
					var_158_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_155_1.duration_ = arg_155_1.duration_ + 0.3

				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_14 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(928011037).content)

				arg_155_1.text_.text = var_158_14

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_16 = 43 <= 0 and var_158_12 or var_158_12 * (utf8.len(var_158_14) / 43)

				if (43 <= 0 and var_158_12 or var_158_12 * (utf8.len(var_158_14) / 43)) > 0 and var_158_12 < var_158_16 then
					arg_155_1.talkMaxDuration = var_158_16
					var_158_11 = var_158_11 + 0.3

					if var_158_16 + var_158_11 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_16 + var_158_11
					end
				end

				arg_155_1.text_.text = var_158_14
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_17 = var_158_11 + 0.3
			local var_158_18 = math.max(var_158_12, arg_155_1.talkMaxDuration)

			if var_158_11 + 0.3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_17 + var_158_18 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_17) / var_158_18

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_17 + var_158_18 and arg_155_1.time_ < var_158_17 + var_158_18 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play928011038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 928011038
		arg_161_1.duration_ = 9.33

		local var_161_0 = {
			zh = 5.233,
			ja = 9.333
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play928011039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1033ui_story = arg_161_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1033ui_story"].transform.position).z)
				arg_161_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1033ui_story"].transform.localEulerAngles = arg_161_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_161_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1033ui_story"].transform.position).z)
				arg_161_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1033ui_story"].transform.localEulerAngles = arg_161_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1033ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1033ui_story == nil then
				arg_161_1.var_.characterEffect1033ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1033ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1033ui_story then
				arg_161_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_164_4 = 0
			local var_164_5 = 0.725

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_6 = arg_161_1:GetWordFromCfg(928011038)
				local var_164_7 = arg_161_1:FormatText(var_164_6.content)

				arg_161_1.text_.text = var_164_7

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 29 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 29)

				if (29 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 29)) > 0 and var_164_5 < var_164_9 then
					arg_161_1.talkMaxDuration = var_164_9

					if var_164_9 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_7
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011038", "story_v_side_old_928011.awb") ~= 0 then
					local var_164_10 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011038", "story_v_side_old_928011.awb") / 1000

					if var_164_10 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_4
					end

					if var_164_6.prefab_name ~= "" and arg_161_1.actors_[var_164_6.prefab_name] ~= nil then
						local var_164_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_6.prefab_name].transform, "story_v_side_old_928011", "928011038", "story_v_side_old_928011.awb")

						arg_161_1:RecordAudio("928011038", var_164_11)
						arg_161_1:RecordAudio("928011038", var_164_11)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011038", "story_v_side_old_928011.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011038", "story_v_side_old_928011.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_12 = math.max(var_164_5, arg_161_1.talkMaxDuration)

			if var_164_4 <= arg_161_1.time_ and arg_161_1.time_ < var_164_4 + var_164_12 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_4) / var_164_12

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_4 + var_164_12 and arg_161_1.time_ < var_164_4 + var_164_12 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play928011039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 928011039
		arg_165_1.duration_ = 8.33

		local var_165_0 = {
			zh = 5.133,
			ja = 8.333
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play928011040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1066ui_story = arg_165_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1066ui_story"].transform.position).z)
				arg_165_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1066ui_story"].transform.localEulerAngles = arg_165_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_165_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1066ui_story"].transform.position).z)
				arg_165_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1066ui_story"].transform.localEulerAngles = arg_165_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1033ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1033ui_story = var_168_1.localPosition
			end

			local var_168_2 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 then
				var_168_1.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_2)
				var_168_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_1.position).x, (manager.ui.mainCamera.transform.position - var_168_1.position).y, (manager.ui.mainCamera.transform.position - var_168_1.position).z)
				var_168_1.localEulerAngles.z = 0
				var_168_1.localEulerAngles.x = 0
				var_168_1.localEulerAngles = var_168_1.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 then
				var_168_1.localPosition = Vector3.New(0, 100, 0)
				var_168_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_1.position).x, (manager.ui.mainCamera.transform.position - var_168_1.position).y, (manager.ui.mainCamera.transform.position - var_168_1.position).z)
				var_168_1.localEulerAngles.z = 0
				var_168_1.localEulerAngles.x = 0
				var_168_1.localEulerAngles = var_168_1.localEulerAngles
			end

			local var_168_3 = arg_165_1.actors_["1066ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_3) and arg_165_1.var_.characterEffect1066ui_story == nil then
				arg_165_1.var_.characterEffect1066ui_story = var_168_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_4 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 and not isNil(var_168_3) then
				if arg_165_1.var_.characterEffect1066ui_story and not isNil(var_168_3) then
					arg_165_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 and not isNil(var_168_3) and arg_165_1.var_.characterEffect1066ui_story then
				arg_165_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_168_6 = arg_165_1.actors_["1033ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_6) and arg_165_1.var_.characterEffect1033ui_story == nil then
				arg_165_1.var_.characterEffect1033ui_story = var_168_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_7 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 and not isNil(var_168_6) then
				if arg_165_1.var_.characterEffect1033ui_story and not isNil(var_168_6) then
					arg_165_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_7)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 and not isNil(var_168_6) and arg_165_1.var_.characterEffect1033ui_story then
				arg_165_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_168_8 = 0
			local var_168_9 = 0.525

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_10 = arg_165_1:GetWordFromCfg(928011039)
				local var_168_11 = arg_165_1:FormatText(var_168_10.content)

				arg_165_1.text_.text = var_168_11

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_13 = 21 <= 0 and var_168_9 or var_168_9 * (utf8.len(var_168_11) / 21)

				if (21 <= 0 and var_168_9 or var_168_9 * (utf8.len(var_168_11) / 21)) > 0 and var_168_9 < var_168_13 then
					arg_165_1.talkMaxDuration = var_168_13

					if var_168_13 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_13 + var_168_8
					end
				end

				arg_165_1.text_.text = var_168_11
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011039", "story_v_side_old_928011.awb") ~= 0 then
					local var_168_14 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011039", "story_v_side_old_928011.awb") / 1000

					if var_168_14 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_14 + var_168_8
					end

					if var_168_10.prefab_name ~= "" and arg_165_1.actors_[var_168_10.prefab_name] ~= nil then
						local var_168_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_10.prefab_name].transform, "story_v_side_old_928011", "928011039", "story_v_side_old_928011.awb")

						arg_165_1:RecordAudio("928011039", var_168_15)
						arg_165_1:RecordAudio("928011039", var_168_15)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011039", "story_v_side_old_928011.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011039", "story_v_side_old_928011.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_16 = math.max(var_168_9, arg_165_1.talkMaxDuration)

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_16 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_8) / var_168_16

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_8 + var_168_16 and arg_165_1.time_ < var_168_8 + var_168_16 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play928011040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 928011040
		arg_169_1.duration_ = 8.27

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play928011041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 1.7 < arg_169_1.time_ and arg_169_1.time_ <= 1.7 + arg_172_0 then
				local var_172_0 = arg_169_1.bgs_.STblack

				arg_169_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_172_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_172_1 = var_172_0:GetComponent("SpriteRenderer")

				if var_172_1 and var_172_1.sprite then
					local var_172_2 = 2 * (var_172_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_172_0.transform.localScale = Vector3.New(var_172_2 / var_172_1.sprite.bounds.size.y < var_172_2 * manager.ui.mainCameraCom_.aspect / var_172_1.sprite.bounds.size.x and var_172_2 * manager.ui.mainCameraCom_.aspect / var_172_1.sprite.bounds.size.x or var_172_2 / var_172_1.sprite.bounds.size.y, var_172_2 / var_172_1.sprite.bounds.size.y < var_172_2 * manager.ui.mainCameraCom_.aspect / var_172_1.sprite.bounds.size.x and var_172_2 * manager.ui.mainCameraCom_.aspect / var_172_1.sprite.bounds.size.x or var_172_2 / var_172_1.sprite.bounds.size.y, 0)
				end

				for iter_172_0, iter_172_1 in pairs(arg_169_1.bgs_) do
					if iter_172_0 ~= "STblack" then
						iter_172_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_172_3 = 1.7

			if 1.7 < arg_169_1.time_ and arg_169_1.time_ <= var_172_3 + arg_172_0 then
				arg_169_1.allBtn_.enabled = false
			end

			if arg_169_1.time_ >= var_172_3 + 0.3 and arg_169_1.time_ < var_172_3 + 0.3 + arg_172_0 then
				arg_169_1.allBtn_.enabled = true
			end

			local var_172_4 = 0

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_5 = 1.7

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_5 then
				local var_172_6 = Color.New(0, 0, 0)

				var_172_6.a = Mathf.Lerp(0, 1, (arg_169_1.time_ - var_172_4) / var_172_5)
				arg_169_1.mask_.color = var_172_6
			end

			if arg_169_1.time_ >= var_172_4 + var_172_5 and arg_169_1.time_ < var_172_4 + var_172_5 + arg_172_0 then
				local var_172_7 = Color.New(0, 0, 0)

				var_172_7.a = 1
				arg_169_1.mask_.color = var_172_7
			end

			local var_172_8 = 1.7

			if 1.7 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_9 = 2

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_9 then
				local var_172_10 = Color.New(0, 0, 0)

				var_172_10.a = Mathf.Lerp(1, 0, (arg_169_1.time_ - var_172_8) / var_172_9)
				arg_169_1.mask_.color = var_172_10
			end

			if arg_169_1.time_ >= var_172_8 + var_172_9 and arg_169_1.time_ < var_172_8 + var_172_9 + arg_172_0 then
				local var_172_11 = Color.New(0, 0, 0)

				arg_169_1.mask_.enabled = false
				var_172_11.a = 0
				arg_169_1.mask_.color = var_172_11
			end

			local var_172_12 = arg_169_1.actors_["1066ui_story"].transform

			if 1.7 < arg_169_1.time_ and arg_169_1.time_ <= 1.7 + arg_172_0 then
				arg_169_1.var_.moveOldPos1066ui_story = var_172_12.localPosition
			end

			local var_172_13 = 0.001

			if 1.7 <= arg_169_1.time_ and arg_169_1.time_ < 1.7 + var_172_13 then
				var_172_12.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 1.7) / var_172_13)
				var_172_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_12.position).x, (manager.ui.mainCamera.transform.position - var_172_12.position).y, (manager.ui.mainCamera.transform.position - var_172_12.position).z)
				var_172_12.localEulerAngles.z = 0
				var_172_12.localEulerAngles.x = 0
				var_172_12.localEulerAngles = var_172_12.localEulerAngles
			end

			if arg_169_1.time_ >= 1.7 + var_172_13 and arg_169_1.time_ < 1.7 + var_172_13 + arg_172_0 then
				var_172_12.localPosition = Vector3.New(0, 100, 0)
				var_172_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_12.position).x, (manager.ui.mainCamera.transform.position - var_172_12.position).y, (manager.ui.mainCamera.transform.position - var_172_12.position).z)
				var_172_12.localEulerAngles.z = 0
				var_172_12.localEulerAngles.x = 0
				var_172_12.localEulerAngles = var_172_12.localEulerAngles
			end

			local var_172_14 = arg_169_1.actors_["1066ui_story"]

			if 1.7 < arg_169_1.time_ and arg_169_1.time_ <= 1.7 + arg_172_0 and not isNil(var_172_14) and arg_169_1.var_.characterEffect1066ui_story == nil then
				arg_169_1.var_.characterEffect1066ui_story = var_172_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_15 = 0.200000002980232

			if 1.7 <= arg_169_1.time_ and arg_169_1.time_ < 1.7 + var_172_15 and not isNil(var_172_14) then
				if arg_169_1.var_.characterEffect1066ui_story and not isNil(var_172_14) then
					arg_169_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 1.7) / var_172_15)
				end
			end

			if arg_169_1.time_ >= 1.7 + var_172_15 and arg_169_1.time_ < 1.7 + var_172_15 + arg_172_0 and not isNil(var_172_14) and arg_169_1.var_.characterEffect1066ui_story then
				arg_169_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0.133333333333333 < arg_169_1.time_ and arg_169_1.time_ <= 0.133333333333333 + arg_172_0 then
				arg_169_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 1.36666666666667 < arg_169_1.time_ and arg_169_1.time_ <= 1.36666666666667 + arg_172_0 then
				arg_169_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			if 1.73400000184774 < arg_169_1.time_ and arg_169_1.time_ <= 1.73400000184774 + arg_172_0 then
				arg_169_1:AudioAction("play", "effect", "se_story_145", "se_story_145_drum", "")
			end

			if 0.133333333333333 < arg_169_1.time_ and arg_169_1.time_ <= 0.133333333333333 + arg_172_0 then
				arg_169_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_172_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_169_1.bgmTxt_.text ~= var_172_21 and arg_169_1.bgmTxt_.text ~= "" then
						if arg_169_1.bgmTxt2_.text ~= "" then
							arg_169_1.bgmTxt_.text = arg_169_1.bgmTxt2_.text
						end

						arg_169_1.bgmTxt2_.text = var_172_21

						arg_169_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_169_1.bgmTxt_.text = var_172_21
						arg_169_1.bgmTxt2_.text = var_172_21
					end

					if arg_169_1.bgmTimer then
						arg_169_1.bgmTimer:Stop()

						arg_169_1.bgmTimer = nil
					end

					if arg_169_1.settingData.show_music_name == 1 then
						arg_169_1.musicController:SetSelectedState("show")
						arg_169_1.musicAnimator_:Play("open", 0, 0)

						if arg_169_1.settingData.music_time ~= 0 then
							arg_169_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_169_1.settingData.music_time), function()
								if arg_169_1 == nil or isNil(arg_169_1.bgmTxt_) then
									return
								end

								arg_169_1.musicController:SetSelectedState("hide")
								arg_169_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_22 = 3.26666666666667
			local var_172_23 = 0.75

			if 3.26666666666667 < arg_169_1.time_ and arg_169_1.time_ <= var_172_22 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_24 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_24:setOnUpdate(LuaHelper.FloatAction(function(arg_174_0)
					arg_169_1.dialogCg_.alpha = arg_174_0
				end))
				var_172_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_25 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(928011040).content)

				arg_169_1.text_.text = var_172_25

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_27 = 30 <= 0 and var_172_23 or var_172_23 * (utf8.len(var_172_25) / 30)

				if (30 <= 0 and var_172_23 or var_172_23 * (utf8.len(var_172_25) / 30)) > 0 and var_172_23 < var_172_27 then
					arg_169_1.talkMaxDuration = var_172_27
					var_172_22 = var_172_22 + 0.3

					if var_172_27 + var_172_22 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_27 + var_172_22
					end
				end

				arg_169_1.text_.text = var_172_25
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_28 = var_172_22 + 0.3
			local var_172_29 = math.max(var_172_23, arg_169_1.talkMaxDuration)

			if var_172_22 + 0.3 <= arg_169_1.time_ and arg_169_1.time_ < var_172_28 + var_172_29 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_28) / var_172_29

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_28 + var_172_29 and arg_169_1.time_ < var_172_28 + var_172_29 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play928011041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 928011041
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play928011042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0.75

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_1 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(928011041).content)

				arg_176_1.text_.text = var_179_1

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_3 = 30 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 30)

				if (30 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 30)) > 0 and var_179_0 < var_179_3 then
					arg_176_1.talkMaxDuration = var_179_3

					if var_179_3 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_3 + 0
					end
				end

				arg_176_1.text_.text = var_179_1
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_4 = math.max(var_179_0, arg_176_1.talkMaxDuration)

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_4 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - 0) / var_179_4

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= 0 + var_179_4 and arg_176_1.time_ < 0 + var_179_4 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play928011042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 928011042
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play928011043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0.625

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_1 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(928011042).content)

				arg_180_1.text_.text = var_183_1

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_3 = 25 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_1) / 25)

				if (25 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_1) / 25)) > 0 and var_183_0 < var_183_3 then
					arg_180_1.talkMaxDuration = var_183_3

					if var_183_3 + 0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_3 + 0
					end
				end

				arg_180_1.text_.text = var_183_1
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_4 = math.max(var_183_0, arg_180_1.talkMaxDuration)

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_4 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - 0) / var_183_4

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= 0 + var_183_4 and arg_180_1.time_ < 0 + var_183_4 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play928011043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 928011043
		arg_184_1.duration_ = 7

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play928011044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if arg_184_1.bgs_.STwhite == nil then
				local var_187_0 = Object.Instantiate(arg_184_1.paintGo_)

				var_187_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_187_0.name = "STwhite"
				var_187_0.transform.parent = arg_184_1.stage_.transform
				var_187_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_184_1.bgs_.STwhite = var_187_0
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				local var_187_1 = arg_184_1.bgs_.STwhite

				arg_184_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_187_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_187_2 = var_187_1:GetComponent("SpriteRenderer")

				if var_187_2 and var_187_2.sprite then
					local var_187_3 = 2 * (var_187_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_187_1.transform.localScale = Vector3.New(var_187_3 / var_187_2.sprite.bounds.size.y < var_187_3 * manager.ui.mainCameraCom_.aspect / var_187_2.sprite.bounds.size.x and var_187_3 * manager.ui.mainCameraCom_.aspect / var_187_2.sprite.bounds.size.x or var_187_3 / var_187_2.sprite.bounds.size.y, var_187_3 / var_187_2.sprite.bounds.size.y < var_187_3 * manager.ui.mainCameraCom_.aspect / var_187_2.sprite.bounds.size.x and var_187_3 * manager.ui.mainCameraCom_.aspect / var_187_2.sprite.bounds.size.x or var_187_3 / var_187_2.sprite.bounds.size.y, 0)
				end

				for iter_187_0, iter_187_1 in pairs(arg_184_1.bgs_) do
					if iter_187_0 ~= "STwhite" then
						iter_187_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_187_4 = 0

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1.allBtn_.enabled = false
			end

			if arg_184_1.time_ >= var_187_4 + 0.3 and arg_184_1.time_ < var_187_4 + 0.3 + arg_187_0 then
				arg_184_1.allBtn_.enabled = true
			end

			local var_187_5 = 0

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 then
				arg_184_1.mask_.enabled = true
				arg_184_1.mask_.raycastTarget = true

				arg_184_1:SetGaussion(false)
			end

			local var_187_6 = 1.16666666666667

			if var_187_5 <= arg_184_1.time_ and arg_184_1.time_ < var_187_5 + var_187_6 then
				local var_187_7 = Color.New(0, 0, 0)

				var_187_7.a = Mathf.Lerp(1, 0, (arg_184_1.time_ - var_187_5) / var_187_6)
				arg_184_1.mask_.color = var_187_7
			end

			if arg_184_1.time_ >= var_187_5 + var_187_6 and arg_184_1.time_ < var_187_5 + var_187_6 + arg_187_0 then
				local var_187_8 = Color.New(0, 0, 0)

				arg_184_1.mask_.enabled = false
				var_187_8.a = 0
				arg_184_1.mask_.color = var_187_8
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:AudioAction("play", "effect", "se_story_145", "se_story_145_whoosh", "")
			end

			local var_187_10 = 1.16666666666667

			if 1.16666666666667 < arg_184_1.time_ and arg_184_1.time_ <= var_187_10 + arg_187_0 then
				arg_184_1.allBtn_.enabled = false
			end

			if arg_184_1.time_ >= var_187_10 + 1 and arg_184_1.time_ < var_187_10 + 1 + arg_187_0 then
				arg_184_1.allBtn_.enabled = true
			end

			if arg_184_1.frameCnt_ <= 1 then
				arg_184_1.dialog_:SetActive(false)
			end

			local var_187_11 = 1.999999999999
			local var_187_12 = 0.325

			if 1.999999999999 < arg_184_1.time_ and arg_184_1.time_ <= var_187_11 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0

				arg_184_1.dialog_:SetActive(true)

				arg_184_1.dialogCg_.alpha = 0

				local var_187_13 = LeanTween.value(arg_184_1.dialog_, 0, 1, 0.3)

				var_187_13:setOnUpdate(LuaHelper.FloatAction(function(arg_188_0)
					arg_184_1.dialogCg_.alpha = arg_188_0
				end))
				var_187_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_184_1.dialog_)
					var_187_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_184_1.duration_ = arg_184_1.duration_ + 0.3

				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_14 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(928011043).content)

				arg_184_1.text_.text = var_187_14

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_16 = 13 <= 0 and var_187_12 or var_187_12 * (utf8.len(var_187_14) / 13)

				if (13 <= 0 and var_187_12 or var_187_12 * (utf8.len(var_187_14) / 13)) > 0 and var_187_12 < var_187_16 then
					arg_184_1.talkMaxDuration = var_187_16
					var_187_11 = var_187_11 + 0.3

					if var_187_16 + var_187_11 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_16 + var_187_11
					end
				end

				arg_184_1.text_.text = var_187_14
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_17 = var_187_11 + 0.3
			local var_187_18 = math.max(var_187_12, arg_184_1.talkMaxDuration)

			if var_187_11 + 0.3 <= arg_184_1.time_ and arg_184_1.time_ < var_187_17 + var_187_18 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_17) / var_187_18

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_17 + var_187_18 and arg_184_1.time_ < var_187_17 + var_187_18 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play928011044 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 928011044
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play928011045(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0.675

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_1 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(928011044).content)

				arg_190_1.text_.text = var_193_1

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_3 = 27 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 27)

				if (27 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 27)) > 0 and var_193_0 < var_193_3 then
					arg_190_1.talkMaxDuration = var_193_3

					if var_193_3 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_3 + 0
					end
				end

				arg_190_1.text_.text = var_193_1
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_4 = math.max(var_193_0, arg_190_1.talkMaxDuration)

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_4 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - 0) / var_193_4

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= 0 + var_193_4 and arg_190_1.time_ < 0 + var_193_4 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play928011045 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 928011045
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play928011046(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0.95

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, false)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_1 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(928011045).content)

				arg_194_1.text_.text = var_197_1

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_3 = 38 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_1) / 38)

				if (38 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_1) / 38)) > 0 and var_197_0 < var_197_3 then
					arg_194_1.talkMaxDuration = var_197_3

					if var_197_3 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_3 + 0
					end
				end

				arg_194_1.text_.text = var_197_1
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_4 = math.max(var_197_0, arg_194_1.talkMaxDuration)

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_4 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - 0) / var_197_4

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= 0 + var_197_4 and arg_194_1.time_ < 0 + var_197_4 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play928011046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 928011046
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play928011047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0.75

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_1 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(928011046).content)

				arg_198_1.text_.text = var_201_1

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_3 = 30 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_1) / 30)

				if (30 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_1) / 30)) > 0 and var_201_0 < var_201_3 then
					arg_198_1.talkMaxDuration = var_201_3

					if var_201_3 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_3 + 0
					end
				end

				arg_198_1.text_.text = var_201_1
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_4 = math.max(var_201_0, arg_198_1.talkMaxDuration)

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_4 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - 0) / var_201_4

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= 0 + var_201_4 and arg_198_1.time_ < 0 + var_201_4 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play928011047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 928011047
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play928011048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0.9

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_1 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(928011047).content)

				arg_202_1.text_.text = var_205_1

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_3 = 36 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_1) / 36)

				if (36 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_1) / 36)) > 0 and var_205_0 < var_205_3 then
					arg_202_1.talkMaxDuration = var_205_3

					if var_205_3 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_3 + 0
					end
				end

				arg_202_1.text_.text = var_205_1
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_4 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_4 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_4

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_4 and arg_202_1.time_ < 0 + var_205_4 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play928011048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 928011048
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play928011049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0.75

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_1 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(928011048).content)

				arg_206_1.text_.text = var_209_1

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_3 = 30 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_1) / 30)

				if (30 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_1) / 30)) > 0 and var_209_0 < var_209_3 then
					arg_206_1.talkMaxDuration = var_209_3

					if var_209_3 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_3 + 0
					end
				end

				arg_206_1.text_.text = var_209_1
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_4 = math.max(var_209_0, arg_206_1.talkMaxDuration)

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_4 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - 0) / var_209_4

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= 0 + var_209_4 and arg_206_1.time_ < 0 + var_209_4 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play928011049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 928011049
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play928011050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0.525

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_1 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(928011049).content)

				arg_210_1.text_.text = var_213_1

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_3 = 21 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_1) / 21)

				if (21 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_1) / 21)) > 0 and var_213_0 < var_213_3 then
					arg_210_1.talkMaxDuration = var_213_3

					if var_213_3 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_3 + 0
					end
				end

				arg_210_1.text_.text = var_213_1
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_4 = math.max(var_213_0, arg_210_1.talkMaxDuration)

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_4 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - 0) / var_213_4

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= 0 + var_213_4 and arg_210_1.time_ < 0 + var_213_4 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play928011050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 928011050
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play928011051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.7

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_1 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(928011050).content)

				arg_214_1.text_.text = var_217_1

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_3 = 28 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 28)

				if (28 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 28)) > 0 and var_217_0 < var_217_3 then
					arg_214_1.talkMaxDuration = var_217_3

					if var_217_3 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_3 + 0
					end
				end

				arg_214_1.text_.text = var_217_1
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_4 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_4

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play928011051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 928011051
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play928011052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_9000

			if 0.455322796246037 < arg_218_1.time_ and arg_218_1.time_ <= 0.455322796246037 + arg_221_0 then
				arg_218_1:AudioAction("play", "effect", "se_story_140", "se_story_140_sand", "")
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				local var_221_1 = arg_218_1.var_.effect3424

				if not arg_218_1.var_.effect3424 then
					var_221_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suipian_in"), manager.ui.mainCamera.transform)
					var_221_1.name = "3424"
					arg_218_1.var_.effect3424 = var_221_1
				else
					var_221_1.transform:SetParent(var_221_9000)
				end

				var_221_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_221_1.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_221_3 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_221_0, iter_221_1 in ipairs((var_221_1.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_221_1.transform.localScale = Vector3.New(iter_221_1.transform.localScale.x / var_221_3 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_221_1.transform.localScale.y / var_221_3, iter_221_1.transform.localScale.z)
				end
			end

			local var_221_5 = 0
			local var_221_6 = 0.9

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_5 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_7 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(928011051).content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_9 = 36 <= 0 and var_221_6 or var_221_6 * (utf8.len(var_221_7) / 36)

				if (36 <= 0 and var_221_6 or var_221_6 * (utf8.len(var_221_7) / 36)) > 0 and var_221_6 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_5 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_5
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_10 = math.max(var_221_6, arg_218_1.talkMaxDuration)

			if var_221_5 <= arg_218_1.time_ and arg_218_1.time_ < var_221_5 + var_221_10 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_5) / var_221_10

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_5 + var_221_10 and arg_218_1.time_ < var_221_5 + var_221_10 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play928011052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 928011052
		arg_222_1.duration_ = 6.83

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play928011053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_9000

			if 0.833333333333333 < arg_222_1.time_ and arg_222_1.time_ <= 0.833333333333333 + arg_225_0 then
				arg_222_1:AudioAction("play", "effect", "se_story_145", "se_story_145_break01", "")
			end

			if 0.833333333333333 < arg_222_1.time_ and arg_222_1.time_ <= 0.833333333333333 + arg_225_0 then
				if arg_222_1.var_.effect3424 then
					Object.Destroy(arg_222_1.var_.effect3424)

					arg_222_1.var_.effect3424 = nil
				end
			end

			local var_225_2 = 0.833333333333333

			if 0.833333333333333 < arg_222_1.time_ and arg_222_1.time_ <= var_225_2 + arg_225_0 then
				arg_222_1.mask_.enabled = true
				arg_222_1.mask_.raycastTarget = true

				arg_222_1:SetGaussion(false)
			end

			local var_225_3 = 0.666666666666667

			if var_225_2 <= arg_222_1.time_ and arg_222_1.time_ < var_225_2 + var_225_3 then
				local var_225_4 = Color.New(1, 1, 1)

				var_225_4.a = Mathf.Lerp(1, 0, (arg_222_1.time_ - var_225_2) / var_225_3)
				arg_222_1.mask_.color = var_225_4
			end

			if arg_222_1.time_ >= var_225_2 + var_225_3 and arg_222_1.time_ < var_225_2 + var_225_3 + arg_225_0 then
				local var_225_5 = Color.New(1, 1, 1)

				arg_222_1.mask_.enabled = false
				var_225_5.a = 0
				arg_222_1.mask_.color = var_225_5
			end

			local var_225_6 = 0

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_6 + arg_225_0 then
				arg_222_1.allBtn_.enabled = false
			end

			if arg_222_1.time_ >= var_225_6 + 1 and arg_222_1.time_ < var_225_6 + 1 + arg_225_0 then
				arg_222_1.allBtn_.enabled = true
			end

			if 0.833333333333333 < arg_222_1.time_ and arg_222_1.time_ <= 0.833333333333333 + arg_225_0 then
				local var_225_7 = arg_222_1.var_.effect3424

				if not arg_222_1.var_.effect3424 then
					var_225_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suipian_out"), manager.ui.mainCamera.transform)
					var_225_7.name = "3424"
					arg_222_1.var_.effect3424 = var_225_7
				else
					var_225_7.transform:SetParent(var_225_9000)
				end

				var_225_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_225_7.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_225_9 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_225_0, iter_225_1 in ipairs((var_225_7.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_225_1.transform.localScale = Vector3.New(iter_225_1.transform.localScale.x / var_225_9 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_225_1.transform.localScale.y / var_225_9, iter_225_1.transform.localScale.z)
				end
			end

			if arg_222_1.frameCnt_ <= 1 then
				arg_222_1.dialog_:SetActive(false)
			end

			local var_225_11 = 1.833333333332
			local var_225_12 = 1.3

			if 1.833333333332 < arg_222_1.time_ and arg_222_1.time_ <= var_225_11 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0

				arg_222_1.dialog_:SetActive(true)

				arg_222_1.dialogCg_.alpha = 0

				local var_225_13 = LeanTween.value(arg_222_1.dialog_, 0, 1, 0.3)

				var_225_13:setOnUpdate(LuaHelper.FloatAction(function(arg_226_0)
					arg_222_1.dialogCg_.alpha = arg_226_0
				end))
				var_225_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_222_1.dialog_)
					var_225_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_222_1.duration_ = arg_222_1.duration_ + 0.3

				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_14 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(928011052).content)

				arg_222_1.text_.text = var_225_14

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_16 = 52 <= 0 and var_225_12 or var_225_12 * (utf8.len(var_225_14) / 52)

				if (52 <= 0 and var_225_12 or var_225_12 * (utf8.len(var_225_14) / 52)) > 0 and var_225_12 < var_225_16 then
					arg_222_1.talkMaxDuration = var_225_16
					var_225_11 = var_225_11 + 0.3

					if var_225_16 + var_225_11 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_16 + var_225_11
					end
				end

				arg_222_1.text_.text = var_225_14
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_17 = var_225_11 + 0.3
			local var_225_18 = math.max(var_225_12, arg_222_1.talkMaxDuration)

			if var_225_11 + 0.3 <= arg_222_1.time_ and arg_222_1.time_ < var_225_17 + var_225_18 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_17) / var_225_18

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_17 + var_225_18 and arg_222_1.time_ < var_225_17 + var_225_18 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play928011053 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 928011053
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play928011054(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				if arg_228_1.var_.effect3424 then
					Object.Destroy(arg_228_1.var_.effect3424)

					arg_228_1.var_.effect3424 = nil
				end
			end

			local var_231_1 = 0
			local var_231_2 = 0.875

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, false)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_3 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(928011053).content)

				arg_228_1.text_.text = var_231_3

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_5 = 35 <= 0 and var_231_2 or var_231_2 * (utf8.len(var_231_3) / 35)

				if (35 <= 0 and var_231_2 or var_231_2 * (utf8.len(var_231_3) / 35)) > 0 and var_231_2 < var_231_5 then
					arg_228_1.talkMaxDuration = var_231_5

					if var_231_5 + var_231_1 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_5 + var_231_1
					end
				end

				arg_228_1.text_.text = var_231_3
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_6 = math.max(var_231_2, arg_228_1.talkMaxDuration)

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_6 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_1) / var_231_6

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_1 + var_231_6 and arg_228_1.time_ < var_231_1 + var_231_6 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play928011054 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 928011054
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play928011055(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0.875

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_1 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(928011054).content)

				arg_232_1.text_.text = var_235_1

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_3 = 35 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_1) / 35)

				if (35 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_1) / 35)) > 0 and var_235_0 < var_235_3 then
					arg_232_1.talkMaxDuration = var_235_3

					if var_235_3 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_3 + 0
					end
				end

				arg_232_1.text_.text = var_235_1
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_4 = math.max(var_235_0, arg_232_1.talkMaxDuration)

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_4 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - 0) / var_235_4

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= 0 + var_235_4 and arg_232_1.time_ < 0 + var_235_4 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play928011055 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 928011055
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play928011056(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0.125

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_1 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(928011055).content)

				arg_236_1.text_.text = var_239_1

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_3 = 5 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_1) / 5)

				if (5 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_1) / 5)) > 0 and var_239_0 < var_239_3 then
					arg_236_1.talkMaxDuration = var_239_3

					if var_239_3 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_3 + 0
					end
				end

				arg_236_1.text_.text = var_239_1
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_4 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_4 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_4

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_4 and arg_236_1.time_ < 0 + var_239_4 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play928011056 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 928011056
		arg_240_1.duration_ = 3.6

		local var_240_0 = {
			zh = 3.533,
			ja = 3.6
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play928011057(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_9000

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				local var_243_0 = arg_240_1.bgs_.ST2201

				arg_240_1.bgs_.ST2201.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_243_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_243_1 = var_243_0:GetComponent("SpriteRenderer")

				if var_243_1 and var_243_1.sprite then
					local var_243_2 = 2 * (var_243_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_243_0.transform.localScale = Vector3.New(var_243_2 / var_243_1.sprite.bounds.size.y < var_243_2 * manager.ui.mainCameraCom_.aspect / var_243_1.sprite.bounds.size.x and var_243_2 * manager.ui.mainCameraCom_.aspect / var_243_1.sprite.bounds.size.x or var_243_2 / var_243_1.sprite.bounds.size.y, var_243_2 / var_243_1.sprite.bounds.size.y < var_243_2 * manager.ui.mainCameraCom_.aspect / var_243_1.sprite.bounds.size.x and var_243_2 * manager.ui.mainCameraCom_.aspect / var_243_1.sprite.bounds.size.x or var_243_2 / var_243_1.sprite.bounds.size.y, 0)
				end

				for iter_243_0, iter_243_1 in pairs(arg_240_1.bgs_) do
					if iter_243_0 ~= "ST2201" then
						iter_243_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_243_3 = 0

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_3 + arg_243_0 then
				arg_240_1.allBtn_.enabled = false
			end

			if arg_240_1.time_ >= var_243_3 + 0.3 and arg_240_1.time_ < var_243_3 + 0.3 + arg_243_0 then
				arg_240_1.allBtn_.enabled = true
			end

			local var_243_4 = 0

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_4 + arg_243_0 then
				arg_240_1.mask_.enabled = true
				arg_240_1.mask_.raycastTarget = true

				arg_240_1:SetGaussion(false)
			end

			local var_243_5 = 0.633333333333333

			if var_243_4 <= arg_240_1.time_ and arg_240_1.time_ < var_243_4 + var_243_5 then
				local var_243_6 = Color.New(1, 1, 1)

				var_243_6.a = Mathf.Lerp(1, 0, (arg_240_1.time_ - var_243_4) / var_243_5)
				arg_240_1.mask_.color = var_243_6
			end

			if arg_240_1.time_ >= var_243_4 + var_243_5 and arg_240_1.time_ < var_243_4 + var_243_5 + arg_243_0 then
				local var_243_7 = Color.New(1, 1, 1)

				arg_240_1.mask_.enabled = false
				var_243_7.a = 0
				arg_240_1.mask_.color = var_243_7
			end

			local var_243_8 = arg_240_1.actors_["1085ui_story"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_8) and arg_240_1.var_.characterEffect1085ui_story == nil then
				arg_240_1.var_.characterEffect1085ui_story = var_243_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_9 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_9 and not isNil(var_243_8) then
				if arg_240_1.var_.characterEffect1085ui_story and not isNil(var_243_8) then
					arg_240_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= 0 + var_243_9 and arg_240_1.time_ < 0 + var_243_9 + arg_243_0 and not isNil(var_243_8) and arg_240_1.var_.characterEffect1085ui_story then
				arg_240_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			if 0.200000002980232 < arg_240_1.time_ and arg_240_1.time_ <= 0.200000002980232 + arg_243_0 then
				arg_240_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_243_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_240_1.bgmTxt_.text ~= var_243_15 and arg_240_1.bgmTxt_.text ~= "" then
						if arg_240_1.bgmTxt2_.text ~= "" then
							arg_240_1.bgmTxt_.text = arg_240_1.bgmTxt2_.text
						end

						arg_240_1.bgmTxt2_.text = var_243_15

						arg_240_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_240_1.bgmTxt_.text = var_243_15
						arg_240_1.bgmTxt2_.text = var_243_15
					end

					if arg_240_1.bgmTimer then
						arg_240_1.bgmTimer:Stop()

						arg_240_1.bgmTimer = nil
					end

					if arg_240_1.settingData.show_music_name == 1 then
						arg_240_1.musicController:SetSelectedState("show")
						arg_240_1.musicAnimator_:Play("open", 0, 0)

						if arg_240_1.settingData.music_time ~= 0 then
							arg_240_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_240_1.settingData.music_time), function()
								if arg_240_1 == nil or isNil(arg_240_1.bgmTxt_) then
									return
								end

								arg_240_1.musicController:SetSelectedState("hide")
								arg_240_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.200000002980232 < arg_240_1.time_ and arg_240_1.time_ <= 0.200000002980232 + arg_243_0 then
				arg_240_1:AudioAction("play", "music", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily.awb")

				local var_243_18 = manager.audio:GetAudioName("bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily")

				if "" ~= "" then
					if arg_240_1.bgmTxt_.text ~= var_243_18 and arg_240_1.bgmTxt_.text ~= "" then
						if arg_240_1.bgmTxt2_.text ~= "" then
							arg_240_1.bgmTxt_.text = arg_240_1.bgmTxt2_.text
						end

						arg_240_1.bgmTxt2_.text = var_243_18

						arg_240_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_240_1.bgmTxt_.text = var_243_18
						arg_240_1.bgmTxt2_.text = var_243_18
					end

					if arg_240_1.bgmTimer then
						arg_240_1.bgmTimer:Stop()

						arg_240_1.bgmTimer = nil
					end

					if arg_240_1.settingData.show_music_name == 1 then
						arg_240_1.musicController:SetSelectedState("show")
						arg_240_1.musicAnimator_:Play("open", 0, 0)

						if arg_240_1.settingData.music_time ~= 0 then
							arg_240_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_240_1.settingData.music_time), function()
								if arg_240_1 == nil or isNil(arg_240_1.bgmTxt_) then
									return
								end

								arg_240_1.musicController:SetSelectedState("hide")
								arg_240_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				local var_243_19 = arg_240_1.var_.effecttttt

				if not arg_240_1.var_.effecttttt then
					var_243_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapopen"), manager.ui.mainCamera.transform)
					var_243_19.name = "tttt"
					arg_240_1.var_.effecttttt = var_243_19
				else
					var_243_19.transform:SetParent(var_243_9000)
				end

				var_243_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_243_19.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_243_21 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_243_2, iter_243_3 in ipairs((var_243_19.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_243_3.transform.localScale = Vector3.New(iter_243_3.transform.localScale.x / var_243_21 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_243_3.transform.localScale.y / var_243_21, iter_243_3.transform.localScale.z)
				end
			end

			local var_243_23

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				local var_243_24 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_243_24 then
					var_243_24.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_243_24.radialBlurScale = 0
					var_243_24.radialBlurGradient = 1
					var_243_24.radialBlurIntensity = 1

					if var_243_23 then
						var_243_24.radialBlurTarget = var_243_23.transform
					end
				end
			end

			local var_243_25 = 1.48333333333333

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_25 then
				local var_243_26 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_243_26 then
					var_243_26.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_243_26.radialBlurScale = Mathf.Lerp(0, 0.712, (arg_240_1.time_ - 0) / var_243_25)
					var_243_26.radialBlurGradient = Mathf.Lerp(1, 1, (arg_240_1.time_ - 0) / var_243_25)
					var_243_26.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_240_1.time_ - 0) / var_243_25)
				end
			end

			if arg_240_1.time_ >= 0 + var_243_25 and arg_240_1.time_ < 0 + var_243_25 + arg_243_0 then
				local var_243_27 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_243_27 then
					var_243_27.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_243_27.radialBlurScale = 0.712
					var_243_27.radialBlurGradient = 1
					var_243_27.radialBlurIntensity = 1
				end
			end

			if arg_240_1.frameCnt_ <= 1 then
				arg_240_1.dialog_:SetActive(false)
			end

			local var_243_28 = 2.3
			local var_243_29 = 0.075

			if 2.3 < arg_240_1.time_ and arg_240_1.time_ <= var_243_28 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0

				arg_240_1.dialog_:SetActive(true)

				arg_240_1.dialogCg_.alpha = 0

				local var_243_30 = LeanTween.value(arg_240_1.dialog_, 0, 1, 0.3)

				var_243_30:setOnUpdate(LuaHelper.FloatAction(function(arg_246_0)
					arg_240_1.dialogCg_.alpha = arg_246_0
				end))
				var_243_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_240_1.dialog_)
					var_243_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_240_1.duration_ = arg_240_1.duration_ + 0.3

				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1085")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_31 = arg_240_1:GetWordFromCfg(928011056)
				local var_243_32 = arg_240_1:FormatText(var_243_31.content)

				arg_240_1.text_.text = var_243_32

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_34 = 3 <= 0 and var_243_29 or var_243_29 * (utf8.len(var_243_32) / 3)

				if (3 <= 0 and var_243_29 or var_243_29 * (utf8.len(var_243_32) / 3)) > 0 and var_243_29 < var_243_34 then
					arg_240_1.talkMaxDuration = var_243_34
					var_243_28 = var_243_28 + 0.3

					if var_243_34 + var_243_28 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_34 + var_243_28
					end
				end

				arg_240_1.text_.text = var_243_32
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011056", "story_v_side_old_928011.awb") ~= 0 then
					local var_243_35 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011056", "story_v_side_old_928011.awb") / 1000

					if var_243_35 + var_243_28 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_35 + var_243_28
					end

					if var_243_31.prefab_name ~= "" and arg_240_1.actors_[var_243_31.prefab_name] ~= nil then
						local var_243_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_31.prefab_name].transform, "story_v_side_old_928011", "928011056", "story_v_side_old_928011.awb")

						arg_240_1:RecordAudio("928011056", var_243_36)
						arg_240_1:RecordAudio("928011056", var_243_36)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011056", "story_v_side_old_928011.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011056", "story_v_side_old_928011.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_37 = var_243_28 + 0.3
			local var_243_38 = math.max(var_243_29, arg_240_1.talkMaxDuration)

			if var_243_28 + 0.3 <= arg_240_1.time_ and arg_240_1.time_ < var_243_37 + var_243_38 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_37) / var_243_38

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_37 + var_243_38 and arg_240_1.time_ < var_243_37 + var_243_38 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play928011057 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 928011057
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play928011058(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(arg_248_1.actors_["1085ui_story"]) and arg_248_1.var_.characterEffect1085ui_story == nil then
				arg_248_1.var_.characterEffect1085ui_story = arg_248_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_0 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 and not isNil(arg_248_1.actors_["1085ui_story"]) then
				if arg_248_1.var_.characterEffect1085ui_story and not isNil(arg_248_1.actors_["1085ui_story"]) then
					arg_248_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_248_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_248_1.time_ - 0) / var_251_0)
				end
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 and not isNil(arg_248_1.actors_["1085ui_story"]) and arg_248_1.var_.characterEffect1085ui_story then
				arg_248_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_248_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_251_1 = 0
			local var_251_2 = 0.625

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_3 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(928011057).content)

				arg_248_1.text_.text = var_251_3

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 25 <= 0 and var_251_2 or var_251_2 * (utf8.len(var_251_3) / 25)

				if (25 <= 0 and var_251_2 or var_251_2 * (utf8.len(var_251_3) / 25)) > 0 and var_251_2 < var_251_5 then
					arg_248_1.talkMaxDuration = var_251_5

					if var_251_5 + var_251_1 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + var_251_1
					end
				end

				arg_248_1.text_.text = var_251_3
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_6 = math.max(var_251_2, arg_248_1.talkMaxDuration)

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_6 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_1) / var_251_6

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_1 + var_251_6 and arg_248_1.time_ < var_251_1 + var_251_6 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play928011058 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 928011058
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play928011059(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				local var_255_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_255_0 then
					var_255_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_255_0.radialBlurScale = 0.7
					var_255_0.radialBlurGradient = 1
					var_255_0.radialBlurIntensity = 1

					if nil then
						var_255_0.radialBlurTarget = (nil).transform
					end
				end
			end

			local var_255_1 = 1

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_1 then
				local var_255_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_255_2 then
					var_255_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_255_2.radialBlurScale = Mathf.Lerp(0.7, 0, (arg_252_1.time_ - 0) / var_255_1)
					var_255_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_252_1.time_ - 0) / var_255_1)
					var_255_2.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_252_1.time_ - 0) / var_255_1)
				end
			end

			if arg_252_1.time_ >= 0 + var_255_1 and arg_252_1.time_ < 0 + var_255_1 + arg_255_0 then
				local var_255_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_255_3 then
					var_255_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_255_3.radialBlurScale = 0
					var_255_3.radialBlurGradient = 1
					var_255_3.radialBlurIntensity = 1
				end
			end

			local var_255_4 = 0

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1.allBtn_.enabled = false
			end

			if arg_252_1.time_ >= var_255_4 + 1 and arg_252_1.time_ < var_255_4 + 1 + arg_255_0 then
				arg_252_1.allBtn_.enabled = true
			end

			local var_255_5 = 0
			local var_255_6 = 0.85

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_5 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_7 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(928011058).content)

				arg_252_1.text_.text = var_255_7

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_9 = 34 <= 0 and var_255_6 or var_255_6 * (utf8.len(var_255_7) / 34)

				if (34 <= 0 and var_255_6 or var_255_6 * (utf8.len(var_255_7) / 34)) > 0 and var_255_6 < var_255_9 then
					arg_252_1.talkMaxDuration = var_255_9

					if var_255_9 + var_255_5 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_9 + var_255_5
					end
				end

				arg_252_1.text_.text = var_255_7
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_10 = math.max(var_255_6, arg_252_1.talkMaxDuration)

			if var_255_5 <= arg_252_1.time_ and arg_252_1.time_ < var_255_5 + var_255_10 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_5) / var_255_10

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_5 + var_255_10 and arg_252_1.time_ < var_255_5 + var_255_10 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play928011059 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 928011059
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play928011060(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0.225

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_1 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(928011059).content)

				arg_256_1.text_.text = var_259_1

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_3 = 9 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_1) / 9)

				if (9 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_1) / 9)) > 0 and var_259_0 < var_259_3 then
					arg_256_1.talkMaxDuration = var_259_3

					if var_259_3 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_3 + 0
					end
				end

				arg_256_1.text_.text = var_259_1
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_4 = math.max(var_259_0, arg_256_1.talkMaxDuration)

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_4 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - 0) / var_259_4

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= 0 + var_259_4 and arg_256_1.time_ < 0 + var_259_4 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play928011060 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 928011060
		arg_260_1.duration_ = 10

		local var_260_0 = {
			zh = 6.133,
			ja = 10
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play928011061(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos1066ui_story = arg_260_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_263_0 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 then
				arg_260_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_260_1.time_ - 0) / var_263_0)
				arg_260_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1066ui_story"].transform.position).z)
				arg_260_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["1066ui_story"].transform.localEulerAngles = arg_260_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 then
				arg_260_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_260_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1066ui_story"].transform.position).z)
				arg_260_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["1066ui_story"].transform.localEulerAngles = arg_260_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_263_1 = arg_260_1.actors_["1066ui_story"]

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(var_263_1) and arg_260_1.var_.characterEffect1066ui_story == nil then
				arg_260_1.var_.characterEffect1066ui_story = var_263_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_2 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_2 and not isNil(var_263_1) then
				if arg_260_1.var_.characterEffect1066ui_story and not isNil(var_263_1) then
					arg_260_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= 0 + var_263_2 and arg_260_1.time_ < 0 + var_263_2 + arg_263_0 and not isNil(var_263_1) and arg_260_1.var_.characterEffect1066ui_story then
				arg_260_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_1")
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_263_4 = 0
			local var_263_5 = 0.75

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_4 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_6 = arg_260_1:GetWordFromCfg(928011060)
				local var_263_7 = arg_260_1:FormatText(var_263_6.content)

				arg_260_1.text_.text = var_263_7

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_9 = 30 <= 0 and var_263_5 or var_263_5 * (utf8.len(var_263_7) / 30)

				if (30 <= 0 and var_263_5 or var_263_5 * (utf8.len(var_263_7) / 30)) > 0 and var_263_5 < var_263_9 then
					arg_260_1.talkMaxDuration = var_263_9

					if var_263_9 + var_263_4 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_9 + var_263_4
					end
				end

				arg_260_1.text_.text = var_263_7
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011060", "story_v_side_old_928011.awb") ~= 0 then
					local var_263_10 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011060", "story_v_side_old_928011.awb") / 1000

					if var_263_10 + var_263_4 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_10 + var_263_4
					end

					if var_263_6.prefab_name ~= "" and arg_260_1.actors_[var_263_6.prefab_name] ~= nil then
						local var_263_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_6.prefab_name].transform, "story_v_side_old_928011", "928011060", "story_v_side_old_928011.awb")

						arg_260_1:RecordAudio("928011060", var_263_11)
						arg_260_1:RecordAudio("928011060", var_263_11)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011060", "story_v_side_old_928011.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011060", "story_v_side_old_928011.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_12 = math.max(var_263_5, arg_260_1.talkMaxDuration)

			if var_263_4 <= arg_260_1.time_ and arg_260_1.time_ < var_263_4 + var_263_12 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_4) / var_263_12

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_4 + var_263_12 and arg_260_1.time_ < var_263_4 + var_263_12 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play928011061 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 928011061
		arg_264_1.duration_ = 9.4

		local var_264_0 = {
			zh = 6,
			ja = 9.4
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play928011062(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos1085ui_story = arg_264_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_267_0 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 then
				arg_264_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_264_1.time_ - 0) / var_267_0)
				arg_264_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1085ui_story"].transform.position).z)
				arg_264_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["1085ui_story"].transform.localEulerAngles = arg_264_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 then
				arg_264_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_264_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1085ui_story"].transform.position).z)
				arg_264_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["1085ui_story"].transform.localEulerAngles = arg_264_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_267_1 = arg_264_1.actors_["1066ui_story"].transform

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos1066ui_story = var_267_1.localPosition
			end

			local var_267_2 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_2 then
				var_267_1.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_264_1.time_ - 0) / var_267_2)
				var_267_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_267_1.position).x, (manager.ui.mainCamera.transform.position - var_267_1.position).y, (manager.ui.mainCamera.transform.position - var_267_1.position).z)
				var_267_1.localEulerAngles.z = 0
				var_267_1.localEulerAngles.x = 0
				var_267_1.localEulerAngles = var_267_1.localEulerAngles
			end

			if arg_264_1.time_ >= 0 + var_267_2 and arg_264_1.time_ < 0 + var_267_2 + arg_267_0 then
				var_267_1.localPosition = Vector3.New(0, 100, 0)
				var_267_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_267_1.position).x, (manager.ui.mainCamera.transform.position - var_267_1.position).y, (manager.ui.mainCamera.transform.position - var_267_1.position).z)
				var_267_1.localEulerAngles.z = 0
				var_267_1.localEulerAngles.x = 0
				var_267_1.localEulerAngles = var_267_1.localEulerAngles
			end

			local var_267_3 = arg_264_1.actors_["1085ui_story"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_3) and arg_264_1.var_.characterEffect1085ui_story == nil then
				arg_264_1.var_.characterEffect1085ui_story = var_267_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_4 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_4 and not isNil(var_267_3) then
				if arg_264_1.var_.characterEffect1085ui_story and not isNil(var_267_3) then
					arg_264_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= 0 + var_267_4 and arg_264_1.time_ < 0 + var_267_4 + arg_267_0 and not isNil(var_267_3) and arg_264_1.var_.characterEffect1085ui_story then
				arg_264_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_267_6 = arg_264_1.actors_["1066ui_story"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_6) and arg_264_1.var_.characterEffect1066ui_story == nil then
				arg_264_1.var_.characterEffect1066ui_story = var_267_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_7 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_7 and not isNil(var_267_6) then
				if arg_264_1.var_.characterEffect1066ui_story and not isNil(var_267_6) then
					arg_264_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_264_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_264_1.time_ - 0) / var_267_7)
				end
			end

			if arg_264_1.time_ >= 0 + var_267_7 and arg_264_1.time_ < 0 + var_267_7 + arg_267_0 and not isNil(var_267_6) and arg_264_1.var_.characterEffect1066ui_story then
				arg_264_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_264_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_267_8 = 0
			local var_267_9 = 0.475

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_8 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_10 = arg_264_1:GetWordFromCfg(928011061)
				local var_267_11 = arg_264_1:FormatText(var_267_10.content)

				arg_264_1.text_.text = var_267_11

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_13 = 19 <= 0 and var_267_9 or var_267_9 * (utf8.len(var_267_11) / 19)

				if (19 <= 0 and var_267_9 or var_267_9 * (utf8.len(var_267_11) / 19)) > 0 and var_267_9 < var_267_13 then
					arg_264_1.talkMaxDuration = var_267_13

					if var_267_13 + var_267_8 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_13 + var_267_8
					end
				end

				arg_264_1.text_.text = var_267_11
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011061", "story_v_side_old_928011.awb") ~= 0 then
					local var_267_14 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011061", "story_v_side_old_928011.awb") / 1000

					if var_267_14 + var_267_8 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_14 + var_267_8
					end

					if var_267_10.prefab_name ~= "" and arg_264_1.actors_[var_267_10.prefab_name] ~= nil then
						local var_267_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_10.prefab_name].transform, "story_v_side_old_928011", "928011061", "story_v_side_old_928011.awb")

						arg_264_1:RecordAudio("928011061", var_267_15)
						arg_264_1:RecordAudio("928011061", var_267_15)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011061", "story_v_side_old_928011.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011061", "story_v_side_old_928011.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_16 = math.max(var_267_9, arg_264_1.talkMaxDuration)

			if var_267_8 <= arg_264_1.time_ and arg_264_1.time_ < var_267_8 + var_267_16 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_8) / var_267_16

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_8 + var_267_16 and arg_264_1.time_ < var_267_8 + var_267_16 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play928011062 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 928011062
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play928011063(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(arg_268_1.actors_["1085ui_story"]) and arg_268_1.var_.characterEffect1085ui_story == nil then
				arg_268_1.var_.characterEffect1085ui_story = arg_268_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_0 = 0.200000002980232

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 and not isNil(arg_268_1.actors_["1085ui_story"]) then
				if arg_268_1.var_.characterEffect1085ui_story and not isNil(arg_268_1.actors_["1085ui_story"]) then
					arg_268_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_268_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_268_1.time_ - 0) / var_271_0)
				end
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 and not isNil(arg_268_1.actors_["1085ui_story"]) and arg_268_1.var_.characterEffect1085ui_story then
				arg_268_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_268_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_271_1 = 0
			local var_271_2 = 0.65

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_3 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(928011062).content)

				arg_268_1.text_.text = var_271_3

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_5 = 26 <= 0 and var_271_2 or var_271_2 * (utf8.len(var_271_3) / 26)

				if (26 <= 0 and var_271_2 or var_271_2 * (utf8.len(var_271_3) / 26)) > 0 and var_271_2 < var_271_5 then
					arg_268_1.talkMaxDuration = var_271_5

					if var_271_5 + var_271_1 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_5 + var_271_1
					end
				end

				arg_268_1.text_.text = var_271_3
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_6 = math.max(var_271_2, arg_268_1.talkMaxDuration)

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_6 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_1) / var_271_6

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_1 + var_271_6 and arg_268_1.time_ < var_271_1 + var_271_6 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play928011063 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 928011063
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play928011064(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0.45

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_1 = arg_272_1:FormatText(arg_272_1:GetWordFromCfg(928011063).content)

				arg_272_1.text_.text = var_275_1

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_3 = 18 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_1) / 18)

				if (18 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_1) / 18)) > 0 and var_275_0 < var_275_3 then
					arg_272_1.talkMaxDuration = var_275_3

					if var_275_3 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_3 + 0
					end
				end

				arg_272_1.text_.text = var_275_1
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_4 = math.max(var_275_0, arg_272_1.talkMaxDuration)

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_4 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - 0) / var_275_4

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= 0 + var_275_4 and arg_272_1.time_ < 0 + var_275_4 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play928011064 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 928011064
		arg_276_1.duration_ = 12.63

		local var_276_0 = {
			zh = 8,
			ja = 12.633
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play928011065(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(arg_276_1.actors_["1085ui_story"]) and arg_276_1.var_.characterEffect1085ui_story == nil then
				arg_276_1.var_.characterEffect1085ui_story = arg_276_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_0 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 and not isNil(arg_276_1.actors_["1085ui_story"]) then
				if arg_276_1.var_.characterEffect1085ui_story and not isNil(arg_276_1.actors_["1085ui_story"]) then
					arg_276_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 and not isNil(arg_276_1.actors_["1085ui_story"]) and arg_276_1.var_.characterEffect1085ui_story then
				arg_276_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_279_2 = 0
			local var_279_3 = 0.6

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_2 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_4 = arg_276_1:GetWordFromCfg(928011064)
				local var_279_5 = arg_276_1:FormatText(var_279_4.content)

				arg_276_1.text_.text = var_279_5

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_7 = 24 <= 0 and var_279_3 or var_279_3 * (utf8.len(var_279_5) / 24)

				if (24 <= 0 and var_279_3 or var_279_3 * (utf8.len(var_279_5) / 24)) > 0 and var_279_3 < var_279_7 then
					arg_276_1.talkMaxDuration = var_279_7

					if var_279_7 + var_279_2 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_7 + var_279_2
					end
				end

				arg_276_1.text_.text = var_279_5
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011064", "story_v_side_old_928011.awb") ~= 0 then
					local var_279_8 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011064", "story_v_side_old_928011.awb") / 1000

					if var_279_8 + var_279_2 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_8 + var_279_2
					end

					if var_279_4.prefab_name ~= "" and arg_276_1.actors_[var_279_4.prefab_name] ~= nil then
						local var_279_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_4.prefab_name].transform, "story_v_side_old_928011", "928011064", "story_v_side_old_928011.awb")

						arg_276_1:RecordAudio("928011064", var_279_9)
						arg_276_1:RecordAudio("928011064", var_279_9)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011064", "story_v_side_old_928011.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011064", "story_v_side_old_928011.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_10 = math.max(var_279_3, arg_276_1.talkMaxDuration)

			if var_279_2 <= arg_276_1.time_ and arg_276_1.time_ < var_279_2 + var_279_10 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_2) / var_279_10

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_2 + var_279_10 and arg_276_1.time_ < var_279_2 + var_279_10 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play928011065 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 928011065
		arg_280_1.duration_ = 7

		local var_280_0 = {
			zh = 4.866,
			ja = 7
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play928011066(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action424")
			end

			local var_283_0 = 0
			local var_283_1 = 0.45

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_2 = arg_280_1:GetWordFromCfg(928011065)
				local var_283_3 = arg_280_1:FormatText(var_283_2.content)

				arg_280_1.text_.text = var_283_3

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_5 = 18 <= 0 and var_283_1 or var_283_1 * (utf8.len(var_283_3) / 18)

				if (18 <= 0 and var_283_1 or var_283_1 * (utf8.len(var_283_3) / 18)) > 0 and var_283_1 < var_283_5 then
					arg_280_1.talkMaxDuration = var_283_5

					if var_283_5 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_5 + var_283_0
					end
				end

				arg_280_1.text_.text = var_283_3
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011065", "story_v_side_old_928011.awb") ~= 0 then
					local var_283_6 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011065", "story_v_side_old_928011.awb") / 1000

					if var_283_6 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_6 + var_283_0
					end

					if var_283_2.prefab_name ~= "" and arg_280_1.actors_[var_283_2.prefab_name] ~= nil then
						local var_283_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_2.prefab_name].transform, "story_v_side_old_928011", "928011065", "story_v_side_old_928011.awb")

						arg_280_1:RecordAudio("928011065", var_283_7)
						arg_280_1:RecordAudio("928011065", var_283_7)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011065", "story_v_side_old_928011.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011065", "story_v_side_old_928011.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_8 = math.max(var_283_1, arg_280_1.talkMaxDuration)

			if var_283_0 <= arg_280_1.time_ and arg_280_1.time_ < var_283_0 + var_283_8 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_0) / var_283_8

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_0 + var_283_8 and arg_280_1.time_ < var_283_0 + var_283_8 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play928011066 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 928011066
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play928011067(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(arg_284_1.actors_["1085ui_story"]) and arg_284_1.var_.characterEffect1085ui_story == nil then
				arg_284_1.var_.characterEffect1085ui_story = arg_284_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_0 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 and not isNil(arg_284_1.actors_["1085ui_story"]) then
				if arg_284_1.var_.characterEffect1085ui_story and not isNil(arg_284_1.actors_["1085ui_story"]) then
					arg_284_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_284_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_284_1.time_ - 0) / var_287_0)
				end
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 and not isNil(arg_284_1.actors_["1085ui_story"]) and arg_284_1.var_.characterEffect1085ui_story then
				arg_284_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_284_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_287_1 = 0
			local var_287_2 = 0.6

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_3 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(928011066).content)

				arg_284_1.text_.text = var_287_3

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_5 = 24 <= 0 and var_287_2 or var_287_2 * (utf8.len(var_287_3) / 24)

				if (24 <= 0 and var_287_2 or var_287_2 * (utf8.len(var_287_3) / 24)) > 0 and var_287_2 < var_287_5 then
					arg_284_1.talkMaxDuration = var_287_5

					if var_287_5 + var_287_1 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + var_287_1
					end
				end

				arg_284_1.text_.text = var_287_3
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_6 = math.max(var_287_2, arg_284_1.talkMaxDuration)

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_6 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_1) / var_287_6

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_1 + var_287_6 and arg_284_1.time_ < var_287_1 + var_287_6 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play928011067 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 928011067
		arg_288_1.duration_ = 4.43

		local var_288_0 = {
			zh = 3.466,
			ja = 4.433
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play928011068(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos1066ui_story = arg_288_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_291_0 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 then
				arg_288_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_288_1.time_ - 0) / var_291_0)
				arg_288_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_288_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1066ui_story"].transform.position).z)
				arg_288_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_288_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_288_1.actors_["1066ui_story"].transform.localEulerAngles = arg_288_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 then
				arg_288_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_288_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_288_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1066ui_story"].transform.position).z)
				arg_288_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_288_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_288_1.actors_["1066ui_story"].transform.localEulerAngles = arg_288_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_291_1 = arg_288_1.actors_["1085ui_story"].transform

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos1085ui_story = var_291_1.localPosition
			end

			local var_291_2 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_2 then
				var_291_1.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_288_1.time_ - 0) / var_291_2)
				var_291_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_291_1.position).x, (manager.ui.mainCamera.transform.position - var_291_1.position).y, (manager.ui.mainCamera.transform.position - var_291_1.position).z)
				var_291_1.localEulerAngles.z = 0
				var_291_1.localEulerAngles.x = 0
				var_291_1.localEulerAngles = var_291_1.localEulerAngles
			end

			if arg_288_1.time_ >= 0 + var_291_2 and arg_288_1.time_ < 0 + var_291_2 + arg_291_0 then
				var_291_1.localPosition = Vector3.New(0, 100, 0)
				var_291_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_291_1.position).x, (manager.ui.mainCamera.transform.position - var_291_1.position).y, (manager.ui.mainCamera.transform.position - var_291_1.position).z)
				var_291_1.localEulerAngles.z = 0
				var_291_1.localEulerAngles.x = 0
				var_291_1.localEulerAngles = var_291_1.localEulerAngles
			end

			local var_291_3 = arg_288_1.actors_["1066ui_story"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_3) and arg_288_1.var_.characterEffect1066ui_story == nil then
				arg_288_1.var_.characterEffect1066ui_story = var_291_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_4 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_4 and not isNil(var_291_3) then
				if arg_288_1.var_.characterEffect1066ui_story and not isNil(var_291_3) then
					arg_288_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= 0 + var_291_4 and arg_288_1.time_ < 0 + var_291_4 + arg_291_0 and not isNil(var_291_3) and arg_288_1.var_.characterEffect1066ui_story then
				arg_288_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_291_6 = 0
			local var_291_7 = 0.425

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_6 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_8 = arg_288_1:GetWordFromCfg(928011067)
				local var_291_9 = arg_288_1:FormatText(var_291_8.content)

				arg_288_1.text_.text = var_291_9

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_11 = 17 <= 0 and var_291_7 or var_291_7 * (utf8.len(var_291_9) / 17)

				if (17 <= 0 and var_291_7 or var_291_7 * (utf8.len(var_291_9) / 17)) > 0 and var_291_7 < var_291_11 then
					arg_288_1.talkMaxDuration = var_291_11

					if var_291_11 + var_291_6 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_11 + var_291_6
					end
				end

				arg_288_1.text_.text = var_291_9
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011067", "story_v_side_old_928011.awb") ~= 0 then
					local var_291_12 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011067", "story_v_side_old_928011.awb") / 1000

					if var_291_12 + var_291_6 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_12 + var_291_6
					end

					if var_291_8.prefab_name ~= "" and arg_288_1.actors_[var_291_8.prefab_name] ~= nil then
						local var_291_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_8.prefab_name].transform, "story_v_side_old_928011", "928011067", "story_v_side_old_928011.awb")

						arg_288_1:RecordAudio("928011067", var_291_13)
						arg_288_1:RecordAudio("928011067", var_291_13)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011067", "story_v_side_old_928011.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011067", "story_v_side_old_928011.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_14 = math.max(var_291_7, arg_288_1.talkMaxDuration)

			if var_291_6 <= arg_288_1.time_ and arg_288_1.time_ < var_291_6 + var_291_14 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_6) / var_291_14

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_6 + var_291_14 and arg_288_1.time_ < var_291_6 + var_291_14 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_288_1:InitPlayNodeList()
	end,
	Play928011068 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 928011068
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play928011069(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(arg_292_1.actors_["1066ui_story"]) and arg_292_1.var_.characterEffect1066ui_story == nil then
				arg_292_1.var_.characterEffect1066ui_story = arg_292_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_0 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 and not isNil(arg_292_1.actors_["1066ui_story"]) then
				if arg_292_1.var_.characterEffect1066ui_story and not isNil(arg_292_1.actors_["1066ui_story"]) then
					arg_292_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_292_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_292_1.time_ - 0) / var_295_0)
				end
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 and not isNil(arg_292_1.actors_["1066ui_story"]) and arg_292_1.var_.characterEffect1066ui_story then
				arg_292_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_292_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_295_1 = 0
			local var_295_2 = 0.3

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_3 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(928011068).content)

				arg_292_1.text_.text = var_295_3

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_5 = 12 <= 0 and var_295_2 or var_295_2 * (utf8.len(var_295_3) / 12)

				if (12 <= 0 and var_295_2 or var_295_2 * (utf8.len(var_295_3) / 12)) > 0 and var_295_2 < var_295_5 then
					arg_292_1.talkMaxDuration = var_295_5

					if var_295_5 + var_295_1 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_5 + var_295_1
					end
				end

				arg_292_1.text_.text = var_295_3
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_6 = math.max(var_295_2, arg_292_1.talkMaxDuration)

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_6 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_1) / var_295_6

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_1 + var_295_6 and arg_292_1.time_ < var_295_1 + var_295_6 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play928011069 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 928011069
		arg_296_1.duration_ = 6.67

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play928011070(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				local var_299_0 = arg_296_1.bgs_.ST2201

				arg_296_1.bgs_.ST2201.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_299_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_299_1 = var_299_0:GetComponent("SpriteRenderer")

				if var_299_1 and var_299_1.sprite then
					local var_299_2 = 2 * (var_299_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_299_0.transform.localScale = Vector3.New(var_299_2 / var_299_1.sprite.bounds.size.y < var_299_2 * manager.ui.mainCameraCom_.aspect / var_299_1.sprite.bounds.size.x and var_299_2 * manager.ui.mainCameraCom_.aspect / var_299_1.sprite.bounds.size.x or var_299_2 / var_299_1.sprite.bounds.size.y, var_299_2 / var_299_1.sprite.bounds.size.y < var_299_2 * manager.ui.mainCameraCom_.aspect / var_299_1.sprite.bounds.size.x and var_299_2 * manager.ui.mainCameraCom_.aspect / var_299_1.sprite.bounds.size.x or var_299_2 / var_299_1.sprite.bounds.size.y, 0)
				end

				for iter_299_0, iter_299_1 in pairs(arg_296_1.bgs_) do
					if iter_299_0 ~= "ST2201" then
						iter_299_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_299_3 = 0

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_3 + arg_299_0 then
				arg_296_1.allBtn_.enabled = false
			end

			if arg_296_1.time_ >= var_299_3 + 0.3 and arg_296_1.time_ < var_299_3 + 0.3 + arg_299_0 then
				arg_296_1.allBtn_.enabled = true
			end

			local var_299_4 = 0

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_4 + arg_299_0 then
				arg_296_1.mask_.enabled = true
				arg_296_1.mask_.raycastTarget = true

				arg_296_1:SetGaussion(false)
			end

			local var_299_5 = 0.766666666666667

			if var_299_4 <= arg_296_1.time_ and arg_296_1.time_ < var_299_4 + var_299_5 then
				local var_299_6 = Color.New(0, 0, 0)

				var_299_6.a = Mathf.Lerp(0, 1, (arg_296_1.time_ - var_299_4) / var_299_5)
				arg_296_1.mask_.color = var_299_6
			end

			if arg_296_1.time_ >= var_299_4 + var_299_5 and arg_296_1.time_ < var_299_4 + var_299_5 + arg_299_0 then
				local var_299_7 = Color.New(0, 0, 0)

				var_299_7.a = 1
				arg_296_1.mask_.color = var_299_7
			end

			local var_299_8 = 0.766666666666667

			if 0.766666666666667 < arg_296_1.time_ and arg_296_1.time_ <= var_299_8 + arg_299_0 then
				arg_296_1.mask_.enabled = true
				arg_296_1.mask_.raycastTarget = true

				arg_296_1:SetGaussion(false)
			end

			local var_299_9 = 0.9

			if var_299_8 <= arg_296_1.time_ and arg_296_1.time_ < var_299_8 + var_299_9 then
				local var_299_10 = Color.New(0, 0, 0)

				var_299_10.a = Mathf.Lerp(1, 0, (arg_296_1.time_ - var_299_8) / var_299_9)
				arg_296_1.mask_.color = var_299_10
			end

			if arg_296_1.time_ >= var_299_8 + var_299_9 and arg_296_1.time_ < var_299_8 + var_299_9 + arg_299_0 then
				local var_299_11 = Color.New(0, 0, 0)

				arg_296_1.mask_.enabled = false
				var_299_11.a = 0
				arg_296_1.mask_.color = var_299_11
			end

			local var_299_12 = arg_296_1.actors_["1066ui_story"].transform

			if 0.766666666666667 < arg_296_1.time_ and arg_296_1.time_ <= 0.766666666666667 + arg_299_0 then
				arg_296_1.var_.moveOldPos1066ui_story = var_299_12.localPosition
			end

			local var_299_13 = 0.001

			if 0.766666666666667 <= arg_296_1.time_ and arg_296_1.time_ < 0.766666666666667 + var_299_13 then
				var_299_12.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_296_1.time_ - 0.766666666666667) / var_299_13)
				var_299_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_12.position).x, (manager.ui.mainCamera.transform.position - var_299_12.position).y, (manager.ui.mainCamera.transform.position - var_299_12.position).z)
				var_299_12.localEulerAngles.z = 0
				var_299_12.localEulerAngles.x = 0
				var_299_12.localEulerAngles = var_299_12.localEulerAngles
			end

			if arg_296_1.time_ >= 0.766666666666667 + var_299_13 and arg_296_1.time_ < 0.766666666666667 + var_299_13 + arg_299_0 then
				var_299_12.localPosition = Vector3.New(0, 100, 0)
				var_299_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_12.position).x, (manager.ui.mainCamera.transform.position - var_299_12.position).y, (manager.ui.mainCamera.transform.position - var_299_12.position).z)
				var_299_12.localEulerAngles.z = 0
				var_299_12.localEulerAngles.x = 0
				var_299_12.localEulerAngles = var_299_12.localEulerAngles
			end

			if arg_296_1.frameCnt_ <= 1 then
				arg_296_1.dialog_:SetActive(false)
			end

			local var_299_14 = 1.66666666666667
			local var_299_15 = 0.95

			if 1.66666666666667 < arg_296_1.time_ and arg_296_1.time_ <= var_299_14 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0

				arg_296_1.dialog_:SetActive(true)

				arg_296_1.dialogCg_.alpha = 0

				local var_299_16 = LeanTween.value(arg_296_1.dialog_, 0, 1, 0.3)

				var_299_16:setOnUpdate(LuaHelper.FloatAction(function(arg_300_0)
					arg_296_1.dialogCg_.alpha = arg_300_0
				end))
				var_299_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_296_1.dialog_)
					var_299_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_296_1.duration_ = arg_296_1.duration_ + 0.3

				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_17 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(928011069).content)

				arg_296_1.text_.text = var_299_17

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_19 = 38 <= 0 and var_299_15 or var_299_15 * (utf8.len(var_299_17) / 38)

				if (38 <= 0 and var_299_15 or var_299_15 * (utf8.len(var_299_17) / 38)) > 0 and var_299_15 < var_299_19 then
					arg_296_1.talkMaxDuration = var_299_19
					var_299_14 = var_299_14 + 0.3

					if var_299_19 + var_299_14 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_19 + var_299_14
					end
				end

				arg_296_1.text_.text = var_299_17
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_20 = var_299_14 + 0.3
			local var_299_21 = math.max(var_299_15, arg_296_1.talkMaxDuration)

			if var_299_14 + 0.3 <= arg_296_1.time_ and arg_296_1.time_ < var_299_20 + var_299_21 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_20) / var_299_21

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_20 + var_299_21 and arg_296_1.time_ < var_299_20 + var_299_21 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.766666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play928011070 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 928011070
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play928011071(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0.75

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_1 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(928011070).content)

				arg_302_1.text_.text = var_305_1

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_3 = 30 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 30)

				if (30 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 30)) > 0 and var_305_0 < var_305_3 then
					arg_302_1.talkMaxDuration = var_305_3

					if var_305_3 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_3 + 0
					end
				end

				arg_302_1.text_.text = var_305_1
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_4 = math.max(var_305_0, arg_302_1.talkMaxDuration)

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_4 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - 0) / var_305_4

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= 0 + var_305_4 and arg_302_1.time_ < 0 + var_305_4 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play928011071 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 928011071
		arg_306_1.duration_ = 8.4

		local var_306_0 = {
			zh = 5.933,
			ja = 8.4
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play928011072(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos1066ui_story = arg_306_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_309_0 = 0.001

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 then
				arg_306_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_306_1.time_ - 0) / var_309_0)
				arg_306_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_306_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["1066ui_story"].transform.position).z)
				arg_306_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_306_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_306_1.actors_["1066ui_story"].transform.localEulerAngles = arg_306_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 then
				arg_306_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_306_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_306_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["1066ui_story"].transform.position).z)
				arg_306_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_306_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_306_1.actors_["1066ui_story"].transform.localEulerAngles = arg_306_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_309_1 = arg_306_1.actors_["1066ui_story"]

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(var_309_1) and arg_306_1.var_.characterEffect1066ui_story == nil then
				arg_306_1.var_.characterEffect1066ui_story = var_309_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_2 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_2 and not isNil(var_309_1) then
				if arg_306_1.var_.characterEffect1066ui_story and not isNil(var_309_1) then
					arg_306_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_306_1.time_ >= 0 + var_309_2 and arg_306_1.time_ < 0 + var_309_2 + arg_309_0 and not isNil(var_309_1) and arg_306_1.var_.characterEffect1066ui_story then
				arg_306_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_309_4 = 0
			local var_309_5 = 0.75

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_4 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_6 = arg_306_1:GetWordFromCfg(928011071)
				local var_309_7 = arg_306_1:FormatText(var_309_6.content)

				arg_306_1.text_.text = var_309_7

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_9 = 30 <= 0 and var_309_5 or var_309_5 * (utf8.len(var_309_7) / 30)

				if (30 <= 0 and var_309_5 or var_309_5 * (utf8.len(var_309_7) / 30)) > 0 and var_309_5 < var_309_9 then
					arg_306_1.talkMaxDuration = var_309_9

					if var_309_9 + var_309_4 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_9 + var_309_4
					end
				end

				arg_306_1.text_.text = var_309_7
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011071", "story_v_side_old_928011.awb") ~= 0 then
					local var_309_10 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011071", "story_v_side_old_928011.awb") / 1000

					if var_309_10 + var_309_4 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_10 + var_309_4
					end

					if var_309_6.prefab_name ~= "" and arg_306_1.actors_[var_309_6.prefab_name] ~= nil then
						local var_309_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_6.prefab_name].transform, "story_v_side_old_928011", "928011071", "story_v_side_old_928011.awb")

						arg_306_1:RecordAudio("928011071", var_309_11)
						arg_306_1:RecordAudio("928011071", var_309_11)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011071", "story_v_side_old_928011.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011071", "story_v_side_old_928011.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_12 = math.max(var_309_5, arg_306_1.talkMaxDuration)

			if var_309_4 <= arg_306_1.time_ and arg_306_1.time_ < var_309_4 + var_309_12 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_4) / var_309_12

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_4 + var_309_12 and arg_306_1.time_ < var_309_4 + var_309_12 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play928011072 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 928011072
		arg_310_1.duration_ = 10.27

		local var_310_0 = {
			zh = 10.266,
			ja = 9.7
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play928011073(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_2")
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_313_0 = 0
			local var_313_1 = 1.125

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_2 = arg_310_1:GetWordFromCfg(928011072)
				local var_313_3 = arg_310_1:FormatText(var_313_2.content)

				arg_310_1.text_.text = var_313_3

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_5 = 45 <= 0 and var_313_1 or var_313_1 * (utf8.len(var_313_3) / 45)

				if (45 <= 0 and var_313_1 or var_313_1 * (utf8.len(var_313_3) / 45)) > 0 and var_313_1 < var_313_5 then
					arg_310_1.talkMaxDuration = var_313_5

					if var_313_5 + var_313_0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_5 + var_313_0
					end
				end

				arg_310_1.text_.text = var_313_3
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011072", "story_v_side_old_928011.awb") ~= 0 then
					local var_313_6 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011072", "story_v_side_old_928011.awb") / 1000

					if var_313_6 + var_313_0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_6 + var_313_0
					end

					if var_313_2.prefab_name ~= "" and arg_310_1.actors_[var_313_2.prefab_name] ~= nil then
						local var_313_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_2.prefab_name].transform, "story_v_side_old_928011", "928011072", "story_v_side_old_928011.awb")

						arg_310_1:RecordAudio("928011072", var_313_7)
						arg_310_1:RecordAudio("928011072", var_313_7)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011072", "story_v_side_old_928011.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011072", "story_v_side_old_928011.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_8 = math.max(var_313_1, arg_310_1.talkMaxDuration)

			if var_313_0 <= arg_310_1.time_ and arg_310_1.time_ < var_313_0 + var_313_8 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_0) / var_313_8

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_0 + var_313_8 and arg_310_1.time_ < var_313_0 + var_313_8 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play928011073 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 928011073
		arg_314_1.duration_ = 10.7

		local var_314_0 = {
			zh = 10.7,
			ja = 9.7
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play928011074(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 1.3

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_1 = arg_314_1:GetWordFromCfg(928011073)
				local var_317_2 = arg_314_1:FormatText(var_317_1.content)

				arg_314_1.text_.text = var_317_2

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_4 = 52 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_2) / 52)

				if (52 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_2) / 52)) > 0 and var_317_0 < var_317_4 then
					arg_314_1.talkMaxDuration = var_317_4

					if var_317_4 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_4 + 0
					end
				end

				arg_314_1.text_.text = var_317_2
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011073", "story_v_side_old_928011.awb") ~= 0 then
					local var_317_5 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011073", "story_v_side_old_928011.awb") / 1000

					if var_317_5 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + 0
					end

					if var_317_1.prefab_name ~= "" and arg_314_1.actors_[var_317_1.prefab_name] ~= nil then
						local var_317_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_1.prefab_name].transform, "story_v_side_old_928011", "928011073", "story_v_side_old_928011.awb")

						arg_314_1:RecordAudio("928011073", var_317_6)
						arg_314_1:RecordAudio("928011073", var_317_6)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011073", "story_v_side_old_928011.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011073", "story_v_side_old_928011.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_7 = math.max(var_317_0, arg_314_1.talkMaxDuration)

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_7 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - 0) / var_317_7

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= 0 + var_317_7 and arg_314_1.time_ < 0 + var_317_7 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play928011074 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 928011074
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play928011075(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["1066ui_story"]) and arg_318_1.var_.characterEffect1066ui_story == nil then
				arg_318_1.var_.characterEffect1066ui_story = arg_318_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_0 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["1066ui_story"]) then
				if arg_318_1.var_.characterEffect1066ui_story and not isNil(arg_318_1.actors_["1066ui_story"]) then
					arg_318_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_318_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_318_1.time_ - 0) / var_321_0)
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["1066ui_story"]) and arg_318_1.var_.characterEffect1066ui_story then
				arg_318_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_318_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_321_1 = 0
			local var_321_2 = 0.5

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_3 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(928011074).content)

				arg_318_1.text_.text = var_321_3

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 20 <= 0 and var_321_2 or var_321_2 * (utf8.len(var_321_3) / 20)

				if (20 <= 0 and var_321_2 or var_321_2 * (utf8.len(var_321_3) / 20)) > 0 and var_321_2 < var_321_5 then
					arg_318_1.talkMaxDuration = var_321_5

					if var_321_5 + var_321_1 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_5 + var_321_1
					end
				end

				arg_318_1.text_.text = var_321_3
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_6 = math.max(var_321_2, arg_318_1.talkMaxDuration)

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_6 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_1) / var_321_6

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_1 + var_321_6 and arg_318_1.time_ < var_321_1 + var_321_6 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play928011075 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 928011075
		arg_322_1.duration_ = 6.97

		local var_322_0 = {
			zh = 5.4,
			ja = 6.966
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play928011076(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["1066ui_story"]) and arg_322_1.var_.characterEffect1066ui_story == nil then
				arg_322_1.var_.characterEffect1066ui_story = arg_322_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_0 = 0.200000002980232

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["1066ui_story"]) then
				if arg_322_1.var_.characterEffect1066ui_story and not isNil(arg_322_1.actors_["1066ui_story"]) then
					arg_322_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["1066ui_story"]) and arg_322_1.var_.characterEffect1066ui_story then
				arg_322_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_325_2 = 0
			local var_325_3 = 0.65

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_2 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_4 = arg_322_1:GetWordFromCfg(928011075)
				local var_325_5 = arg_322_1:FormatText(var_325_4.content)

				arg_322_1.text_.text = var_325_5

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_7 = 26 <= 0 and var_325_3 or var_325_3 * (utf8.len(var_325_5) / 26)

				if (26 <= 0 and var_325_3 or var_325_3 * (utf8.len(var_325_5) / 26)) > 0 and var_325_3 < var_325_7 then
					arg_322_1.talkMaxDuration = var_325_7

					if var_325_7 + var_325_2 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_7 + var_325_2
					end
				end

				arg_322_1.text_.text = var_325_5
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011075", "story_v_side_old_928011.awb") ~= 0 then
					local var_325_8 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011075", "story_v_side_old_928011.awb") / 1000

					if var_325_8 + var_325_2 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_8 + var_325_2
					end

					if var_325_4.prefab_name ~= "" and arg_322_1.actors_[var_325_4.prefab_name] ~= nil then
						local var_325_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_4.prefab_name].transform, "story_v_side_old_928011", "928011075", "story_v_side_old_928011.awb")

						arg_322_1:RecordAudio("928011075", var_325_9)
						arg_322_1:RecordAudio("928011075", var_325_9)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011075", "story_v_side_old_928011.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011075", "story_v_side_old_928011.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_10 = math.max(var_325_3, arg_322_1.talkMaxDuration)

			if var_325_2 <= arg_322_1.time_ and arg_322_1.time_ < var_325_2 + var_325_10 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_2) / var_325_10

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_2 + var_325_10 and arg_322_1.time_ < var_325_2 + var_325_10 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play928011076 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 928011076
		arg_326_1.duration_ = 8.8

		local var_326_0 = {
			zh = 5.266,
			ja = 8.8
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play928011077(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0.7

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_1 = arg_326_1:GetWordFromCfg(928011076)
				local var_329_2 = arg_326_1:FormatText(var_329_1.content)

				arg_326_1.text_.text = var_329_2

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_4 = 28 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 28)

				if (28 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 28)) > 0 and var_329_0 < var_329_4 then
					arg_326_1.talkMaxDuration = var_329_4

					if var_329_4 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_4 + 0
					end
				end

				arg_326_1.text_.text = var_329_2
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011076", "story_v_side_old_928011.awb") ~= 0 then
					local var_329_5 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011076", "story_v_side_old_928011.awb") / 1000

					if var_329_5 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_5 + 0
					end

					if var_329_1.prefab_name ~= "" and arg_326_1.actors_[var_329_1.prefab_name] ~= nil then
						local var_329_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_1.prefab_name].transform, "story_v_side_old_928011", "928011076", "story_v_side_old_928011.awb")

						arg_326_1:RecordAudio("928011076", var_329_6)
						arg_326_1:RecordAudio("928011076", var_329_6)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011076", "story_v_side_old_928011.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011076", "story_v_side_old_928011.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_7 = math.max(var_329_0, arg_326_1.talkMaxDuration)

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_7 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - 0) / var_329_7

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= 0 + var_329_7 and arg_326_1.time_ < 0 + var_329_7 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play928011077 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 928011077
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play928011078(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["1066ui_story"]) and arg_330_1.var_.characterEffect1066ui_story == nil then
				arg_330_1.var_.characterEffect1066ui_story = arg_330_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_0 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["1066ui_story"]) then
				if arg_330_1.var_.characterEffect1066ui_story and not isNil(arg_330_1.actors_["1066ui_story"]) then
					arg_330_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_330_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_330_1.time_ - 0) / var_333_0)
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["1066ui_story"]) and arg_330_1.var_.characterEffect1066ui_story then
				arg_330_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_330_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_333_1 = 0
			local var_333_2 = 0.15

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_3 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(928011077).content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 6 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 6)

				if (6 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 6)) > 0 and var_333_2 < var_333_5 then
					arg_330_1.talkMaxDuration = var_333_5

					if var_333_5 + var_333_1 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + var_333_1
					end
				end

				arg_330_1.text_.text = var_333_3
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_6 = math.max(var_333_2, arg_330_1.talkMaxDuration)

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_6 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_1) / var_333_6

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_1 + var_333_6 and arg_330_1.time_ < var_333_1 + var_333_6 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play928011078 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 928011078
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play928011079(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0.475

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_1 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(928011078).content)

				arg_334_1.text_.text = var_337_1

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_3 = 19 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_1) / 19)

				if (19 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_1) / 19)) > 0 and var_337_0 < var_337_3 then
					arg_334_1.talkMaxDuration = var_337_3

					if var_337_3 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_3 + 0
					end
				end

				arg_334_1.text_.text = var_337_1
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_4 = math.max(var_337_0, arg_334_1.talkMaxDuration)

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_4 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - 0) / var_337_4

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= 0 + var_337_4 and arg_334_1.time_ < 0 + var_337_4 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play928011079 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 928011079
		arg_338_1.duration_ = 10.57

		local var_338_0 = {
			zh = 6.133,
			ja = 10.566
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play928011080(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["1066ui_story"]) and arg_338_1.var_.characterEffect1066ui_story == nil then
				arg_338_1.var_.characterEffect1066ui_story = arg_338_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_0 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["1066ui_story"]) then
				if arg_338_1.var_.characterEffect1066ui_story and not isNil(arg_338_1.actors_["1066ui_story"]) then
					arg_338_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["1066ui_story"]) and arg_338_1.var_.characterEffect1066ui_story then
				arg_338_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_2")
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_341_2 = 0
			local var_341_3 = 0.825

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_2 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_4 = arg_338_1:GetWordFromCfg(928011079)
				local var_341_5 = arg_338_1:FormatText(var_341_4.content)

				arg_338_1.text_.text = var_341_5

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_7 = 33 <= 0 and var_341_3 or var_341_3 * (utf8.len(var_341_5) / 33)

				if (33 <= 0 and var_341_3 or var_341_3 * (utf8.len(var_341_5) / 33)) > 0 and var_341_3 < var_341_7 then
					arg_338_1.talkMaxDuration = var_341_7

					if var_341_7 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_7 + var_341_2
					end
				end

				arg_338_1.text_.text = var_341_5
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011079", "story_v_side_old_928011.awb") ~= 0 then
					local var_341_8 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011079", "story_v_side_old_928011.awb") / 1000

					if var_341_8 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_8 + var_341_2
					end

					if var_341_4.prefab_name ~= "" and arg_338_1.actors_[var_341_4.prefab_name] ~= nil then
						local var_341_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_4.prefab_name].transform, "story_v_side_old_928011", "928011079", "story_v_side_old_928011.awb")

						arg_338_1:RecordAudio("928011079", var_341_9)
						arg_338_1:RecordAudio("928011079", var_341_9)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011079", "story_v_side_old_928011.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011079", "story_v_side_old_928011.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_10 = math.max(var_341_3, arg_338_1.talkMaxDuration)

			if var_341_2 <= arg_338_1.time_ and arg_338_1.time_ < var_341_2 + var_341_10 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_2) / var_341_10

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_2 + var_341_10 and arg_338_1.time_ < var_341_2 + var_341_10 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play928011080 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 928011080
		arg_342_1.duration_ = 6.87

		local var_342_0 = {
			zh = 4.866,
			ja = 6.866
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play928011081(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0.575

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_1 = arg_342_1:GetWordFromCfg(928011080)
				local var_345_2 = arg_342_1:FormatText(var_345_1.content)

				arg_342_1.text_.text = var_345_2

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_4 = 23 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_2) / 23)

				if (23 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_2) / 23)) > 0 and var_345_0 < var_345_4 then
					arg_342_1.talkMaxDuration = var_345_4

					if var_345_4 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_4 + 0
					end
				end

				arg_342_1.text_.text = var_345_2
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011080", "story_v_side_old_928011.awb") ~= 0 then
					local var_345_5 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011080", "story_v_side_old_928011.awb") / 1000

					if var_345_5 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_5 + 0
					end

					if var_345_1.prefab_name ~= "" and arg_342_1.actors_[var_345_1.prefab_name] ~= nil then
						local var_345_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_1.prefab_name].transform, "story_v_side_old_928011", "928011080", "story_v_side_old_928011.awb")

						arg_342_1:RecordAudio("928011080", var_345_6)
						arg_342_1:RecordAudio("928011080", var_345_6)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011080", "story_v_side_old_928011.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011080", "story_v_side_old_928011.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_7 = math.max(var_345_0, arg_342_1.talkMaxDuration)

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_7 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - 0) / var_345_7

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= 0 + var_345_7 and arg_342_1.time_ < 0 + var_345_7 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play928011081 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 928011081
		arg_346_1.duration_ = 9.73

		local var_346_0 = {
			zh = 7.3,
			ja = 9.733
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play928011082(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos1033ui_story = arg_346_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_349_0 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 then
				arg_346_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_346_1.time_ - 0) / var_349_0)
				arg_346_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_346_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["1033ui_story"].transform.position).z)
				arg_346_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_346_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_346_1.actors_["1033ui_story"].transform.localEulerAngles = arg_346_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 then
				arg_346_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				arg_346_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_346_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["1033ui_story"].transform.position).z)
				arg_346_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_346_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_346_1.actors_["1033ui_story"].transform.localEulerAngles = arg_346_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_349_1 = arg_346_1.actors_["1066ui_story"].transform

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos1066ui_story = var_349_1.localPosition
			end

			local var_349_2 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_2 then
				var_349_1.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (arg_346_1.time_ - 0) / var_349_2)
				var_349_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_349_1.position).x, (manager.ui.mainCamera.transform.position - var_349_1.position).y, (manager.ui.mainCamera.transform.position - var_349_1.position).z)
				var_349_1.localEulerAngles.z = 0
				var_349_1.localEulerAngles.x = 0
				var_349_1.localEulerAngles = var_349_1.localEulerAngles
			end

			if arg_346_1.time_ >= 0 + var_349_2 and arg_346_1.time_ < 0 + var_349_2 + arg_349_0 then
				var_349_1.localPosition = Vector3.New(0.7, -0.77, -6.1)
				var_349_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_349_1.position).x, (manager.ui.mainCamera.transform.position - var_349_1.position).y, (manager.ui.mainCamera.transform.position - var_349_1.position).z)
				var_349_1.localEulerAngles.z = 0
				var_349_1.localEulerAngles.x = 0
				var_349_1.localEulerAngles = var_349_1.localEulerAngles
			end

			local var_349_3 = arg_346_1.actors_["1033ui_story"]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(var_349_3) and arg_346_1.var_.characterEffect1033ui_story == nil then
				arg_346_1.var_.characterEffect1033ui_story = var_349_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_4 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_4 and not isNil(var_349_3) then
				if arg_346_1.var_.characterEffect1033ui_story and not isNil(var_349_3) then
					arg_346_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= 0 + var_349_4 and arg_346_1.time_ < 0 + var_349_4 + arg_349_0 and not isNil(var_349_3) and arg_346_1.var_.characterEffect1033ui_story then
				arg_346_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_349_6 = arg_346_1.actors_["1066ui_story"]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(var_349_6) and arg_346_1.var_.characterEffect1066ui_story == nil then
				arg_346_1.var_.characterEffect1066ui_story = var_349_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_7 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_7 and not isNil(var_349_6) then
				if arg_346_1.var_.characterEffect1066ui_story and not isNil(var_349_6) then
					arg_346_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_346_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_346_1.time_ - 0) / var_349_7)
				end
			end

			if arg_346_1.time_ >= 0 + var_349_7 and arg_346_1.time_ < 0 + var_349_7 + arg_349_0 and not isNil(var_349_6) and arg_346_1.var_.characterEffect1066ui_story then
				arg_346_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_346_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_349_8 = 0
			local var_349_9 = 1.025

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_8 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_10 = arg_346_1:GetWordFromCfg(928011081)
				local var_349_11 = arg_346_1:FormatText(var_349_10.content)

				arg_346_1.text_.text = var_349_11

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_13 = 41 <= 0 and var_349_9 or var_349_9 * (utf8.len(var_349_11) / 41)

				if (41 <= 0 and var_349_9 or var_349_9 * (utf8.len(var_349_11) / 41)) > 0 and var_349_9 < var_349_13 then
					arg_346_1.talkMaxDuration = var_349_13

					if var_349_13 + var_349_8 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_13 + var_349_8
					end
				end

				arg_346_1.text_.text = var_349_11
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011081", "story_v_side_old_928011.awb") ~= 0 then
					local var_349_14 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011081", "story_v_side_old_928011.awb") / 1000

					if var_349_14 + var_349_8 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_14 + var_349_8
					end

					if var_349_10.prefab_name ~= "" and arg_346_1.actors_[var_349_10.prefab_name] ~= nil then
						local var_349_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_10.prefab_name].transform, "story_v_side_old_928011", "928011081", "story_v_side_old_928011.awb")

						arg_346_1:RecordAudio("928011081", var_349_15)
						arg_346_1:RecordAudio("928011081", var_349_15)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011081", "story_v_side_old_928011.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011081", "story_v_side_old_928011.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_16 = math.max(var_349_9, arg_346_1.talkMaxDuration)

			if var_349_8 <= arg_346_1.time_ and arg_346_1.time_ < var_349_8 + var_349_16 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_8) / var_349_16

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_8 + var_349_16 and arg_346_1.time_ < var_349_8 + var_349_16 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play928011082 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 928011082
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play928011083(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["1033ui_story"]) and arg_350_1.var_.characterEffect1033ui_story == nil then
				arg_350_1.var_.characterEffect1033ui_story = arg_350_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_0 = 0.200000002980232

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["1033ui_story"]) then
				if arg_350_1.var_.characterEffect1033ui_story and not isNil(arg_350_1.actors_["1033ui_story"]) then
					arg_350_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_350_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_350_1.time_ - 0) / var_353_0)
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["1033ui_story"]) and arg_350_1.var_.characterEffect1033ui_story then
				arg_350_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_350_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_353_1 = 0
			local var_353_2 = 0.575

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, true)
				arg_350_1.iconController_:SetSelectedState("hero")

				arg_350_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_350_1.callingController_:SetSelectedState("normal")

				arg_350_1.keyicon_.color = Color.New(1, 1, 1)
				arg_350_1.icon_.color = Color.New(1, 1, 1)

				local var_353_3 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(928011082).content)

				arg_350_1.text_.text = var_353_3

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_5 = 23 <= 0 and var_353_2 or var_353_2 * (utf8.len(var_353_3) / 23)

				if (23 <= 0 and var_353_2 or var_353_2 * (utf8.len(var_353_3) / 23)) > 0 and var_353_2 < var_353_5 then
					arg_350_1.talkMaxDuration = var_353_5

					if var_353_5 + var_353_1 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_5 + var_353_1
					end
				end

				arg_350_1.text_.text = var_353_3
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_6 = math.max(var_353_2, arg_350_1.talkMaxDuration)

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_6 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_1) / var_353_6

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_1 + var_353_6 and arg_350_1.time_ < var_353_1 + var_353_6 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play928011083 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 928011083
		arg_354_1.duration_ = 7.73

		local var_354_0 = {
			zh = 6,
			ja = 7.733
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play928011084(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(arg_354_1.actors_["1066ui_story"]) and arg_354_1.var_.characterEffect1066ui_story == nil then
				arg_354_1.var_.characterEffect1066ui_story = arg_354_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_0 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 and not isNil(arg_354_1.actors_["1066ui_story"]) then
				if arg_354_1.var_.characterEffect1066ui_story and not isNil(arg_354_1.actors_["1066ui_story"]) then
					arg_354_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 and not isNil(arg_354_1.actors_["1066ui_story"]) and arg_354_1.var_.characterEffect1066ui_story then
				arg_354_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_357_2 = 0
			local var_357_3 = 0.75

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_2 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_4 = arg_354_1:GetWordFromCfg(928011083)
				local var_357_5 = arg_354_1:FormatText(var_357_4.content)

				arg_354_1.text_.text = var_357_5

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_7 = 30 <= 0 and var_357_3 or var_357_3 * (utf8.len(var_357_5) / 30)

				if (30 <= 0 and var_357_3 or var_357_3 * (utf8.len(var_357_5) / 30)) > 0 and var_357_3 < var_357_7 then
					arg_354_1.talkMaxDuration = var_357_7

					if var_357_7 + var_357_2 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_7 + var_357_2
					end
				end

				arg_354_1.text_.text = var_357_5
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011083", "story_v_side_old_928011.awb") ~= 0 then
					local var_357_8 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011083", "story_v_side_old_928011.awb") / 1000

					if var_357_8 + var_357_2 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_8 + var_357_2
					end

					if var_357_4.prefab_name ~= "" and arg_354_1.actors_[var_357_4.prefab_name] ~= nil then
						local var_357_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_4.prefab_name].transform, "story_v_side_old_928011", "928011083", "story_v_side_old_928011.awb")

						arg_354_1:RecordAudio("928011083", var_357_9)
						arg_354_1:RecordAudio("928011083", var_357_9)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011083", "story_v_side_old_928011.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011083", "story_v_side_old_928011.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_10 = math.max(var_357_3, arg_354_1.talkMaxDuration)

			if var_357_2 <= arg_354_1.time_ and arg_354_1.time_ < var_357_2 + var_357_10 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_2) / var_357_10

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_2 + var_357_10 and arg_354_1.time_ < var_357_2 + var_357_10 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play928011084 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 928011084
		arg_358_1.duration_ = 7.37

		local var_358_0 = {
			zh = 4.233,
			ja = 7.366
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play928011085(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0.425

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_1 = arg_358_1:GetWordFromCfg(928011084)
				local var_361_2 = arg_358_1:FormatText(var_361_1.content)

				arg_358_1.text_.text = var_361_2

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_4 = 17 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_2) / 17)

				if (17 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_2) / 17)) > 0 and var_361_0 < var_361_4 then
					arg_358_1.talkMaxDuration = var_361_4

					if var_361_4 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_4 + 0
					end
				end

				arg_358_1.text_.text = var_361_2
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011084", "story_v_side_old_928011.awb") ~= 0 then
					local var_361_5 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011084", "story_v_side_old_928011.awb") / 1000

					if var_361_5 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_5 + 0
					end

					if var_361_1.prefab_name ~= "" and arg_358_1.actors_[var_361_1.prefab_name] ~= nil then
						local var_361_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_1.prefab_name].transform, "story_v_side_old_928011", "928011084", "story_v_side_old_928011.awb")

						arg_358_1:RecordAudio("928011084", var_361_6)
						arg_358_1:RecordAudio("928011084", var_361_6)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011084", "story_v_side_old_928011.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011084", "story_v_side_old_928011.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_7 = math.max(var_361_0, arg_358_1.talkMaxDuration)

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_7 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - 0) / var_361_7

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= 0 + var_361_7 and arg_358_1.time_ < 0 + var_361_7 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play928011085 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 928011085
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play928011086(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["1066ui_story"]) and arg_362_1.var_.characterEffect1066ui_story == nil then
				arg_362_1.var_.characterEffect1066ui_story = arg_362_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_0 = 0.200000002980232

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["1066ui_story"]) then
				if arg_362_1.var_.characterEffect1066ui_story and not isNil(arg_362_1.actors_["1066ui_story"]) then
					arg_362_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_362_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_362_1.time_ - 0) / var_365_0)
				end
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["1066ui_story"]) and arg_362_1.var_.characterEffect1066ui_story then
				arg_362_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_362_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_365_1 = 0
			local var_365_2 = 0.175

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_3 = arg_362_1:FormatText(arg_362_1:GetWordFromCfg(928011085).content)

				arg_362_1.text_.text = var_365_3

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_5 = 7 <= 0 and var_365_2 or var_365_2 * (utf8.len(var_365_3) / 7)

				if (7 <= 0 and var_365_2 or var_365_2 * (utf8.len(var_365_3) / 7)) > 0 and var_365_2 < var_365_5 then
					arg_362_1.talkMaxDuration = var_365_5

					if var_365_5 + var_365_1 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + var_365_1
					end
				end

				arg_362_1.text_.text = var_365_3
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_6 = math.max(var_365_2, arg_362_1.talkMaxDuration)

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_6 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_1) / var_365_6

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_1 + var_365_6 and arg_362_1.time_ < var_365_1 + var_365_6 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play928011086 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 928011086
		arg_366_1.duration_ = 11.1

		local var_366_0 = {
			zh = 7.866,
			ja = 11.1
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play928011087(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(arg_366_1.actors_["1033ui_story"]) and arg_366_1.var_.characterEffect1033ui_story == nil then
				arg_366_1.var_.characterEffect1033ui_story = arg_366_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_0 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 and not isNil(arg_366_1.actors_["1033ui_story"]) then
				if arg_366_1.var_.characterEffect1033ui_story and not isNil(arg_366_1.actors_["1033ui_story"]) then
					arg_366_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 and not isNil(arg_366_1.actors_["1033ui_story"]) and arg_366_1.var_.characterEffect1033ui_story then
				arg_366_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_2")
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_369_2 = 0
			local var_369_3 = 1.05

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_2 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_4 = arg_366_1:GetWordFromCfg(928011086)
				local var_369_5 = arg_366_1:FormatText(var_369_4.content)

				arg_366_1.text_.text = var_369_5

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_7 = 42 <= 0 and var_369_3 or var_369_3 * (utf8.len(var_369_5) / 42)

				if (42 <= 0 and var_369_3 or var_369_3 * (utf8.len(var_369_5) / 42)) > 0 and var_369_3 < var_369_7 then
					arg_366_1.talkMaxDuration = var_369_7

					if var_369_7 + var_369_2 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_7 + var_369_2
					end
				end

				arg_366_1.text_.text = var_369_5
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011086", "story_v_side_old_928011.awb") ~= 0 then
					local var_369_8 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011086", "story_v_side_old_928011.awb") / 1000

					if var_369_8 + var_369_2 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_8 + var_369_2
					end

					if var_369_4.prefab_name ~= "" and arg_366_1.actors_[var_369_4.prefab_name] ~= nil then
						local var_369_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_4.prefab_name].transform, "story_v_side_old_928011", "928011086", "story_v_side_old_928011.awb")

						arg_366_1:RecordAudio("928011086", var_369_9)
						arg_366_1:RecordAudio("928011086", var_369_9)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011086", "story_v_side_old_928011.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011086", "story_v_side_old_928011.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_10 = math.max(var_369_3, arg_366_1.talkMaxDuration)

			if var_369_2 <= arg_366_1.time_ and arg_366_1.time_ < var_369_2 + var_369_10 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_2) / var_369_10

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_2 + var_369_10 and arg_366_1.time_ < var_369_2 + var_369_10 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play928011087 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 928011087
		arg_370_1.duration_ = 10.4

		local var_370_0 = {
			zh = 7.933,
			ja = 10.4
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play928011088(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 1.075

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_1 = arg_370_1:GetWordFromCfg(928011087)
				local var_373_2 = arg_370_1:FormatText(var_373_1.content)

				arg_370_1.text_.text = var_373_2

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_4 = 43 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_2) / 43)

				if (43 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_2) / 43)) > 0 and var_373_0 < var_373_4 then
					arg_370_1.talkMaxDuration = var_373_4

					if var_373_4 + 0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_4 + 0
					end
				end

				arg_370_1.text_.text = var_373_2
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011087", "story_v_side_old_928011.awb") ~= 0 then
					local var_373_5 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011087", "story_v_side_old_928011.awb") / 1000

					if var_373_5 + 0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_5 + 0
					end

					if var_373_1.prefab_name ~= "" and arg_370_1.actors_[var_373_1.prefab_name] ~= nil then
						local var_373_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_1.prefab_name].transform, "story_v_side_old_928011", "928011087", "story_v_side_old_928011.awb")

						arg_370_1:RecordAudio("928011087", var_373_6)
						arg_370_1:RecordAudio("928011087", var_373_6)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011087", "story_v_side_old_928011.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011087", "story_v_side_old_928011.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_7 = math.max(var_373_0, arg_370_1.talkMaxDuration)

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_7 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - 0) / var_373_7

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= 0 + var_373_7 and arg_370_1.time_ < 0 + var_373_7 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play928011088 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 928011088
		arg_374_1.duration_ = 14.8

		local var_374_0 = {
			zh = 6.733,
			ja = 14.8
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play928011089(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0.925

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_1 = arg_374_1:GetWordFromCfg(928011088)
				local var_377_2 = arg_374_1:FormatText(var_377_1.content)

				arg_374_1.text_.text = var_377_2

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_4 = 37 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 37)

				if (37 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 37)) > 0 and var_377_0 < var_377_4 then
					arg_374_1.talkMaxDuration = var_377_4

					if var_377_4 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_4 + 0
					end
				end

				arg_374_1.text_.text = var_377_2
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011088", "story_v_side_old_928011.awb") ~= 0 then
					local var_377_5 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011088", "story_v_side_old_928011.awb") / 1000

					if var_377_5 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_5 + 0
					end

					if var_377_1.prefab_name ~= "" and arg_374_1.actors_[var_377_1.prefab_name] ~= nil then
						local var_377_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_1.prefab_name].transform, "story_v_side_old_928011", "928011088", "story_v_side_old_928011.awb")

						arg_374_1:RecordAudio("928011088", var_377_6)
						arg_374_1:RecordAudio("928011088", var_377_6)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011088", "story_v_side_old_928011.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011088", "story_v_side_old_928011.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_7 = math.max(var_377_0, arg_374_1.talkMaxDuration)

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_7 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - 0) / var_377_7

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= 0 + var_377_7 and arg_374_1.time_ < 0 + var_377_7 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play928011089 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 928011089
		arg_378_1.duration_ = 10.8

		local var_378_0 = {
			zh = 8.266,
			ja = 10.8
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play928011090(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(arg_378_1.actors_["1066ui_story"]) and arg_378_1.var_.characterEffect1066ui_story == nil then
				arg_378_1.var_.characterEffect1066ui_story = arg_378_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_0 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 and not isNil(arg_378_1.actors_["1066ui_story"]) then
				if arg_378_1.var_.characterEffect1066ui_story and not isNil(arg_378_1.actors_["1066ui_story"]) then
					arg_378_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 and not isNil(arg_378_1.actors_["1066ui_story"]) and arg_378_1.var_.characterEffect1066ui_story then
				arg_378_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_381_2 = arg_378_1.actors_["1033ui_story"]

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(var_381_2) and arg_378_1.var_.characterEffect1033ui_story == nil then
				arg_378_1.var_.characterEffect1033ui_story = var_381_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_3 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_3 and not isNil(var_381_2) then
				if arg_378_1.var_.characterEffect1033ui_story and not isNil(var_381_2) then
					arg_378_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_378_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_378_1.time_ - 0) / var_381_3)
				end
			end

			if arg_378_1.time_ >= 0 + var_381_3 and arg_378_1.time_ < 0 + var_381_3 + arg_381_0 and not isNil(var_381_2) and arg_378_1.var_.characterEffect1033ui_story then
				arg_378_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_378_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_381_4 = 0
			local var_381_5 = 0.95

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_4 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_6 = arg_378_1:GetWordFromCfg(928011089)
				local var_381_7 = arg_378_1:FormatText(var_381_6.content)

				arg_378_1.text_.text = var_381_7

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_9 = 38 <= 0 and var_381_5 or var_381_5 * (utf8.len(var_381_7) / 38)

				if (38 <= 0 and var_381_5 or var_381_5 * (utf8.len(var_381_7) / 38)) > 0 and var_381_5 < var_381_9 then
					arg_378_1.talkMaxDuration = var_381_9

					if var_381_9 + var_381_4 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_9 + var_381_4
					end
				end

				arg_378_1.text_.text = var_381_7
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011089", "story_v_side_old_928011.awb") ~= 0 then
					local var_381_10 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011089", "story_v_side_old_928011.awb") / 1000

					if var_381_10 + var_381_4 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_10 + var_381_4
					end

					if var_381_6.prefab_name ~= "" and arg_378_1.actors_[var_381_6.prefab_name] ~= nil then
						local var_381_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_6.prefab_name].transform, "story_v_side_old_928011", "928011089", "story_v_side_old_928011.awb")

						arg_378_1:RecordAudio("928011089", var_381_11)
						arg_378_1:RecordAudio("928011089", var_381_11)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011089", "story_v_side_old_928011.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011089", "story_v_side_old_928011.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_12 = math.max(var_381_5, arg_378_1.talkMaxDuration)

			if var_381_4 <= arg_378_1.time_ and arg_378_1.time_ < var_381_4 + var_381_12 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_4) / var_381_12

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_4 + var_381_12 and arg_378_1.time_ < var_381_4 + var_381_12 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play928011090 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 928011090
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play928011091(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(arg_382_1.actors_["1066ui_story"]) and arg_382_1.var_.characterEffect1066ui_story == nil then
				arg_382_1.var_.characterEffect1066ui_story = arg_382_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_0 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 and not isNil(arg_382_1.actors_["1066ui_story"]) then
				if arg_382_1.var_.characterEffect1066ui_story and not isNil(arg_382_1.actors_["1066ui_story"]) then
					arg_382_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_382_1.time_ - 0) / var_385_0)
				end
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 and not isNil(arg_382_1.actors_["1066ui_story"]) and arg_382_1.var_.characterEffect1066ui_story then
				arg_382_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_385_1 = 0
			local var_385_2 = 0.35

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_3 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(928011090).content)

				arg_382_1.text_.text = var_385_3

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 14 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 14)

				if (14 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 14)) > 0 and var_385_2 < var_385_5 then
					arg_382_1.talkMaxDuration = var_385_5

					if var_385_5 + var_385_1 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_5 + var_385_1
					end
				end

				arg_382_1.text_.text = var_385_3
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_6 = math.max(var_385_2, arg_382_1.talkMaxDuration)

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_6 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_1) / var_385_6

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_1 + var_385_6 and arg_382_1.time_ < var_385_1 + var_385_6 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play928011091 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 928011091
		arg_386_1.duration_ = 8.9

		local var_386_0 = {
			zh = 6.266,
			ja = 8.9
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play928011092(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(arg_386_1.actors_["1066ui_story"]) and arg_386_1.var_.characterEffect1066ui_story == nil then
				arg_386_1.var_.characterEffect1066ui_story = arg_386_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_0 = 0.200000002980232

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 and not isNil(arg_386_1.actors_["1066ui_story"]) then
				if arg_386_1.var_.characterEffect1066ui_story and not isNil(arg_386_1.actors_["1066ui_story"]) then
					arg_386_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 and not isNil(arg_386_1.actors_["1066ui_story"]) and arg_386_1.var_.characterEffect1066ui_story then
				arg_386_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action426")
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_389_2 = 0
			local var_389_3 = 0.725

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_2 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_4 = arg_386_1:GetWordFromCfg(928011091)
				local var_389_5 = arg_386_1:FormatText(var_389_4.content)

				arg_386_1.text_.text = var_389_5

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_7 = 29 <= 0 and var_389_3 or var_389_3 * (utf8.len(var_389_5) / 29)

				if (29 <= 0 and var_389_3 or var_389_3 * (utf8.len(var_389_5) / 29)) > 0 and var_389_3 < var_389_7 then
					arg_386_1.talkMaxDuration = var_389_7

					if var_389_7 + var_389_2 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_7 + var_389_2
					end
				end

				arg_386_1.text_.text = var_389_5
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011091", "story_v_side_old_928011.awb") ~= 0 then
					local var_389_8 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011091", "story_v_side_old_928011.awb") / 1000

					if var_389_8 + var_389_2 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_8 + var_389_2
					end

					if var_389_4.prefab_name ~= "" and arg_386_1.actors_[var_389_4.prefab_name] ~= nil then
						local var_389_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_4.prefab_name].transform, "story_v_side_old_928011", "928011091", "story_v_side_old_928011.awb")

						arg_386_1:RecordAudio("928011091", var_389_9)
						arg_386_1:RecordAudio("928011091", var_389_9)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011091", "story_v_side_old_928011.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011091", "story_v_side_old_928011.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_10 = math.max(var_389_3, arg_386_1.talkMaxDuration)

			if var_389_2 <= arg_386_1.time_ and arg_386_1.time_ < var_389_2 + var_389_10 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_2) / var_389_10

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_2 + var_389_10 and arg_386_1.time_ < var_389_2 + var_389_10 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play928011092 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 928011092
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play928011093(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos1066ui_story = arg_390_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_393_0 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 then
				arg_390_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_390_1.time_ - 0) / var_393_0)
				arg_390_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_390_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1066ui_story"].transform.position).z)
				arg_390_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_390_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_390_1.actors_["1066ui_story"].transform.localEulerAngles = arg_390_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 then
				arg_390_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_390_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_390_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1066ui_story"].transform.position).z)
				arg_390_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_390_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_390_1.actors_["1066ui_story"].transform.localEulerAngles = arg_390_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_393_1 = arg_390_1.actors_["1033ui_story"].transform

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos1033ui_story = var_393_1.localPosition
			end

			local var_393_2 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_2 then
				var_393_1.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_390_1.time_ - 0) / var_393_2)
				var_393_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_393_1.position).x, (manager.ui.mainCamera.transform.position - var_393_1.position).y, (manager.ui.mainCamera.transform.position - var_393_1.position).z)
				var_393_1.localEulerAngles.z = 0
				var_393_1.localEulerAngles.x = 0
				var_393_1.localEulerAngles = var_393_1.localEulerAngles
			end

			if arg_390_1.time_ >= 0 + var_393_2 and arg_390_1.time_ < 0 + var_393_2 + arg_393_0 then
				var_393_1.localPosition = Vector3.New(0, 100, 0)
				var_393_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_393_1.position).x, (manager.ui.mainCamera.transform.position - var_393_1.position).y, (manager.ui.mainCamera.transform.position - var_393_1.position).z)
				var_393_1.localEulerAngles.z = 0
				var_393_1.localEulerAngles.x = 0
				var_393_1.localEulerAngles = var_393_1.localEulerAngles
			end

			local var_393_3 = arg_390_1.actors_["1066ui_story"]

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(var_393_3) and arg_390_1.var_.characterEffect1066ui_story == nil then
				arg_390_1.var_.characterEffect1066ui_story = var_393_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_4 = 0.200000002980232

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_4 and not isNil(var_393_3) then
				if arg_390_1.var_.characterEffect1066ui_story and not isNil(var_393_3) then
					arg_390_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_390_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_390_1.time_ - 0) / var_393_4)
				end
			end

			if arg_390_1.time_ >= 0 + var_393_4 and arg_390_1.time_ < 0 + var_393_4 + arg_393_0 and not isNil(var_393_3) and arg_390_1.var_.characterEffect1066ui_story then
				arg_390_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_390_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_393_5 = 0
			local var_393_6 = 0.85

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_5 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, false)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_7 = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(928011092).content)

				arg_390_1.text_.text = var_393_7

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_9 = 34 <= 0 and var_393_6 or var_393_6 * (utf8.len(var_393_7) / 34)

				if (34 <= 0 and var_393_6 or var_393_6 * (utf8.len(var_393_7) / 34)) > 0 and var_393_6 < var_393_9 then
					arg_390_1.talkMaxDuration = var_393_9

					if var_393_9 + var_393_5 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_9 + var_393_5
					end
				end

				arg_390_1.text_.text = var_393_7
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_10 = math.max(var_393_6, arg_390_1.talkMaxDuration)

			if var_393_5 <= arg_390_1.time_ and arg_390_1.time_ < var_393_5 + var_393_10 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_5) / var_393_10

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_5 + var_393_10 and arg_390_1.time_ < var_393_5 + var_393_10 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play928011093 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 928011093
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play928011094(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0.475

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_1 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(928011093).content)

				arg_394_1.text_.text = var_397_1

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_3 = 19 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 19)

				if (19 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 19)) > 0 and var_397_0 < var_397_3 then
					arg_394_1.talkMaxDuration = var_397_3

					if var_397_3 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_3 + 0
					end
				end

				arg_394_1.text_.text = var_397_1
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_4 = math.max(var_397_0, arg_394_1.talkMaxDuration)

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_4 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - 0) / var_397_4

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= 0 + var_397_4 and arg_394_1.time_ < 0 + var_397_4 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play928011094 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 928011094
		arg_398_1.duration_ = 5.27

		local var_398_0 = {
			zh = 3.366,
			ja = 5.266
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play928011095(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.var_.moveOldPos1085ui_story = arg_398_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_401_0 = 0.001

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 then
				arg_398_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_398_1.time_ - 0) / var_401_0)
				arg_398_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_398_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1085ui_story"].transform.position).z)
				arg_398_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_398_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_398_1.actors_["1085ui_story"].transform.localEulerAngles = arg_398_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 then
				arg_398_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_398_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_398_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1085ui_story"].transform.position).z)
				arg_398_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_398_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_398_1.actors_["1085ui_story"].transform.localEulerAngles = arg_398_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_401_1 = arg_398_1.actors_["1085ui_story"]

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(var_401_1) and arg_398_1.var_.characterEffect1085ui_story == nil then
				arg_398_1.var_.characterEffect1085ui_story = var_401_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_2 = 0.200000002980232

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_2 and not isNil(var_401_1) then
				if arg_398_1.var_.characterEffect1085ui_story and not isNil(var_401_1) then
					arg_398_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_398_1.time_ >= 0 + var_401_2 and arg_398_1.time_ < 0 + var_401_2 + arg_401_0 and not isNil(var_401_1) and arg_398_1.var_.characterEffect1085ui_story then
				arg_398_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action7_1")
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_401_4 = 0
			local var_401_5 = 0.3

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_4 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_6 = arg_398_1:GetWordFromCfg(928011094)
				local var_401_7 = arg_398_1:FormatText(var_401_6.content)

				arg_398_1.text_.text = var_401_7

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_9 = 12 <= 0 and var_401_5 or var_401_5 * (utf8.len(var_401_7) / 12)

				if (12 <= 0 and var_401_5 or var_401_5 * (utf8.len(var_401_7) / 12)) > 0 and var_401_5 < var_401_9 then
					arg_398_1.talkMaxDuration = var_401_9

					if var_401_9 + var_401_4 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_9 + var_401_4
					end
				end

				arg_398_1.text_.text = var_401_7
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011094", "story_v_side_old_928011.awb") ~= 0 then
					local var_401_10 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011094", "story_v_side_old_928011.awb") / 1000

					if var_401_10 + var_401_4 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_10 + var_401_4
					end

					if var_401_6.prefab_name ~= "" and arg_398_1.actors_[var_401_6.prefab_name] ~= nil then
						local var_401_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_6.prefab_name].transform, "story_v_side_old_928011", "928011094", "story_v_side_old_928011.awb")

						arg_398_1:RecordAudio("928011094", var_401_11)
						arg_398_1:RecordAudio("928011094", var_401_11)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011094", "story_v_side_old_928011.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011094", "story_v_side_old_928011.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_12 = math.max(var_401_5, arg_398_1.talkMaxDuration)

			if var_401_4 <= arg_398_1.time_ and arg_398_1.time_ < var_401_4 + var_401_12 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_4) / var_401_12

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_4 + var_401_12 and arg_398_1.time_ < var_401_4 + var_401_12 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_398_1:InitPlayNodeList()
	end,
	Play928011095 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 928011095
		arg_402_1.duration_ = 1

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"

			SetActive(arg_402_1.choicesGo_, true)

			for iter_403_0, iter_403_1 in ipairs(arg_402_1.choices_) do
				SetActive(iter_403_1.go, iter_403_0 <= 2)
			end

			arg_402_1.choices_[1].txt.text = arg_402_1:FormatText(StoryChoiceCfg[1425].name)
			arg_402_1.choices_[2].txt.text = arg_402_1:FormatText(StoryChoiceCfg[1426].name)
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play928011096(arg_402_1)
			end

			if arg_404_0 == 2 then
				arg_402_0:Play928011096(arg_402_1)
			end

			arg_402_1:RecordChoiceLog(928011095, 1425, 1426)
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(arg_402_1.actors_["1085ui_story"]) and arg_402_1.var_.characterEffect1085ui_story == nil then
				arg_402_1.var_.characterEffect1085ui_story = arg_402_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_0 = 0.200000002980232

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_0 and not isNil(arg_402_1.actors_["1085ui_story"]) then
				if arg_402_1.var_.characterEffect1085ui_story and not isNil(arg_402_1.actors_["1085ui_story"]) then
					arg_402_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_402_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_402_1.time_ - 0) / var_405_0)
				end
			end

			if arg_402_1.time_ >= 0 + var_405_0 and arg_402_1.time_ < 0 + var_405_0 + arg_405_0 and not isNil(arg_402_1.actors_["1085ui_story"]) and arg_402_1.var_.characterEffect1085ui_story then
				arg_402_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_402_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play928011096 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 928011096
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play928011097(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0.6

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_1 = arg_406_1:FormatText(arg_406_1:GetWordFromCfg(928011096).content)

				arg_406_1.text_.text = var_409_1

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_3 = 24 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_1) / 24)

				if (24 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_1) / 24)) > 0 and var_409_0 < var_409_3 then
					arg_406_1.talkMaxDuration = var_409_3

					if var_409_3 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_3 + 0
					end
				end

				arg_406_1.text_.text = var_409_1
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_4 = math.max(var_409_0, arg_406_1.talkMaxDuration)

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_4 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - 0) / var_409_4

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= 0 + var_409_4 and arg_406_1.time_ < 0 + var_409_4 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play928011097 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 928011097
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play928011098(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action474")
			end

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_413_0 = 0
			local var_413_1 = 0.55

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, false)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_2 = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(928011097).content)

				arg_410_1.text_.text = var_413_2

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_4 = 22 <= 0 and var_413_1 or var_413_1 * (utf8.len(var_413_2) / 22)

				if (22 <= 0 and var_413_1 or var_413_1 * (utf8.len(var_413_2) / 22)) > 0 and var_413_1 < var_413_4 then
					arg_410_1.talkMaxDuration = var_413_4

					if var_413_4 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_4 + var_413_0
					end
				end

				arg_410_1.text_.text = var_413_2
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_5 = math.max(var_413_1, arg_410_1.talkMaxDuration)

			if var_413_0 <= arg_410_1.time_ and arg_410_1.time_ < var_413_0 + var_413_5 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_0) / var_413_5

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_0 + var_413_5 and arg_410_1.time_ < var_413_0 + var_413_5 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play928011098 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 928011098
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play928011099(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0.7

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_1 = arg_414_1:FormatText(arg_414_1:GetWordFromCfg(928011098).content)

				arg_414_1.text_.text = var_417_1

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_3 = 28 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_1) / 28)

				if (28 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_1) / 28)) > 0 and var_417_0 < var_417_3 then
					arg_414_1.talkMaxDuration = var_417_3

					if var_417_3 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_3 + 0
					end
				end

				arg_414_1.text_.text = var_417_1
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_4 = math.max(var_417_0, arg_414_1.talkMaxDuration)

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_4 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - 0) / var_417_4

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= 0 + var_417_4 and arg_414_1.time_ < 0 + var_417_4 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play928011099 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 928011099
		arg_418_1.duration_ = 13.23

		local var_418_0 = {
			zh = 13.233,
			ja = 9.633
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play928011100(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(arg_418_1.actors_["1085ui_story"]) and arg_418_1.var_.characterEffect1085ui_story == nil then
				arg_418_1.var_.characterEffect1085ui_story = arg_418_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_0 = 0.200000002980232

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 and not isNil(arg_418_1.actors_["1085ui_story"]) then
				if arg_418_1.var_.characterEffect1085ui_story and not isNil(arg_418_1.actors_["1085ui_story"]) then
					arg_418_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 and not isNil(arg_418_1.actors_["1085ui_story"]) and arg_418_1.var_.characterEffect1085ui_story then
				arg_418_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_421_2 = 0
			local var_421_3 = 1

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_2 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_4 = arg_418_1:GetWordFromCfg(928011099)
				local var_421_5 = arg_418_1:FormatText(var_421_4.content)

				arg_418_1.text_.text = var_421_5

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_7 = 40 <= 0 and var_421_3 or var_421_3 * (utf8.len(var_421_5) / 40)

				if (40 <= 0 and var_421_3 or var_421_3 * (utf8.len(var_421_5) / 40)) > 0 and var_421_3 < var_421_7 then
					arg_418_1.talkMaxDuration = var_421_7

					if var_421_7 + var_421_2 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_7 + var_421_2
					end
				end

				arg_418_1.text_.text = var_421_5
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011099", "story_v_side_old_928011.awb") ~= 0 then
					local var_421_8 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011099", "story_v_side_old_928011.awb") / 1000

					if var_421_8 + var_421_2 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_8 + var_421_2
					end

					if var_421_4.prefab_name ~= "" and arg_418_1.actors_[var_421_4.prefab_name] ~= nil then
						local var_421_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_4.prefab_name].transform, "story_v_side_old_928011", "928011099", "story_v_side_old_928011.awb")

						arg_418_1:RecordAudio("928011099", var_421_9)
						arg_418_1:RecordAudio("928011099", var_421_9)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011099", "story_v_side_old_928011.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011099", "story_v_side_old_928011.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_10 = math.max(var_421_3, arg_418_1.talkMaxDuration)

			if var_421_2 <= arg_418_1.time_ and arg_418_1.time_ < var_421_2 + var_421_10 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_2) / var_421_10

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_2 + var_421_10 and arg_418_1.time_ < var_421_2 + var_421_10 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play928011100 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 928011100
		arg_422_1.duration_ = 7.87

		local var_422_0 = {
			zh = 6.866,
			ja = 7.866
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play928011101(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0.575

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_1 = arg_422_1:GetWordFromCfg(928011100)
				local var_425_2 = arg_422_1:FormatText(var_425_1.content)

				arg_422_1.text_.text = var_425_2

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_4 = 23 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_2) / 23)

				if (23 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_2) / 23)) > 0 and var_425_0 < var_425_4 then
					arg_422_1.talkMaxDuration = var_425_4

					if var_425_4 + 0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_4 + 0
					end
				end

				arg_422_1.text_.text = var_425_2
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011100", "story_v_side_old_928011.awb") ~= 0 then
					local var_425_5 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011100", "story_v_side_old_928011.awb") / 1000

					if var_425_5 + 0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_5 + 0
					end

					if var_425_1.prefab_name ~= "" and arg_422_1.actors_[var_425_1.prefab_name] ~= nil then
						local var_425_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_1.prefab_name].transform, "story_v_side_old_928011", "928011100", "story_v_side_old_928011.awb")

						arg_422_1:RecordAudio("928011100", var_425_6)
						arg_422_1:RecordAudio("928011100", var_425_6)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011100", "story_v_side_old_928011.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011100", "story_v_side_old_928011.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_7 = math.max(var_425_0, arg_422_1.talkMaxDuration)

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_7 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - 0) / var_425_7

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= 0 + var_425_7 and arg_422_1.time_ < 0 + var_425_7 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play928011101 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 928011101
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play928011102(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(arg_426_1.actors_["1085ui_story"]) and arg_426_1.var_.characterEffect1085ui_story == nil then
				arg_426_1.var_.characterEffect1085ui_story = arg_426_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_0 = 0.200000002980232

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_0 and not isNil(arg_426_1.actors_["1085ui_story"]) then
				if arg_426_1.var_.characterEffect1085ui_story and not isNil(arg_426_1.actors_["1085ui_story"]) then
					arg_426_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_426_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_426_1.time_ - 0) / var_429_0)
				end
			end

			if arg_426_1.time_ >= 0 + var_429_0 and arg_426_1.time_ < 0 + var_429_0 + arg_429_0 and not isNil(arg_426_1.actors_["1085ui_story"]) and arg_426_1.var_.characterEffect1085ui_story then
				arg_426_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_426_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_429_1 = 0
			local var_429_2 = 0.075

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, true)
				arg_426_1.iconController_:SetSelectedState("hero")

				arg_426_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_426_1.callingController_:SetSelectedState("normal")

				arg_426_1.keyicon_.color = Color.New(1, 1, 1)
				arg_426_1.icon_.color = Color.New(1, 1, 1)

				local var_429_3 = arg_426_1:FormatText(arg_426_1:GetWordFromCfg(928011101).content)

				arg_426_1.text_.text = var_429_3

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_5 = 3 <= 0 and var_429_2 or var_429_2 * (utf8.len(var_429_3) / 3)

				if (3 <= 0 and var_429_2 or var_429_2 * (utf8.len(var_429_3) / 3)) > 0 and var_429_2 < var_429_5 then
					arg_426_1.talkMaxDuration = var_429_5

					if var_429_5 + var_429_1 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_5 + var_429_1
					end
				end

				arg_426_1.text_.text = var_429_3
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_6 = math.max(var_429_2, arg_426_1.talkMaxDuration)

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_6 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_1) / var_429_6

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_1 + var_429_6 and arg_426_1.time_ < var_429_1 + var_429_6 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play928011102 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 928011102
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play928011103(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 0.525

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, false)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_1 = arg_430_1:FormatText(arg_430_1:GetWordFromCfg(928011102).content)

				arg_430_1.text_.text = var_433_1

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_3 = 21 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_1) / 21)

				if (21 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_1) / 21)) > 0 and var_433_0 < var_433_3 then
					arg_430_1.talkMaxDuration = var_433_3

					if var_433_3 + 0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_3 + 0
					end
				end

				arg_430_1.text_.text = var_433_1
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_4 = math.max(var_433_0, arg_430_1.talkMaxDuration)

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_4 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - 0) / var_433_4

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= 0 + var_433_4 and arg_430_1.time_ < 0 + var_433_4 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play928011103 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 928011103
		arg_434_1.duration_ = 13.57

		local var_434_0 = {
			zh = 10.7,
			ja = 13.566
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play928011104(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(arg_434_1.actors_["1085ui_story"]) and arg_434_1.var_.characterEffect1085ui_story == nil then
				arg_434_1.var_.characterEffect1085ui_story = arg_434_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_0 = 0.200000002980232

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_0 and not isNil(arg_434_1.actors_["1085ui_story"]) then
				if arg_434_1.var_.characterEffect1085ui_story and not isNil(arg_434_1.actors_["1085ui_story"]) then
					arg_434_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_434_1.time_ >= 0 + var_437_0 and arg_434_1.time_ < 0 + var_437_0 + arg_437_0 and not isNil(arg_434_1.actors_["1085ui_story"]) and arg_434_1.var_.characterEffect1085ui_story then
				arg_434_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_437_2 = 0
			local var_437_3 = 0.725

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_2 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_4 = arg_434_1:GetWordFromCfg(928011103)
				local var_437_5 = arg_434_1:FormatText(var_437_4.content)

				arg_434_1.text_.text = var_437_5

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_7 = 29 <= 0 and var_437_3 or var_437_3 * (utf8.len(var_437_5) / 29)

				if (29 <= 0 and var_437_3 or var_437_3 * (utf8.len(var_437_5) / 29)) > 0 and var_437_3 < var_437_7 then
					arg_434_1.talkMaxDuration = var_437_7

					if var_437_7 + var_437_2 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_7 + var_437_2
					end
				end

				arg_434_1.text_.text = var_437_5
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011103", "story_v_side_old_928011.awb") ~= 0 then
					local var_437_8 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011103", "story_v_side_old_928011.awb") / 1000

					if var_437_8 + var_437_2 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_8 + var_437_2
					end

					if var_437_4.prefab_name ~= "" and arg_434_1.actors_[var_437_4.prefab_name] ~= nil then
						local var_437_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_4.prefab_name].transform, "story_v_side_old_928011", "928011103", "story_v_side_old_928011.awb")

						arg_434_1:RecordAudio("928011103", var_437_9)
						arg_434_1:RecordAudio("928011103", var_437_9)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011103", "story_v_side_old_928011.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011103", "story_v_side_old_928011.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_10 = math.max(var_437_3, arg_434_1.talkMaxDuration)

			if var_437_2 <= arg_434_1.time_ and arg_434_1.time_ < var_437_2 + var_437_10 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_2) / var_437_10

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_2 + var_437_10 and arg_434_1.time_ < var_437_2 + var_437_10 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play928011104 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 928011104
		arg_438_1.duration_ = 6.27

		local var_438_0 = {
			zh = 6,
			ja = 6.266
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play928011105(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0.55

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_1 = arg_438_1:GetWordFromCfg(928011104)
				local var_441_2 = arg_438_1:FormatText(var_441_1.content)

				arg_438_1.text_.text = var_441_2

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_4 = 22 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_2) / 22)

				if (22 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_2) / 22)) > 0 and var_441_0 < var_441_4 then
					arg_438_1.talkMaxDuration = var_441_4

					if var_441_4 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_4 + 0
					end
				end

				arg_438_1.text_.text = var_441_2
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011104", "story_v_side_old_928011.awb") ~= 0 then
					local var_441_5 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011104", "story_v_side_old_928011.awb") / 1000

					if var_441_5 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_5 + 0
					end

					if var_441_1.prefab_name ~= "" and arg_438_1.actors_[var_441_1.prefab_name] ~= nil then
						local var_441_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_1.prefab_name].transform, "story_v_side_old_928011", "928011104", "story_v_side_old_928011.awb")

						arg_438_1:RecordAudio("928011104", var_441_6)
						arg_438_1:RecordAudio("928011104", var_441_6)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011104", "story_v_side_old_928011.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011104", "story_v_side_old_928011.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_7 = math.max(var_441_0, arg_438_1.talkMaxDuration)

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_7 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - 0) / var_441_7

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= 0 + var_441_7 and arg_438_1.time_ < 0 + var_441_7 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play928011105 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 928011105
		arg_442_1.duration_ = 10.43

		local var_442_0 = {
			zh = 7.4,
			ja = 10.433
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play928011106(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0.75

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_1 = arg_442_1:GetWordFromCfg(928011105)
				local var_445_2 = arg_442_1:FormatText(var_445_1.content)

				arg_442_1.text_.text = var_445_2

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_4 = 30 <= 0 and var_445_0 or var_445_0 * (utf8.len(var_445_2) / 30)

				if (30 <= 0 and var_445_0 or var_445_0 * (utf8.len(var_445_2) / 30)) > 0 and var_445_0 < var_445_4 then
					arg_442_1.talkMaxDuration = var_445_4

					if var_445_4 + 0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_4 + 0
					end
				end

				arg_442_1.text_.text = var_445_2
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011105", "story_v_side_old_928011.awb") ~= 0 then
					local var_445_5 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011105", "story_v_side_old_928011.awb") / 1000

					if var_445_5 + 0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_5 + 0
					end

					if var_445_1.prefab_name ~= "" and arg_442_1.actors_[var_445_1.prefab_name] ~= nil then
						local var_445_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_1.prefab_name].transform, "story_v_side_old_928011", "928011105", "story_v_side_old_928011.awb")

						arg_442_1:RecordAudio("928011105", var_445_6)
						arg_442_1:RecordAudio("928011105", var_445_6)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011105", "story_v_side_old_928011.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011105", "story_v_side_old_928011.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_7 = math.max(var_445_0, arg_442_1.talkMaxDuration)

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_7 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - 0) / var_445_7

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= 0 + var_445_7 and arg_442_1.time_ < 0 + var_445_7 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play928011106 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 928011106
		arg_446_1.duration_ = 11.6

		local var_446_0 = {
			zh = 9.033,
			ja = 11.6
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play928011107(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_449_0 = 0
			local var_449_1 = 0.95

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_2 = arg_446_1:GetWordFromCfg(928011106)
				local var_449_3 = arg_446_1:FormatText(var_449_2.content)

				arg_446_1.text_.text = var_449_3

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_5 = 38 <= 0 and var_449_1 or var_449_1 * (utf8.len(var_449_3) / 38)

				if (38 <= 0 and var_449_1 or var_449_1 * (utf8.len(var_449_3) / 38)) > 0 and var_449_1 < var_449_5 then
					arg_446_1.talkMaxDuration = var_449_5

					if var_449_5 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_5 + var_449_0
					end
				end

				arg_446_1.text_.text = var_449_3
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011106", "story_v_side_old_928011.awb") ~= 0 then
					local var_449_6 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011106", "story_v_side_old_928011.awb") / 1000

					if var_449_6 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_6 + var_449_0
					end

					if var_449_2.prefab_name ~= "" and arg_446_1.actors_[var_449_2.prefab_name] ~= nil then
						local var_449_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_2.prefab_name].transform, "story_v_side_old_928011", "928011106", "story_v_side_old_928011.awb")

						arg_446_1:RecordAudio("928011106", var_449_7)
						arg_446_1:RecordAudio("928011106", var_449_7)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011106", "story_v_side_old_928011.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011106", "story_v_side_old_928011.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_8 = math.max(var_449_1, arg_446_1.talkMaxDuration)

			if var_449_0 <= arg_446_1.time_ and arg_446_1.time_ < var_449_0 + var_449_8 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_0) / var_449_8

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_0 + var_449_8 and arg_446_1.time_ < var_449_0 + var_449_8 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play928011107 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 928011107
		arg_450_1.duration_ = 11.27

		local var_450_0 = {
			zh = 11.266,
			ja = 10.633
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play928011108(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0.875

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_1 = arg_450_1:GetWordFromCfg(928011107)
				local var_453_2 = arg_450_1:FormatText(var_453_1.content)

				arg_450_1.text_.text = var_453_2

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_4 = 35 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_2) / 35)

				if (35 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_2) / 35)) > 0 and var_453_0 < var_453_4 then
					arg_450_1.talkMaxDuration = var_453_4

					if var_453_4 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_4 + 0
					end
				end

				arg_450_1.text_.text = var_453_2
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011107", "story_v_side_old_928011.awb") ~= 0 then
					local var_453_5 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011107", "story_v_side_old_928011.awb") / 1000

					if var_453_5 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_5 + 0
					end

					if var_453_1.prefab_name ~= "" and arg_450_1.actors_[var_453_1.prefab_name] ~= nil then
						local var_453_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_1.prefab_name].transform, "story_v_side_old_928011", "928011107", "story_v_side_old_928011.awb")

						arg_450_1:RecordAudio("928011107", var_453_6)
						arg_450_1:RecordAudio("928011107", var_453_6)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011107", "story_v_side_old_928011.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011107", "story_v_side_old_928011.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_7 = math.max(var_453_0, arg_450_1.talkMaxDuration)

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_7 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - 0) / var_453_7

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= 0 + var_453_7 and arg_450_1.time_ < 0 + var_453_7 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play928011108 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 928011108
		arg_454_1.duration_ = 5.07

		local var_454_0 = {
			zh = 4.2,
			ja = 5.066
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play928011109(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_457_0 = 0
			local var_457_1 = 0.4

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_2 = arg_454_1:GetWordFromCfg(928011108)
				local var_457_3 = arg_454_1:FormatText(var_457_2.content)

				arg_454_1.text_.text = var_457_3

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_5 = 16 <= 0 and var_457_1 or var_457_1 * (utf8.len(var_457_3) / 16)

				if (16 <= 0 and var_457_1 or var_457_1 * (utf8.len(var_457_3) / 16)) > 0 and var_457_1 < var_457_5 then
					arg_454_1.talkMaxDuration = var_457_5

					if var_457_5 + var_457_0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_5 + var_457_0
					end
				end

				arg_454_1.text_.text = var_457_3
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011108", "story_v_side_old_928011.awb") ~= 0 then
					local var_457_6 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011108", "story_v_side_old_928011.awb") / 1000

					if var_457_6 + var_457_0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_6 + var_457_0
					end

					if var_457_2.prefab_name ~= "" and arg_454_1.actors_[var_457_2.prefab_name] ~= nil then
						local var_457_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_2.prefab_name].transform, "story_v_side_old_928011", "928011108", "story_v_side_old_928011.awb")

						arg_454_1:RecordAudio("928011108", var_457_7)
						arg_454_1:RecordAudio("928011108", var_457_7)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011108", "story_v_side_old_928011.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011108", "story_v_side_old_928011.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_8 = math.max(var_457_1, arg_454_1.talkMaxDuration)

			if var_457_0 <= arg_454_1.time_ and arg_454_1.time_ < var_457_0 + var_457_8 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_0) / var_457_8

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_0 + var_457_8 and arg_454_1.time_ < var_457_0 + var_457_8 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play928011109 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 928011109
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play928011110(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1.var_.moveOldPos1085ui_story = arg_458_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_461_0 = 0.001

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 then
				arg_458_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_458_1.time_ - 0) / var_461_0)
				arg_458_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_458_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["1085ui_story"].transform.position).z)
				arg_458_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_458_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_458_1.actors_["1085ui_story"].transform.localEulerAngles = arg_458_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 then
				arg_458_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_458_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_458_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["1085ui_story"].transform.position).z)
				arg_458_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_458_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_458_1.actors_["1085ui_story"].transform.localEulerAngles = arg_458_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_461_1 = arg_458_1.actors_["1085ui_story"]

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(var_461_1) and arg_458_1.var_.characterEffect1085ui_story == nil then
				arg_458_1.var_.characterEffect1085ui_story = var_461_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_2 = 0.200000002980232

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_2 and not isNil(var_461_1) then
				if arg_458_1.var_.characterEffect1085ui_story and not isNil(var_461_1) then
					arg_458_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_458_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_458_1.time_ - 0) / var_461_2)
				end
			end

			if arg_458_1.time_ >= 0 + var_461_2 and arg_458_1.time_ < 0 + var_461_2 + arg_461_0 and not isNil(var_461_1) and arg_458_1.var_.characterEffect1085ui_story then
				arg_458_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_458_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_461_3 = 0
			local var_461_4 = 0.8

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_3 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_5 = arg_458_1:FormatText(arg_458_1:GetWordFromCfg(928011109).content)

				arg_458_1.text_.text = var_461_5

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_7 = 32 <= 0 and var_461_4 or var_461_4 * (utf8.len(var_461_5) / 32)

				if (32 <= 0 and var_461_4 or var_461_4 * (utf8.len(var_461_5) / 32)) > 0 and var_461_4 < var_461_7 then
					arg_458_1.talkMaxDuration = var_461_7

					if var_461_7 + var_461_3 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_7 + var_461_3
					end
				end

				arg_458_1.text_.text = var_461_5
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_8 = math.max(var_461_4, arg_458_1.talkMaxDuration)

			if var_461_3 <= arg_458_1.time_ and arg_458_1.time_ < var_461_3 + var_461_8 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_3) / var_461_8

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_3 + var_461_8 and arg_458_1.time_ < var_461_3 + var_461_8 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_458_1:InitPlayNodeList()
	end,
	Play928011110 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 928011110
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play928011111(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = 0.9

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, true)
				arg_462_1.iconController_:SetSelectedState("hero")

				arg_462_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_462_1.callingController_:SetSelectedState("normal")

				arg_462_1.keyicon_.color = Color.New(1, 1, 1)
				arg_462_1.icon_.color = Color.New(1, 1, 1)

				local var_465_1 = arg_462_1:FormatText(arg_462_1:GetWordFromCfg(928011110).content)

				arg_462_1.text_.text = var_465_1

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_3 = 36 <= 0 and var_465_0 or var_465_0 * (utf8.len(var_465_1) / 36)

				if (36 <= 0 and var_465_0 or var_465_0 * (utf8.len(var_465_1) / 36)) > 0 and var_465_0 < var_465_3 then
					arg_462_1.talkMaxDuration = var_465_3

					if var_465_3 + 0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_3 + 0
					end
				end

				arg_462_1.text_.text = var_465_1
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_4 = math.max(var_465_0, arg_462_1.talkMaxDuration)

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_4 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - 0) / var_465_4

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= 0 + var_465_4 and arg_462_1.time_ < 0 + var_465_4 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play928011111 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 928011111
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play928011112(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0.333333333333333 < arg_466_1.time_ and arg_466_1.time_ <= 0.333333333333333 + arg_469_0 then
				arg_466_1:AudioAction("play", "effect", "se_story_birthday3", "se_story_birthday3_catch", "")
			end

			local var_469_1 = 0

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 then
				arg_466_1.allBtn_.enabled = false
			end

			if arg_466_1.time_ >= var_469_1 + 1 and arg_466_1.time_ < var_469_1 + 1 + arg_469_0 then
				arg_466_1.allBtn_.enabled = true
			end

			local var_469_2 = 0
			local var_469_3 = 0.925

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_2 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, false)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_4 = arg_466_1:FormatText(arg_466_1:GetWordFromCfg(928011111).content)

				arg_466_1.text_.text = var_469_4

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_6 = 37 <= 0 and var_469_3 or var_469_3 * (utf8.len(var_469_4) / 37)

				if (37 <= 0 and var_469_3 or var_469_3 * (utf8.len(var_469_4) / 37)) > 0 and var_469_3 < var_469_6 then
					arg_466_1.talkMaxDuration = var_469_6

					if var_469_6 + var_469_2 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_6 + var_469_2
					end
				end

				arg_466_1.text_.text = var_469_4
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_7 = math.max(var_469_3, arg_466_1.talkMaxDuration)

			if var_469_2 <= arg_466_1.time_ and arg_466_1.time_ < var_469_2 + var_469_7 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_2) / var_469_7

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_2 + var_469_7 and arg_466_1.time_ < var_469_2 + var_469_7 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play928011112 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 928011112
		arg_470_1.duration_ = 5.23

		local var_470_0 = {
			zh = 5.233,
			ja = 4.266
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play928011113(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.var_.moveOldPos1085ui_story = arg_470_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_473_0 = 0.001

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_0 then
				arg_470_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_470_1.time_ - 0) / var_473_0)
				arg_470_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1085ui_story"].transform.position).z)
				arg_470_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["1085ui_story"].transform.localEulerAngles = arg_470_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_470_1.time_ >= 0 + var_473_0 and arg_470_1.time_ < 0 + var_473_0 + arg_473_0 then
				arg_470_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_470_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1085ui_story"].transform.position).z)
				arg_470_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["1085ui_story"].transform.localEulerAngles = arg_470_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_473_1 = arg_470_1.actors_["1085ui_story"]

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 and not isNil(var_473_1) and arg_470_1.var_.characterEffect1085ui_story == nil then
				arg_470_1.var_.characterEffect1085ui_story = var_473_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_2 = 0.200000002980232

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_2 and not isNil(var_473_1) then
				if arg_470_1.var_.characterEffect1085ui_story and not isNil(var_473_1) then
					arg_470_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_470_1.time_ >= 0 + var_473_2 and arg_470_1.time_ < 0 + var_473_2 + arg_473_0 and not isNil(var_473_1) and arg_470_1.var_.characterEffect1085ui_story then
				arg_470_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_473_4 = 0
			local var_473_5 = 0.25

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_4 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_6 = arg_470_1:GetWordFromCfg(928011112)
				local var_473_7 = arg_470_1:FormatText(var_473_6.content)

				arg_470_1.text_.text = var_473_7

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_9 = 10 <= 0 and var_473_5 or var_473_5 * (utf8.len(var_473_7) / 10)

				if (10 <= 0 and var_473_5 or var_473_5 * (utf8.len(var_473_7) / 10)) > 0 and var_473_5 < var_473_9 then
					arg_470_1.talkMaxDuration = var_473_9

					if var_473_9 + var_473_4 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_9 + var_473_4
					end
				end

				arg_470_1.text_.text = var_473_7
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011112", "story_v_side_old_928011.awb") ~= 0 then
					local var_473_10 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011112", "story_v_side_old_928011.awb") / 1000

					if var_473_10 + var_473_4 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_10 + var_473_4
					end

					if var_473_6.prefab_name ~= "" and arg_470_1.actors_[var_473_6.prefab_name] ~= nil then
						local var_473_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_6.prefab_name].transform, "story_v_side_old_928011", "928011112", "story_v_side_old_928011.awb")

						arg_470_1:RecordAudio("928011112", var_473_11)
						arg_470_1:RecordAudio("928011112", var_473_11)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011112", "story_v_side_old_928011.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011112", "story_v_side_old_928011.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_12 = math.max(var_473_5, arg_470_1.talkMaxDuration)

			if var_473_4 <= arg_470_1.time_ and arg_470_1.time_ < var_473_4 + var_473_12 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_4) / var_473_12

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_4 + var_473_12 and arg_470_1.time_ < var_473_4 + var_473_12 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_470_1:InitPlayNodeList()
	end,
	Play928011113 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 928011113
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play928011114(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 and not isNil(arg_474_1.actors_["1085ui_story"]) and arg_474_1.var_.characterEffect1085ui_story == nil then
				arg_474_1.var_.characterEffect1085ui_story = arg_474_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_0 = 0.200000002980232

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_0 and not isNil(arg_474_1.actors_["1085ui_story"]) then
				if arg_474_1.var_.characterEffect1085ui_story and not isNil(arg_474_1.actors_["1085ui_story"]) then
					arg_474_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_474_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_474_1.time_ - 0) / var_477_0)
				end
			end

			if arg_474_1.time_ >= 0 + var_477_0 and arg_474_1.time_ < 0 + var_477_0 + arg_477_0 and not isNil(arg_474_1.actors_["1085ui_story"]) and arg_474_1.var_.characterEffect1085ui_story then
				arg_474_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_474_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_477_1 = 0
			local var_477_2 = 0.625

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				arg_474_1.leftNameTxt_.text = arg_474_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, true)
				arg_474_1.iconController_:SetSelectedState("hero")

				arg_474_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_474_1.callingController_:SetSelectedState("normal")

				arg_474_1.keyicon_.color = Color.New(1, 1, 1)
				arg_474_1.icon_.color = Color.New(1, 1, 1)

				local var_477_3 = arg_474_1:FormatText(arg_474_1:GetWordFromCfg(928011113).content)

				arg_474_1.text_.text = var_477_3

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_5 = 25 <= 0 and var_477_2 or var_477_2 * (utf8.len(var_477_3) / 25)

				if (25 <= 0 and var_477_2 or var_477_2 * (utf8.len(var_477_3) / 25)) > 0 and var_477_2 < var_477_5 then
					arg_474_1.talkMaxDuration = var_477_5

					if var_477_5 + var_477_1 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_5 + var_477_1
					end
				end

				arg_474_1.text_.text = var_477_3
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_6 = math.max(var_477_2, arg_474_1.talkMaxDuration)

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_6 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_1) / var_477_6

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_1 + var_477_6 and arg_474_1.time_ < var_477_1 + var_477_6 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play928011114 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 928011114
		arg_478_1.duration_ = 15.83

		local var_478_0 = {
			zh = 12.3,
			ja = 15.833
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play928011115(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.var_.moveOldPos1085ui_story = arg_478_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_481_0 = 0.001

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_0 then
				arg_478_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_478_1.time_ - 0) / var_481_0)
				arg_478_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_478_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_478_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_478_1.actors_["1085ui_story"].transform.position).z)
				arg_478_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_478_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_478_1.actors_["1085ui_story"].transform.localEulerAngles = arg_478_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_478_1.time_ >= 0 + var_481_0 and arg_478_1.time_ < 0 + var_481_0 + arg_481_0 then
				arg_478_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_478_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_478_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_478_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_478_1.actors_["1085ui_story"].transform.position).z)
				arg_478_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_478_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_478_1.actors_["1085ui_story"].transform.localEulerAngles = arg_478_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_481_1 = arg_478_1.actors_["1066ui_story"].transform

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.var_.moveOldPos1066ui_story = var_481_1.localPosition
			end

			local var_481_2 = 0.001

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_2 then
				var_481_1.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_478_1.time_ - 0) / var_481_2)
				var_481_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_481_1.position).x, (manager.ui.mainCamera.transform.position - var_481_1.position).y, (manager.ui.mainCamera.transform.position - var_481_1.position).z)
				var_481_1.localEulerAngles.z = 0
				var_481_1.localEulerAngles.x = 0
				var_481_1.localEulerAngles = var_481_1.localEulerAngles
			end

			if arg_478_1.time_ >= 0 + var_481_2 and arg_478_1.time_ < 0 + var_481_2 + arg_481_0 then
				var_481_1.localPosition = Vector3.New(0, -0.77, -6.1)
				var_481_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_481_1.position).x, (manager.ui.mainCamera.transform.position - var_481_1.position).y, (manager.ui.mainCamera.transform.position - var_481_1.position).z)
				var_481_1.localEulerAngles.z = 0
				var_481_1.localEulerAngles.x = 0
				var_481_1.localEulerAngles = var_481_1.localEulerAngles
			end

			local var_481_3 = arg_478_1.actors_["1066ui_story"]

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(var_481_3) and arg_478_1.var_.characterEffect1066ui_story == nil then
				arg_478_1.var_.characterEffect1066ui_story = var_481_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_4 = 0.200000002980232

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_4 and not isNil(var_481_3) then
				if arg_478_1.var_.characterEffect1066ui_story and not isNil(var_481_3) then
					arg_478_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_478_1.time_ >= 0 + var_481_4 and arg_478_1.time_ < 0 + var_481_4 + arg_481_0 and not isNil(var_481_3) and arg_478_1.var_.characterEffect1066ui_story then
				arg_478_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_481_6 = 0
			local var_481_7 = 1.375

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_6 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				arg_478_1.leftNameTxt_.text = arg_478_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_8 = arg_478_1:GetWordFromCfg(928011114)
				local var_481_9 = arg_478_1:FormatText(var_481_8.content)

				arg_478_1.text_.text = var_481_9

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_11 = 55 <= 0 and var_481_7 or var_481_7 * (utf8.len(var_481_9) / 55)

				if (55 <= 0 and var_481_7 or var_481_7 * (utf8.len(var_481_9) / 55)) > 0 and var_481_7 < var_481_11 then
					arg_478_1.talkMaxDuration = var_481_11

					if var_481_11 + var_481_6 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_11 + var_481_6
					end
				end

				arg_478_1.text_.text = var_481_9
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011114", "story_v_side_old_928011.awb") ~= 0 then
					local var_481_12 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011114", "story_v_side_old_928011.awb") / 1000

					if var_481_12 + var_481_6 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_12 + var_481_6
					end

					if var_481_8.prefab_name ~= "" and arg_478_1.actors_[var_481_8.prefab_name] ~= nil then
						local var_481_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_8.prefab_name].transform, "story_v_side_old_928011", "928011114", "story_v_side_old_928011.awb")

						arg_478_1:RecordAudio("928011114", var_481_13)
						arg_478_1:RecordAudio("928011114", var_481_13)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011114", "story_v_side_old_928011.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011114", "story_v_side_old_928011.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_14 = math.max(var_481_7, arg_478_1.talkMaxDuration)

			if var_481_6 <= arg_478_1.time_ and arg_478_1.time_ < var_481_6 + var_481_14 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_6) / var_481_14

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_6 + var_481_14 and arg_478_1.time_ < var_481_6 + var_481_14 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_478_1:InitPlayNodeList()
	end,
	Play928011115 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 928011115
		arg_482_1.duration_ = 5

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play928011116(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 and not isNil(arg_482_1.actors_["1066ui_story"]) and arg_482_1.var_.characterEffect1066ui_story == nil then
				arg_482_1.var_.characterEffect1066ui_story = arg_482_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_0 = 0.200000002980232

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_0 and not isNil(arg_482_1.actors_["1066ui_story"]) then
				if arg_482_1.var_.characterEffect1066ui_story and not isNil(arg_482_1.actors_["1066ui_story"]) then
					arg_482_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_482_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_482_1.time_ - 0) / var_485_0)
				end
			end

			if arg_482_1.time_ >= 0 + var_485_0 and arg_482_1.time_ < 0 + var_485_0 + arg_485_0 and not isNil(arg_482_1.actors_["1066ui_story"]) and arg_482_1.var_.characterEffect1066ui_story then
				arg_482_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_482_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_485_1 = 0
			local var_485_2 = 0.45

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_1 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, true)
				arg_482_1.iconController_:SetSelectedState("hero")

				arg_482_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_482_1.callingController_:SetSelectedState("normal")

				arg_482_1.keyicon_.color = Color.New(1, 1, 1)
				arg_482_1.icon_.color = Color.New(1, 1, 1)

				local var_485_3 = arg_482_1:FormatText(arg_482_1:GetWordFromCfg(928011115).content)

				arg_482_1.text_.text = var_485_3

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_5 = 18 <= 0 and var_485_2 or var_485_2 * (utf8.len(var_485_3) / 18)

				if (18 <= 0 and var_485_2 or var_485_2 * (utf8.len(var_485_3) / 18)) > 0 and var_485_2 < var_485_5 then
					arg_482_1.talkMaxDuration = var_485_5

					if var_485_5 + var_485_1 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_5 + var_485_1
					end
				end

				arg_482_1.text_.text = var_485_3
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_6 = math.max(var_485_2, arg_482_1.talkMaxDuration)

			if var_485_1 <= arg_482_1.time_ and arg_482_1.time_ < var_485_1 + var_485_6 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_1) / var_485_6

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_1 + var_485_6 and arg_482_1.time_ < var_485_1 + var_485_6 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play928011116 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 928011116
		arg_486_1.duration_ = 10.73

		local var_486_0 = {
			zh = 9.5,
			ja = 10.733
		}
		local var_486_1 = manager.audio:GetLocalizationFlag()

		if var_486_0[var_486_1] ~= nil then
			arg_486_1.duration_ = var_486_0[var_486_1]
		end

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play928011117(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 and not isNil(arg_486_1.actors_["1066ui_story"]) and arg_486_1.var_.characterEffect1066ui_story == nil then
				arg_486_1.var_.characterEffect1066ui_story = arg_486_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_0 = 0.200000002980232

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_0 and not isNil(arg_486_1.actors_["1066ui_story"]) then
				if arg_486_1.var_.characterEffect1066ui_story and not isNil(arg_486_1.actors_["1066ui_story"]) then
					arg_486_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_486_1.time_ >= 0 + var_489_0 and arg_486_1.time_ < 0 + var_489_0 + arg_489_0 and not isNil(arg_486_1.actors_["1066ui_story"]) and arg_486_1.var_.characterEffect1066ui_story then
				arg_486_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action438")
			end

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_489_2 = 0
			local var_489_3 = 1.225

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_2 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				arg_486_1.leftNameTxt_.text = arg_486_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_4 = arg_486_1:GetWordFromCfg(928011116)
				local var_489_5 = arg_486_1:FormatText(var_489_4.content)

				arg_486_1.text_.text = var_489_5

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_7 = 49 <= 0 and var_489_3 or var_489_3 * (utf8.len(var_489_5) / 49)

				if (49 <= 0 and var_489_3 or var_489_3 * (utf8.len(var_489_5) / 49)) > 0 and var_489_3 < var_489_7 then
					arg_486_1.talkMaxDuration = var_489_7

					if var_489_7 + var_489_2 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_7 + var_489_2
					end
				end

				arg_486_1.text_.text = var_489_5
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011116", "story_v_side_old_928011.awb") ~= 0 then
					local var_489_8 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011116", "story_v_side_old_928011.awb") / 1000

					if var_489_8 + var_489_2 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_8 + var_489_2
					end

					if var_489_4.prefab_name ~= "" and arg_486_1.actors_[var_489_4.prefab_name] ~= nil then
						local var_489_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_4.prefab_name].transform, "story_v_side_old_928011", "928011116", "story_v_side_old_928011.awb")

						arg_486_1:RecordAudio("928011116", var_489_9)
						arg_486_1:RecordAudio("928011116", var_489_9)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011116", "story_v_side_old_928011.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011116", "story_v_side_old_928011.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_10 = math.max(var_489_3, arg_486_1.talkMaxDuration)

			if var_489_2 <= arg_486_1.time_ and arg_486_1.time_ < var_489_2 + var_489_10 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_2) / var_489_10

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_2 + var_489_10 and arg_486_1.time_ < var_489_2 + var_489_10 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play928011117 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 928011117
		arg_490_1.duration_ = 9.13

		local var_490_0 = {
			zh = 5.533,
			ja = 9.133
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play928011118(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1.var_.moveOldPos1033ui_story = arg_490_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_493_0 = 0.001

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_0 then
				arg_490_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_490_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_490_1.time_ - 0) / var_493_0)
				arg_490_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_490_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_490_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_490_1.actors_["1033ui_story"].transform.position).z)
				arg_490_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_490_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_490_1.actors_["1033ui_story"].transform.localEulerAngles = arg_490_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_490_1.time_ >= 0 + var_493_0 and arg_490_1.time_ < 0 + var_493_0 + arg_493_0 then
				arg_490_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_490_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_490_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_490_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_490_1.actors_["1033ui_story"].transform.position).z)
				arg_490_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_490_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_490_1.actors_["1033ui_story"].transform.localEulerAngles = arg_490_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_493_1 = arg_490_1.actors_["1066ui_story"].transform

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1.var_.moveOldPos1066ui_story = var_493_1.localPosition
			end

			local var_493_2 = 0.001

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_2 then
				var_493_1.localPosition = Vector3.Lerp(arg_490_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_490_1.time_ - 0) / var_493_2)
				var_493_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_493_1.position).x, (manager.ui.mainCamera.transform.position - var_493_1.position).y, (manager.ui.mainCamera.transform.position - var_493_1.position).z)
				var_493_1.localEulerAngles.z = 0
				var_493_1.localEulerAngles.x = 0
				var_493_1.localEulerAngles = var_493_1.localEulerAngles
			end

			if arg_490_1.time_ >= 0 + var_493_2 and arg_490_1.time_ < 0 + var_493_2 + arg_493_0 then
				var_493_1.localPosition = Vector3.New(0, 100, 0)
				var_493_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_493_1.position).x, (manager.ui.mainCamera.transform.position - var_493_1.position).y, (manager.ui.mainCamera.transform.position - var_493_1.position).z)
				var_493_1.localEulerAngles.z = 0
				var_493_1.localEulerAngles.x = 0
				var_493_1.localEulerAngles = var_493_1.localEulerAngles
			end

			local var_493_3 = arg_490_1.actors_["1033ui_story"]

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 and not isNil(var_493_3) and arg_490_1.var_.characterEffect1033ui_story == nil then
				arg_490_1.var_.characterEffect1033ui_story = var_493_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_4 = 0.200000002980232

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_4 and not isNil(var_493_3) then
				if arg_490_1.var_.characterEffect1033ui_story and not isNil(var_493_3) then
					arg_490_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_490_1.time_ >= 0 + var_493_4 and arg_490_1.time_ < 0 + var_493_4 + arg_493_0 and not isNil(var_493_3) and arg_490_1.var_.characterEffect1033ui_story then
				arg_490_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_493_6 = arg_490_1.actors_["1066ui_story"]

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 and not isNil(var_493_6) and arg_490_1.var_.characterEffect1066ui_story == nil then
				arg_490_1.var_.characterEffect1066ui_story = var_493_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_7 = 0.200000002980232

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_7 and not isNil(var_493_6) then
				if arg_490_1.var_.characterEffect1066ui_story and not isNil(var_493_6) then
					arg_490_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_490_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_490_1.time_ - 0) / var_493_7)
				end
			end

			if arg_490_1.time_ >= 0 + var_493_7 and arg_490_1.time_ < 0 + var_493_7 + arg_493_0 and not isNil(var_493_6) and arg_490_1.var_.characterEffect1066ui_story then
				arg_490_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_490_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_493_8 = 0
			local var_493_9 = 0.725

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_8 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_10 = arg_490_1:GetWordFromCfg(928011117)
				local var_493_11 = arg_490_1:FormatText(var_493_10.content)

				arg_490_1.text_.text = var_493_11

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_13 = 29 <= 0 and var_493_9 or var_493_9 * (utf8.len(var_493_11) / 29)

				if (29 <= 0 and var_493_9 or var_493_9 * (utf8.len(var_493_11) / 29)) > 0 and var_493_9 < var_493_13 then
					arg_490_1.talkMaxDuration = var_493_13

					if var_493_13 + var_493_8 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_13 + var_493_8
					end
				end

				arg_490_1.text_.text = var_493_11
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011117", "story_v_side_old_928011.awb") ~= 0 then
					local var_493_14 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011117", "story_v_side_old_928011.awb") / 1000

					if var_493_14 + var_493_8 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_14 + var_493_8
					end

					if var_493_10.prefab_name ~= "" and arg_490_1.actors_[var_493_10.prefab_name] ~= nil then
						local var_493_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_10.prefab_name].transform, "story_v_side_old_928011", "928011117", "story_v_side_old_928011.awb")

						arg_490_1:RecordAudio("928011117", var_493_15)
						arg_490_1:RecordAudio("928011117", var_493_15)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011117", "story_v_side_old_928011.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011117", "story_v_side_old_928011.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_16 = math.max(var_493_9, arg_490_1.talkMaxDuration)

			if var_493_8 <= arg_490_1.time_ and arg_490_1.time_ < var_493_8 + var_493_16 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_8) / var_493_16

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_8 + var_493_16 and arg_490_1.time_ < var_493_8 + var_493_16 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_490_1:InitPlayNodeList()
	end,
	Play928011118 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 928011118
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play928011119(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 and not isNil(arg_494_1.actors_["1033ui_story"]) and arg_494_1.var_.characterEffect1033ui_story == nil then
				arg_494_1.var_.characterEffect1033ui_story = arg_494_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_0 = 0.200000002980232

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_0 and not isNil(arg_494_1.actors_["1033ui_story"]) then
				if arg_494_1.var_.characterEffect1033ui_story and not isNil(arg_494_1.actors_["1033ui_story"]) then
					arg_494_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_494_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_494_1.time_ - 0) / var_497_0)
				end
			end

			if arg_494_1.time_ >= 0 + var_497_0 and arg_494_1.time_ < 0 + var_497_0 + arg_497_0 and not isNil(arg_494_1.actors_["1033ui_story"]) and arg_494_1.var_.characterEffect1033ui_story then
				arg_494_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_494_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_497_1 = 0
			local var_497_2 = 0.975

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, false)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_3 = arg_494_1:FormatText(arg_494_1:GetWordFromCfg(928011118).content)

				arg_494_1.text_.text = var_497_3

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_5 = 39 <= 0 and var_497_2 or var_497_2 * (utf8.len(var_497_3) / 39)

				if (39 <= 0 and var_497_2 or var_497_2 * (utf8.len(var_497_3) / 39)) > 0 and var_497_2 < var_497_5 then
					arg_494_1.talkMaxDuration = var_497_5

					if var_497_5 + var_497_1 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_5 + var_497_1
					end
				end

				arg_494_1.text_.text = var_497_3
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_6 = math.max(var_497_2, arg_494_1.talkMaxDuration)

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_6 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_1) / var_497_6

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_1 + var_497_6 and arg_494_1.time_ < var_497_1 + var_497_6 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play928011119 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 928011119
		arg_498_1.duration_ = 13.6

		local var_498_0 = {
			zh = 9.3,
			ja = 13.6
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play928011120(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 and not isNil(arg_498_1.actors_["1033ui_story"]) and arg_498_1.var_.characterEffect1033ui_story == nil then
				arg_498_1.var_.characterEffect1033ui_story = arg_498_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_0 = 0.200000002980232

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_0 and not isNil(arg_498_1.actors_["1033ui_story"]) then
				if arg_498_1.var_.characterEffect1033ui_story and not isNil(arg_498_1.actors_["1033ui_story"]) then
					arg_498_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= 0 + var_501_0 and arg_498_1.time_ < 0 + var_501_0 + arg_501_0 and not isNil(arg_498_1.actors_["1033ui_story"]) and arg_498_1.var_.characterEffect1033ui_story then
				arg_498_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_501_2 = 0
			local var_501_3 = 1.175

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_2 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_4 = arg_498_1:GetWordFromCfg(928011119)
				local var_501_5 = arg_498_1:FormatText(var_501_4.content)

				arg_498_1.text_.text = var_501_5

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_7 = 47 <= 0 and var_501_3 or var_501_3 * (utf8.len(var_501_5) / 47)

				if (47 <= 0 and var_501_3 or var_501_3 * (utf8.len(var_501_5) / 47)) > 0 and var_501_3 < var_501_7 then
					arg_498_1.talkMaxDuration = var_501_7

					if var_501_7 + var_501_2 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_7 + var_501_2
					end
				end

				arg_498_1.text_.text = var_501_5
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011119", "story_v_side_old_928011.awb") ~= 0 then
					local var_501_8 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011119", "story_v_side_old_928011.awb") / 1000

					if var_501_8 + var_501_2 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_8 + var_501_2
					end

					if var_501_4.prefab_name ~= "" and arg_498_1.actors_[var_501_4.prefab_name] ~= nil then
						local var_501_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_4.prefab_name].transform, "story_v_side_old_928011", "928011119", "story_v_side_old_928011.awb")

						arg_498_1:RecordAudio("928011119", var_501_9)
						arg_498_1:RecordAudio("928011119", var_501_9)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011119", "story_v_side_old_928011.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011119", "story_v_side_old_928011.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_10 = math.max(var_501_3, arg_498_1.talkMaxDuration)

			if var_501_2 <= arg_498_1.time_ and arg_498_1.time_ < var_501_2 + var_501_10 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_2) / var_501_10

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_2 + var_501_10 and arg_498_1.time_ < var_501_2 + var_501_10 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play928011120 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 928011120
		arg_502_1.duration_ = 13.97

		local var_502_0 = {
			zh = 7.266,
			ja = 13.966
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play928011121(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action436")
			end

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_505_0 = 0
			local var_505_1 = 0.975

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_0 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_2 = arg_502_1:GetWordFromCfg(928011120)
				local var_505_3 = arg_502_1:FormatText(var_505_2.content)

				arg_502_1.text_.text = var_505_3

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_5 = 42 <= 0 and var_505_1 or var_505_1 * (utf8.len(var_505_3) / 42)

				if (42 <= 0 and var_505_1 or var_505_1 * (utf8.len(var_505_3) / 42)) > 0 and var_505_1 < var_505_5 then
					arg_502_1.talkMaxDuration = var_505_5

					if var_505_5 + var_505_0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_5 + var_505_0
					end
				end

				arg_502_1.text_.text = var_505_3
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011120", "story_v_side_old_928011.awb") ~= 0 then
					local var_505_6 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011120", "story_v_side_old_928011.awb") / 1000

					if var_505_6 + var_505_0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_6 + var_505_0
					end

					if var_505_2.prefab_name ~= "" and arg_502_1.actors_[var_505_2.prefab_name] ~= nil then
						local var_505_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_2.prefab_name].transform, "story_v_side_old_928011", "928011120", "story_v_side_old_928011.awb")

						arg_502_1:RecordAudio("928011120", var_505_7)
						arg_502_1:RecordAudio("928011120", var_505_7)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011120", "story_v_side_old_928011.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011120", "story_v_side_old_928011.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_8 = math.max(var_505_1, arg_502_1.talkMaxDuration)

			if var_505_0 <= arg_502_1.time_ and arg_502_1.time_ < var_505_0 + var_505_8 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_0) / var_505_8

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_0 + var_505_8 and arg_502_1.time_ < var_505_0 + var_505_8 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play928011121 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 928011121
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play928011122(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 and not isNil(arg_506_1.actors_["1033ui_story"]) and arg_506_1.var_.characterEffect1033ui_story == nil then
				arg_506_1.var_.characterEffect1033ui_story = arg_506_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_0 = 0.200000002980232

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_0 and not isNil(arg_506_1.actors_["1033ui_story"]) then
				if arg_506_1.var_.characterEffect1033ui_story and not isNil(arg_506_1.actors_["1033ui_story"]) then
					arg_506_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_506_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_506_1.time_ - 0) / var_509_0)
				end
			end

			if arg_506_1.time_ >= 0 + var_509_0 and arg_506_1.time_ < 0 + var_509_0 + arg_509_0 and not isNil(arg_506_1.actors_["1033ui_story"]) and arg_506_1.var_.characterEffect1033ui_story then
				arg_506_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_506_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_509_1 = 0
			local var_509_2 = 0.575

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_1 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				arg_506_1.leftNameTxt_.text = arg_506_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, true)
				arg_506_1.iconController_:SetSelectedState("hero")

				arg_506_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_506_1.callingController_:SetSelectedState("normal")

				arg_506_1.keyicon_.color = Color.New(1, 1, 1)
				arg_506_1.icon_.color = Color.New(1, 1, 1)

				local var_509_3 = arg_506_1:FormatText(arg_506_1:GetWordFromCfg(928011121).content)

				arg_506_1.text_.text = var_509_3

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_5 = 23 <= 0 and var_509_2 or var_509_2 * (utf8.len(var_509_3) / 23)

				if (23 <= 0 and var_509_2 or var_509_2 * (utf8.len(var_509_3) / 23)) > 0 and var_509_2 < var_509_5 then
					arg_506_1.talkMaxDuration = var_509_5

					if var_509_5 + var_509_1 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_5 + var_509_1
					end
				end

				arg_506_1.text_.text = var_509_3
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_6 = math.max(var_509_2, arg_506_1.talkMaxDuration)

			if var_509_1 <= arg_506_1.time_ and arg_506_1.time_ < var_509_1 + var_509_6 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_1) / var_509_6

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_1 + var_509_6 and arg_506_1.time_ < var_509_1 + var_509_6 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play928011122 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 928011122
		arg_510_1.duration_ = 14.03

		local var_510_0 = {
			zh = 11,
			ja = 14.033
		}
		local var_510_1 = manager.audio:GetLocalizationFlag()

		if var_510_0[var_510_1] ~= nil then
			arg_510_1.duration_ = var_510_0[var_510_1]
		end

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play928011123(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 and not isNil(arg_510_1.actors_["1033ui_story"]) and arg_510_1.var_.characterEffect1033ui_story == nil then
				arg_510_1.var_.characterEffect1033ui_story = arg_510_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_0 = 0.200000002980232

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_0 and not isNil(arg_510_1.actors_["1033ui_story"]) then
				if arg_510_1.var_.characterEffect1033ui_story and not isNil(arg_510_1.actors_["1033ui_story"]) then
					arg_510_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_510_1.time_ >= 0 + var_513_0 and arg_510_1.time_ < 0 + var_513_0 + arg_513_0 and not isNil(arg_510_1.actors_["1033ui_story"]) and arg_510_1.var_.characterEffect1033ui_story then
				arg_510_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_513_2 = 0
			local var_513_3 = 1.4

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_2 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				arg_510_1.leftNameTxt_.text = arg_510_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_4 = arg_510_1:GetWordFromCfg(928011122)
				local var_513_5 = arg_510_1:FormatText(var_513_4.content)

				arg_510_1.text_.text = var_513_5

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_7 = 56 <= 0 and var_513_3 or var_513_3 * (utf8.len(var_513_5) / 56)

				if (56 <= 0 and var_513_3 or var_513_3 * (utf8.len(var_513_5) / 56)) > 0 and var_513_3 < var_513_7 then
					arg_510_1.talkMaxDuration = var_513_7

					if var_513_7 + var_513_2 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_7 + var_513_2
					end
				end

				arg_510_1.text_.text = var_513_5
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011122", "story_v_side_old_928011.awb") ~= 0 then
					local var_513_8 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011122", "story_v_side_old_928011.awb") / 1000

					if var_513_8 + var_513_2 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_8 + var_513_2
					end

					if var_513_4.prefab_name ~= "" and arg_510_1.actors_[var_513_4.prefab_name] ~= nil then
						local var_513_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_4.prefab_name].transform, "story_v_side_old_928011", "928011122", "story_v_side_old_928011.awb")

						arg_510_1:RecordAudio("928011122", var_513_9)
						arg_510_1:RecordAudio("928011122", var_513_9)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011122", "story_v_side_old_928011.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011122", "story_v_side_old_928011.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_10 = math.max(var_513_3, arg_510_1.talkMaxDuration)

			if var_513_2 <= arg_510_1.time_ and arg_510_1.time_ < var_513_2 + var_513_10 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_2) / var_513_10

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_2 + var_513_10 and arg_510_1.time_ < var_513_2 + var_513_10 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play928011123 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 928011123
		arg_514_1.duration_ = 14.77

		local var_514_0 = {
			zh = 10.7,
			ja = 14.766
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play928011124(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action6_2")
			end

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_517_0 = 0
			local var_517_1 = 1.275

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_0 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_2 = arg_514_1:GetWordFromCfg(928011123)
				local var_517_3 = arg_514_1:FormatText(var_517_2.content)

				arg_514_1.text_.text = var_517_3

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_5 = 51 <= 0 and var_517_1 or var_517_1 * (utf8.len(var_517_3) / 51)

				if (51 <= 0 and var_517_1 or var_517_1 * (utf8.len(var_517_3) / 51)) > 0 and var_517_1 < var_517_5 then
					arg_514_1.talkMaxDuration = var_517_5

					if var_517_5 + var_517_0 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_5 + var_517_0
					end
				end

				arg_514_1.text_.text = var_517_3
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011123", "story_v_side_old_928011.awb") ~= 0 then
					local var_517_6 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011123", "story_v_side_old_928011.awb") / 1000

					if var_517_6 + var_517_0 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_6 + var_517_0
					end

					if var_517_2.prefab_name ~= "" and arg_514_1.actors_[var_517_2.prefab_name] ~= nil then
						local var_517_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_2.prefab_name].transform, "story_v_side_old_928011", "928011123", "story_v_side_old_928011.awb")

						arg_514_1:RecordAudio("928011123", var_517_7)
						arg_514_1:RecordAudio("928011123", var_517_7)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011123", "story_v_side_old_928011.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011123", "story_v_side_old_928011.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_8 = math.max(var_517_1, arg_514_1.talkMaxDuration)

			if var_517_0 <= arg_514_1.time_ and arg_514_1.time_ < var_517_0 + var_517_8 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_0) / var_517_8

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_0 + var_517_8 and arg_514_1.time_ < var_517_0 + var_517_8 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play928011124 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 928011124
		arg_518_1.duration_ = 3.03

		local var_518_0 = {
			zh = 2.233,
			ja = 3.033
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play928011125(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(arg_518_1.actors_["1066ui_story"]) and arg_518_1.var_.characterEffect1066ui_story == nil then
				arg_518_1.var_.characterEffect1066ui_story = arg_518_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_0 = 0.200000002980232

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_0 and not isNil(arg_518_1.actors_["1066ui_story"]) then
				if arg_518_1.var_.characterEffect1066ui_story and not isNil(arg_518_1.actors_["1066ui_story"]) then
					arg_518_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_518_1.time_ >= 0 + var_521_0 and arg_518_1.time_ < 0 + var_521_0 + arg_521_0 and not isNil(arg_518_1.actors_["1066ui_story"]) and arg_518_1.var_.characterEffect1066ui_story then
				arg_518_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_521_2 = arg_518_1.actors_["1033ui_story"]

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(var_521_2) and arg_518_1.var_.characterEffect1033ui_story == nil then
				arg_518_1.var_.characterEffect1033ui_story = var_521_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_3 = 0.200000002980232

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_3 and not isNil(var_521_2) then
				if arg_518_1.var_.characterEffect1033ui_story and not isNil(var_521_2) then
					arg_518_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_518_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_518_1.time_ - 0) / var_521_3)
				end
			end

			if arg_518_1.time_ >= 0 + var_521_3 and arg_518_1.time_ < 0 + var_521_3 + arg_521_0 and not isNil(var_521_2) and arg_518_1.var_.characterEffect1033ui_story then
				arg_518_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_518_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_521_4 = arg_518_1.actors_["1066ui_story"].transform

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1.var_.moveOldPos1066ui_story = var_521_4.localPosition
			end

			local var_521_5 = 0.001

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_5 then
				var_521_4.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_518_1.time_ - 0) / var_521_5)
				var_521_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_521_4.position).x, (manager.ui.mainCamera.transform.position - var_521_4.position).y, (manager.ui.mainCamera.transform.position - var_521_4.position).z)
				var_521_4.localEulerAngles.z = 0
				var_521_4.localEulerAngles.x = 0
				var_521_4.localEulerAngles = var_521_4.localEulerAngles
			end

			if arg_518_1.time_ >= 0 + var_521_5 and arg_518_1.time_ < 0 + var_521_5 + arg_521_0 then
				var_521_4.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				var_521_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_521_4.position).x, (manager.ui.mainCamera.transform.position - var_521_4.position).y, (manager.ui.mainCamera.transform.position - var_521_4.position).z)
				var_521_4.localEulerAngles.z = 0
				var_521_4.localEulerAngles.x = 0
				var_521_4.localEulerAngles = var_521_4.localEulerAngles
			end

			local var_521_6 = arg_518_1.actors_["1033ui_story"].transform

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1.var_.moveOldPos1033ui_story = var_521_6.localPosition
			end

			local var_521_7 = 0.001

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_7 then
				var_521_6.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_518_1.time_ - 0) / var_521_7)
				var_521_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_521_6.position).x, (manager.ui.mainCamera.transform.position - var_521_6.position).y, (manager.ui.mainCamera.transform.position - var_521_6.position).z)
				var_521_6.localEulerAngles.z = 0
				var_521_6.localEulerAngles.x = 0
				var_521_6.localEulerAngles = var_521_6.localEulerAngles
			end

			if arg_518_1.time_ >= 0 + var_521_7 and arg_518_1.time_ < 0 + var_521_7 + arg_521_0 then
				var_521_6.localPosition = Vector3.New(0.7, -1.01, -6.13)
				var_521_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_521_6.position).x, (manager.ui.mainCamera.transform.position - var_521_6.position).y, (manager.ui.mainCamera.transform.position - var_521_6.position).z)
				var_521_6.localEulerAngles.z = 0
				var_521_6.localEulerAngles.x = 0
				var_521_6.localEulerAngles = var_521_6.localEulerAngles
			end

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action8_2")
			end

			local var_521_8 = 0
			local var_521_9 = 0.225

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_8 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				arg_518_1.leftNameTxt_.text = arg_518_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_10 = arg_518_1:GetWordFromCfg(928011124)
				local var_521_11 = arg_518_1:FormatText(var_521_10.content)

				arg_518_1.text_.text = var_521_11

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_13 = 9 <= 0 and var_521_9 or var_521_9 * (utf8.len(var_521_11) / 9)

				if (9 <= 0 and var_521_9 or var_521_9 * (utf8.len(var_521_11) / 9)) > 0 and var_521_9 < var_521_13 then
					arg_518_1.talkMaxDuration = var_521_13

					if var_521_13 + var_521_8 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_13 + var_521_8
					end
				end

				arg_518_1.text_.text = var_521_11
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011124", "story_v_side_old_928011.awb") ~= 0 then
					local var_521_14 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011124", "story_v_side_old_928011.awb") / 1000

					if var_521_14 + var_521_8 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_14 + var_521_8
					end

					if var_521_10.prefab_name ~= "" and arg_518_1.actors_[var_521_10.prefab_name] ~= nil then
						local var_521_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_10.prefab_name].transform, "story_v_side_old_928011", "928011124", "story_v_side_old_928011.awb")

						arg_518_1:RecordAudio("928011124", var_521_15)
						arg_518_1:RecordAudio("928011124", var_521_15)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011124", "story_v_side_old_928011.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011124", "story_v_side_old_928011.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_16 = math.max(var_521_9, arg_518_1.talkMaxDuration)

			if var_521_8 <= arg_518_1.time_ and arg_518_1.time_ < var_521_8 + var_521_16 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_8) / var_521_16

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_8 + var_521_16 and arg_518_1.time_ < var_521_8 + var_521_16 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_518_1:InitPlayNodeList()
	end,
	Play928011125 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 928011125
		arg_522_1.duration_ = 5

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play928011126(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 and not isNil(arg_522_1.actors_["1066ui_story"]) and arg_522_1.var_.characterEffect1066ui_story == nil then
				arg_522_1.var_.characterEffect1066ui_story = arg_522_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_0 = 0.200000002980232

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_0 and not isNil(arg_522_1.actors_["1066ui_story"]) then
				if arg_522_1.var_.characterEffect1066ui_story and not isNil(arg_522_1.actors_["1066ui_story"]) then
					arg_522_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_522_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_522_1.time_ - 0) / var_525_0)
				end
			end

			if arg_522_1.time_ >= 0 + var_525_0 and arg_522_1.time_ < 0 + var_525_0 + arg_525_0 and not isNil(arg_522_1.actors_["1066ui_story"]) and arg_522_1.var_.characterEffect1066ui_story then
				arg_522_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_522_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_525_1 = 0
			local var_525_2 = 0.3

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_1 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				arg_522_1.leftNameTxt_.text = arg_522_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, true)
				arg_522_1.iconController_:SetSelectedState("hero")

				arg_522_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_522_1.callingController_:SetSelectedState("normal")

				arg_522_1.keyicon_.color = Color.New(1, 1, 1)
				arg_522_1.icon_.color = Color.New(1, 1, 1)

				local var_525_3 = arg_522_1:FormatText(arg_522_1:GetWordFromCfg(928011125).content)

				arg_522_1.text_.text = var_525_3

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_5 = 12 <= 0 and var_525_2 or var_525_2 * (utf8.len(var_525_3) / 12)

				if (12 <= 0 and var_525_2 or var_525_2 * (utf8.len(var_525_3) / 12)) > 0 and var_525_2 < var_525_5 then
					arg_522_1.talkMaxDuration = var_525_5

					if var_525_5 + var_525_1 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_5 + var_525_1
					end
				end

				arg_522_1.text_.text = var_525_3
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)
				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_6 = math.max(var_525_2, arg_522_1.talkMaxDuration)

			if var_525_1 <= arg_522_1.time_ and arg_522_1.time_ < var_525_1 + var_525_6 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_1) / var_525_6

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_1 + var_525_6 and arg_522_1.time_ < var_525_1 + var_525_6 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play928011126 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 928011126
		arg_526_1.duration_ = 5.43

		local var_526_0 = {
			zh = 4.7,
			ja = 5.433
		}
		local var_526_1 = manager.audio:GetLocalizationFlag()

		if var_526_0[var_526_1] ~= nil then
			arg_526_1.duration_ = var_526_0[var_526_1]
		end

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play928011127(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1.var_.moveOldPos1033ui_story = arg_526_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_529_0 = 0.001

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_0 then
				arg_526_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_526_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_526_1.time_ - 0) / var_529_0)
				arg_526_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_526_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_526_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_526_1.actors_["1033ui_story"].transform.position).z)
				arg_526_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_526_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_526_1.actors_["1033ui_story"].transform.localEulerAngles = arg_526_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_526_1.time_ >= 0 + var_529_0 and arg_526_1.time_ < 0 + var_529_0 + arg_529_0 then
				arg_526_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.13)
				arg_526_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_526_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_526_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_526_1.actors_["1033ui_story"].transform.position).z)
				arg_526_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_526_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_526_1.actors_["1033ui_story"].transform.localEulerAngles = arg_526_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_529_1 = arg_526_1.actors_["1066ui_story"].transform

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1.var_.moveOldPos1066ui_story = var_529_1.localPosition
			end

			local var_529_2 = 0.001

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_2 then
				var_529_1.localPosition = Vector3.Lerp(arg_526_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_526_1.time_ - 0) / var_529_2)
				var_529_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_529_1.position).x, (manager.ui.mainCamera.transform.position - var_529_1.position).y, (manager.ui.mainCamera.transform.position - var_529_1.position).z)
				var_529_1.localEulerAngles.z = 0
				var_529_1.localEulerAngles.x = 0
				var_529_1.localEulerAngles = var_529_1.localEulerAngles
			end

			if arg_526_1.time_ >= 0 + var_529_2 and arg_526_1.time_ < 0 + var_529_2 + arg_529_0 then
				var_529_1.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				var_529_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_529_1.position).x, (manager.ui.mainCamera.transform.position - var_529_1.position).y, (manager.ui.mainCamera.transform.position - var_529_1.position).z)
				var_529_1.localEulerAngles.z = 0
				var_529_1.localEulerAngles.x = 0
				var_529_1.localEulerAngles = var_529_1.localEulerAngles
			end

			local var_529_3 = arg_526_1.actors_["1066ui_story"]

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 and not isNil(var_529_3) and arg_526_1.var_.characterEffect1066ui_story == nil then
				arg_526_1.var_.characterEffect1066ui_story = var_529_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_4 = 0.200000002980232

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_4 and not isNil(var_529_3) then
				if arg_526_1.var_.characterEffect1066ui_story and not isNil(var_529_3) then
					arg_526_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_526_1.time_ >= 0 + var_529_4 and arg_526_1.time_ < 0 + var_529_4 + arg_529_0 and not isNil(var_529_3) and arg_526_1.var_.characterEffect1066ui_story then
				arg_526_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action6_1")
			end

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_529_6 = 0
			local var_529_7 = 0.5

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_6 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				arg_526_1.leftNameTxt_.text = arg_526_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_8 = arg_526_1:GetWordFromCfg(928011126)
				local var_529_9 = arg_526_1:FormatText(var_529_8.content)

				arg_526_1.text_.text = var_529_9

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_11 = 20 <= 0 and var_529_7 or var_529_7 * (utf8.len(var_529_9) / 20)

				if (20 <= 0 and var_529_7 or var_529_7 * (utf8.len(var_529_9) / 20)) > 0 and var_529_7 < var_529_11 then
					arg_526_1.talkMaxDuration = var_529_11

					if var_529_11 + var_529_6 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_11 + var_529_6
					end
				end

				arg_526_1.text_.text = var_529_9
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011126", "story_v_side_old_928011.awb") ~= 0 then
					local var_529_12 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011126", "story_v_side_old_928011.awb") / 1000

					if var_529_12 + var_529_6 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_12 + var_529_6
					end

					if var_529_8.prefab_name ~= "" and arg_526_1.actors_[var_529_8.prefab_name] ~= nil then
						local var_529_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_8.prefab_name].transform, "story_v_side_old_928011", "928011126", "story_v_side_old_928011.awb")

						arg_526_1:RecordAudio("928011126", var_529_13)
						arg_526_1:RecordAudio("928011126", var_529_13)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011126", "story_v_side_old_928011.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011126", "story_v_side_old_928011.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_14 = math.max(var_529_7, arg_526_1.talkMaxDuration)

			if var_529_6 <= arg_526_1.time_ and arg_526_1.time_ < var_529_6 + var_529_14 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_6) / var_529_14

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_6 + var_529_14 and arg_526_1.time_ < var_529_6 + var_529_14 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_526_1:InitPlayNodeList()
	end,
	Play928011127 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 928011127
		arg_530_1.duration_ = 16.27

		local var_530_0 = {
			zh = 10.066,
			ja = 16.266
		}
		local var_530_1 = manager.audio:GetLocalizationFlag()

		if var_530_0[var_530_1] ~= nil then
			arg_530_1.duration_ = var_530_0[var_530_1]
		end

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play928011128(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 then
				arg_530_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action6_2")
			end

			local var_533_0 = 0
			local var_533_1 = 1.2

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= var_533_0 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				arg_530_1.leftNameTxt_.text = arg_530_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_2 = arg_530_1:GetWordFromCfg(928011127)
				local var_533_3 = arg_530_1:FormatText(var_533_2.content)

				arg_530_1.text_.text = var_533_3

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_5 = 48 <= 0 and var_533_1 or var_533_1 * (utf8.len(var_533_3) / 48)

				if (48 <= 0 and var_533_1 or var_533_1 * (utf8.len(var_533_3) / 48)) > 0 and var_533_1 < var_533_5 then
					arg_530_1.talkMaxDuration = var_533_5

					if var_533_5 + var_533_0 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_5 + var_533_0
					end
				end

				arg_530_1.text_.text = var_533_3
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011127", "story_v_side_old_928011.awb") ~= 0 then
					local var_533_6 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011127", "story_v_side_old_928011.awb") / 1000

					if var_533_6 + var_533_0 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_6 + var_533_0
					end

					if var_533_2.prefab_name ~= "" and arg_530_1.actors_[var_533_2.prefab_name] ~= nil then
						local var_533_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_2.prefab_name].transform, "story_v_side_old_928011", "928011127", "story_v_side_old_928011.awb")

						arg_530_1:RecordAudio("928011127", var_533_7)
						arg_530_1:RecordAudio("928011127", var_533_7)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011127", "story_v_side_old_928011.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011127", "story_v_side_old_928011.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_8 = math.max(var_533_1, arg_530_1.talkMaxDuration)

			if var_533_0 <= arg_530_1.time_ and arg_530_1.time_ < var_533_0 + var_533_8 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_0) / var_533_8

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_0 + var_533_8 and arg_530_1.time_ < var_533_0 + var_533_8 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play928011128 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 928011128
		arg_534_1.duration_ = 13.67

		local var_534_0 = {
			zh = 10.633,
			ja = 13.666
		}
		local var_534_1 = manager.audio:GetLocalizationFlag()

		if var_534_0[var_534_1] ~= nil then
			arg_534_1.duration_ = var_534_0[var_534_1]
		end

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play928011129(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 and not isNil(arg_534_1.actors_["1033ui_story"]) and arg_534_1.var_.characterEffect1033ui_story == nil then
				arg_534_1.var_.characterEffect1033ui_story = arg_534_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_537_0 = 0.200000002980232

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_0 and not isNil(arg_534_1.actors_["1033ui_story"]) then
				if arg_534_1.var_.characterEffect1033ui_story and not isNil(arg_534_1.actors_["1033ui_story"]) then
					arg_534_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_534_1.time_ >= 0 + var_537_0 and arg_534_1.time_ < 0 + var_537_0 + arg_537_0 and not isNil(arg_534_1.actors_["1033ui_story"]) and arg_534_1.var_.characterEffect1033ui_story then
				arg_534_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_537_2 = arg_534_1.actors_["1066ui_story"]

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 and not isNil(var_537_2) and arg_534_1.var_.characterEffect1066ui_story == nil then
				arg_534_1.var_.characterEffect1066ui_story = var_537_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_537_3 = 0.200000002980232

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_3 and not isNil(var_537_2) then
				if arg_534_1.var_.characterEffect1066ui_story and not isNil(var_537_2) then
					arg_534_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_534_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_534_1.time_ - 0) / var_537_3)
				end
			end

			if arg_534_1.time_ >= 0 + var_537_3 and arg_534_1.time_ < 0 + var_537_3 + arg_537_0 and not isNil(var_537_2) and arg_534_1.var_.characterEffect1066ui_story then
				arg_534_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_534_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action4_1")
			end

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_537_4 = 0
			local var_537_5 = 1.375

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= var_537_4 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				arg_534_1.leftNameTxt_.text = arg_534_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_6 = arg_534_1:GetWordFromCfg(928011128)
				local var_537_7 = arg_534_1:FormatText(var_537_6.content)

				arg_534_1.text_.text = var_537_7

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_9 = 55 <= 0 and var_537_5 or var_537_5 * (utf8.len(var_537_7) / 55)

				if (55 <= 0 and var_537_5 or var_537_5 * (utf8.len(var_537_7) / 55)) > 0 and var_537_5 < var_537_9 then
					arg_534_1.talkMaxDuration = var_537_9

					if var_537_9 + var_537_4 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_9 + var_537_4
					end
				end

				arg_534_1.text_.text = var_537_7
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011128", "story_v_side_old_928011.awb") ~= 0 then
					local var_537_10 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011128", "story_v_side_old_928011.awb") / 1000

					if var_537_10 + var_537_4 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_10 + var_537_4
					end

					if var_537_6.prefab_name ~= "" and arg_534_1.actors_[var_537_6.prefab_name] ~= nil then
						local var_537_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_6.prefab_name].transform, "story_v_side_old_928011", "928011128", "story_v_side_old_928011.awb")

						arg_534_1:RecordAudio("928011128", var_537_11)
						arg_534_1:RecordAudio("928011128", var_537_11)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011128", "story_v_side_old_928011.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011128", "story_v_side_old_928011.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_12 = math.max(var_537_5, arg_534_1.talkMaxDuration)

			if var_537_4 <= arg_534_1.time_ and arg_534_1.time_ < var_537_4 + var_537_12 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_4) / var_537_12

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_4 + var_537_12 and arg_534_1.time_ < var_537_4 + var_537_12 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play928011129 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 928011129
		arg_538_1.duration_ = 4.5

		local var_538_0 = {
			zh = 3.233,
			ja = 4.5
		}
		local var_538_1 = manager.audio:GetLocalizationFlag()

		if var_538_0[var_538_1] ~= nil then
			arg_538_1.duration_ = var_538_0[var_538_1]
		end

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play928011130(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 and not isNil(arg_538_1.actors_["1066ui_story"]) and arg_538_1.var_.characterEffect1066ui_story == nil then
				arg_538_1.var_.characterEffect1066ui_story = arg_538_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_0 = 0.200000002980232

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_0 and not isNil(arg_538_1.actors_["1066ui_story"]) then
				if arg_538_1.var_.characterEffect1066ui_story and not isNil(arg_538_1.actors_["1066ui_story"]) then
					arg_538_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_538_1.time_ >= 0 + var_541_0 and arg_538_1.time_ < 0 + var_541_0 + arg_541_0 and not isNil(arg_538_1.actors_["1066ui_story"]) and arg_538_1.var_.characterEffect1066ui_story then
				arg_538_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_541_2 = arg_538_1.actors_["1033ui_story"]

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 and not isNil(var_541_2) and arg_538_1.var_.characterEffect1033ui_story == nil then
				arg_538_1.var_.characterEffect1033ui_story = var_541_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_3 = 0.200000002980232

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_3 and not isNil(var_541_2) then
				if arg_538_1.var_.characterEffect1033ui_story and not isNil(var_541_2) then
					arg_538_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_538_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_538_1.time_ - 0) / var_541_3)
				end
			end

			if arg_538_1.time_ >= 0 + var_541_3 and arg_538_1.time_ < 0 + var_541_3 + arg_541_0 and not isNil(var_541_2) and arg_538_1.var_.characterEffect1033ui_story then
				arg_538_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_538_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_541_4 = 0
			local var_541_5 = 0.3

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_4 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				arg_538_1.leftNameTxt_.text = arg_538_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_6 = arg_538_1:GetWordFromCfg(928011129)
				local var_541_7 = arg_538_1:FormatText(var_541_6.content)

				arg_538_1.text_.text = var_541_7

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_9 = 12 <= 0 and var_541_5 or var_541_5 * (utf8.len(var_541_7) / 12)

				if (12 <= 0 and var_541_5 or var_541_5 * (utf8.len(var_541_7) / 12)) > 0 and var_541_5 < var_541_9 then
					arg_538_1.talkMaxDuration = var_541_9

					if var_541_9 + var_541_4 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_9 + var_541_4
					end
				end

				arg_538_1.text_.text = var_541_7
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011129", "story_v_side_old_928011.awb") ~= 0 then
					local var_541_10 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011129", "story_v_side_old_928011.awb") / 1000

					if var_541_10 + var_541_4 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_10 + var_541_4
					end

					if var_541_6.prefab_name ~= "" and arg_538_1.actors_[var_541_6.prefab_name] ~= nil then
						local var_541_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_6.prefab_name].transform, "story_v_side_old_928011", "928011129", "story_v_side_old_928011.awb")

						arg_538_1:RecordAudio("928011129", var_541_11)
						arg_538_1:RecordAudio("928011129", var_541_11)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011129", "story_v_side_old_928011.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011129", "story_v_side_old_928011.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_12 = math.max(var_541_5, arg_538_1.talkMaxDuration)

			if var_541_4 <= arg_538_1.time_ and arg_538_1.time_ < var_541_4 + var_541_12 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_4) / var_541_12

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_4 + var_541_12 and arg_538_1.time_ < var_541_4 + var_541_12 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play928011130 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 928011130
		arg_542_1.duration_ = 1

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"

			SetActive(arg_542_1.choicesGo_, true)

			for iter_543_0, iter_543_1 in ipairs(arg_542_1.choices_) do
				SetActive(iter_543_1.go, iter_543_0 <= 2)
			end

			arg_542_1.choices_[1].txt.text = arg_542_1:FormatText(StoryChoiceCfg[1427].name)
			arg_542_1.choices_[2].txt.text = arg_542_1:FormatText(StoryChoiceCfg[1428].name)
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play928011131(arg_542_1)
			end

			if arg_544_0 == 2 then
				arg_542_0:Play928011131(arg_542_1)
			end

			arg_542_1:RecordChoiceLog(928011130, 1427, 1428)
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 and not isNil(arg_542_1.actors_["1066ui_story"]) and arg_542_1.var_.characterEffect1066ui_story == nil then
				arg_542_1.var_.characterEffect1066ui_story = arg_542_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_545_0 = 0.200000002980232

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_0 and not isNil(arg_542_1.actors_["1066ui_story"]) then
				if arg_542_1.var_.characterEffect1066ui_story and not isNil(arg_542_1.actors_["1066ui_story"]) then
					arg_542_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_542_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_542_1.time_ - 0) / var_545_0)
				end
			end

			if arg_542_1.time_ >= 0 + var_545_0 and arg_542_1.time_ < 0 + var_545_0 + arg_545_0 and not isNil(arg_542_1.actors_["1066ui_story"]) and arg_542_1.var_.characterEffect1066ui_story then
				arg_542_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_542_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play928011131 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 928011131
		arg_546_1.duration_ = 5

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play928011132(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 and not isNil(arg_546_1.actors_["1066ui_story"]) and arg_546_1.var_.characterEffect1066ui_story == nil then
				arg_546_1.var_.characterEffect1066ui_story = arg_546_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_549_0 = 0.200000002980232

			if 0 <= arg_546_1.time_ and arg_546_1.time_ < 0 + var_549_0 and not isNil(arg_546_1.actors_["1066ui_story"]) then
				if arg_546_1.var_.characterEffect1066ui_story and not isNil(arg_546_1.actors_["1066ui_story"]) then
					arg_546_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_546_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_546_1.time_ - 0) / var_549_0)
				end
			end

			if arg_546_1.time_ >= 0 + var_549_0 and arg_546_1.time_ < 0 + var_549_0 + arg_549_0 and not isNil(arg_546_1.actors_["1066ui_story"]) and arg_546_1.var_.characterEffect1066ui_story then
				arg_546_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_546_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_549_1 = 0
			local var_549_2 = 0.55

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_1 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				arg_546_1.leftNameTxt_.text = arg_546_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, true)
				arg_546_1.iconController_:SetSelectedState("hero")

				arg_546_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_546_1.callingController_:SetSelectedState("normal")

				arg_546_1.keyicon_.color = Color.New(1, 1, 1)
				arg_546_1.icon_.color = Color.New(1, 1, 1)

				local var_549_3 = arg_546_1:FormatText(arg_546_1:GetWordFromCfg(928011131).content)

				arg_546_1.text_.text = var_549_3

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_5 = 22 <= 0 and var_549_2 or var_549_2 * (utf8.len(var_549_3) / 22)

				if (22 <= 0 and var_549_2 or var_549_2 * (utf8.len(var_549_3) / 22)) > 0 and var_549_2 < var_549_5 then
					arg_546_1.talkMaxDuration = var_549_5

					if var_549_5 + var_549_1 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_5 + var_549_1
					end
				end

				arg_546_1.text_.text = var_549_3
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)
				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_6 = math.max(var_549_2, arg_546_1.talkMaxDuration)

			if var_549_1 <= arg_546_1.time_ and arg_546_1.time_ < var_549_1 + var_549_6 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_1) / var_549_6

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_1 + var_549_6 and arg_546_1.time_ < var_549_1 + var_549_6 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play928011132 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 928011132
		arg_550_1.duration_ = 5

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play928011133(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1.var_.moveOldPos1033ui_story = arg_550_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_553_0 = 0.001

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_0 then
				arg_550_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_550_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_550_1.time_ - 0) / var_553_0)
				arg_550_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_550_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_550_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_550_1.actors_["1033ui_story"].transform.position).z)
				arg_550_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_550_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_550_1.actors_["1033ui_story"].transform.localEulerAngles = arg_550_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_550_1.time_ >= 0 + var_553_0 and arg_550_1.time_ < 0 + var_553_0 + arg_553_0 then
				arg_550_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_550_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_550_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_550_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_550_1.actors_["1033ui_story"].transform.position).z)
				arg_550_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_550_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_550_1.actors_["1033ui_story"].transform.localEulerAngles = arg_550_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_553_1 = arg_550_1.actors_["1066ui_story"].transform

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1.var_.moveOldPos1066ui_story = var_553_1.localPosition
			end

			local var_553_2 = 0.001

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_2 then
				var_553_1.localPosition = Vector3.Lerp(arg_550_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_550_1.time_ - 0) / var_553_2)
				var_553_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_553_1.position).x, (manager.ui.mainCamera.transform.position - var_553_1.position).y, (manager.ui.mainCamera.transform.position - var_553_1.position).z)
				var_553_1.localEulerAngles.z = 0
				var_553_1.localEulerAngles.x = 0
				var_553_1.localEulerAngles = var_553_1.localEulerAngles
			end

			if arg_550_1.time_ >= 0 + var_553_2 and arg_550_1.time_ < 0 + var_553_2 + arg_553_0 then
				var_553_1.localPosition = Vector3.New(0, 100, 0)
				var_553_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_553_1.position).x, (manager.ui.mainCamera.transform.position - var_553_1.position).y, (manager.ui.mainCamera.transform.position - var_553_1.position).z)
				var_553_1.localEulerAngles.z = 0
				var_553_1.localEulerAngles.x = 0
				var_553_1.localEulerAngles = var_553_1.localEulerAngles
			end

			local var_553_3 = 0
			local var_553_4 = 0.85

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= var_553_3 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, false)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_550_1.iconTrs_.gameObject, false)
				arg_550_1.callingController_:SetSelectedState("normal")

				local var_553_5 = arg_550_1:FormatText(arg_550_1:GetWordFromCfg(928011132).content)

				arg_550_1.text_.text = var_553_5

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_7 = 34 <= 0 and var_553_4 or var_553_4 * (utf8.len(var_553_5) / 34)

				if (34 <= 0 and var_553_4 or var_553_4 * (utf8.len(var_553_5) / 34)) > 0 and var_553_4 < var_553_7 then
					arg_550_1.talkMaxDuration = var_553_7

					if var_553_7 + var_553_3 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_7 + var_553_3
					end
				end

				arg_550_1.text_.text = var_553_5
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)
				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_8 = math.max(var_553_4, arg_550_1.talkMaxDuration)

			if var_553_3 <= arg_550_1.time_ and arg_550_1.time_ < var_553_3 + var_553_8 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_3) / var_553_8

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_3 + var_553_8 and arg_550_1.time_ < var_553_3 + var_553_8 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_550_1:InitPlayNodeList()
	end,
	Play928011133 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 928011133
		arg_554_1.duration_ = 5

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play928011134(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_557_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_554_1.bgmTxt_.text ~= var_557_2 and arg_554_1.bgmTxt_.text ~= "" then
						if arg_554_1.bgmTxt2_.text ~= "" then
							arg_554_1.bgmTxt_.text = arg_554_1.bgmTxt2_.text
						end

						arg_554_1.bgmTxt2_.text = var_557_2

						arg_554_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_554_1.bgmTxt_.text = var_557_2
						arg_554_1.bgmTxt2_.text = var_557_2
					end

					if arg_554_1.bgmTimer then
						arg_554_1.bgmTimer:Stop()

						arg_554_1.bgmTimer = nil
					end

					if arg_554_1.settingData.show_music_name == 1 then
						arg_554_1.musicController:SetSelectedState("show")
						arg_554_1.musicAnimator_:Play("open", 0, 0)

						if arg_554_1.settingData.music_time ~= 0 then
							arg_554_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_554_1.settingData.music_time), function()
								if arg_554_1 == nil or isNil(arg_554_1.bgmTxt_) then
									return
								end

								arg_554_1.musicController:SetSelectedState("hide")
								arg_554_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_557_3 = 0
			local var_557_4 = 0.65

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_3 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, false)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_5 = arg_554_1:FormatText(arg_554_1:GetWordFromCfg(928011133).content)

				arg_554_1.text_.text = var_557_5

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_7 = 26 <= 0 and var_557_4 or var_557_4 * (utf8.len(var_557_5) / 26)

				if (26 <= 0 and var_557_4 or var_557_4 * (utf8.len(var_557_5) / 26)) > 0 and var_557_4 < var_557_7 then
					arg_554_1.talkMaxDuration = var_557_7

					if var_557_7 + var_557_3 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_7 + var_557_3
					end
				end

				arg_554_1.text_.text = var_557_5
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)
				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_8 = math.max(var_557_4, arg_554_1.talkMaxDuration)

			if var_557_3 <= arg_554_1.time_ and arg_554_1.time_ < var_557_3 + var_557_8 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_3) / var_557_8

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_3 + var_557_8 and arg_554_1.time_ < var_557_3 + var_557_8 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play928011134 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 928011134
		arg_559_1.duration_ = 6.73

		local var_559_0 = {
			zh = 5.733,
			ja = 6.733
		}
		local var_559_1 = manager.audio:GetLocalizationFlag()

		if var_559_0[var_559_1] ~= nil then
			arg_559_1.duration_ = var_559_0[var_559_1]
		end

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play928011135(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			if 1.4 < arg_559_1.time_ and arg_559_1.time_ <= 1.4 + arg_562_0 then
				local var_562_0 = arg_559_1.bgs_.ST0103

				arg_559_1.bgs_.ST0103.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_562_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_562_1 = var_562_0:GetComponent("SpriteRenderer")

				if var_562_1 and var_562_1.sprite then
					local var_562_2 = 2 * (var_562_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_562_0.transform.localScale = Vector3.New(var_562_2 / var_562_1.sprite.bounds.size.y < var_562_2 * manager.ui.mainCameraCom_.aspect / var_562_1.sprite.bounds.size.x and var_562_2 * manager.ui.mainCameraCom_.aspect / var_562_1.sprite.bounds.size.x or var_562_2 / var_562_1.sprite.bounds.size.y, var_562_2 / var_562_1.sprite.bounds.size.y < var_562_2 * manager.ui.mainCameraCom_.aspect / var_562_1.sprite.bounds.size.x and var_562_2 * manager.ui.mainCameraCom_.aspect / var_562_1.sprite.bounds.size.x or var_562_2 / var_562_1.sprite.bounds.size.y, 0)
				end

				for iter_562_0, iter_562_1 in pairs(arg_559_1.bgs_) do
					if iter_562_0 ~= "ST0103" then
						iter_562_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_562_3 = 0

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_3 + arg_562_0 then
				arg_559_1.allBtn_.enabled = false
			end

			if arg_559_1.time_ >= var_562_3 + 0.3 and arg_559_1.time_ < var_562_3 + 0.3 + arg_562_0 then
				arg_559_1.allBtn_.enabled = true
			end

			local var_562_4 = 0

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_4 + arg_562_0 then
				arg_559_1.mask_.enabled = true
				arg_559_1.mask_.raycastTarget = true

				arg_559_1:SetGaussion(false)
			end

			local var_562_5 = 1.33333333333333

			if var_562_4 <= arg_559_1.time_ and arg_559_1.time_ < var_562_4 + var_562_5 then
				local var_562_6 = Color.New(0, 0, 0)

				var_562_6.a = Mathf.Lerp(0, 1, (arg_559_1.time_ - var_562_4) / var_562_5)
				arg_559_1.mask_.color = var_562_6
			end

			if arg_559_1.time_ >= var_562_4 + var_562_5 and arg_559_1.time_ < var_562_4 + var_562_5 + arg_562_0 then
				local var_562_7 = Color.New(0, 0, 0)

				var_562_7.a = 1
				arg_559_1.mask_.color = var_562_7
			end

			local var_562_8 = 1.33333333333333

			if 1.33333333333333 < arg_559_1.time_ and arg_559_1.time_ <= var_562_8 + arg_562_0 then
				arg_559_1.mask_.enabled = true
				arg_559_1.mask_.raycastTarget = true

				arg_559_1:SetGaussion(false)
			end

			local var_562_9 = 2.8

			if var_562_8 <= arg_559_1.time_ and arg_559_1.time_ < var_562_8 + var_562_9 then
				local var_562_10 = Color.New(0, 0, 0)

				var_562_10.a = Mathf.Lerp(1, 0, (arg_559_1.time_ - var_562_8) / var_562_9)
				arg_559_1.mask_.color = var_562_10
			end

			if arg_559_1.time_ >= var_562_8 + var_562_9 and arg_559_1.time_ < var_562_8 + var_562_9 + arg_562_0 then
				local var_562_11 = Color.New(0, 0, 0)

				arg_559_1.mask_.enabled = false
				var_562_11.a = 0
				arg_559_1.mask_.color = var_562_11
			end

			local var_562_12 = arg_559_1.actors_["1085ui_story"].transform

			if 3.03333333333333 < arg_559_1.time_ and arg_559_1.time_ <= 3.03333333333333 + arg_562_0 then
				arg_559_1.var_.moveOldPos1085ui_story = var_562_12.localPosition
			end

			local var_562_13 = 0.001

			if 3.03333333333333 <= arg_559_1.time_ and arg_559_1.time_ < 3.03333333333333 + var_562_13 then
				var_562_12.localPosition = Vector3.Lerp(arg_559_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_559_1.time_ - 3.03333333333333) / var_562_13)
				var_562_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_562_12.position).x, (manager.ui.mainCamera.transform.position - var_562_12.position).y, (manager.ui.mainCamera.transform.position - var_562_12.position).z)
				var_562_12.localEulerAngles.z = 0
				var_562_12.localEulerAngles.x = 0
				var_562_12.localEulerAngles = var_562_12.localEulerAngles
			end

			if arg_559_1.time_ >= 3.03333333333333 + var_562_13 and arg_559_1.time_ < 3.03333333333333 + var_562_13 + arg_562_0 then
				var_562_12.localPosition = Vector3.New(0, -1.01, -5.83)
				var_562_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_562_12.position).x, (manager.ui.mainCamera.transform.position - var_562_12.position).y, (manager.ui.mainCamera.transform.position - var_562_12.position).z)
				var_562_12.localEulerAngles.z = 0
				var_562_12.localEulerAngles.x = 0
				var_562_12.localEulerAngles = var_562_12.localEulerAngles
			end

			local var_562_14 = arg_559_1.actors_["1085ui_story"]

			if 3.03333333333333 < arg_559_1.time_ and arg_559_1.time_ <= 3.03333333333333 + arg_562_0 and not isNil(var_562_14) and arg_559_1.var_.characterEffect1085ui_story == nil then
				arg_559_1.var_.characterEffect1085ui_story = var_562_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_562_15 = 0.200000002980232

			if 3.03333333333333 <= arg_559_1.time_ and arg_559_1.time_ < 3.03333333333333 + var_562_15 and not isNil(var_562_14) then
				if arg_559_1.var_.characterEffect1085ui_story and not isNil(var_562_14) then
					arg_559_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_559_1.time_ >= 3.03333333333333 + var_562_15 and arg_559_1.time_ < 3.03333333333333 + var_562_15 + arg_562_0 and not isNil(var_562_14) and arg_559_1.var_.characterEffect1085ui_story then
				arg_559_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 3.03333333333333 < arg_559_1.time_ and arg_559_1.time_ <= 3.03333333333333 + arg_562_0 then
				arg_559_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 3.06733333518108 < arg_559_1.time_ and arg_559_1.time_ <= 3.06733333518108 + arg_562_0 then
				arg_559_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 3.03333333333333 < arg_559_1.time_ and arg_559_1.time_ <= 3.03333333333333 + arg_562_0 then
				arg_559_1:AudioAction("play", "effect", "se_story_side_1061", "se_story_side_1061_amb_train", "")
			end

			if 3.03333333333333 < arg_559_1.time_ and arg_559_1.time_ <= 3.03333333333333 + arg_562_0 then
				arg_559_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1:AudioAction("play", "effect", "se_story_145", "se_story_145_reverse", "")
			end

			if arg_559_1.frameCnt_ <= 1 then
				arg_559_1.dialog_:SetActive(false)
			end

			local var_562_21 = 3.2
			local var_562_22 = 0.2

			if 3.2 < arg_559_1.time_ and arg_559_1.time_ <= var_562_21 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0

				arg_559_1.dialog_:SetActive(true)

				arg_559_1.dialogCg_.alpha = 0

				local var_562_23 = LeanTween.value(arg_559_1.dialog_, 0, 1, 0.3)

				var_562_23:setOnUpdate(LuaHelper.FloatAction(function(arg_563_0)
					arg_559_1.dialogCg_.alpha = arg_563_0
				end))
				var_562_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_559_1.dialog_)
					var_562_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_559_1.duration_ = arg_559_1.duration_ + 0.3

				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_24 = arg_559_1:GetWordFromCfg(928011134)
				local var_562_25 = arg_559_1:FormatText(var_562_24.content)

				arg_559_1.text_.text = var_562_25

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_27 = 8 <= 0 and var_562_22 or var_562_22 * (utf8.len(var_562_25) / 8)

				if (8 <= 0 and var_562_22 or var_562_22 * (utf8.len(var_562_25) / 8)) > 0 and var_562_22 < var_562_27 then
					arg_559_1.talkMaxDuration = var_562_27
					var_562_21 = var_562_21 + 0.3

					if var_562_27 + var_562_21 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_27 + var_562_21
					end
				end

				arg_559_1.text_.text = var_562_25
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011134", "story_v_side_old_928011.awb") ~= 0 then
					local var_562_28 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011134", "story_v_side_old_928011.awb") / 1000

					if var_562_28 + var_562_21 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_28 + var_562_21
					end

					if var_562_24.prefab_name ~= "" and arg_559_1.actors_[var_562_24.prefab_name] ~= nil then
						local var_562_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_24.prefab_name].transform, "story_v_side_old_928011", "928011134", "story_v_side_old_928011.awb")

						arg_559_1:RecordAudio("928011134", var_562_29)
						arg_559_1:RecordAudio("928011134", var_562_29)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011134", "story_v_side_old_928011.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011134", "story_v_side_old_928011.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_30 = var_562_21 + 0.3
			local var_562_31 = math.max(var_562_22, arg_559_1.talkMaxDuration)

			if var_562_21 + 0.3 <= arg_559_1.time_ and arg_559_1.time_ < var_562_30 + var_562_31 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_30) / var_562_31

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_30 + var_562_31 and arg_559_1.time_ < var_562_30 + var_562_31 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.03333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_559_1:InitPlayNodeList()
	end,
	Play928011135 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 928011135
		arg_565_1.duration_ = 5

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play928011136(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 and not isNil(arg_565_1.actors_["1085ui_story"]) and arg_565_1.var_.characterEffect1085ui_story == nil then
				arg_565_1.var_.characterEffect1085ui_story = arg_565_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_0 = 0.200000002980232

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_0 and not isNil(arg_565_1.actors_["1085ui_story"]) then
				if arg_565_1.var_.characterEffect1085ui_story and not isNil(arg_565_1.actors_["1085ui_story"]) then
					arg_565_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_565_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_565_1.time_ - 0) / var_568_0)
				end
			end

			if arg_565_1.time_ >= 0 + var_568_0 and arg_565_1.time_ < 0 + var_568_0 + arg_568_0 and not isNil(arg_565_1.actors_["1085ui_story"]) and arg_565_1.var_.characterEffect1085ui_story then
				arg_565_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_565_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_568_1 = 0
			local var_568_2 = 0.1

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_1 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, true)
				arg_565_1.iconController_:SetSelectedState("hero")

				arg_565_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_565_1.callingController_:SetSelectedState("normal")

				arg_565_1.keyicon_.color = Color.New(1, 1, 1)
				arg_565_1.icon_.color = Color.New(1, 1, 1)

				local var_568_3 = arg_565_1:FormatText(arg_565_1:GetWordFromCfg(928011135).content)

				arg_565_1.text_.text = var_568_3

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_5 = 4 <= 0 and var_568_2 or var_568_2 * (utf8.len(var_568_3) / 4)

				if (4 <= 0 and var_568_2 or var_568_2 * (utf8.len(var_568_3) / 4)) > 0 and var_568_2 < var_568_5 then
					arg_565_1.talkMaxDuration = var_568_5

					if var_568_5 + var_568_1 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_5 + var_568_1
					end
				end

				arg_565_1.text_.text = var_568_3
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)
				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_6 = math.max(var_568_2, arg_565_1.talkMaxDuration)

			if var_568_1 <= arg_565_1.time_ and arg_565_1.time_ < var_568_1 + var_568_6 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_1) / var_568_6

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_1 + var_568_6 and arg_565_1.time_ < var_568_1 + var_568_6 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play928011136 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 928011136
		arg_569_1.duration_ = 3

		local var_569_0 = {
			zh = 1.966,
			ja = 3
		}
		local var_569_1 = manager.audio:GetLocalizationFlag()

		if var_569_0[var_569_1] ~= nil then
			arg_569_1.duration_ = var_569_0[var_569_1]
		end

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play928011137(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 and not isNil(arg_569_1.actors_["1085ui_story"]) and arg_569_1.var_.characterEffect1085ui_story == nil then
				arg_569_1.var_.characterEffect1085ui_story = arg_569_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_572_0 = 0.200000002980232

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_0 and not isNil(arg_569_1.actors_["1085ui_story"]) then
				if arg_569_1.var_.characterEffect1085ui_story and not isNil(arg_569_1.actors_["1085ui_story"]) then
					arg_569_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_569_1.time_ >= 0 + var_572_0 and arg_569_1.time_ < 0 + var_572_0 + arg_572_0 and not isNil(arg_569_1.actors_["1085ui_story"]) and arg_569_1.var_.characterEffect1085ui_story then
				arg_569_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_572_2 = 0
			local var_572_3 = 0.175

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_2 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				arg_569_1.leftNameTxt_.text = arg_569_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_4 = arg_569_1:GetWordFromCfg(928011136)
				local var_572_5 = arg_569_1:FormatText(var_572_4.content)

				arg_569_1.text_.text = var_572_5

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_7 = 7 <= 0 and var_572_3 or var_572_3 * (utf8.len(var_572_5) / 7)

				if (7 <= 0 and var_572_3 or var_572_3 * (utf8.len(var_572_5) / 7)) > 0 and var_572_3 < var_572_7 then
					arg_569_1.talkMaxDuration = var_572_7

					if var_572_7 + var_572_2 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_7 + var_572_2
					end
				end

				arg_569_1.text_.text = var_572_5
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011136", "story_v_side_old_928011.awb") ~= 0 then
					local var_572_8 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011136", "story_v_side_old_928011.awb") / 1000

					if var_572_8 + var_572_2 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_8 + var_572_2
					end

					if var_572_4.prefab_name ~= "" and arg_569_1.actors_[var_572_4.prefab_name] ~= nil then
						local var_572_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_4.prefab_name].transform, "story_v_side_old_928011", "928011136", "story_v_side_old_928011.awb")

						arg_569_1:RecordAudio("928011136", var_572_9)
						arg_569_1:RecordAudio("928011136", var_572_9)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011136", "story_v_side_old_928011.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011136", "story_v_side_old_928011.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_10 = math.max(var_572_3, arg_569_1.talkMaxDuration)

			if var_572_2 <= arg_569_1.time_ and arg_569_1.time_ < var_572_2 + var_572_10 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_2) / var_572_10

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_2 + var_572_10 and arg_569_1.time_ < var_572_2 + var_572_10 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play928011137 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 928011137
		arg_573_1.duration_ = 7.87

		local var_573_0 = {
			zh = 7.4,
			ja = 7.866
		}
		local var_573_1 = manager.audio:GetLocalizationFlag()

		if var_573_0[var_573_1] ~= nil then
			arg_573_1.duration_ = var_573_0[var_573_1]
		end

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play928011138(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action5_1")
			end

			local var_576_0 = 0
			local var_576_1 = 0.575

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_0 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				arg_573_1.leftNameTxt_.text = arg_573_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_2 = arg_573_1:GetWordFromCfg(928011137)
				local var_576_3 = arg_573_1:FormatText(var_576_2.content)

				arg_573_1.text_.text = var_576_3

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_5 = 23 <= 0 and var_576_1 or var_576_1 * (utf8.len(var_576_3) / 23)

				if (23 <= 0 and var_576_1 or var_576_1 * (utf8.len(var_576_3) / 23)) > 0 and var_576_1 < var_576_5 then
					arg_573_1.talkMaxDuration = var_576_5

					if var_576_5 + var_576_0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_5 + var_576_0
					end
				end

				arg_573_1.text_.text = var_576_3
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011137", "story_v_side_old_928011.awb") ~= 0 then
					local var_576_6 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011137", "story_v_side_old_928011.awb") / 1000

					if var_576_6 + var_576_0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_6 + var_576_0
					end

					if var_576_2.prefab_name ~= "" and arg_573_1.actors_[var_576_2.prefab_name] ~= nil then
						local var_576_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_2.prefab_name].transform, "story_v_side_old_928011", "928011137", "story_v_side_old_928011.awb")

						arg_573_1:RecordAudio("928011137", var_576_7)
						arg_573_1:RecordAudio("928011137", var_576_7)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011137", "story_v_side_old_928011.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011137", "story_v_side_old_928011.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_8 = math.max(var_576_1, arg_573_1.talkMaxDuration)

			if var_576_0 <= arg_573_1.time_ and arg_573_1.time_ < var_576_0 + var_576_8 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_0) / var_576_8

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_0 + var_576_8 and arg_573_1.time_ < var_576_0 + var_576_8 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play928011138 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 928011138
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play928011139(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 and not isNil(arg_577_1.actors_["1085ui_story"]) and arg_577_1.var_.characterEffect1085ui_story == nil then
				arg_577_1.var_.characterEffect1085ui_story = arg_577_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_580_0 = 0.200000002980232

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_0 and not isNil(arg_577_1.actors_["1085ui_story"]) then
				if arg_577_1.var_.characterEffect1085ui_story and not isNil(arg_577_1.actors_["1085ui_story"]) then
					arg_577_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_577_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_577_1.time_ - 0) / var_580_0)
				end
			end

			if arg_577_1.time_ >= 0 + var_580_0 and arg_577_1.time_ < 0 + var_580_0 + arg_580_0 and not isNil(arg_577_1.actors_["1085ui_story"]) and arg_577_1.var_.characterEffect1085ui_story then
				arg_577_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_577_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_580_1 = 0
			local var_580_2 = 0.675

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= var_580_1 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, false)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_3 = arg_577_1:FormatText(arg_577_1:GetWordFromCfg(928011138).content)

				arg_577_1.text_.text = var_580_3

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_5 = 27 <= 0 and var_580_2 or var_580_2 * (utf8.len(var_580_3) / 27)

				if (27 <= 0 and var_580_2 or var_580_2 * (utf8.len(var_580_3) / 27)) > 0 and var_580_2 < var_580_5 then
					arg_577_1.talkMaxDuration = var_580_5

					if var_580_5 + var_580_1 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_5 + var_580_1
					end
				end

				arg_577_1.text_.text = var_580_3
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_6 = math.max(var_580_2, arg_577_1.talkMaxDuration)

			if var_580_1 <= arg_577_1.time_ and arg_577_1.time_ < var_580_1 + var_580_6 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_1) / var_580_6

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_1 + var_580_6 and arg_577_1.time_ < var_580_1 + var_580_6 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play928011139 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 928011139
		arg_581_1.duration_ = 5

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play928011140(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = 0.425

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				arg_581_1.leftNameTxt_.text = arg_581_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, true)
				arg_581_1.iconController_:SetSelectedState("hero")

				arg_581_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_581_1.callingController_:SetSelectedState("normal")

				arg_581_1.keyicon_.color = Color.New(1, 1, 1)
				arg_581_1.icon_.color = Color.New(1, 1, 1)

				local var_584_1 = arg_581_1:FormatText(arg_581_1:GetWordFromCfg(928011139).content)

				arg_581_1.text_.text = var_584_1

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_3 = 17 <= 0 and var_584_0 or var_584_0 * (utf8.len(var_584_1) / 17)

				if (17 <= 0 and var_584_0 or var_584_0 * (utf8.len(var_584_1) / 17)) > 0 and var_584_0 < var_584_3 then
					arg_581_1.talkMaxDuration = var_584_3

					if var_584_3 + 0 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_3 + 0
					end
				end

				arg_581_1.text_.text = var_584_1
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)
				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_4 = math.max(var_584_0, arg_581_1.talkMaxDuration)

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_4 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - 0) / var_584_4

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= 0 + var_584_4 and arg_581_1.time_ < 0 + var_584_4 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play928011140 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 928011140
		arg_585_1.duration_ = 5.97

		local var_585_0 = {
			zh = 5.966,
			ja = 4.9
		}
		local var_585_1 = manager.audio:GetLocalizationFlag()

		if var_585_0[var_585_1] ~= nil then
			arg_585_1.duration_ = var_585_0[var_585_1]
		end

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play928011141(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 and not isNil(arg_585_1.actors_["1085ui_story"]) and arg_585_1.var_.characterEffect1085ui_story == nil then
				arg_585_1.var_.characterEffect1085ui_story = arg_585_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_588_0 = 0.200000002980232

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_0 and not isNil(arg_585_1.actors_["1085ui_story"]) then
				if arg_585_1.var_.characterEffect1085ui_story and not isNil(arg_585_1.actors_["1085ui_story"]) then
					arg_585_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_585_1.time_ >= 0 + var_588_0 and arg_585_1.time_ < 0 + var_588_0 + arg_588_0 and not isNil(arg_585_1.actors_["1085ui_story"]) and arg_585_1.var_.characterEffect1085ui_story then
				arg_585_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action453")
			end

			local var_588_2 = 0
			local var_588_3 = 0.325

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_2 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				arg_585_1.leftNameTxt_.text = arg_585_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_4 = arg_585_1:GetWordFromCfg(928011140)
				local var_588_5 = arg_585_1:FormatText(var_588_4.content)

				arg_585_1.text_.text = var_588_5

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_7 = 13 <= 0 and var_588_3 or var_588_3 * (utf8.len(var_588_5) / 13)

				if (13 <= 0 and var_588_3 or var_588_3 * (utf8.len(var_588_5) / 13)) > 0 and var_588_3 < var_588_7 then
					arg_585_1.talkMaxDuration = var_588_7

					if var_588_7 + var_588_2 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_7 + var_588_2
					end
				end

				arg_585_1.text_.text = var_588_5
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928011", "928011140", "story_v_side_old_928011.awb") ~= 0 then
					local var_588_8 = manager.audio:GetVoiceLength("story_v_side_old_928011", "928011140", "story_v_side_old_928011.awb") / 1000

					if var_588_8 + var_588_2 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_8 + var_588_2
					end

					if var_588_4.prefab_name ~= "" and arg_585_1.actors_[var_588_4.prefab_name] ~= nil then
						local var_588_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_585_1.actors_[var_588_4.prefab_name].transform, "story_v_side_old_928011", "928011140", "story_v_side_old_928011.awb")

						arg_585_1:RecordAudio("928011140", var_588_9)
						arg_585_1:RecordAudio("928011140", var_588_9)
					else
						arg_585_1:AudioAction("play", "voice", "story_v_side_old_928011", "928011140", "story_v_side_old_928011.awb")
					end

					arg_585_1:RecordHistoryTalkVoice("story_v_side_old_928011", "928011140", "story_v_side_old_928011.awb")
				end

				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_10 = math.max(var_588_3, arg_585_1.talkMaxDuration)

			if var_588_2 <= arg_585_1.time_ and arg_585_1.time_ < var_588_2 + var_588_10 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_2) / var_588_10

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_2 + var_588_10 and arg_585_1.time_ < var_588_2 + var_588_10 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play928011141 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 928011141
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
			arg_589_1.auto_ = false
		end

		function arg_589_1.playNext_(arg_591_0)
			arg_589_1.onStoryFinished_()
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 and not isNil(arg_589_1.actors_["1085ui_story"]) and arg_589_1.var_.characterEffect1085ui_story == nil then
				arg_589_1.var_.characterEffect1085ui_story = arg_589_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_592_0 = 0.200000002980232

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_0 and not isNil(arg_589_1.actors_["1085ui_story"]) then
				if arg_589_1.var_.characterEffect1085ui_story and not isNil(arg_589_1.actors_["1085ui_story"]) then
					arg_589_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_589_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_589_1.time_ - 0) / var_592_0)
				end
			end

			if arg_589_1.time_ >= 0 + var_592_0 and arg_589_1.time_ < 0 + var_592_0 + arg_592_0 and not isNil(arg_589_1.actors_["1085ui_story"]) and arg_589_1.var_.characterEffect1085ui_story then
				arg_589_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_589_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_592_1 = 0
			local var_592_2 = 0.275

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= var_592_1 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				arg_589_1.leftNameTxt_.text = arg_589_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, true)
				arg_589_1.iconController_:SetSelectedState("hero")

				arg_589_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_589_1.callingController_:SetSelectedState("normal")

				arg_589_1.keyicon_.color = Color.New(1, 1, 1)
				arg_589_1.icon_.color = Color.New(1, 1, 1)

				local var_592_3 = arg_589_1:FormatText(arg_589_1:GetWordFromCfg(928011141).content)

				arg_589_1.text_.text = var_592_3

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_5 = 11 <= 0 and var_592_2 or var_592_2 * (utf8.len(var_592_3) / 11)

				if (11 <= 0 and var_592_2 or var_592_2 * (utf8.len(var_592_3) / 11)) > 0 and var_592_2 < var_592_5 then
					arg_589_1.talkMaxDuration = var_592_5

					if var_592_5 + var_592_1 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_5 + var_592_1
					end
				end

				arg_589_1.text_.text = var_592_3
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_6 = math.max(var_592_2, arg_589_1.talkMaxDuration)

			if var_592_1 <= arg_589_1.time_ and arg_589_1.time_ < var_592_1 + var_592_6 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_1) / var_592_6

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_1 + var_592_6 and arg_589_1.time_ < var_592_1 + var_592_6 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST0103",
		"TextureConfig/Background/ST2201",
		"TextureConfig/Background/STwhite"
	},
	voices = {
		"story_v_side_old_928011.awb"
	}
}
