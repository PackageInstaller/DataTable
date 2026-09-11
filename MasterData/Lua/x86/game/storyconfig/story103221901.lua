return {
	Play322191001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322191001
		arg_1_1.duration_ = 5.1

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play322191002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.STwhite == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_4_0.name = "STwhite"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STwhite = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STwhite

				arg_1_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STwhite" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			local var_4_8 = 1.975

			if 1.975 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_8 + 0.158333333333333 and arg_1_1.time_ < var_4_8 + 0.158333333333333 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_4_13 = 2
			local var_4_14 = manager.audio:GetVoiceLength("story_v_out_322191", "322191001", "story_v_out_322191.awb") / 1000

			if var_4_14 > 0 and 3.1 < var_4_14 and var_4_14 + var_4_13 > arg_1_1.duration_ then
				arg_1_1.duration_ = var_4_14 + var_4_13
			end

			if var_4_13 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1:AudioAction("play", "voice", "story_v_out_322191", "322191001", "story_v_out_322191.awb")
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = true,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				contentID = 322191001,
				charCount = 11,
				enableEffect = true,
				enableLayoutChange = true,
				duration = 0.733333333333333,
				groupID = "1",
				startTime = 2,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				bgData = {
					bgActionType = StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.DISABLE,
					bgColor = Color.New(0, 0, 0, 0.5)
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(0, 0, 0, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play322191002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 322191002
		arg_6_1.duration_ = 1.3

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play322191003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = manager.audio:GetVoiceLength("story_v_out_322191", "322191002", "story_v_out_322191.awb") / 1000

			if var_9_0 > 0 and 1.3 < var_9_0 and var_9_0 + 0 > arg_6_1.duration_ then
				arg_6_1.duration_ = var_9_0 + 0
			end

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1:AudioAction("play", "voice", "story_v_out_322191", "322191002", "story_v_out_322191.awb")
			end
		end

		arg_6_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = true,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				contentID = 322191002,
				charCount = 5,
				enableEffect = true,
				enableLayoutChange = true,
				duration = 0.333333333333333,
				groupID = "2",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				bgData = {
					bgActionType = StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.DISABLE,
					bgColor = Color.New(0, 0, 0, 0.5)
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(0, 0, 0, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "1",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_6_1:InitPlayNodeList()
	end,
	Play322191003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 322191003
		arg_10_1.duration_ = 1.27

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play322191004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = manager.audio:GetVoiceLength("story_v_out_322191", "322191003", "story_v_out_322191.awb") / 1000

			if var_13_0 > 0 and 1.266 < var_13_0 and var_13_0 + 0 > arg_10_1.duration_ then
				arg_10_1.duration_ = var_13_0 + 0
			end

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1:AudioAction("play", "voice", "story_v_out_322191", "322191003", "story_v_out_322191.awb")
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322191003,
				charCount = 4,
				enableLayoutChange = true,
				duration = 0.266666666666667,
				groupID = "3",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(0, 0, 0, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "2",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_10_1:InitPlayNodeList()
	end,
	Play322191004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 322191004
		arg_14_1.duration_ = 6.92

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play322191005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 1.91666666666667 < arg_14_1.time_ and arg_14_1.time_ <= 1.91666666666667 + arg_17_0 then
				arg_14_1.allBtn_.enabled = false
			end

			if arg_14_1.time_ >= 1.91666666666667 + 0.833333333334334 and arg_14_1.time_ < 1.91666666666667 + 0.833333333334334 + arg_17_0 then
				arg_14_1.allBtn_.enabled = true
			end

			local var_17_0 = "L09h"

			if arg_14_1.bgs_.L09h == nil then
				local var_17_1 = Object.Instantiate(arg_14_1.paintGo_)

				var_17_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_17_0)
				var_17_1.name = var_17_0
				var_17_1.transform.parent = arg_14_1.stage_.transform
				var_17_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_14_1.bgs_[var_17_0] = var_17_1
			end

			if 0.966666666666667 < arg_14_1.time_ and arg_14_1.time_ <= 0.966666666666667 + arg_17_0 then
				local var_17_2 = arg_14_1.bgs_.L09h

				arg_14_1.bgs_.L09h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_17_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_17_3 = var_17_2:GetComponent("SpriteRenderer")

				if var_17_3 and var_17_3.sprite then
					local var_17_4 = 2 * (var_17_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_17_2.transform.localScale = Vector3.New(var_17_4 / var_17_3.sprite.bounds.size.y < var_17_4 * manager.ui.mainCameraCom_.aspect / var_17_3.sprite.bounds.size.x and var_17_4 * manager.ui.mainCameraCom_.aspect / var_17_3.sprite.bounds.size.x or var_17_4 / var_17_3.sprite.bounds.size.y, var_17_4 / var_17_3.sprite.bounds.size.y < var_17_4 * manager.ui.mainCameraCom_.aspect / var_17_3.sprite.bounds.size.x and var_17_4 * manager.ui.mainCameraCom_.aspect / var_17_3.sprite.bounds.size.x or var_17_4 / var_17_3.sprite.bounds.size.y, 0)
				end

				for iter_17_0, iter_17_1 in pairs(arg_14_1.bgs_) do
					if iter_17_0 ~= "L09h" then
						iter_17_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_17_5 = 0

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_5 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = true

				arg_14_1:SetGaussion(false)
			end

			local var_17_6 = 0.966666666666667

			if var_17_5 <= arg_14_1.time_ and arg_14_1.time_ < var_17_5 + var_17_6 then
				local var_17_7 = Color.New(1, 1, 1)

				var_17_7.a = Mathf.Lerp(0, 1, (arg_14_1.time_ - var_17_5) / var_17_6)
				arg_14_1.mask_.color = var_17_7
			end

			if arg_14_1.time_ >= var_17_5 + var_17_6 and arg_14_1.time_ < var_17_5 + var_17_6 + arg_17_0 then
				local var_17_8 = Color.New(1, 1, 1)

				var_17_8.a = 1
				arg_14_1.mask_.color = var_17_8
			end

			local var_17_9 = 0.966666666666667

			if 0.966666666666667 < arg_14_1.time_ and arg_14_1.time_ <= var_17_9 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = true

				arg_14_1:SetGaussion(false)
			end

			local var_17_10 = 0.966666666666667

			if var_17_9 <= arg_14_1.time_ and arg_14_1.time_ < var_17_9 + var_17_10 then
				local var_17_11 = Color.New(1, 1, 1)

				var_17_11.a = Mathf.Lerp(1, 0, (arg_14_1.time_ - var_17_9) / var_17_10)
				arg_14_1.mask_.color = var_17_11
			end

			if arg_14_1.time_ >= var_17_9 + var_17_10 and arg_14_1.time_ < var_17_9 + var_17_10 + arg_17_0 then
				local var_17_12 = Color.New(1, 1, 1)

				arg_14_1.mask_.enabled = false
				var_17_12.a = 0
				arg_14_1.mask_.color = var_17_12
			end

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_17_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_14_1.bgmTxt_.text ~= var_17_15 and arg_14_1.bgmTxt_.text ~= "" then
						if arg_14_1.bgmTxt2_.text ~= "" then
							arg_14_1.bgmTxt_.text = arg_14_1.bgmTxt2_.text
						end

						arg_14_1.bgmTxt2_.text = var_17_15

						arg_14_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_14_1.bgmTxt_.text = var_17_15
						arg_14_1.bgmTxt2_.text = var_17_15
					end

					if arg_14_1.bgmTimer then
						arg_14_1.bgmTimer:Stop()

						arg_14_1.bgmTimer = nil
					end

					if arg_14_1.settingData.show_music_name == 1 then
						arg_14_1.musicController:SetSelectedState("show")
						arg_14_1.musicAnimator_:Play("open", 0, 0)

						if arg_14_1.settingData.music_time ~= 0 then
							arg_14_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_14_1.settingData.music_time), function()
								if arg_14_1 == nil or isNil(arg_14_1.bgmTxt_) then
									return
								end

								arg_14_1.musicController:SetSelectedState("hide")
								arg_14_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_14_1.time_ and arg_14_1.time_ <= 0.433333333333333 + arg_17_0 then
				arg_14_1:AudioAction("play", "music", "bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source.awb")

				local var_17_18 = manager.audio:GetAudioName("bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source")

				if "" ~= "" then
					if arg_14_1.bgmTxt_.text ~= var_17_18 and arg_14_1.bgmTxt_.text ~= "" then
						if arg_14_1.bgmTxt2_.text ~= "" then
							arg_14_1.bgmTxt_.text = arg_14_1.bgmTxt2_.text
						end

						arg_14_1.bgmTxt2_.text = var_17_18

						arg_14_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_14_1.bgmTxt_.text = var_17_18
						arg_14_1.bgmTxt2_.text = var_17_18
					end

					if arg_14_1.bgmTimer then
						arg_14_1.bgmTimer:Stop()

						arg_14_1.bgmTimer = nil
					end

					if arg_14_1.settingData.show_music_name == 1 then
						arg_14_1.musicController:SetSelectedState("show")
						arg_14_1.musicAnimator_:Play("open", 0, 0)

						if arg_14_1.settingData.music_time ~= 0 then
							arg_14_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_14_1.settingData.music_time), function()
								if arg_14_1 == nil or isNil(arg_14_1.bgmTxt_) then
									return
								end

								arg_14_1.musicController:SetSelectedState("hide")
								arg_14_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.607469807844609 < arg_14_1.time_ and arg_14_1.time_ <= 0.607469807844609 + arg_17_0 then
				arg_14_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_dark_L09", "")
			end

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_magic", "")
			end

			if 0.44 < arg_14_1.time_ and arg_14_1.time_ <= 0.44 + arg_17_0 then
				arg_14_1:AudioAction("play", "music", "bgm_activity_4_5_story_source", "init_story", "bgm_activity_4_5_story_source.awb")

				local var_17_23 = manager.audio:GetAudioName("bgm_activity_4_5_story_source", "init_story")

				if "" ~= "" then
					if arg_14_1.bgmTxt_.text ~= var_17_23 and arg_14_1.bgmTxt_.text ~= "" then
						if arg_14_1.bgmTxt2_.text ~= "" then
							arg_14_1.bgmTxt_.text = arg_14_1.bgmTxt2_.text
						end

						arg_14_1.bgmTxt2_.text = var_17_23

						arg_14_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_14_1.bgmTxt_.text = var_17_23
						arg_14_1.bgmTxt2_.text = var_17_23
					end

					if arg_14_1.bgmTimer then
						arg_14_1.bgmTimer:Stop()

						arg_14_1.bgmTimer = nil
					end

					if arg_14_1.settingData.show_music_name == 1 then
						arg_14_1.musicController:SetSelectedState("show")
						arg_14_1.musicAnimator_:Play("open", 0, 0)

						if arg_14_1.settingData.music_time ~= 0 then
							arg_14_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_14_1.settingData.music_time), function()
								if arg_14_1 == nil or isNil(arg_14_1.bgmTxt_) then
									return
								end

								arg_14_1.musicController:SetSelectedState("hide")
								arg_14_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_14_1.frameCnt_ <= 1 then
				arg_14_1.dialog_:SetActive(false)
			end

			local var_17_24 = 1.91666666666667
			local var_17_25 = 1.05

			if 1.91666666666667 < arg_14_1.time_ and arg_14_1.time_ <= var_17_24 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				arg_14_1.dialog_:SetActive(true)

				arg_14_1.dialogCg_.alpha = 0

				local var_17_26 = LeanTween.value(arg_14_1.dialog_, 0, 1, 0.3)

				var_17_26:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_14_1.dialogCg_.alpha = arg_21_0
				end))
				var_17_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_14_1.dialog_)
					var_17_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_14_1.duration_ = arg_14_1.duration_ + 0.3

				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_27 = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(322191004).content)

				arg_14_1.text_.text = var_17_27

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_29 = 42 <= 0 and var_17_25 or var_17_25 * (utf8.len(var_17_27) / 42)

				if (42 <= 0 and var_17_25 or var_17_25 * (utf8.len(var_17_27) / 42)) > 0 and var_17_25 < var_17_29 then
					arg_14_1.talkMaxDuration = var_17_29
					var_17_24 = var_17_24 + 0.3

					if var_17_29 + var_17_24 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_29 + var_17_24
					end
				end

				arg_14_1.text_.text = var_17_27
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_30 = var_17_24 + 0.3
			local var_17_31 = math.max(var_17_25, arg_14_1.talkMaxDuration)

			if var_17_24 + 0.3 <= arg_14_1.time_ and arg_14_1.time_ < var_17_30 + var_17_31 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_30) / var_17_31

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_30 + var_17_31 and arg_14_1.time_ < var_17_30 + var_17_31 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				groupID = "3",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0.95,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play322191005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 322191005
		arg_23_1.duration_ = 3.33

		local var_23_0 = {
			zh = 2.133,
			ja = 3.333
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play322191006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if arg_23_1.actors_["1211ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1211ui_story"))) then
				local var_26_0 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_23_1.stage_.transform)

				var_26_0.name = "1211ui_story"
				var_26_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_["1211ui_story"] = var_26_0

				local var_26_1 = var_26_0:GetComponentInChildren(typeof(CharacterEffect))

				var_26_1.enabled = true

				local var_26_2 = GameObjectTools.GetOrAddComponent(var_26_0, typeof(DynamicBoneHelper))

				if var_26_2 then
					var_26_2:EnableDynamicBone(false)
				end

				arg_23_1:ShowWeapon(var_26_1.transform, false)

				arg_23_1.var_["1211ui_story" .. "Animator"] = var_26_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_23_1.var_["1211ui_story" .. "Animator"].applyRootMotion = true
				arg_23_1.var_["1211ui_story" .. "LipSync"] = var_26_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_26_3 = arg_23_1.actors_["1211ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1211ui_story = var_26_3.localPosition

				arg_23_1:ShowWeapon(arg_23_1.var_["1211ui_story" .. "Animator"].transform, false)
			end

			local var_26_4 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				var_26_3.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_23_1.time_ - 0) / var_26_4)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				var_26_3.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			local var_26_5 = arg_23_1.actors_["1211ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect1211ui_story == nil then
				arg_23_1.var_.characterEffect1211ui_story = var_26_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_6 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_6 and not isNil(var_26_5) then
				if arg_23_1.var_.characterEffect1211ui_story and not isNil(var_26_5) then
					arg_23_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_6 and arg_23_1.time_ < 0 + var_26_6 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect1211ui_story then
				arg_23_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action2_1")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_26_8 = 0
			local var_26_9 = 0.25

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_10 = arg_23_1:GetWordFromCfg(322191005)
				local var_26_11 = arg_23_1:FormatText(var_26_10.content)

				arg_23_1.text_.text = var_26_11

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_13 = 10 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 10)

				if (10 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 10)) > 0 and var_26_9 < var_26_13 then
					arg_23_1.talkMaxDuration = var_26_13

					if var_26_13 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_13 + var_26_8
					end
				end

				arg_23_1.text_.text = var_26_11
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191005", "story_v_out_322191.awb") ~= 0 then
					local var_26_14 = manager.audio:GetVoiceLength("story_v_out_322191", "322191005", "story_v_out_322191.awb") / 1000

					if var_26_14 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_14 + var_26_8
					end

					if var_26_10.prefab_name ~= "" and arg_23_1.actors_[var_26_10.prefab_name] ~= nil then
						local var_26_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_10.prefab_name].transform, "story_v_out_322191", "322191005", "story_v_out_322191.awb")

						arg_23_1:RecordAudio("322191005", var_26_15)
						arg_23_1:RecordAudio("322191005", var_26_15)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_322191", "322191005", "story_v_out_322191.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_322191", "322191005", "story_v_out_322191.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_16 = math.max(var_26_9, arg_23_1.talkMaxDuration)

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_16 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_8) / var_26_16

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_8 + var_26_16 and arg_23_1.time_ < var_26_8 + var_26_16 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play322191006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 322191006
		arg_27_1.duration_ = 7.63

		local var_27_0 = {
			zh = 6.666,
			ja = 7.633
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play322191007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if arg_27_1.actors_["1043ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1043ui_story"))) then
				local var_30_0 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_27_1.stage_.transform)

				var_30_0.name = "1043ui_story"
				var_30_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.actors_["1043ui_story"] = var_30_0

				local var_30_1 = var_30_0:GetComponentInChildren(typeof(CharacterEffect))

				var_30_1.enabled = true

				local var_30_2 = GameObjectTools.GetOrAddComponent(var_30_0, typeof(DynamicBoneHelper))

				if var_30_2 then
					var_30_2:EnableDynamicBone(false)
				end

				arg_27_1:ShowWeapon(var_30_1.transform, false)

				arg_27_1.var_["1043ui_story" .. "Animator"] = var_30_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_27_1.var_["1043ui_story" .. "Animator"].applyRootMotion = true
				arg_27_1.var_["1043ui_story" .. "LipSync"] = var_30_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_30_3 = arg_27_1.actors_["1043ui_story"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1043ui_story = var_30_3.localPosition
			end

			local var_30_4 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				var_30_3.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_27_1.time_ - 0) / var_30_4)
				var_30_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_3.position).x, (manager.ui.mainCamera.transform.position - var_30_3.position).y, (manager.ui.mainCamera.transform.position - var_30_3.position).z)
				var_30_3.localEulerAngles.z = 0
				var_30_3.localEulerAngles.x = 0
				var_30_3.localEulerAngles = var_30_3.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				var_30_3.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_30_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_3.position).x, (manager.ui.mainCamera.transform.position - var_30_3.position).y, (manager.ui.mainCamera.transform.position - var_30_3.position).z)
				var_30_3.localEulerAngles.z = 0
				var_30_3.localEulerAngles.x = 0
				var_30_3.localEulerAngles = var_30_3.localEulerAngles
			end

			local var_30_5 = arg_27_1.actors_["1043ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_5) and arg_27_1.var_.characterEffect1043ui_story == nil then
				arg_27_1.var_.characterEffect1043ui_story = var_30_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_6 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_6 and not isNil(var_30_5) then
				if arg_27_1.var_.characterEffect1043ui_story and not isNil(var_30_5) then
					arg_27_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_6 and arg_27_1.time_ < 0 + var_30_6 + arg_30_0 and not isNil(var_30_5) and arg_27_1.var_.characterEffect1043ui_story then
				arg_27_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_30_8 = arg_27_1.actors_["1211ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_8) and arg_27_1.var_.characterEffect1211ui_story == nil then
				arg_27_1.var_.characterEffect1211ui_story = var_30_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_9 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_9 and not isNil(var_30_8) then
				if arg_27_1.var_.characterEffect1211ui_story and not isNil(var_30_8) then
					arg_27_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_9)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_9 and arg_27_1.time_ < 0 + var_30_9 + arg_30_0 and not isNil(var_30_8) and arg_27_1.var_.characterEffect1211ui_story then
				arg_27_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_30_10 = 0
			local var_30_11 = 0.8

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_10 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_12 = arg_27_1:GetWordFromCfg(322191006)
				local var_30_13 = arg_27_1:FormatText(var_30_12.content)

				arg_27_1.text_.text = var_30_13

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_15 = 32 <= 0 and var_30_11 or var_30_11 * (utf8.len(var_30_13) / 32)

				if (32 <= 0 and var_30_11 or var_30_11 * (utf8.len(var_30_13) / 32)) > 0 and var_30_11 < var_30_15 then
					arg_27_1.talkMaxDuration = var_30_15

					if var_30_15 + var_30_10 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_15 + var_30_10
					end
				end

				arg_27_1.text_.text = var_30_13
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191006", "story_v_out_322191.awb") ~= 0 then
					local var_30_16 = manager.audio:GetVoiceLength("story_v_out_322191", "322191006", "story_v_out_322191.awb") / 1000

					if var_30_16 + var_30_10 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_16 + var_30_10
					end

					if var_30_12.prefab_name ~= "" and arg_27_1.actors_[var_30_12.prefab_name] ~= nil then
						local var_30_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_12.prefab_name].transform, "story_v_out_322191", "322191006", "story_v_out_322191.awb")

						arg_27_1:RecordAudio("322191006", var_30_17)
						arg_27_1:RecordAudio("322191006", var_30_17)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_322191", "322191006", "story_v_out_322191.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_322191", "322191006", "story_v_out_322191.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_18 = math.max(var_30_11, arg_27_1.talkMaxDuration)

			if var_30_10 <= arg_27_1.time_ and arg_27_1.time_ < var_30_10 + var_30_18 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_10) / var_30_18

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_10 + var_30_18 and arg_27_1.time_ < var_30_10 + var_30_18 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play322191007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 322191007
		arg_31_1.duration_ = 4.23

		local var_31_0 = {
			zh = 4.066,
			ja = 4.233
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play322191008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["1211ui_story"]) and arg_31_1.var_.characterEffect1211ui_story == nil then
				arg_31_1.var_.characterEffect1211ui_story = arg_31_1.actors_["1211ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_0 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["1211ui_story"]) then
				if arg_31_1.var_.characterEffect1211ui_story and not isNil(arg_31_1.actors_["1211ui_story"]) then
					arg_31_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["1211ui_story"]) and arg_31_1.var_.characterEffect1211ui_story then
				arg_31_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_34_2 = arg_31_1.actors_["1043ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.characterEffect1043ui_story == nil then
				arg_31_1.var_.characterEffect1043ui_story = var_34_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_3 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_3 and not isNil(var_34_2) then
				if arg_31_1.var_.characterEffect1043ui_story and not isNil(var_34_2) then
					arg_31_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_3)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_3 and arg_31_1.time_ < 0 + var_34_3 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.characterEffect1043ui_story then
				arg_31_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action2_2")
			end

			local var_34_4 = 0
			local var_34_5 = 0.4

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_4 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_6 = arg_31_1:GetWordFromCfg(322191007)
				local var_34_7 = arg_31_1:FormatText(var_34_6.content)

				arg_31_1.text_.text = var_34_7

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_9 = 16 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 16)

				if (16 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 16)) > 0 and var_34_5 < var_34_9 then
					arg_31_1.talkMaxDuration = var_34_9

					if var_34_9 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_9 + var_34_4
					end
				end

				arg_31_1.text_.text = var_34_7
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191007", "story_v_out_322191.awb") ~= 0 then
					local var_34_10 = manager.audio:GetVoiceLength("story_v_out_322191", "322191007", "story_v_out_322191.awb") / 1000

					if var_34_10 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_10 + var_34_4
					end

					if var_34_6.prefab_name ~= "" and arg_31_1.actors_[var_34_6.prefab_name] ~= nil then
						local var_34_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_6.prefab_name].transform, "story_v_out_322191", "322191007", "story_v_out_322191.awb")

						arg_31_1:RecordAudio("322191007", var_34_11)
						arg_31_1:RecordAudio("322191007", var_34_11)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_322191", "322191007", "story_v_out_322191.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_322191", "322191007", "story_v_out_322191.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_12 = math.max(var_34_5, arg_31_1.talkMaxDuration)

			if var_34_4 <= arg_31_1.time_ and arg_31_1.time_ < var_34_4 + var_34_12 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_4) / var_34_12

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_4 + var_34_12 and arg_31_1.time_ < var_34_4 + var_34_12 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play322191008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 322191008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play322191009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1211ui_story = arg_35_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1211ui_story"].transform.position).z)
				arg_35_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1211ui_story"].transform.localEulerAngles = arg_35_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1211ui_story"].transform.position).z)
				arg_35_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1211ui_story"].transform.localEulerAngles = arg_35_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["1043ui_story"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1043ui_story = var_38_1.localPosition
			end

			local var_38_2 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 then
				var_38_1.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_35_1.time_ - 0) / var_38_2)
				var_38_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_1.position).x, (manager.ui.mainCamera.transform.position - var_38_1.position).y, (manager.ui.mainCamera.transform.position - var_38_1.position).z)
				var_38_1.localEulerAngles.z = 0
				var_38_1.localEulerAngles.x = 0
				var_38_1.localEulerAngles = var_38_1.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 then
				var_38_1.localPosition = Vector3.New(0, 100, 0)
				var_38_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_1.position).x, (manager.ui.mainCamera.transform.position - var_38_1.position).y, (manager.ui.mainCamera.transform.position - var_38_1.position).z)
				var_38_1.localEulerAngles.z = 0
				var_38_1.localEulerAngles.x = 0
				var_38_1.localEulerAngles = var_38_1.localEulerAngles
			end

			local var_38_3 = 0
			local var_38_4 = 1.275

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_3 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_5 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(322191008).content)

				arg_35_1.text_.text = var_38_5

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_7 = 51 <= 0 and var_38_4 or var_38_4 * (utf8.len(var_38_5) / 51)

				if (51 <= 0 and var_38_4 or var_38_4 * (utf8.len(var_38_5) / 51)) > 0 and var_38_4 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_3 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_3
					end
				end

				arg_35_1.text_.text = var_38_5
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_8 = math.max(var_38_4, arg_35_1.talkMaxDuration)

			if var_38_3 <= arg_35_1.time_ and arg_35_1.time_ < var_38_3 + var_38_8 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_3) / var_38_8

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_3 + var_38_8 and arg_35_1.time_ < var_38_3 + var_38_8 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play322191009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 322191009
		arg_39_1.duration_ = 2.23

		local var_39_0 = {
			zh = 1.999999999999,
			ja = 2.233
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play322191010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1043ui_story = arg_39_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_42_0 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				arg_39_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_39_1.time_ - 0) / var_42_0)
				arg_39_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1043ui_story"].transform.position).z)
				arg_39_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1043ui_story"].transform.localEulerAngles = arg_39_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				arg_39_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_39_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1043ui_story"].transform.position).z)
				arg_39_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1043ui_story"].transform.localEulerAngles = arg_39_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_42_1 = arg_39_1.actors_["1043ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1043ui_story == nil then
				arg_39_1.var_.characterEffect1043ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect1043ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1043ui_story then
				arg_39_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_2")
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_42_4 = 0
			local var_42_5 = 0.2

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_6 = arg_39_1:GetWordFromCfg(322191009)
				local var_42_7 = arg_39_1:FormatText(var_42_6.content)

				arg_39_1.text_.text = var_42_7

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_9 = 8 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 8)

				if (8 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 8)) > 0 and var_42_5 < var_42_9 then
					arg_39_1.talkMaxDuration = var_42_9

					if var_42_9 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_4
					end
				end

				arg_39_1.text_.text = var_42_7
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191009", "story_v_out_322191.awb") ~= 0 then
					local var_42_10 = manager.audio:GetVoiceLength("story_v_out_322191", "322191009", "story_v_out_322191.awb") / 1000

					if var_42_10 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_10 + var_42_4
					end

					if var_42_6.prefab_name ~= "" and arg_39_1.actors_[var_42_6.prefab_name] ~= nil then
						local var_42_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_6.prefab_name].transform, "story_v_out_322191", "322191009", "story_v_out_322191.awb")

						arg_39_1:RecordAudio("322191009", var_42_11)
						arg_39_1:RecordAudio("322191009", var_42_11)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_322191", "322191009", "story_v_out_322191.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_322191", "322191009", "story_v_out_322191.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_12 = math.max(var_42_5, arg_39_1.talkMaxDuration)

			if var_42_4 <= arg_39_1.time_ and arg_39_1.time_ < var_42_4 + var_42_12 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_4) / var_42_12

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_4 + var_42_12 and arg_39_1.time_ < var_42_4 + var_42_12 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play322191010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 322191010
		arg_43_1.duration_ = 2.27

		local var_43_0 = {
			zh = 2.133,
			ja = 2.266
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play322191011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.275

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:GetWordFromCfg(322191010)
				local var_46_2 = arg_43_1:FormatText(var_46_1.content)

				arg_43_1.text_.text = var_46_2

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 11 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 11)

				if (11 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 11)) > 0 and var_46_0 < var_46_4 then
					arg_43_1.talkMaxDuration = var_46_4

					if var_46_4 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_4 + 0
					end
				end

				arg_43_1.text_.text = var_46_2
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191010", "story_v_out_322191.awb") ~= 0 then
					local var_46_5 = manager.audio:GetVoiceLength("story_v_out_322191", "322191010", "story_v_out_322191.awb") / 1000

					if var_46_5 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + 0
					end

					if var_46_1.prefab_name ~= "" and arg_43_1.actors_[var_46_1.prefab_name] ~= nil then
						local var_46_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_1.prefab_name].transform, "story_v_out_322191", "322191010", "story_v_out_322191.awb")

						arg_43_1:RecordAudio("322191010", var_46_6)
						arg_43_1:RecordAudio("322191010", var_46_6)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_322191", "322191010", "story_v_out_322191.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_322191", "322191010", "story_v_out_322191.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_7 and arg_43_1.time_ < 0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play322191011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 322191011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play322191012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1043ui_story = arg_47_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1043ui_story"].transform.position).z)
				arg_47_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1043ui_story"].transform.localEulerAngles = arg_47_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1043ui_story"].transform.position).z)
				arg_47_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1043ui_story"].transform.localEulerAngles = arg_47_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_50_1 = 0
			local var_50_2 = 1.775

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_3 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(322191011).content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 71 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 71)

				if (71 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 71)) > 0 and var_50_2 < var_50_5 then
					arg_47_1.talkMaxDuration = var_50_5

					if var_50_5 + var_50_1 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + var_50_1
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_6 = math.max(var_50_2, arg_47_1.talkMaxDuration)

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_6 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_1) / var_50_6

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_1 + var_50_6 and arg_47_1.time_ < var_50_1 + var_50_6 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play322191012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 322191012
		arg_51_1.duration_ = 5.2

		local var_51_0 = {
			zh = 4.566,
			ja = 5.2
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play322191013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1211ui_story = arg_51_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1211ui_story, Vector3.New(0, -0.67, -6.07), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1211ui_story"].transform.position).z)
				arg_51_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1211ui_story"].transform.localEulerAngles = arg_51_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, -0.67, -6.07)
				arg_51_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1211ui_story"].transform.position).z)
				arg_51_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1211ui_story"].transform.localEulerAngles = arg_51_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_54_1 = arg_51_1.actors_["1211ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1211ui_story == nil then
				arg_51_1.var_.characterEffect1211ui_story = var_54_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 and not isNil(var_54_1) then
				if arg_51_1.var_.characterEffect1211ui_story and not isNil(var_54_1) then
					arg_51_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1211ui_story then
				arg_51_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_54_4 = 0
			local var_54_5 = 0.4

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_6 = arg_51_1:GetWordFromCfg(322191012)
				local var_54_7 = arg_51_1:FormatText(var_54_6.content)

				arg_51_1.text_.text = var_54_7

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_9 = 16 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_7) / 16)

				if (16 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_7) / 16)) > 0 and var_54_5 < var_54_9 then
					arg_51_1.talkMaxDuration = var_54_9

					if var_54_9 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_9 + var_54_4
					end
				end

				arg_51_1.text_.text = var_54_7
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191012", "story_v_out_322191.awb") ~= 0 then
					local var_54_10 = manager.audio:GetVoiceLength("story_v_out_322191", "322191012", "story_v_out_322191.awb") / 1000

					if var_54_10 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_10 + var_54_4
					end

					if var_54_6.prefab_name ~= "" and arg_51_1.actors_[var_54_6.prefab_name] ~= nil then
						local var_54_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_6.prefab_name].transform, "story_v_out_322191", "322191012", "story_v_out_322191.awb")

						arg_51_1:RecordAudio("322191012", var_54_11)
						arg_51_1:RecordAudio("322191012", var_54_11)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_322191", "322191012", "story_v_out_322191.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_322191", "322191012", "story_v_out_322191.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_12 = math.max(var_54_5, arg_51_1.talkMaxDuration)

			if var_54_4 <= arg_51_1.time_ and arg_51_1.time_ < var_54_4 + var_54_12 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_4) / var_54_12

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_4 + var_54_12 and arg_51_1.time_ < var_54_4 + var_54_12 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play322191013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 322191013
		arg_55_1.duration_ = 8.13

		local var_55_0 = {
			zh = 8.133,
			ja = 6.3
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play322191014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1211ui_story = arg_55_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1211ui_story"].transform.position).z)
				arg_55_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1211ui_story"].transform.localEulerAngles = arg_55_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				arg_55_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1211ui_story"].transform.position).z)
				arg_55_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1211ui_story"].transform.localEulerAngles = arg_55_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["1043ui_story"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1043ui_story = var_58_1.localPosition
			end

			local var_58_2 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 then
				var_58_1.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_55_1.time_ - 0) / var_58_2)
				var_58_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_1.position).x, (manager.ui.mainCamera.transform.position - var_58_1.position).y, (manager.ui.mainCamera.transform.position - var_58_1.position).z)
				var_58_1.localEulerAngles.z = 0
				var_58_1.localEulerAngles.x = 0
				var_58_1.localEulerAngles = var_58_1.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 then
				var_58_1.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_58_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_1.position).x, (manager.ui.mainCamera.transform.position - var_58_1.position).y, (manager.ui.mainCamera.transform.position - var_58_1.position).z)
				var_58_1.localEulerAngles.z = 0
				var_58_1.localEulerAngles.x = 0
				var_58_1.localEulerAngles = var_58_1.localEulerAngles
			end

			local var_58_3 = arg_55_1.actors_["1043ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_3) and arg_55_1.var_.characterEffect1043ui_story == nil then
				arg_55_1.var_.characterEffect1043ui_story = var_58_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_4 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 and not isNil(var_58_3) then
				if arg_55_1.var_.characterEffect1043ui_story and not isNil(var_58_3) then
					arg_55_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 and not isNil(var_58_3) and arg_55_1.var_.characterEffect1043ui_story then
				arg_55_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_58_6 = arg_55_1.actors_["1211ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_6) and arg_55_1.var_.characterEffect1211ui_story == nil then
				arg_55_1.var_.characterEffect1211ui_story = var_58_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_7 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 and not isNil(var_58_6) then
				if arg_55_1.var_.characterEffect1211ui_story and not isNil(var_58_6) then
					arg_55_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_7)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 and not isNil(var_58_6) and arg_55_1.var_.characterEffect1211ui_story then
				arg_55_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_58_8 = 0
			local var_58_9 = 1.075

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_10 = arg_55_1:GetWordFromCfg(322191013)
				local var_58_11 = arg_55_1:FormatText(var_58_10.content)

				arg_55_1.text_.text = var_58_11

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_13 = 43 <= 0 and var_58_9 or var_58_9 * (utf8.len(var_58_11) / 43)

				if (43 <= 0 and var_58_9 or var_58_9 * (utf8.len(var_58_11) / 43)) > 0 and var_58_9 < var_58_13 then
					arg_55_1.talkMaxDuration = var_58_13

					if var_58_13 + var_58_8 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_13 + var_58_8
					end
				end

				arg_55_1.text_.text = var_58_11
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191013", "story_v_out_322191.awb") ~= 0 then
					local var_58_14 = manager.audio:GetVoiceLength("story_v_out_322191", "322191013", "story_v_out_322191.awb") / 1000

					if var_58_14 + var_58_8 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_14 + var_58_8
					end

					if var_58_10.prefab_name ~= "" and arg_55_1.actors_[var_58_10.prefab_name] ~= nil then
						local var_58_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_10.prefab_name].transform, "story_v_out_322191", "322191013", "story_v_out_322191.awb")

						arg_55_1:RecordAudio("322191013", var_58_15)
						arg_55_1:RecordAudio("322191013", var_58_15)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_322191", "322191013", "story_v_out_322191.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_322191", "322191013", "story_v_out_322191.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_16 = math.max(var_58_9, arg_55_1.talkMaxDuration)

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_16 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_8) / var_58_16

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_8 + var_58_16 and arg_55_1.time_ < var_58_8 + var_58_16 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play322191014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 322191014
		arg_59_1.duration_ = 6.97

		local var_59_0 = {
			zh = 4.733,
			ja = 6.966
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play322191015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.55

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:GetWordFromCfg(322191014)
				local var_62_2 = arg_59_1:FormatText(var_62_1.content)

				arg_59_1.text_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 22 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 22)

				if (22 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 22)) > 0 and var_62_0 < var_62_4 then
					arg_59_1.talkMaxDuration = var_62_4

					if var_62_4 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_4 + 0
					end
				end

				arg_59_1.text_.text = var_62_2
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191014", "story_v_out_322191.awb") ~= 0 then
					local var_62_5 = manager.audio:GetVoiceLength("story_v_out_322191", "322191014", "story_v_out_322191.awb") / 1000

					if var_62_5 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + 0
					end

					if var_62_1.prefab_name ~= "" and arg_59_1.actors_[var_62_1.prefab_name] ~= nil then
						local var_62_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_1.prefab_name].transform, "story_v_out_322191", "322191014", "story_v_out_322191.awb")

						arg_59_1:RecordAudio("322191014", var_62_6)
						arg_59_1:RecordAudio("322191014", var_62_6)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_322191", "322191014", "story_v_out_322191.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_322191", "322191014", "story_v_out_322191.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play322191015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 322191015
		arg_63_1.duration_ = 5.63

		local var_63_0 = {
			zh = 5.066,
			ja = 5.633
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play322191016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1211ui_story"]) and arg_63_1.var_.characterEffect1211ui_story == nil then
				arg_63_1.var_.characterEffect1211ui_story = arg_63_1.actors_["1211ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1211ui_story"]) then
				if arg_63_1.var_.characterEffect1211ui_story and not isNil(arg_63_1.actors_["1211ui_story"]) then
					arg_63_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1211ui_story"]) and arg_63_1.var_.characterEffect1211ui_story then
				arg_63_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_66_2 = arg_63_1.actors_["1043ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.characterEffect1043ui_story == nil then
				arg_63_1.var_.characterEffect1043ui_story = var_66_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_3 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_3 and not isNil(var_66_2) then
				if arg_63_1.var_.characterEffect1043ui_story and not isNil(var_66_2) then
					arg_63_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_3)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_3 and arg_63_1.time_ < 0 + var_66_3 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.characterEffect1043ui_story then
				arg_63_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_2")
			end

			local var_66_4 = 0
			local var_66_5 = 0.6

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_6 = arg_63_1:GetWordFromCfg(322191015)
				local var_66_7 = arg_63_1:FormatText(var_66_6.content)

				arg_63_1.text_.text = var_66_7

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_9 = 24 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 24)

				if (24 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 24)) > 0 and var_66_5 < var_66_9 then
					arg_63_1.talkMaxDuration = var_66_9

					if var_66_9 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_7
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191015", "story_v_out_322191.awb") ~= 0 then
					local var_66_10 = manager.audio:GetVoiceLength("story_v_out_322191", "322191015", "story_v_out_322191.awb") / 1000

					if var_66_10 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_4
					end

					if var_66_6.prefab_name ~= "" and arg_63_1.actors_[var_66_6.prefab_name] ~= nil then
						local var_66_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_6.prefab_name].transform, "story_v_out_322191", "322191015", "story_v_out_322191.awb")

						arg_63_1:RecordAudio("322191015", var_66_11)
						arg_63_1:RecordAudio("322191015", var_66_11)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_322191", "322191015", "story_v_out_322191.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_322191", "322191015", "story_v_out_322191.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_12 = math.max(var_66_5, arg_63_1.talkMaxDuration)

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_12 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_4) / var_66_12

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_4 + var_66_12 and arg_63_1.time_ < var_66_4 + var_66_12 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play322191016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 322191016
		arg_67_1.duration_ = 9.77

		local var_67_0 = {
			zh = 7.2,
			ja = 9.766
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play322191017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.825

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:GetWordFromCfg(322191016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 33 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 33)

				if (33 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 33)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191016", "story_v_out_322191.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_322191", "322191016", "story_v_out_322191.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_322191", "322191016", "story_v_out_322191.awb")

						arg_67_1:RecordAudio("322191016", var_70_6)
						arg_67_1:RecordAudio("322191016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_322191", "322191016", "story_v_out_322191.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_322191", "322191016", "story_v_out_322191.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_7 and arg_67_1.time_ < 0 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play322191017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 322191017
		arg_71_1.duration_ = 6.1

		local var_71_0 = {
			zh = 4.033,
			ja = 6.1
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play322191018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1043ui_story"]) and arg_71_1.var_.characterEffect1043ui_story == nil then
				arg_71_1.var_.characterEffect1043ui_story = arg_71_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["1043ui_story"]) then
				if arg_71_1.var_.characterEffect1043ui_story and not isNil(arg_71_1.actors_["1043ui_story"]) then
					arg_71_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["1043ui_story"]) and arg_71_1.var_.characterEffect1043ui_story then
				arg_71_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_74_2 = arg_71_1.actors_["1211ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.characterEffect1211ui_story == nil then
				arg_71_1.var_.characterEffect1211ui_story = var_74_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_3 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_3 and not isNil(var_74_2) then
				if arg_71_1.var_.characterEffect1211ui_story and not isNil(var_74_2) then
					arg_71_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_3)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_3 and arg_71_1.time_ < 0 + var_74_3 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.characterEffect1211ui_story then
				arg_71_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_1")
			end

			local var_74_4 = 0
			local var_74_5 = 0.4

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(322191017)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 16 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 16)

				if (16 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 16)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191017", "story_v_out_322191.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_out_322191", "322191017", "story_v_out_322191.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_out_322191", "322191017", "story_v_out_322191.awb")

						arg_71_1:RecordAudio("322191017", var_74_11)
						arg_71_1:RecordAudio("322191017", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_322191", "322191017", "story_v_out_322191.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_322191", "322191017", "story_v_out_322191.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_12 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_12 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_4) / var_74_12

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_12 and arg_71_1.time_ < var_74_4 + var_74_12 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play322191018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 322191018
		arg_75_1.duration_ = 11.27

		local var_75_0 = {
			zh = 9.4,
			ja = 11.266
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play322191019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1211ui_story"]) and arg_75_1.var_.characterEffect1211ui_story == nil then
				arg_75_1.var_.characterEffect1211ui_story = arg_75_1.actors_["1211ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1211ui_story"]) then
				if arg_75_1.var_.characterEffect1211ui_story and not isNil(arg_75_1.actors_["1211ui_story"]) then
					arg_75_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1211ui_story"]) and arg_75_1.var_.characterEffect1211ui_story then
				arg_75_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_78_2 = arg_75_1.actors_["1043ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.characterEffect1043ui_story == nil then
				arg_75_1.var_.characterEffect1043ui_story = var_78_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_3 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_3 and not isNil(var_78_2) then
				if arg_75_1.var_.characterEffect1043ui_story and not isNil(var_78_2) then
					arg_75_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_3)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_3 and arg_75_1.time_ < 0 + var_78_3 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.characterEffect1043ui_story then
				arg_75_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_78_4 = 0
			local var_78_5 = 0.875

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_6 = arg_75_1:GetWordFromCfg(322191018)
				local var_78_7 = arg_75_1:FormatText(var_78_6.content)

				arg_75_1.text_.text = var_78_7

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_9 = 35 <= 0 and var_78_5 or var_78_5 * (utf8.len(var_78_7) / 35)

				if (35 <= 0 and var_78_5 or var_78_5 * (utf8.len(var_78_7) / 35)) > 0 and var_78_5 < var_78_9 then
					arg_75_1.talkMaxDuration = var_78_9

					if var_78_9 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_9 + var_78_4
					end
				end

				arg_75_1.text_.text = var_78_7
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191018", "story_v_out_322191.awb") ~= 0 then
					local var_78_10 = manager.audio:GetVoiceLength("story_v_out_322191", "322191018", "story_v_out_322191.awb") / 1000

					if var_78_10 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_4
					end

					if var_78_6.prefab_name ~= "" and arg_75_1.actors_[var_78_6.prefab_name] ~= nil then
						local var_78_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_6.prefab_name].transform, "story_v_out_322191", "322191018", "story_v_out_322191.awb")

						arg_75_1:RecordAudio("322191018", var_78_11)
						arg_75_1:RecordAudio("322191018", var_78_11)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_322191", "322191018", "story_v_out_322191.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_322191", "322191018", "story_v_out_322191.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_12 = math.max(var_78_5, arg_75_1.talkMaxDuration)

			if var_78_4 <= arg_75_1.time_ and arg_75_1.time_ < var_78_4 + var_78_12 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_4) / var_78_12

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_4 + var_78_12 and arg_75_1.time_ < var_78_4 + var_78_12 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play322191019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 322191019
		arg_79_1.duration_ = 6.27

		local var_79_0 = {
			zh = 3.7,
			ja = 6.266
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play322191020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1043ui_story"]) and arg_79_1.var_.characterEffect1043ui_story == nil then
				arg_79_1.var_.characterEffect1043ui_story = arg_79_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1043ui_story"]) then
				if arg_79_1.var_.characterEffect1043ui_story and not isNil(arg_79_1.actors_["1043ui_story"]) then
					arg_79_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1043ui_story"]) and arg_79_1.var_.characterEffect1043ui_story then
				arg_79_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_82_2 = arg_79_1.actors_["1211ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.characterEffect1211ui_story == nil then
				arg_79_1.var_.characterEffect1211ui_story = var_82_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_3 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 and not isNil(var_82_2) then
				if arg_79_1.var_.characterEffect1211ui_story and not isNil(var_82_2) then
					arg_79_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_3)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.characterEffect1211ui_story then
				arg_79_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			local var_82_4 = 0
			local var_82_5 = 0.425

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(322191019)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 17 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 17)

				if (17 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 17)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191019", "story_v_out_322191.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_out_322191", "322191019", "story_v_out_322191.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_out_322191", "322191019", "story_v_out_322191.awb")

						arg_79_1:RecordAudio("322191019", var_82_11)
						arg_79_1:RecordAudio("322191019", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_322191", "322191019", "story_v_out_322191.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_322191", "322191019", "story_v_out_322191.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_12 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_12 and arg_79_1.time_ < var_82_4 + var_82_12 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play322191020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 322191020
		arg_83_1.duration_ = 13.5

		local var_83_0 = {
			zh = 8.2,
			ja = 13.5
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play322191021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 1.025

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:GetWordFromCfg(322191020)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 41 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 41)

				if (41 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 41)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191020", "story_v_out_322191.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_322191", "322191020", "story_v_out_322191.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_322191", "322191020", "story_v_out_322191.awb")

						arg_83_1:RecordAudio("322191020", var_86_6)
						arg_83_1:RecordAudio("322191020", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_322191", "322191020", "story_v_out_322191.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_322191", "322191020", "story_v_out_322191.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play322191021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 322191021
		arg_87_1.duration_ = 5.3

		local var_87_0 = {
			zh = 5.033,
			ja = 5.3
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play322191022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_2")
			end

			local var_90_0 = 0
			local var_90_1 = 0.525

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_2 = arg_87_1:GetWordFromCfg(322191021)
				local var_90_3 = arg_87_1:FormatText(var_90_2.content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 21 <= 0 and var_90_1 or var_90_1 * (utf8.len(var_90_3) / 21)

				if (21 <= 0 and var_90_1 or var_90_1 * (utf8.len(var_90_3) / 21)) > 0 and var_90_1 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191021", "story_v_out_322191.awb") ~= 0 then
					local var_90_6 = manager.audio:GetVoiceLength("story_v_out_322191", "322191021", "story_v_out_322191.awb") / 1000

					if var_90_6 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_6 + var_90_0
					end

					if var_90_2.prefab_name ~= "" and arg_87_1.actors_[var_90_2.prefab_name] ~= nil then
						local var_90_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_2.prefab_name].transform, "story_v_out_322191", "322191021", "story_v_out_322191.awb")

						arg_87_1:RecordAudio("322191021", var_90_7)
						arg_87_1:RecordAudio("322191021", var_90_7)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_322191", "322191021", "story_v_out_322191.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_322191", "322191021", "story_v_out_322191.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_8 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_8 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_8

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_8 and arg_87_1.time_ < var_90_0 + var_90_8 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play322191022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 322191022
		arg_91_1.duration_ = 8.3

		local var_91_0 = {
			zh = 7.2,
			ja = 8.3
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play322191023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1211ui_story"]) and arg_91_1.var_.characterEffect1211ui_story == nil then
				arg_91_1.var_.characterEffect1211ui_story = arg_91_1.actors_["1211ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1211ui_story"]) then
				if arg_91_1.var_.characterEffect1211ui_story and not isNil(arg_91_1.actors_["1211ui_story"]) then
					arg_91_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1211ui_story"]) and arg_91_1.var_.characterEffect1211ui_story then
				arg_91_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_94_2 = arg_91_1.actors_["1043ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.characterEffect1043ui_story == nil then
				arg_91_1.var_.characterEffect1043ui_story = var_94_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_3 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_3 and not isNil(var_94_2) then
				if arg_91_1.var_.characterEffect1043ui_story and not isNil(var_94_2) then
					arg_91_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_3)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_3 and arg_91_1.time_ < 0 + var_94_3 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.characterEffect1043ui_story then
				arg_91_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action7_1")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_94_4 = 0
			local var_94_5 = 0.9

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_6 = arg_91_1:GetWordFromCfg(322191022)
				local var_94_7 = arg_91_1:FormatText(var_94_6.content)

				arg_91_1.text_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 36 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 36)

				if (36 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 36)) > 0 and var_94_5 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9

					if var_94_9 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_4
					end
				end

				arg_91_1.text_.text = var_94_7
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191022", "story_v_out_322191.awb") ~= 0 then
					local var_94_10 = manager.audio:GetVoiceLength("story_v_out_322191", "322191022", "story_v_out_322191.awb") / 1000

					if var_94_10 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_4
					end

					if var_94_6.prefab_name ~= "" and arg_91_1.actors_[var_94_6.prefab_name] ~= nil then
						local var_94_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_6.prefab_name].transform, "story_v_out_322191", "322191022", "story_v_out_322191.awb")

						arg_91_1:RecordAudio("322191022", var_94_11)
						arg_91_1:RecordAudio("322191022", var_94_11)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_322191", "322191022", "story_v_out_322191.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_322191", "322191022", "story_v_out_322191.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_12 = math.max(var_94_5, arg_91_1.talkMaxDuration)

			if var_94_4 <= arg_91_1.time_ and arg_91_1.time_ < var_94_4 + var_94_12 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_4) / var_94_12

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_4 + var_94_12 and arg_91_1.time_ < var_94_4 + var_94_12 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play322191023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 322191023
		arg_95_1.duration_ = 1.6

		local var_95_0 = {
			zh = 1.1,
			ja = 1.6
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play322191024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1043ui_story"]) and arg_95_1.var_.characterEffect1043ui_story == nil then
				arg_95_1.var_.characterEffect1043ui_story = arg_95_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1043ui_story"]) then
				if arg_95_1.var_.characterEffect1043ui_story and not isNil(arg_95_1.actors_["1043ui_story"]) then
					arg_95_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1043ui_story"]) and arg_95_1.var_.characterEffect1043ui_story then
				arg_95_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_98_2 = arg_95_1.actors_["1211ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.characterEffect1211ui_story == nil then
				arg_95_1.var_.characterEffect1211ui_story = var_98_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_3 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_3 and not isNil(var_98_2) then
				if arg_95_1.var_.characterEffect1211ui_story and not isNil(var_98_2) then
					arg_95_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_3)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_3 and arg_95_1.time_ < 0 + var_98_3 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.characterEffect1211ui_story then
				arg_95_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			local var_98_4 = 0
			local var_98_5 = 0.075

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(322191023)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 3 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 3)

				if (3 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 3)) > 0 and var_98_5 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191023", "story_v_out_322191.awb") ~= 0 then
					local var_98_10 = manager.audio:GetVoiceLength("story_v_out_322191", "322191023", "story_v_out_322191.awb") / 1000

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end

					if var_98_6.prefab_name ~= "" and arg_95_1.actors_[var_98_6.prefab_name] ~= nil then
						local var_98_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_6.prefab_name].transform, "story_v_out_322191", "322191023", "story_v_out_322191.awb")

						arg_95_1:RecordAudio("322191023", var_98_11)
						arg_95_1:RecordAudio("322191023", var_98_11)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_322191", "322191023", "story_v_out_322191.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_322191", "322191023", "story_v_out_322191.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_12 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_12 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_12

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_12 and arg_95_1.time_ < var_98_4 + var_98_12 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play322191024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 322191024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play322191025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1211ui_story = arg_99_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1211ui_story"].transform.position).z)
				arg_99_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1211ui_story"].transform.localEulerAngles = arg_99_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1211ui_story"].transform.position).z)
				arg_99_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1211ui_story"].transform.localEulerAngles = arg_99_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["1043ui_story"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1043ui_story = var_102_1.localPosition
			end

			local var_102_2 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 then
				var_102_1.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_2)
				var_102_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_1.position).x, (manager.ui.mainCamera.transform.position - var_102_1.position).y, (manager.ui.mainCamera.transform.position - var_102_1.position).z)
				var_102_1.localEulerAngles.z = 0
				var_102_1.localEulerAngles.x = 0
				var_102_1.localEulerAngles = var_102_1.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 then
				var_102_1.localPosition = Vector3.New(0, 100, 0)
				var_102_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_1.position).x, (manager.ui.mainCamera.transform.position - var_102_1.position).y, (manager.ui.mainCamera.transform.position - var_102_1.position).z)
				var_102_1.localEulerAngles.z = 0
				var_102_1.localEulerAngles.x = 0
				var_102_1.localEulerAngles = var_102_1.localEulerAngles
			end

			local var_102_3 = 0
			local var_102_4 = 1.125

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_5 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(322191024).content)

				arg_99_1.text_.text = var_102_5

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_7 = 45 <= 0 and var_102_4 or var_102_4 * (utf8.len(var_102_5) / 45)

				if (45 <= 0 and var_102_4 or var_102_4 * (utf8.len(var_102_5) / 45)) > 0 and var_102_4 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_3 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_3
					end
				end

				arg_99_1.text_.text = var_102_5
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_8 = math.max(var_102_4, arg_99_1.talkMaxDuration)

			if var_102_3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_3 + var_102_8 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_3) / var_102_8

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_3 + var_102_8 and arg_99_1.time_ < var_102_3 + var_102_8 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play322191025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 322191025
		arg_103_1.duration_ = 2.03

		local var_103_0 = {
			zh = 1.999999999999,
			ja = 2.033
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
			arg_103_1.auto_ = false
		end

		function arg_103_1.playNext_(arg_105_0)
			arg_103_1.onStoryFinished_()
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1043ui_story = arg_103_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_106_0 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				arg_103_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1043ui_story"].transform.position).z)
				arg_103_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1043ui_story"].transform.localEulerAngles = arg_103_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				arg_103_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_103_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1043ui_story"].transform.position).z)
				arg_103_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1043ui_story"].transform.localEulerAngles = arg_103_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_106_1 = arg_103_1.actors_["1043ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1043ui_story == nil then
				arg_103_1.var_.characterEffect1043ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and not isNil(var_106_1) then
				if arg_103_1.var_.characterEffect1043ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1043ui_story then
				arg_103_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action7_1")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_106_4 = 0
			local var_106_5 = 0.2

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_6 = arg_103_1:GetWordFromCfg(322191025)
				local var_106_7 = arg_103_1:FormatText(var_106_6.content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 8 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 8)

				if (8 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 8)) > 0 and var_106_5 < var_106_9 then
					arg_103_1.talkMaxDuration = var_106_9

					if var_106_9 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191025", "story_v_out_322191.awb") ~= 0 then
					local var_106_10 = manager.audio:GetVoiceLength("story_v_out_322191", "322191025", "story_v_out_322191.awb") / 1000

					if var_106_10 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_4
					end

					if var_106_6.prefab_name ~= "" and arg_103_1.actors_[var_106_6.prefab_name] ~= nil then
						local var_106_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_6.prefab_name].transform, "story_v_out_322191", "322191025", "story_v_out_322191.awb")

						arg_103_1:RecordAudio("322191025", var_106_11)
						arg_103_1:RecordAudio("322191025", var_106_11)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_322191", "322191025", "story_v_out_322191.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_322191", "322191025", "story_v_out_322191.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_12 = math.max(var_106_5, arg_103_1.talkMaxDuration)

			if var_106_4 <= arg_103_1.time_ and arg_103_1.time_ < var_106_4 + var_106_12 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_4) / var_106_12

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_4 + var_106_12 and arg_103_1.time_ < var_106_4 + var_106_12 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/L09h"
	},
	voices = {
		"story_v_out_322191.awb"
	}
}
