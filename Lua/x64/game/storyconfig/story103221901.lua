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
			local var_4_0 = "STwhite"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.STwhite

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STwhite" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = 1.975

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_23 = 0.158333333333333

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_24 = 0
			local var_4_25 = 0.3

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 0.166666666666667
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "effect"

				arg_1_1:AudioAction(var_4_32, var_4_33, "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_4_34 = 2
			local var_4_35 = 3.1
			local var_4_36 = manager.audio:GetVoiceLength("story_v_out_322191", "322191001", "story_v_out_322191.awb") / 1000

			if var_4_36 > 0 and var_4_35 < var_4_36 and var_4_36 + var_4_34 > arg_1_1.duration_ then
				local var_4_37 = var_4_36

				arg_1_1.duration_ = var_4_36 + var_4_34
			end

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "voice"

				arg_1_1:AudioAction(var_4_38, var_4_39, "story_v_out_322191", "322191001", "story_v_out_322191.awb")
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
			local var_9_0 = 0
			local var_9_1 = 1.3
			local var_9_2 = manager.audio:GetVoiceLength("story_v_out_322191", "322191002", "story_v_out_322191.awb") / 1000

			if var_9_2 > 0 and var_9_1 < var_9_2 and var_9_2 + var_9_0 > arg_6_1.duration_ then
				local var_9_3 = var_9_2

				arg_6_1.duration_ = var_9_2 + var_9_0
			end

			if var_9_0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				local var_9_4 = "play"
				local var_9_5 = "voice"

				arg_6_1:AudioAction(var_9_4, var_9_5, "story_v_out_322191", "322191002", "story_v_out_322191.awb")
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
			local var_13_0 = 0
			local var_13_1 = 1.266
			local var_13_2 = manager.audio:GetVoiceLength("story_v_out_322191", "322191003", "story_v_out_322191.awb") / 1000

			if var_13_2 > 0 and var_13_1 < var_13_2 and var_13_2 + var_13_0 > arg_10_1.duration_ then
				local var_13_3 = var_13_2

				arg_10_1.duration_ = var_13_2 + var_13_0
			end

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				local var_13_4 = "play"
				local var_13_5 = "voice"

				arg_10_1:AudioAction(var_13_4, var_13_5, "story_v_out_322191", "322191003", "story_v_out_322191.awb")
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
			local var_17_0 = 1.91666666666667

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.allBtn_.enabled = false
			end

			local var_17_1 = 0.833333333334334

			if arg_14_1.time_ >= var_17_0 + var_17_1 and arg_14_1.time_ < var_17_0 + var_17_1 + arg_17_0 then
				arg_14_1.allBtn_.enabled = true
			end

			local var_17_2 = "L09h"

			if arg_14_1.bgs_[var_17_2] == nil then
				local var_17_3 = Object.Instantiate(arg_14_1.paintGo_)

				var_17_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_17_2)
				var_17_3.name = var_17_2
				var_17_3.transform.parent = arg_14_1.stage_.transform
				var_17_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_14_1.bgs_[var_17_2] = var_17_3
			end

			local var_17_4 = 0.966666666666667

			if var_17_4 < arg_14_1.time_ and arg_14_1.time_ <= var_17_4 + arg_17_0 then
				local var_17_5 = manager.ui.mainCamera.transform.localPosition
				local var_17_6 = Vector3.New(0, 0, 10) + Vector3.New(var_17_5.x, var_17_5.y, 0)
				local var_17_7 = arg_14_1.bgs_.L09h

				var_17_7.transform.localPosition = var_17_6
				var_17_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_17_8 = var_17_7:GetComponent("SpriteRenderer")

				if var_17_8 and var_17_8.sprite then
					local var_17_9 = (var_17_7.transform.localPosition - var_17_5).z
					local var_17_10 = manager.ui.mainCameraCom_
					local var_17_11 = 2 * var_17_9 * Mathf.Tan(var_17_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_17_12 = var_17_11 * var_17_10.aspect
					local var_17_13 = var_17_8.sprite.bounds.size.x
					local var_17_14 = var_17_8.sprite.bounds.size.y
					local var_17_15 = var_17_12 / var_17_13
					local var_17_16 = var_17_11 / var_17_14
					local var_17_17 = var_17_16 < var_17_15 and var_17_15 or var_17_16

					var_17_7.transform.localScale = Vector3.New(var_17_17, var_17_17, 0)
				end

				for iter_17_0, iter_17_1 in pairs(arg_14_1.bgs_) do
					if iter_17_0 ~= "L09h" then
						iter_17_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_17_18 = 0

			if var_17_18 < arg_14_1.time_ and arg_14_1.time_ <= var_17_18 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = true

				arg_14_1:SetGaussion(false)
			end

			local var_17_19 = 0.966666666666667

			if var_17_18 <= arg_14_1.time_ and arg_14_1.time_ < var_17_18 + var_17_19 then
				local var_17_20 = (arg_14_1.time_ - var_17_18) / var_17_19
				local var_17_21 = Color.New(1, 1, 1)

				var_17_21.a = Mathf.Lerp(0, 1, var_17_20)
				arg_14_1.mask_.color = var_17_21
			end

			if arg_14_1.time_ >= var_17_18 + var_17_19 and arg_14_1.time_ < var_17_18 + var_17_19 + arg_17_0 then
				local var_17_22 = Color.New(1, 1, 1)

				var_17_22.a = 1
				arg_14_1.mask_.color = var_17_22
			end

			local var_17_23 = 0.966666666666667

			if var_17_23 < arg_14_1.time_ and arg_14_1.time_ <= var_17_23 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = true

				arg_14_1:SetGaussion(false)
			end

			local var_17_24 = 0.966666666666667

			if var_17_23 <= arg_14_1.time_ and arg_14_1.time_ < var_17_23 + var_17_24 then
				local var_17_25 = (arg_14_1.time_ - var_17_23) / var_17_24
				local var_17_26 = Color.New(1, 1, 1)

				var_17_26.a = Mathf.Lerp(1, 0, var_17_25)
				arg_14_1.mask_.color = var_17_26
			end

			if arg_14_1.time_ >= var_17_23 + var_17_24 and arg_14_1.time_ < var_17_23 + var_17_24 + arg_17_0 then
				local var_17_27 = Color.New(1, 1, 1)
				local var_17_28 = 0

				arg_14_1.mask_.enabled = false
				var_17_27.a = var_17_28
				arg_14_1.mask_.color = var_17_27
			end

			local var_17_29 = 0
			local var_17_30 = 0.3

			if var_17_29 < arg_14_1.time_ and arg_14_1.time_ <= var_17_29 + arg_17_0 then
				local var_17_31 = "play"
				local var_17_32 = "music"

				arg_14_1:AudioAction(var_17_31, var_17_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_17_33 = ""
				local var_17_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_17_34 ~= "" then
					if arg_14_1.bgmTxt_.text ~= var_17_34 and arg_14_1.bgmTxt_.text ~= "" then
						if arg_14_1.bgmTxt2_.text ~= "" then
							arg_14_1.bgmTxt_.text = arg_14_1.bgmTxt2_.text
						end

						arg_14_1.bgmTxt2_.text = var_17_34

						arg_14_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_14_1.bgmTxt_.text = var_17_34
						arg_14_1.bgmTxt2_.text = var_17_34
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

			local var_17_35 = 0.433333333333333
			local var_17_36 = 1

			if var_17_35 < arg_14_1.time_ and arg_14_1.time_ <= var_17_35 + arg_17_0 then
				local var_17_37 = "play"
				local var_17_38 = "music"

				arg_14_1:AudioAction(var_17_37, var_17_38, "bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source.awb")

				local var_17_39 = ""
				local var_17_40 = manager.audio:GetAudioName("bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source")

				if var_17_40 ~= "" then
					if arg_14_1.bgmTxt_.text ~= var_17_40 and arg_14_1.bgmTxt_.text ~= "" then
						if arg_14_1.bgmTxt2_.text ~= "" then
							arg_14_1.bgmTxt_.text = arg_14_1.bgmTxt2_.text
						end

						arg_14_1.bgmTxt2_.text = var_17_40

						arg_14_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_14_1.bgmTxt_.text = var_17_40
						arg_14_1.bgmTxt2_.text = var_17_40
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

			local var_17_41 = 0.607469807844609
			local var_17_42 = 1

			if var_17_41 < arg_14_1.time_ and arg_14_1.time_ <= var_17_41 + arg_17_0 then
				local var_17_43 = "play"
				local var_17_44 = "effect"

				arg_14_1:AudioAction(var_17_43, var_17_44, "se_story_145", "se_story_145_amb_dark_L09", "")
			end

			local var_17_45 = 0
			local var_17_46 = 1

			if var_17_45 < arg_14_1.time_ and arg_14_1.time_ <= var_17_45 + arg_17_0 then
				local var_17_47 = "play"
				local var_17_48 = "effect"

				arg_14_1:AudioAction(var_17_47, var_17_48, "se_story_121_04", "se_story_121_04_magic", "")
			end

			local var_17_49 = 0.44
			local var_17_50 = 1

			if var_17_49 < arg_14_1.time_ and arg_14_1.time_ <= var_17_49 + arg_17_0 then
				local var_17_51 = "play"
				local var_17_52 = "music"

				arg_14_1:AudioAction(var_17_51, var_17_52, "bgm_activity_4_5_story_source", "init_story", "bgm_activity_4_5_story_source.awb")

				local var_17_53 = ""
				local var_17_54 = manager.audio:GetAudioName("bgm_activity_4_5_story_source", "init_story")

				if var_17_54 ~= "" then
					if arg_14_1.bgmTxt_.text ~= var_17_54 and arg_14_1.bgmTxt_.text ~= "" then
						if arg_14_1.bgmTxt2_.text ~= "" then
							arg_14_1.bgmTxt_.text = arg_14_1.bgmTxt2_.text
						end

						arg_14_1.bgmTxt2_.text = var_17_54

						arg_14_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_14_1.bgmTxt_.text = var_17_54
						arg_14_1.bgmTxt2_.text = var_17_54
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

			local var_17_55 = 1.91666666666667
			local var_17_56 = 1.05

			if var_17_55 < arg_14_1.time_ and arg_14_1.time_ <= var_17_55 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				arg_14_1.dialog_:SetActive(true)

				arg_14_1.dialogCg_.alpha = 0

				local var_17_57 = LeanTween.value(arg_14_1.dialog_, 0, 1, 0.3)

				var_17_57:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_14_1.dialogCg_.alpha = arg_21_0
				end))
				var_17_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_14_1.dialog_)
					var_17_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_14_1.duration_ = arg_14_1.duration_ + 0.3

				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_58 = arg_14_1:GetWordFromCfg(322191004)
				local var_17_59 = arg_14_1:FormatText(var_17_58.content)

				arg_14_1.text_.text = var_17_59

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_60 = 42
				local var_17_61 = utf8.len(var_17_59)
				local var_17_62 = var_17_60 <= 0 and var_17_56 or var_17_56 * (var_17_61 / var_17_60)

				if var_17_62 > 0 and var_17_56 < var_17_62 then
					arg_14_1.talkMaxDuration = var_17_62
					var_17_55 = var_17_55 + 0.3

					if var_17_62 + var_17_55 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_62 + var_17_55
					end
				end

				arg_14_1.text_.text = var_17_59
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_63 = var_17_55 + 0.3
			local var_17_64 = math.max(var_17_56, arg_14_1.talkMaxDuration)

			if var_17_63 <= arg_14_1.time_ and arg_14_1.time_ < var_17_63 + var_17_64 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_63) / var_17_64

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_63 + var_17_64 and arg_14_1.time_ < var_17_63 + var_17_64 + arg_17_0 then
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
			local var_26_0 = "1211ui_story"

			if arg_23_1.actors_[var_26_0] == nil then
				local var_26_1 = Asset.Load("Char/" .. "1211ui_story")

				if not isNil(var_26_1) then
					local var_26_2 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_23_1.stage_.transform)

					var_26_2.name = var_26_0
					var_26_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_23_1.actors_[var_26_0] = var_26_2

					local var_26_3 = var_26_2:GetComponentInChildren(typeof(CharacterEffect))

					var_26_3.enabled = true

					local var_26_4 = GameObjectTools.GetOrAddComponent(var_26_2, typeof(DynamicBoneHelper))

					if var_26_4 then
						var_26_4:EnableDynamicBone(false)
					end

					arg_23_1:ShowWeapon(var_26_3.transform, false)

					arg_23_1.var_[var_26_0 .. "Animator"] = var_26_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_23_1.var_[var_26_0 .. "Animator"].applyRootMotion = true
					arg_23_1.var_[var_26_0 .. "LipSync"] = var_26_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_26_5 = arg_23_1.actors_["1211ui_story"].transform
			local var_26_6 = 0

			if var_26_6 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1.var_.moveOldPos1211ui_story = var_26_5.localPosition

				local var_26_7 = "1211ui_story"

				arg_23_1:ShowWeapon(arg_23_1.var_[var_26_7 .. "Animator"].transform, false)
			end

			local var_26_8 = 0.001

			if var_26_6 <= arg_23_1.time_ and arg_23_1.time_ < var_26_6 + var_26_8 then
				local var_26_9 = (arg_23_1.time_ - var_26_6) / var_26_8
				local var_26_10 = Vector3.New(-0.7, -0.67, -6.07)

				var_26_5.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1211ui_story, var_26_10, var_26_9)

				local var_26_11 = manager.ui.mainCamera.transform.position - var_26_5.position

				var_26_5.forward = Vector3.New(var_26_11.x, var_26_11.y, var_26_11.z)

				local var_26_12 = var_26_5.localEulerAngles

				var_26_12.z = 0
				var_26_12.x = 0
				var_26_5.localEulerAngles = var_26_12
			end

			if arg_23_1.time_ >= var_26_6 + var_26_8 and arg_23_1.time_ < var_26_6 + var_26_8 + arg_26_0 then
				var_26_5.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_26_13 = manager.ui.mainCamera.transform.position - var_26_5.position

				var_26_5.forward = Vector3.New(var_26_13.x, var_26_13.y, var_26_13.z)

				local var_26_14 = var_26_5.localEulerAngles

				var_26_14.z = 0
				var_26_14.x = 0
				var_26_5.localEulerAngles = var_26_14
			end

			local var_26_15 = arg_23_1.actors_["1211ui_story"]
			local var_26_16 = 0

			if var_26_16 < arg_23_1.time_ and arg_23_1.time_ <= var_26_16 + arg_26_0 and not isNil(var_26_15) and arg_23_1.var_.characterEffect1211ui_story == nil then
				arg_23_1.var_.characterEffect1211ui_story = var_26_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_17 = 0.200000002980232

			if var_26_16 <= arg_23_1.time_ and arg_23_1.time_ < var_26_16 + var_26_17 and not isNil(var_26_15) then
				local var_26_18 = (arg_23_1.time_ - var_26_16) / var_26_17

				if arg_23_1.var_.characterEffect1211ui_story and not isNil(var_26_15) then
					arg_23_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_16 + var_26_17 and arg_23_1.time_ < var_26_16 + var_26_17 + arg_26_0 and not isNil(var_26_15) and arg_23_1.var_.characterEffect1211ui_story then
				arg_23_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_26_19 = 0

			if var_26_19 < arg_23_1.time_ and arg_23_1.time_ <= var_26_19 + arg_26_0 then
				arg_23_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action2_1")
			end

			local var_26_20 = 0

			if var_26_20 < arg_23_1.time_ and arg_23_1.time_ <= var_26_20 + arg_26_0 then
				arg_23_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_26_21 = 0
			local var_26_22 = 0.25

			if var_26_21 < arg_23_1.time_ and arg_23_1.time_ <= var_26_21 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_23 = arg_23_1:FormatText(StoryNameCfg[37].name)

				arg_23_1.leftNameTxt_.text = var_26_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_24 = arg_23_1:GetWordFromCfg(322191005)
				local var_26_25 = arg_23_1:FormatText(var_26_24.content)

				arg_23_1.text_.text = var_26_25

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_26 = 10
				local var_26_27 = utf8.len(var_26_25)
				local var_26_28 = var_26_26 <= 0 and var_26_22 or var_26_22 * (var_26_27 / var_26_26)

				if var_26_28 > 0 and var_26_22 < var_26_28 then
					arg_23_1.talkMaxDuration = var_26_28

					if var_26_28 + var_26_21 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_28 + var_26_21
					end
				end

				arg_23_1.text_.text = var_26_25
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191005", "story_v_out_322191.awb") ~= 0 then
					local var_26_29 = manager.audio:GetVoiceLength("story_v_out_322191", "322191005", "story_v_out_322191.awb") / 1000

					if var_26_29 + var_26_21 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_29 + var_26_21
					end

					if var_26_24.prefab_name ~= "" and arg_23_1.actors_[var_26_24.prefab_name] ~= nil then
						local var_26_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_24.prefab_name].transform, "story_v_out_322191", "322191005", "story_v_out_322191.awb")

						arg_23_1:RecordAudio("322191005", var_26_30)
						arg_23_1:RecordAudio("322191005", var_26_30)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_322191", "322191005", "story_v_out_322191.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_322191", "322191005", "story_v_out_322191.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_31 = math.max(var_26_22, arg_23_1.talkMaxDuration)

			if var_26_21 <= arg_23_1.time_ and arg_23_1.time_ < var_26_21 + var_26_31 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_21) / var_26_31

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_21 + var_26_31 and arg_23_1.time_ < var_26_21 + var_26_31 + arg_26_0 then
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
			local var_30_0 = "1043ui_story"

			if arg_27_1.actors_[var_30_0] == nil then
				local var_30_1 = Asset.Load("Char/" .. "1043ui_story")

				if not isNil(var_30_1) then
					local var_30_2 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_27_1.stage_.transform)

					var_30_2.name = var_30_0
					var_30_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_27_1.actors_[var_30_0] = var_30_2

					local var_30_3 = var_30_2:GetComponentInChildren(typeof(CharacterEffect))

					var_30_3.enabled = true

					local var_30_4 = GameObjectTools.GetOrAddComponent(var_30_2, typeof(DynamicBoneHelper))

					if var_30_4 then
						var_30_4:EnableDynamicBone(false)
					end

					arg_27_1:ShowWeapon(var_30_3.transform, false)

					arg_27_1.var_[var_30_0 .. "Animator"] = var_30_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_27_1.var_[var_30_0 .. "Animator"].applyRootMotion = true
					arg_27_1.var_[var_30_0 .. "LipSync"] = var_30_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_30_5 = arg_27_1.actors_["1043ui_story"].transform
			local var_30_6 = 0

			if var_30_6 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.var_.moveOldPos1043ui_story = var_30_5.localPosition
			end

			local var_30_7 = 0.001

			if var_30_6 <= arg_27_1.time_ and arg_27_1.time_ < var_30_6 + var_30_7 then
				local var_30_8 = (arg_27_1.time_ - var_30_6) / var_30_7
				local var_30_9 = Vector3.New(0.81, -1.01, -5.73)

				var_30_5.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1043ui_story, var_30_9, var_30_8)

				local var_30_10 = manager.ui.mainCamera.transform.position - var_30_5.position

				var_30_5.forward = Vector3.New(var_30_10.x, var_30_10.y, var_30_10.z)

				local var_30_11 = var_30_5.localEulerAngles

				var_30_11.z = 0
				var_30_11.x = 0
				var_30_5.localEulerAngles = var_30_11
			end

			if arg_27_1.time_ >= var_30_6 + var_30_7 and arg_27_1.time_ < var_30_6 + var_30_7 + arg_30_0 then
				var_30_5.localPosition = Vector3.New(0.81, -1.01, -5.73)

				local var_30_12 = manager.ui.mainCamera.transform.position - var_30_5.position

				var_30_5.forward = Vector3.New(var_30_12.x, var_30_12.y, var_30_12.z)

				local var_30_13 = var_30_5.localEulerAngles

				var_30_13.z = 0
				var_30_13.x = 0
				var_30_5.localEulerAngles = var_30_13
			end

			local var_30_14 = arg_27_1.actors_["1043ui_story"]
			local var_30_15 = 0

			if var_30_15 < arg_27_1.time_ and arg_27_1.time_ <= var_30_15 + arg_30_0 and not isNil(var_30_14) and arg_27_1.var_.characterEffect1043ui_story == nil then
				arg_27_1.var_.characterEffect1043ui_story = var_30_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_16 = 0.200000002980232

			if var_30_15 <= arg_27_1.time_ and arg_27_1.time_ < var_30_15 + var_30_16 and not isNil(var_30_14) then
				local var_30_17 = (arg_27_1.time_ - var_30_15) / var_30_16

				if arg_27_1.var_.characterEffect1043ui_story and not isNil(var_30_14) then
					arg_27_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_15 + var_30_16 and arg_27_1.time_ < var_30_15 + var_30_16 + arg_30_0 and not isNil(var_30_14) and arg_27_1.var_.characterEffect1043ui_story then
				arg_27_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_30_18 = arg_27_1.actors_["1211ui_story"]
			local var_30_19 = 0

			if var_30_19 < arg_27_1.time_ and arg_27_1.time_ <= var_30_19 + arg_30_0 and not isNil(var_30_18) and arg_27_1.var_.characterEffect1211ui_story == nil then
				arg_27_1.var_.characterEffect1211ui_story = var_30_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_20 = 0.200000002980232

			if var_30_19 <= arg_27_1.time_ and arg_27_1.time_ < var_30_19 + var_30_20 and not isNil(var_30_18) then
				local var_30_21 = (arg_27_1.time_ - var_30_19) / var_30_20

				if arg_27_1.var_.characterEffect1211ui_story and not isNil(var_30_18) then
					local var_30_22 = Mathf.Lerp(0, 0.5, var_30_21)

					arg_27_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1211ui_story.fillRatio = var_30_22
				end
			end

			if arg_27_1.time_ >= var_30_19 + var_30_20 and arg_27_1.time_ < var_30_19 + var_30_20 + arg_30_0 and not isNil(var_30_18) and arg_27_1.var_.characterEffect1211ui_story then
				local var_30_23 = 0.5

				arg_27_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1211ui_story.fillRatio = var_30_23
			end

			local var_30_24 = 0

			if var_30_24 < arg_27_1.time_ and arg_27_1.time_ <= var_30_24 + arg_30_0 then
				arg_27_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_1")
			end

			local var_30_25 = 0

			if var_30_25 < arg_27_1.time_ and arg_27_1.time_ <= var_30_25 + arg_30_0 then
				arg_27_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_30_26 = 0
			local var_30_27 = 0.8

			if var_30_26 < arg_27_1.time_ and arg_27_1.time_ <= var_30_26 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_28 = arg_27_1:FormatText(StoryNameCfg[1156].name)

				arg_27_1.leftNameTxt_.text = var_30_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_29 = arg_27_1:GetWordFromCfg(322191006)
				local var_30_30 = arg_27_1:FormatText(var_30_29.content)

				arg_27_1.text_.text = var_30_30

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_31 = 32
				local var_30_32 = utf8.len(var_30_30)
				local var_30_33 = var_30_31 <= 0 and var_30_27 or var_30_27 * (var_30_32 / var_30_31)

				if var_30_33 > 0 and var_30_27 < var_30_33 then
					arg_27_1.talkMaxDuration = var_30_33

					if var_30_33 + var_30_26 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_33 + var_30_26
					end
				end

				arg_27_1.text_.text = var_30_30
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191006", "story_v_out_322191.awb") ~= 0 then
					local var_30_34 = manager.audio:GetVoiceLength("story_v_out_322191", "322191006", "story_v_out_322191.awb") / 1000

					if var_30_34 + var_30_26 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_34 + var_30_26
					end

					if var_30_29.prefab_name ~= "" and arg_27_1.actors_[var_30_29.prefab_name] ~= nil then
						local var_30_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_29.prefab_name].transform, "story_v_out_322191", "322191006", "story_v_out_322191.awb")

						arg_27_1:RecordAudio("322191006", var_30_35)
						arg_27_1:RecordAudio("322191006", var_30_35)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_322191", "322191006", "story_v_out_322191.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_322191", "322191006", "story_v_out_322191.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_36 = math.max(var_30_27, arg_27_1.talkMaxDuration)

			if var_30_26 <= arg_27_1.time_ and arg_27_1.time_ < var_30_26 + var_30_36 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_26) / var_30_36

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_26 + var_30_36 and arg_27_1.time_ < var_30_26 + var_30_36 + arg_30_0 then
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
			local var_34_0 = arg_31_1.actors_["1211ui_story"]
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.characterEffect1211ui_story == nil then
				arg_31_1.var_.characterEffect1211ui_story = var_34_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 and not isNil(var_34_0) then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2

				if arg_31_1.var_.characterEffect1211ui_story and not isNil(var_34_0) then
					arg_31_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.characterEffect1211ui_story then
				arg_31_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_34_4 = arg_31_1.actors_["1043ui_story"]
			local var_34_5 = 0

			if var_34_5 < arg_31_1.time_ and arg_31_1.time_ <= var_34_5 + arg_34_0 and not isNil(var_34_4) and arg_31_1.var_.characterEffect1043ui_story == nil then
				arg_31_1.var_.characterEffect1043ui_story = var_34_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_6 = 0.200000002980232

			if var_34_5 <= arg_31_1.time_ and arg_31_1.time_ < var_34_5 + var_34_6 and not isNil(var_34_4) then
				local var_34_7 = (arg_31_1.time_ - var_34_5) / var_34_6

				if arg_31_1.var_.characterEffect1043ui_story and not isNil(var_34_4) then
					local var_34_8 = Mathf.Lerp(0, 0.5, var_34_7)

					arg_31_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1043ui_story.fillRatio = var_34_8
				end
			end

			if arg_31_1.time_ >= var_34_5 + var_34_6 and arg_31_1.time_ < var_34_5 + var_34_6 + arg_34_0 and not isNil(var_34_4) and arg_31_1.var_.characterEffect1043ui_story then
				local var_34_9 = 0.5

				arg_31_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1043ui_story.fillRatio = var_34_9
			end

			local var_34_10 = 0

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 then
				arg_31_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action2_2")
			end

			local var_34_11 = 0
			local var_34_12 = 0.4

			if var_34_11 < arg_31_1.time_ and arg_31_1.time_ <= var_34_11 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_13 = arg_31_1:FormatText(StoryNameCfg[37].name)

				arg_31_1.leftNameTxt_.text = var_34_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_14 = arg_31_1:GetWordFromCfg(322191007)
				local var_34_15 = arg_31_1:FormatText(var_34_14.content)

				arg_31_1.text_.text = var_34_15

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_16 = 16
				local var_34_17 = utf8.len(var_34_15)
				local var_34_18 = var_34_16 <= 0 and var_34_12 or var_34_12 * (var_34_17 / var_34_16)

				if var_34_18 > 0 and var_34_12 < var_34_18 then
					arg_31_1.talkMaxDuration = var_34_18

					if var_34_18 + var_34_11 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_18 + var_34_11
					end
				end

				arg_31_1.text_.text = var_34_15
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191007", "story_v_out_322191.awb") ~= 0 then
					local var_34_19 = manager.audio:GetVoiceLength("story_v_out_322191", "322191007", "story_v_out_322191.awb") / 1000

					if var_34_19 + var_34_11 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_19 + var_34_11
					end

					if var_34_14.prefab_name ~= "" and arg_31_1.actors_[var_34_14.prefab_name] ~= nil then
						local var_34_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_14.prefab_name].transform, "story_v_out_322191", "322191007", "story_v_out_322191.awb")

						arg_31_1:RecordAudio("322191007", var_34_20)
						arg_31_1:RecordAudio("322191007", var_34_20)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_322191", "322191007", "story_v_out_322191.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_322191", "322191007", "story_v_out_322191.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_21 = math.max(var_34_12, arg_31_1.talkMaxDuration)

			if var_34_11 <= arg_31_1.time_ and arg_31_1.time_ < var_34_11 + var_34_21 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_11) / var_34_21

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_11 + var_34_21 and arg_31_1.time_ < var_34_11 + var_34_21 + arg_34_0 then
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
			local var_38_0 = arg_35_1.actors_["1211ui_story"].transform
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.var_.moveOldPos1211ui_story = var_38_0.localPosition
			end

			local var_38_2 = 0.001

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2
				local var_38_4 = Vector3.New(0, 100, 0)

				var_38_0.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1211ui_story, var_38_4, var_38_3)

				local var_38_5 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_5.x, var_38_5.y, var_38_5.z)

				local var_38_6 = var_38_0.localEulerAngles

				var_38_6.z = 0
				var_38_6.x = 0
				var_38_0.localEulerAngles = var_38_6
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 then
				var_38_0.localPosition = Vector3.New(0, 100, 0)

				local var_38_7 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_7.x, var_38_7.y, var_38_7.z)

				local var_38_8 = var_38_0.localEulerAngles

				var_38_8.z = 0
				var_38_8.x = 0
				var_38_0.localEulerAngles = var_38_8
			end

			local var_38_9 = arg_35_1.actors_["1043ui_story"].transform
			local var_38_10 = 0

			if var_38_10 < arg_35_1.time_ and arg_35_1.time_ <= var_38_10 + arg_38_0 then
				arg_35_1.var_.moveOldPos1043ui_story = var_38_9.localPosition
			end

			local var_38_11 = 0.001

			if var_38_10 <= arg_35_1.time_ and arg_35_1.time_ < var_38_10 + var_38_11 then
				local var_38_12 = (arg_35_1.time_ - var_38_10) / var_38_11
				local var_38_13 = Vector3.New(0, 100, 0)

				var_38_9.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1043ui_story, var_38_13, var_38_12)

				local var_38_14 = manager.ui.mainCamera.transform.position - var_38_9.position

				var_38_9.forward = Vector3.New(var_38_14.x, var_38_14.y, var_38_14.z)

				local var_38_15 = var_38_9.localEulerAngles

				var_38_15.z = 0
				var_38_15.x = 0
				var_38_9.localEulerAngles = var_38_15
			end

			if arg_35_1.time_ >= var_38_10 + var_38_11 and arg_35_1.time_ < var_38_10 + var_38_11 + arg_38_0 then
				var_38_9.localPosition = Vector3.New(0, 100, 0)

				local var_38_16 = manager.ui.mainCamera.transform.position - var_38_9.position

				var_38_9.forward = Vector3.New(var_38_16.x, var_38_16.y, var_38_16.z)

				local var_38_17 = var_38_9.localEulerAngles

				var_38_17.z = 0
				var_38_17.x = 0
				var_38_9.localEulerAngles = var_38_17
			end

			local var_38_18 = 0
			local var_38_19 = 1.275

			if var_38_18 < arg_35_1.time_ and arg_35_1.time_ <= var_38_18 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_20 = arg_35_1:GetWordFromCfg(322191008)
				local var_38_21 = arg_35_1:FormatText(var_38_20.content)

				arg_35_1.text_.text = var_38_21

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_22 = 51
				local var_38_23 = utf8.len(var_38_21)
				local var_38_24 = var_38_22 <= 0 and var_38_19 or var_38_19 * (var_38_23 / var_38_22)

				if var_38_24 > 0 and var_38_19 < var_38_24 then
					arg_35_1.talkMaxDuration = var_38_24

					if var_38_24 + var_38_18 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_24 + var_38_18
					end
				end

				arg_35_1.text_.text = var_38_21
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_25 = math.max(var_38_19, arg_35_1.talkMaxDuration)

			if var_38_18 <= arg_35_1.time_ and arg_35_1.time_ < var_38_18 + var_38_25 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_18) / var_38_25

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_18 + var_38_25 and arg_35_1.time_ < var_38_18 + var_38_25 + arg_38_0 then
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
			local var_42_0 = arg_39_1.actors_["1043ui_story"].transform
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.var_.moveOldPos1043ui_story = var_42_0.localPosition
			end

			local var_42_2 = 0.001

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2
				local var_42_4 = Vector3.New(0.01, -1.01, -5.73)

				var_42_0.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1043ui_story, var_42_4, var_42_3)

				local var_42_5 = manager.ui.mainCamera.transform.position - var_42_0.position

				var_42_0.forward = Vector3.New(var_42_5.x, var_42_5.y, var_42_5.z)

				local var_42_6 = var_42_0.localEulerAngles

				var_42_6.z = 0
				var_42_6.x = 0
				var_42_0.localEulerAngles = var_42_6
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 then
				var_42_0.localPosition = Vector3.New(0.01, -1.01, -5.73)

				local var_42_7 = manager.ui.mainCamera.transform.position - var_42_0.position

				var_42_0.forward = Vector3.New(var_42_7.x, var_42_7.y, var_42_7.z)

				local var_42_8 = var_42_0.localEulerAngles

				var_42_8.z = 0
				var_42_8.x = 0
				var_42_0.localEulerAngles = var_42_8
			end

			local var_42_9 = arg_39_1.actors_["1043ui_story"]
			local var_42_10 = 0

			if var_42_10 < arg_39_1.time_ and arg_39_1.time_ <= var_42_10 + arg_42_0 and not isNil(var_42_9) and arg_39_1.var_.characterEffect1043ui_story == nil then
				arg_39_1.var_.characterEffect1043ui_story = var_42_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_11 = 0.200000002980232

			if var_42_10 <= arg_39_1.time_ and arg_39_1.time_ < var_42_10 + var_42_11 and not isNil(var_42_9) then
				local var_42_12 = (arg_39_1.time_ - var_42_10) / var_42_11

				if arg_39_1.var_.characterEffect1043ui_story and not isNil(var_42_9) then
					arg_39_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= var_42_10 + var_42_11 and arg_39_1.time_ < var_42_10 + var_42_11 + arg_42_0 and not isNil(var_42_9) and arg_39_1.var_.characterEffect1043ui_story then
				arg_39_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_42_13 = 0

			if var_42_13 < arg_39_1.time_ and arg_39_1.time_ <= var_42_13 + arg_42_0 then
				arg_39_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_2")
			end

			local var_42_14 = 0

			if var_42_14 < arg_39_1.time_ and arg_39_1.time_ <= var_42_14 + arg_42_0 then
				arg_39_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_42_15 = 0
			local var_42_16 = 0.2

			if var_42_15 < arg_39_1.time_ and arg_39_1.time_ <= var_42_15 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_17 = arg_39_1:FormatText(StoryNameCfg[1156].name)

				arg_39_1.leftNameTxt_.text = var_42_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_18 = arg_39_1:GetWordFromCfg(322191009)
				local var_42_19 = arg_39_1:FormatText(var_42_18.content)

				arg_39_1.text_.text = var_42_19

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_20 = 8
				local var_42_21 = utf8.len(var_42_19)
				local var_42_22 = var_42_20 <= 0 and var_42_16 or var_42_16 * (var_42_21 / var_42_20)

				if var_42_22 > 0 and var_42_16 < var_42_22 then
					arg_39_1.talkMaxDuration = var_42_22

					if var_42_22 + var_42_15 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_22 + var_42_15
					end
				end

				arg_39_1.text_.text = var_42_19
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191009", "story_v_out_322191.awb") ~= 0 then
					local var_42_23 = manager.audio:GetVoiceLength("story_v_out_322191", "322191009", "story_v_out_322191.awb") / 1000

					if var_42_23 + var_42_15 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_23 + var_42_15
					end

					if var_42_18.prefab_name ~= "" and arg_39_1.actors_[var_42_18.prefab_name] ~= nil then
						local var_42_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_18.prefab_name].transform, "story_v_out_322191", "322191009", "story_v_out_322191.awb")

						arg_39_1:RecordAudio("322191009", var_42_24)
						arg_39_1:RecordAudio("322191009", var_42_24)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_322191", "322191009", "story_v_out_322191.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_322191", "322191009", "story_v_out_322191.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_25 = math.max(var_42_16, arg_39_1.talkMaxDuration)

			if var_42_15 <= arg_39_1.time_ and arg_39_1.time_ < var_42_15 + var_42_25 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_15) / var_42_25

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_15 + var_42_25 and arg_39_1.time_ < var_42_15 + var_42_25 + arg_42_0 then
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
			local var_46_0 = 0
			local var_46_1 = 0.275

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_2 = arg_43_1:FormatText(StoryNameCfg[1156].name)

				arg_43_1.leftNameTxt_.text = var_46_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_3 = arg_43_1:GetWordFromCfg(322191010)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 11
				local var_46_6 = utf8.len(var_46_4)
				local var_46_7 = var_46_5 <= 0 and var_46_1 or var_46_1 * (var_46_6 / var_46_5)

				if var_46_7 > 0 and var_46_1 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_4
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191010", "story_v_out_322191.awb") ~= 0 then
					local var_46_8 = manager.audio:GetVoiceLength("story_v_out_322191", "322191010", "story_v_out_322191.awb") / 1000

					if var_46_8 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_0
					end

					if var_46_3.prefab_name ~= "" and arg_43_1.actors_[var_46_3.prefab_name] ~= nil then
						local var_46_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_3.prefab_name].transform, "story_v_out_322191", "322191010", "story_v_out_322191.awb")

						arg_43_1:RecordAudio("322191010", var_46_9)
						arg_43_1:RecordAudio("322191010", var_46_9)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_322191", "322191010", "story_v_out_322191.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_322191", "322191010", "story_v_out_322191.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_10 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_10 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_10

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_10 and arg_43_1.time_ < var_46_0 + var_46_10 + arg_46_0 then
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
			local var_50_0 = arg_47_1.actors_["1043ui_story"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos1043ui_story = var_50_0.localPosition
			end

			local var_50_2 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2
				local var_50_4 = Vector3.New(0, 100, 0)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1043ui_story, var_50_4, var_50_3)

				local var_50_5 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_5.x, var_50_5.y, var_50_5.z)

				local var_50_6 = var_50_0.localEulerAngles

				var_50_6.z = 0
				var_50_6.x = 0
				var_50_0.localEulerAngles = var_50_6
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(0, 100, 0)

				local var_50_7 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_7.x, var_50_7.y, var_50_7.z)

				local var_50_8 = var_50_0.localEulerAngles

				var_50_8.z = 0
				var_50_8.x = 0
				var_50_0.localEulerAngles = var_50_8
			end

			local var_50_9 = 0
			local var_50_10 = 1.775

			if var_50_9 < arg_47_1.time_ and arg_47_1.time_ <= var_50_9 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_11 = arg_47_1:GetWordFromCfg(322191011)
				local var_50_12 = arg_47_1:FormatText(var_50_11.content)

				arg_47_1.text_.text = var_50_12

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_13 = 71
				local var_50_14 = utf8.len(var_50_12)
				local var_50_15 = var_50_13 <= 0 and var_50_10 or var_50_10 * (var_50_14 / var_50_13)

				if var_50_15 > 0 and var_50_10 < var_50_15 then
					arg_47_1.talkMaxDuration = var_50_15

					if var_50_15 + var_50_9 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_15 + var_50_9
					end
				end

				arg_47_1.text_.text = var_50_12
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_16 = math.max(var_50_10, arg_47_1.talkMaxDuration)

			if var_50_9 <= arg_47_1.time_ and arg_47_1.time_ < var_50_9 + var_50_16 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_9) / var_50_16

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_9 + var_50_16 and arg_47_1.time_ < var_50_9 + var_50_16 + arg_50_0 then
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
			local var_54_0 = arg_51_1.actors_["1211ui_story"].transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos1211ui_story = var_54_0.localPosition
			end

			local var_54_2 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2
				local var_54_4 = Vector3.New(0, -0.67, -6.07)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1211ui_story, var_54_4, var_54_3)

				local var_54_5 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_5.x, var_54_5.y, var_54_5.z)

				local var_54_6 = var_54_0.localEulerAngles

				var_54_6.z = 0
				var_54_6.x = 0
				var_54_0.localEulerAngles = var_54_6
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_54_7 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_7.x, var_54_7.y, var_54_7.z)

				local var_54_8 = var_54_0.localEulerAngles

				var_54_8.z = 0
				var_54_8.x = 0
				var_54_0.localEulerAngles = var_54_8
			end

			local var_54_9 = arg_51_1.actors_["1211ui_story"]
			local var_54_10 = 0

			if var_54_10 < arg_51_1.time_ and arg_51_1.time_ <= var_54_10 + arg_54_0 and not isNil(var_54_9) and arg_51_1.var_.characterEffect1211ui_story == nil then
				arg_51_1.var_.characterEffect1211ui_story = var_54_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_11 = 0.200000002980232

			if var_54_10 <= arg_51_1.time_ and arg_51_1.time_ < var_54_10 + var_54_11 and not isNil(var_54_9) then
				local var_54_12 = (arg_51_1.time_ - var_54_10) / var_54_11

				if arg_51_1.var_.characterEffect1211ui_story and not isNil(var_54_9) then
					arg_51_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_10 + var_54_11 and arg_51_1.time_ < var_54_10 + var_54_11 + arg_54_0 and not isNil(var_54_9) and arg_51_1.var_.characterEffect1211ui_story then
				arg_51_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_54_13 = 0

			if var_54_13 < arg_51_1.time_ and arg_51_1.time_ <= var_54_13 + arg_54_0 then
				arg_51_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_54_14 = 0

			if var_54_14 < arg_51_1.time_ and arg_51_1.time_ <= var_54_14 + arg_54_0 then
				arg_51_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_54_15 = 0
			local var_54_16 = 0.4

			if var_54_15 < arg_51_1.time_ and arg_51_1.time_ <= var_54_15 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_17 = arg_51_1:FormatText(StoryNameCfg[37].name)

				arg_51_1.leftNameTxt_.text = var_54_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_18 = arg_51_1:GetWordFromCfg(322191012)
				local var_54_19 = arg_51_1:FormatText(var_54_18.content)

				arg_51_1.text_.text = var_54_19

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_20 = 16
				local var_54_21 = utf8.len(var_54_19)
				local var_54_22 = var_54_20 <= 0 and var_54_16 or var_54_16 * (var_54_21 / var_54_20)

				if var_54_22 > 0 and var_54_16 < var_54_22 then
					arg_51_1.talkMaxDuration = var_54_22

					if var_54_22 + var_54_15 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_22 + var_54_15
					end
				end

				arg_51_1.text_.text = var_54_19
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191012", "story_v_out_322191.awb") ~= 0 then
					local var_54_23 = manager.audio:GetVoiceLength("story_v_out_322191", "322191012", "story_v_out_322191.awb") / 1000

					if var_54_23 + var_54_15 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_23 + var_54_15
					end

					if var_54_18.prefab_name ~= "" and arg_51_1.actors_[var_54_18.prefab_name] ~= nil then
						local var_54_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_18.prefab_name].transform, "story_v_out_322191", "322191012", "story_v_out_322191.awb")

						arg_51_1:RecordAudio("322191012", var_54_24)
						arg_51_1:RecordAudio("322191012", var_54_24)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_322191", "322191012", "story_v_out_322191.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_322191", "322191012", "story_v_out_322191.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_25 = math.max(var_54_16, arg_51_1.talkMaxDuration)

			if var_54_15 <= arg_51_1.time_ and arg_51_1.time_ < var_54_15 + var_54_25 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_15) / var_54_25

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_15 + var_54_25 and arg_51_1.time_ < var_54_15 + var_54_25 + arg_54_0 then
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
			local var_58_0 = arg_55_1.actors_["1211ui_story"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1211ui_story = var_58_0.localPosition
			end

			local var_58_2 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2
				local var_58_4 = Vector3.New(-0.7, -0.67, -6.07)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1211ui_story, var_58_4, var_58_3)

				local var_58_5 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_5.x, var_58_5.y, var_58_5.z)

				local var_58_6 = var_58_0.localEulerAngles

				var_58_6.z = 0
				var_58_6.x = 0
				var_58_0.localEulerAngles = var_58_6
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_58_7 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_7.x, var_58_7.y, var_58_7.z)

				local var_58_8 = var_58_0.localEulerAngles

				var_58_8.z = 0
				var_58_8.x = 0
				var_58_0.localEulerAngles = var_58_8
			end

			local var_58_9 = arg_55_1.actors_["1043ui_story"].transform
			local var_58_10 = 0

			if var_58_10 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 then
				arg_55_1.var_.moveOldPos1043ui_story = var_58_9.localPosition
			end

			local var_58_11 = 0.001

			if var_58_10 <= arg_55_1.time_ and arg_55_1.time_ < var_58_10 + var_58_11 then
				local var_58_12 = (arg_55_1.time_ - var_58_10) / var_58_11
				local var_58_13 = Vector3.New(0.81, -1.01, -5.73)

				var_58_9.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1043ui_story, var_58_13, var_58_12)

				local var_58_14 = manager.ui.mainCamera.transform.position - var_58_9.position

				var_58_9.forward = Vector3.New(var_58_14.x, var_58_14.y, var_58_14.z)

				local var_58_15 = var_58_9.localEulerAngles

				var_58_15.z = 0
				var_58_15.x = 0
				var_58_9.localEulerAngles = var_58_15
			end

			if arg_55_1.time_ >= var_58_10 + var_58_11 and arg_55_1.time_ < var_58_10 + var_58_11 + arg_58_0 then
				var_58_9.localPosition = Vector3.New(0.81, -1.01, -5.73)

				local var_58_16 = manager.ui.mainCamera.transform.position - var_58_9.position

				var_58_9.forward = Vector3.New(var_58_16.x, var_58_16.y, var_58_16.z)

				local var_58_17 = var_58_9.localEulerAngles

				var_58_17.z = 0
				var_58_17.x = 0
				var_58_9.localEulerAngles = var_58_17
			end

			local var_58_18 = arg_55_1.actors_["1043ui_story"]
			local var_58_19 = 0

			if var_58_19 < arg_55_1.time_ and arg_55_1.time_ <= var_58_19 + arg_58_0 and not isNil(var_58_18) and arg_55_1.var_.characterEffect1043ui_story == nil then
				arg_55_1.var_.characterEffect1043ui_story = var_58_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_20 = 0.200000002980232

			if var_58_19 <= arg_55_1.time_ and arg_55_1.time_ < var_58_19 + var_58_20 and not isNil(var_58_18) then
				local var_58_21 = (arg_55_1.time_ - var_58_19) / var_58_20

				if arg_55_1.var_.characterEffect1043ui_story and not isNil(var_58_18) then
					arg_55_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_19 + var_58_20 and arg_55_1.time_ < var_58_19 + var_58_20 + arg_58_0 and not isNil(var_58_18) and arg_55_1.var_.characterEffect1043ui_story then
				arg_55_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_58_22 = arg_55_1.actors_["1211ui_story"]
			local var_58_23 = 0

			if var_58_23 < arg_55_1.time_ and arg_55_1.time_ <= var_58_23 + arg_58_0 and not isNil(var_58_22) and arg_55_1.var_.characterEffect1211ui_story == nil then
				arg_55_1.var_.characterEffect1211ui_story = var_58_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_24 = 0.200000002980232

			if var_58_23 <= arg_55_1.time_ and arg_55_1.time_ < var_58_23 + var_58_24 and not isNil(var_58_22) then
				local var_58_25 = (arg_55_1.time_ - var_58_23) / var_58_24

				if arg_55_1.var_.characterEffect1211ui_story and not isNil(var_58_22) then
					local var_58_26 = Mathf.Lerp(0, 0.5, var_58_25)

					arg_55_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1211ui_story.fillRatio = var_58_26
				end
			end

			if arg_55_1.time_ >= var_58_23 + var_58_24 and arg_55_1.time_ < var_58_23 + var_58_24 + arg_58_0 and not isNil(var_58_22) and arg_55_1.var_.characterEffect1211ui_story then
				local var_58_27 = 0.5

				arg_55_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1211ui_story.fillRatio = var_58_27
			end

			local var_58_28 = 0

			if var_58_28 < arg_55_1.time_ and arg_55_1.time_ <= var_58_28 + arg_58_0 then
				arg_55_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_58_29 = 0

			if var_58_29 < arg_55_1.time_ and arg_55_1.time_ <= var_58_29 + arg_58_0 then
				arg_55_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_58_30 = 0
			local var_58_31 = 1.075

			if var_58_30 < arg_55_1.time_ and arg_55_1.time_ <= var_58_30 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_32 = arg_55_1:FormatText(StoryNameCfg[1156].name)

				arg_55_1.leftNameTxt_.text = var_58_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_33 = arg_55_1:GetWordFromCfg(322191013)
				local var_58_34 = arg_55_1:FormatText(var_58_33.content)

				arg_55_1.text_.text = var_58_34

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_35 = 43
				local var_58_36 = utf8.len(var_58_34)
				local var_58_37 = var_58_35 <= 0 and var_58_31 or var_58_31 * (var_58_36 / var_58_35)

				if var_58_37 > 0 and var_58_31 < var_58_37 then
					arg_55_1.talkMaxDuration = var_58_37

					if var_58_37 + var_58_30 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_37 + var_58_30
					end
				end

				arg_55_1.text_.text = var_58_34
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191013", "story_v_out_322191.awb") ~= 0 then
					local var_58_38 = manager.audio:GetVoiceLength("story_v_out_322191", "322191013", "story_v_out_322191.awb") / 1000

					if var_58_38 + var_58_30 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_38 + var_58_30
					end

					if var_58_33.prefab_name ~= "" and arg_55_1.actors_[var_58_33.prefab_name] ~= nil then
						local var_58_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_33.prefab_name].transform, "story_v_out_322191", "322191013", "story_v_out_322191.awb")

						arg_55_1:RecordAudio("322191013", var_58_39)
						arg_55_1:RecordAudio("322191013", var_58_39)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_322191", "322191013", "story_v_out_322191.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_322191", "322191013", "story_v_out_322191.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_40 = math.max(var_58_31, arg_55_1.talkMaxDuration)

			if var_58_30 <= arg_55_1.time_ and arg_55_1.time_ < var_58_30 + var_58_40 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_30) / var_58_40

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_30 + var_58_40 and arg_55_1.time_ < var_58_30 + var_58_40 + arg_58_0 then
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
			local var_62_0 = 0
			local var_62_1 = 0.55

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_2 = arg_59_1:FormatText(StoryNameCfg[1156].name)

				arg_59_1.leftNameTxt_.text = var_62_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_3 = arg_59_1:GetWordFromCfg(322191014)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 22
				local var_62_6 = utf8.len(var_62_4)
				local var_62_7 = var_62_5 <= 0 and var_62_1 or var_62_1 * (var_62_6 / var_62_5)

				if var_62_7 > 0 and var_62_1 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_4
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191014", "story_v_out_322191.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_322191", "322191014", "story_v_out_322191.awb") / 1000

					if var_62_8 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_0
					end

					if var_62_3.prefab_name ~= "" and arg_59_1.actors_[var_62_3.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_3.prefab_name].transform, "story_v_out_322191", "322191014", "story_v_out_322191.awb")

						arg_59_1:RecordAudio("322191014", var_62_9)
						arg_59_1:RecordAudio("322191014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_322191", "322191014", "story_v_out_322191.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_322191", "322191014", "story_v_out_322191.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_10 and arg_59_1.time_ < var_62_0 + var_62_10 + arg_62_0 then
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
			local var_66_0 = arg_63_1.actors_["1211ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1211ui_story == nil then
				arg_63_1.var_.characterEffect1211ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect1211ui_story and not isNil(var_66_0) then
					arg_63_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1211ui_story then
				arg_63_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_66_4 = arg_63_1.actors_["1043ui_story"]
			local var_66_5 = 0

			if var_66_5 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 and not isNil(var_66_4) and arg_63_1.var_.characterEffect1043ui_story == nil then
				arg_63_1.var_.characterEffect1043ui_story = var_66_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_6 = 0.200000002980232

			if var_66_5 <= arg_63_1.time_ and arg_63_1.time_ < var_66_5 + var_66_6 and not isNil(var_66_4) then
				local var_66_7 = (arg_63_1.time_ - var_66_5) / var_66_6

				if arg_63_1.var_.characterEffect1043ui_story and not isNil(var_66_4) then
					local var_66_8 = Mathf.Lerp(0, 0.5, var_66_7)

					arg_63_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1043ui_story.fillRatio = var_66_8
				end
			end

			if arg_63_1.time_ >= var_66_5 + var_66_6 and arg_63_1.time_ < var_66_5 + var_66_6 + arg_66_0 and not isNil(var_66_4) and arg_63_1.var_.characterEffect1043ui_story then
				local var_66_9 = 0.5

				arg_63_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1043ui_story.fillRatio = var_66_9
			end

			local var_66_10 = 0

			if var_66_10 < arg_63_1.time_ and arg_63_1.time_ <= var_66_10 + arg_66_0 then
				arg_63_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_2")
			end

			local var_66_11 = 0
			local var_66_12 = 0.6

			if var_66_11 < arg_63_1.time_ and arg_63_1.time_ <= var_66_11 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_13 = arg_63_1:FormatText(StoryNameCfg[37].name)

				arg_63_1.leftNameTxt_.text = var_66_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_14 = arg_63_1:GetWordFromCfg(322191015)
				local var_66_15 = arg_63_1:FormatText(var_66_14.content)

				arg_63_1.text_.text = var_66_15

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_16 = 24
				local var_66_17 = utf8.len(var_66_15)
				local var_66_18 = var_66_16 <= 0 and var_66_12 or var_66_12 * (var_66_17 / var_66_16)

				if var_66_18 > 0 and var_66_12 < var_66_18 then
					arg_63_1.talkMaxDuration = var_66_18

					if var_66_18 + var_66_11 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_18 + var_66_11
					end
				end

				arg_63_1.text_.text = var_66_15
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191015", "story_v_out_322191.awb") ~= 0 then
					local var_66_19 = manager.audio:GetVoiceLength("story_v_out_322191", "322191015", "story_v_out_322191.awb") / 1000

					if var_66_19 + var_66_11 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_19 + var_66_11
					end

					if var_66_14.prefab_name ~= "" and arg_63_1.actors_[var_66_14.prefab_name] ~= nil then
						local var_66_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_14.prefab_name].transform, "story_v_out_322191", "322191015", "story_v_out_322191.awb")

						arg_63_1:RecordAudio("322191015", var_66_20)
						arg_63_1:RecordAudio("322191015", var_66_20)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_322191", "322191015", "story_v_out_322191.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_322191", "322191015", "story_v_out_322191.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_21 = math.max(var_66_12, arg_63_1.talkMaxDuration)

			if var_66_11 <= arg_63_1.time_ and arg_63_1.time_ < var_66_11 + var_66_21 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_11) / var_66_21

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_11 + var_66_21 and arg_63_1.time_ < var_66_11 + var_66_21 + arg_66_0 then
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
			local var_70_0 = 0
			local var_70_1 = 0.825

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[37].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:GetWordFromCfg(322191016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 33
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191016", "story_v_out_322191.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_322191", "322191016", "story_v_out_322191.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_322191", "322191016", "story_v_out_322191.awb")

						arg_67_1:RecordAudio("322191016", var_70_9)
						arg_67_1:RecordAudio("322191016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_322191", "322191016", "story_v_out_322191.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_322191", "322191016", "story_v_out_322191.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_10 and arg_67_1.time_ < var_70_0 + var_70_10 + arg_70_0 then
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
			local var_74_0 = arg_71_1.actors_["1043ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1043ui_story == nil then
				arg_71_1.var_.characterEffect1043ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect1043ui_story and not isNil(var_74_0) then
					arg_71_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1043ui_story then
				arg_71_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_74_4 = arg_71_1.actors_["1211ui_story"]
			local var_74_5 = 0

			if var_74_5 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect1211ui_story == nil then
				arg_71_1.var_.characterEffect1211ui_story = var_74_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_6 = 0.200000002980232

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_6 and not isNil(var_74_4) then
				local var_74_7 = (arg_71_1.time_ - var_74_5) / var_74_6

				if arg_71_1.var_.characterEffect1211ui_story and not isNil(var_74_4) then
					local var_74_8 = Mathf.Lerp(0, 0.5, var_74_7)

					arg_71_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1211ui_story.fillRatio = var_74_8
				end
			end

			if arg_71_1.time_ >= var_74_5 + var_74_6 and arg_71_1.time_ < var_74_5 + var_74_6 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect1211ui_story then
				local var_74_9 = 0.5

				arg_71_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1211ui_story.fillRatio = var_74_9
			end

			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 then
				arg_71_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_1")
			end

			local var_74_11 = 0
			local var_74_12 = 0.4

			if var_74_11 < arg_71_1.time_ and arg_71_1.time_ <= var_74_11 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_13 = arg_71_1:FormatText(StoryNameCfg[1156].name)

				arg_71_1.leftNameTxt_.text = var_74_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_14 = arg_71_1:GetWordFromCfg(322191017)
				local var_74_15 = arg_71_1:FormatText(var_74_14.content)

				arg_71_1.text_.text = var_74_15

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_16 = 16
				local var_74_17 = utf8.len(var_74_15)
				local var_74_18 = var_74_16 <= 0 and var_74_12 or var_74_12 * (var_74_17 / var_74_16)

				if var_74_18 > 0 and var_74_12 < var_74_18 then
					arg_71_1.talkMaxDuration = var_74_18

					if var_74_18 + var_74_11 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_18 + var_74_11
					end
				end

				arg_71_1.text_.text = var_74_15
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191017", "story_v_out_322191.awb") ~= 0 then
					local var_74_19 = manager.audio:GetVoiceLength("story_v_out_322191", "322191017", "story_v_out_322191.awb") / 1000

					if var_74_19 + var_74_11 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_19 + var_74_11
					end

					if var_74_14.prefab_name ~= "" and arg_71_1.actors_[var_74_14.prefab_name] ~= nil then
						local var_74_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_14.prefab_name].transform, "story_v_out_322191", "322191017", "story_v_out_322191.awb")

						arg_71_1:RecordAudio("322191017", var_74_20)
						arg_71_1:RecordAudio("322191017", var_74_20)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_322191", "322191017", "story_v_out_322191.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_322191", "322191017", "story_v_out_322191.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_21 = math.max(var_74_12, arg_71_1.talkMaxDuration)

			if var_74_11 <= arg_71_1.time_ and arg_71_1.time_ < var_74_11 + var_74_21 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_11) / var_74_21

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_11 + var_74_21 and arg_71_1.time_ < var_74_11 + var_74_21 + arg_74_0 then
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
			local var_78_0 = arg_75_1.actors_["1211ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1211ui_story == nil then
				arg_75_1.var_.characterEffect1211ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect1211ui_story and not isNil(var_78_0) then
					arg_75_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1211ui_story then
				arg_75_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_78_4 = arg_75_1.actors_["1043ui_story"]
			local var_78_5 = 0

			if var_78_5 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 and not isNil(var_78_4) and arg_75_1.var_.characterEffect1043ui_story == nil then
				arg_75_1.var_.characterEffect1043ui_story = var_78_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_6 = 0.200000002980232

			if var_78_5 <= arg_75_1.time_ and arg_75_1.time_ < var_78_5 + var_78_6 and not isNil(var_78_4) then
				local var_78_7 = (arg_75_1.time_ - var_78_5) / var_78_6

				if arg_75_1.var_.characterEffect1043ui_story and not isNil(var_78_4) then
					local var_78_8 = Mathf.Lerp(0, 0.5, var_78_7)

					arg_75_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1043ui_story.fillRatio = var_78_8
				end
			end

			if arg_75_1.time_ >= var_78_5 + var_78_6 and arg_75_1.time_ < var_78_5 + var_78_6 + arg_78_0 and not isNil(var_78_4) and arg_75_1.var_.characterEffect1043ui_story then
				local var_78_9 = 0.5

				arg_75_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1043ui_story.fillRatio = var_78_9
			end

			local var_78_10 = 0
			local var_78_11 = 0.875

			if var_78_10 < arg_75_1.time_ and arg_75_1.time_ <= var_78_10 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_12 = arg_75_1:FormatText(StoryNameCfg[37].name)

				arg_75_1.leftNameTxt_.text = var_78_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_13 = arg_75_1:GetWordFromCfg(322191018)
				local var_78_14 = arg_75_1:FormatText(var_78_13.content)

				arg_75_1.text_.text = var_78_14

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_15 = 35
				local var_78_16 = utf8.len(var_78_14)
				local var_78_17 = var_78_15 <= 0 and var_78_11 or var_78_11 * (var_78_16 / var_78_15)

				if var_78_17 > 0 and var_78_11 < var_78_17 then
					arg_75_1.talkMaxDuration = var_78_17

					if var_78_17 + var_78_10 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_17 + var_78_10
					end
				end

				arg_75_1.text_.text = var_78_14
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191018", "story_v_out_322191.awb") ~= 0 then
					local var_78_18 = manager.audio:GetVoiceLength("story_v_out_322191", "322191018", "story_v_out_322191.awb") / 1000

					if var_78_18 + var_78_10 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_18 + var_78_10
					end

					if var_78_13.prefab_name ~= "" and arg_75_1.actors_[var_78_13.prefab_name] ~= nil then
						local var_78_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_13.prefab_name].transform, "story_v_out_322191", "322191018", "story_v_out_322191.awb")

						arg_75_1:RecordAudio("322191018", var_78_19)
						arg_75_1:RecordAudio("322191018", var_78_19)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_322191", "322191018", "story_v_out_322191.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_322191", "322191018", "story_v_out_322191.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_20 = math.max(var_78_11, arg_75_1.talkMaxDuration)

			if var_78_10 <= arg_75_1.time_ and arg_75_1.time_ < var_78_10 + var_78_20 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_10) / var_78_20

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_10 + var_78_20 and arg_75_1.time_ < var_78_10 + var_78_20 + arg_78_0 then
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
			local var_82_0 = arg_79_1.actors_["1043ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1043ui_story == nil then
				arg_79_1.var_.characterEffect1043ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect1043ui_story and not isNil(var_82_0) then
					arg_79_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1043ui_story then
				arg_79_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_82_4 = arg_79_1.actors_["1211ui_story"]
			local var_82_5 = 0

			if var_82_5 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 and not isNil(var_82_4) and arg_79_1.var_.characterEffect1211ui_story == nil then
				arg_79_1.var_.characterEffect1211ui_story = var_82_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_6 = 0.200000002980232

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_6 and not isNil(var_82_4) then
				local var_82_7 = (arg_79_1.time_ - var_82_5) / var_82_6

				if arg_79_1.var_.characterEffect1211ui_story and not isNil(var_82_4) then
					local var_82_8 = Mathf.Lerp(0, 0.5, var_82_7)

					arg_79_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1211ui_story.fillRatio = var_82_8
				end
			end

			if arg_79_1.time_ >= var_82_5 + var_82_6 and arg_79_1.time_ < var_82_5 + var_82_6 + arg_82_0 and not isNil(var_82_4) and arg_79_1.var_.characterEffect1211ui_story then
				local var_82_9 = 0.5

				arg_79_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1211ui_story.fillRatio = var_82_9
			end

			local var_82_10 = 0
			local var_82_11 = 0.425

			if var_82_10 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_12 = arg_79_1:FormatText(StoryNameCfg[1156].name)

				arg_79_1.leftNameTxt_.text = var_82_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_13 = arg_79_1:GetWordFromCfg(322191019)
				local var_82_14 = arg_79_1:FormatText(var_82_13.content)

				arg_79_1.text_.text = var_82_14

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_15 = 17
				local var_82_16 = utf8.len(var_82_14)
				local var_82_17 = var_82_15 <= 0 and var_82_11 or var_82_11 * (var_82_16 / var_82_15)

				if var_82_17 > 0 and var_82_11 < var_82_17 then
					arg_79_1.talkMaxDuration = var_82_17

					if var_82_17 + var_82_10 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_17 + var_82_10
					end
				end

				arg_79_1.text_.text = var_82_14
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191019", "story_v_out_322191.awb") ~= 0 then
					local var_82_18 = manager.audio:GetVoiceLength("story_v_out_322191", "322191019", "story_v_out_322191.awb") / 1000

					if var_82_18 + var_82_10 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_18 + var_82_10
					end

					if var_82_13.prefab_name ~= "" and arg_79_1.actors_[var_82_13.prefab_name] ~= nil then
						local var_82_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_13.prefab_name].transform, "story_v_out_322191", "322191019", "story_v_out_322191.awb")

						arg_79_1:RecordAudio("322191019", var_82_19)
						arg_79_1:RecordAudio("322191019", var_82_19)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_322191", "322191019", "story_v_out_322191.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_322191", "322191019", "story_v_out_322191.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_20 = math.max(var_82_11, arg_79_1.talkMaxDuration)

			if var_82_10 <= arg_79_1.time_ and arg_79_1.time_ < var_82_10 + var_82_20 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_10) / var_82_20

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_10 + var_82_20 and arg_79_1.time_ < var_82_10 + var_82_20 + arg_82_0 then
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
			local var_86_0 = 0
			local var_86_1 = 1.025

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[1156].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:GetWordFromCfg(322191020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 41
				local var_86_6 = utf8.len(var_86_4)
				local var_86_7 = var_86_5 <= 0 and var_86_1 or var_86_1 * (var_86_6 / var_86_5)

				if var_86_7 > 0 and var_86_1 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191020", "story_v_out_322191.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_322191", "322191020", "story_v_out_322191.awb") / 1000

					if var_86_8 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_0
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_322191", "322191020", "story_v_out_322191.awb")

						arg_83_1:RecordAudio("322191020", var_86_9)
						arg_83_1:RecordAudio("322191020", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_322191", "322191020", "story_v_out_322191.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_322191", "322191020", "story_v_out_322191.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_10 and arg_83_1.time_ < var_86_0 + var_86_10 + arg_86_0 then
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
			local var_90_0 = 0

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_2")
			end

			local var_90_1 = 0
			local var_90_2 = 0.525

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_3 = arg_87_1:FormatText(StoryNameCfg[1156].name)

				arg_87_1.leftNameTxt_.text = var_90_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_4 = arg_87_1:GetWordFromCfg(322191021)
				local var_90_5 = arg_87_1:FormatText(var_90_4.content)

				arg_87_1.text_.text = var_90_5

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_6 = 21
				local var_90_7 = utf8.len(var_90_5)
				local var_90_8 = var_90_6 <= 0 and var_90_2 or var_90_2 * (var_90_7 / var_90_6)

				if var_90_8 > 0 and var_90_2 < var_90_8 then
					arg_87_1.talkMaxDuration = var_90_8

					if var_90_8 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_1
					end
				end

				arg_87_1.text_.text = var_90_5
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191021", "story_v_out_322191.awb") ~= 0 then
					local var_90_9 = manager.audio:GetVoiceLength("story_v_out_322191", "322191021", "story_v_out_322191.awb") / 1000

					if var_90_9 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_1
					end

					if var_90_4.prefab_name ~= "" and arg_87_1.actors_[var_90_4.prefab_name] ~= nil then
						local var_90_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_4.prefab_name].transform, "story_v_out_322191", "322191021", "story_v_out_322191.awb")

						arg_87_1:RecordAudio("322191021", var_90_10)
						arg_87_1:RecordAudio("322191021", var_90_10)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_322191", "322191021", "story_v_out_322191.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_322191", "322191021", "story_v_out_322191.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_11 = math.max(var_90_2, arg_87_1.talkMaxDuration)

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_11 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_1) / var_90_11

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_1 + var_90_11 and arg_87_1.time_ < var_90_1 + var_90_11 + arg_90_0 then
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
			local var_94_0 = arg_91_1.actors_["1211ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1211ui_story == nil then
				arg_91_1.var_.characterEffect1211ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect1211ui_story and not isNil(var_94_0) then
					arg_91_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1211ui_story then
				arg_91_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_94_4 = arg_91_1.actors_["1043ui_story"]
			local var_94_5 = 0

			if var_94_5 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 and not isNil(var_94_4) and arg_91_1.var_.characterEffect1043ui_story == nil then
				arg_91_1.var_.characterEffect1043ui_story = var_94_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_6 = 0.200000002980232

			if var_94_5 <= arg_91_1.time_ and arg_91_1.time_ < var_94_5 + var_94_6 and not isNil(var_94_4) then
				local var_94_7 = (arg_91_1.time_ - var_94_5) / var_94_6

				if arg_91_1.var_.characterEffect1043ui_story and not isNil(var_94_4) then
					local var_94_8 = Mathf.Lerp(0, 0.5, var_94_7)

					arg_91_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1043ui_story.fillRatio = var_94_8
				end
			end

			if arg_91_1.time_ >= var_94_5 + var_94_6 and arg_91_1.time_ < var_94_5 + var_94_6 + arg_94_0 and not isNil(var_94_4) and arg_91_1.var_.characterEffect1043ui_story then
				local var_94_9 = 0.5

				arg_91_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1043ui_story.fillRatio = var_94_9
			end

			local var_94_10 = 0

			if var_94_10 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 then
				arg_91_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action7_1")
			end

			local var_94_11 = 0

			if var_94_11 < arg_91_1.time_ and arg_91_1.time_ <= var_94_11 + arg_94_0 then
				arg_91_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_94_12 = 0
			local var_94_13 = 0.9

			if var_94_12 < arg_91_1.time_ and arg_91_1.time_ <= var_94_12 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_14 = arg_91_1:FormatText(StoryNameCfg[37].name)

				arg_91_1.leftNameTxt_.text = var_94_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_15 = arg_91_1:GetWordFromCfg(322191022)
				local var_94_16 = arg_91_1:FormatText(var_94_15.content)

				arg_91_1.text_.text = var_94_16

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_17 = 36
				local var_94_18 = utf8.len(var_94_16)
				local var_94_19 = var_94_17 <= 0 and var_94_13 or var_94_13 * (var_94_18 / var_94_17)

				if var_94_19 > 0 and var_94_13 < var_94_19 then
					arg_91_1.talkMaxDuration = var_94_19

					if var_94_19 + var_94_12 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_19 + var_94_12
					end
				end

				arg_91_1.text_.text = var_94_16
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191022", "story_v_out_322191.awb") ~= 0 then
					local var_94_20 = manager.audio:GetVoiceLength("story_v_out_322191", "322191022", "story_v_out_322191.awb") / 1000

					if var_94_20 + var_94_12 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_20 + var_94_12
					end

					if var_94_15.prefab_name ~= "" and arg_91_1.actors_[var_94_15.prefab_name] ~= nil then
						local var_94_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_15.prefab_name].transform, "story_v_out_322191", "322191022", "story_v_out_322191.awb")

						arg_91_1:RecordAudio("322191022", var_94_21)
						arg_91_1:RecordAudio("322191022", var_94_21)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_322191", "322191022", "story_v_out_322191.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_322191", "322191022", "story_v_out_322191.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_22 = math.max(var_94_13, arg_91_1.talkMaxDuration)

			if var_94_12 <= arg_91_1.time_ and arg_91_1.time_ < var_94_12 + var_94_22 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_12) / var_94_22

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_12 + var_94_22 and arg_91_1.time_ < var_94_12 + var_94_22 + arg_94_0 then
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
			local var_98_0 = arg_95_1.actors_["1043ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1043ui_story == nil then
				arg_95_1.var_.characterEffect1043ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect1043ui_story and not isNil(var_98_0) then
					arg_95_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1043ui_story then
				arg_95_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_98_4 = arg_95_1.actors_["1211ui_story"]
			local var_98_5 = 0

			if var_98_5 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 and not isNil(var_98_4) and arg_95_1.var_.characterEffect1211ui_story == nil then
				arg_95_1.var_.characterEffect1211ui_story = var_98_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_6 = 0.200000002980232

			if var_98_5 <= arg_95_1.time_ and arg_95_1.time_ < var_98_5 + var_98_6 and not isNil(var_98_4) then
				local var_98_7 = (arg_95_1.time_ - var_98_5) / var_98_6

				if arg_95_1.var_.characterEffect1211ui_story and not isNil(var_98_4) then
					local var_98_8 = Mathf.Lerp(0, 0.5, var_98_7)

					arg_95_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1211ui_story.fillRatio = var_98_8
				end
			end

			if arg_95_1.time_ >= var_98_5 + var_98_6 and arg_95_1.time_ < var_98_5 + var_98_6 + arg_98_0 and not isNil(var_98_4) and arg_95_1.var_.characterEffect1211ui_story then
				local var_98_9 = 0.5

				arg_95_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1211ui_story.fillRatio = var_98_9
			end

			local var_98_10 = 0
			local var_98_11 = 0.075

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_12 = arg_95_1:FormatText(StoryNameCfg[1156].name)

				arg_95_1.leftNameTxt_.text = var_98_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_13 = arg_95_1:GetWordFromCfg(322191023)
				local var_98_14 = arg_95_1:FormatText(var_98_13.content)

				arg_95_1.text_.text = var_98_14

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_15 = 3
				local var_98_16 = utf8.len(var_98_14)
				local var_98_17 = var_98_15 <= 0 and var_98_11 or var_98_11 * (var_98_16 / var_98_15)

				if var_98_17 > 0 and var_98_11 < var_98_17 then
					arg_95_1.talkMaxDuration = var_98_17

					if var_98_17 + var_98_10 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_17 + var_98_10
					end
				end

				arg_95_1.text_.text = var_98_14
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191023", "story_v_out_322191.awb") ~= 0 then
					local var_98_18 = manager.audio:GetVoiceLength("story_v_out_322191", "322191023", "story_v_out_322191.awb") / 1000

					if var_98_18 + var_98_10 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_18 + var_98_10
					end

					if var_98_13.prefab_name ~= "" and arg_95_1.actors_[var_98_13.prefab_name] ~= nil then
						local var_98_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_13.prefab_name].transform, "story_v_out_322191", "322191023", "story_v_out_322191.awb")

						arg_95_1:RecordAudio("322191023", var_98_19)
						arg_95_1:RecordAudio("322191023", var_98_19)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_322191", "322191023", "story_v_out_322191.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_322191", "322191023", "story_v_out_322191.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_20 = math.max(var_98_11, arg_95_1.talkMaxDuration)

			if var_98_10 <= arg_95_1.time_ and arg_95_1.time_ < var_98_10 + var_98_20 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_10) / var_98_20

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_10 + var_98_20 and arg_95_1.time_ < var_98_10 + var_98_20 + arg_98_0 then
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
			local var_102_0 = arg_99_1.actors_["1211ui_story"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos1211ui_story = var_102_0.localPosition
			end

			local var_102_2 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2
				local var_102_4 = Vector3.New(0, 100, 0)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1211ui_story, var_102_4, var_102_3)

				local var_102_5 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_5.x, var_102_5.y, var_102_5.z)

				local var_102_6 = var_102_0.localEulerAngles

				var_102_6.z = 0
				var_102_6.x = 0
				var_102_0.localEulerAngles = var_102_6
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(0, 100, 0)

				local var_102_7 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_7.x, var_102_7.y, var_102_7.z)

				local var_102_8 = var_102_0.localEulerAngles

				var_102_8.z = 0
				var_102_8.x = 0
				var_102_0.localEulerAngles = var_102_8
			end

			local var_102_9 = arg_99_1.actors_["1043ui_story"].transform
			local var_102_10 = 0

			if var_102_10 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 then
				arg_99_1.var_.moveOldPos1043ui_story = var_102_9.localPosition
			end

			local var_102_11 = 0.001

			if var_102_10 <= arg_99_1.time_ and arg_99_1.time_ < var_102_10 + var_102_11 then
				local var_102_12 = (arg_99_1.time_ - var_102_10) / var_102_11
				local var_102_13 = Vector3.New(0, 100, 0)

				var_102_9.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1043ui_story, var_102_13, var_102_12)

				local var_102_14 = manager.ui.mainCamera.transform.position - var_102_9.position

				var_102_9.forward = Vector3.New(var_102_14.x, var_102_14.y, var_102_14.z)

				local var_102_15 = var_102_9.localEulerAngles

				var_102_15.z = 0
				var_102_15.x = 0
				var_102_9.localEulerAngles = var_102_15
			end

			if arg_99_1.time_ >= var_102_10 + var_102_11 and arg_99_1.time_ < var_102_10 + var_102_11 + arg_102_0 then
				var_102_9.localPosition = Vector3.New(0, 100, 0)

				local var_102_16 = manager.ui.mainCamera.transform.position - var_102_9.position

				var_102_9.forward = Vector3.New(var_102_16.x, var_102_16.y, var_102_16.z)

				local var_102_17 = var_102_9.localEulerAngles

				var_102_17.z = 0
				var_102_17.x = 0
				var_102_9.localEulerAngles = var_102_17
			end

			local var_102_18 = 0
			local var_102_19 = 1.125

			if var_102_18 < arg_99_1.time_ and arg_99_1.time_ <= var_102_18 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_20 = arg_99_1:GetWordFromCfg(322191024)
				local var_102_21 = arg_99_1:FormatText(var_102_20.content)

				arg_99_1.text_.text = var_102_21

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_22 = 45
				local var_102_23 = utf8.len(var_102_21)
				local var_102_24 = var_102_22 <= 0 and var_102_19 or var_102_19 * (var_102_23 / var_102_22)

				if var_102_24 > 0 and var_102_19 < var_102_24 then
					arg_99_1.talkMaxDuration = var_102_24

					if var_102_24 + var_102_18 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_24 + var_102_18
					end
				end

				arg_99_1.text_.text = var_102_21
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_25 = math.max(var_102_19, arg_99_1.talkMaxDuration)

			if var_102_18 <= arg_99_1.time_ and arg_99_1.time_ < var_102_18 + var_102_25 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_18) / var_102_25

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_18 + var_102_25 and arg_99_1.time_ < var_102_18 + var_102_25 + arg_102_0 then
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
			local var_106_0 = arg_103_1.actors_["1043ui_story"].transform
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.var_.moveOldPos1043ui_story = var_106_0.localPosition
			end

			local var_106_2 = 0.001

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2
				local var_106_4 = Vector3.New(0.01, -1.01, -5.73)

				var_106_0.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1043ui_story, var_106_4, var_106_3)

				local var_106_5 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_5.x, var_106_5.y, var_106_5.z)

				local var_106_6 = var_106_0.localEulerAngles

				var_106_6.z = 0
				var_106_6.x = 0
				var_106_0.localEulerAngles = var_106_6
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 then
				var_106_0.localPosition = Vector3.New(0.01, -1.01, -5.73)

				local var_106_7 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_7.x, var_106_7.y, var_106_7.z)

				local var_106_8 = var_106_0.localEulerAngles

				var_106_8.z = 0
				var_106_8.x = 0
				var_106_0.localEulerAngles = var_106_8
			end

			local var_106_9 = arg_103_1.actors_["1043ui_story"]
			local var_106_10 = 0

			if var_106_10 < arg_103_1.time_ and arg_103_1.time_ <= var_106_10 + arg_106_0 and not isNil(var_106_9) and arg_103_1.var_.characterEffect1043ui_story == nil then
				arg_103_1.var_.characterEffect1043ui_story = var_106_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_11 = 0.200000002980232

			if var_106_10 <= arg_103_1.time_ and arg_103_1.time_ < var_106_10 + var_106_11 and not isNil(var_106_9) then
				local var_106_12 = (arg_103_1.time_ - var_106_10) / var_106_11

				if arg_103_1.var_.characterEffect1043ui_story and not isNil(var_106_9) then
					arg_103_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_10 + var_106_11 and arg_103_1.time_ < var_106_10 + var_106_11 + arg_106_0 and not isNil(var_106_9) and arg_103_1.var_.characterEffect1043ui_story then
				arg_103_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_106_13 = 0

			if var_106_13 < arg_103_1.time_ and arg_103_1.time_ <= var_106_13 + arg_106_0 then
				arg_103_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action7_1")
			end

			local var_106_14 = 0

			if var_106_14 < arg_103_1.time_ and arg_103_1.time_ <= var_106_14 + arg_106_0 then
				arg_103_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_106_15 = 0
			local var_106_16 = 0.2

			if var_106_15 < arg_103_1.time_ and arg_103_1.time_ <= var_106_15 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_17 = arg_103_1:FormatText(StoryNameCfg[1156].name)

				arg_103_1.leftNameTxt_.text = var_106_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_18 = arg_103_1:GetWordFromCfg(322191025)
				local var_106_19 = arg_103_1:FormatText(var_106_18.content)

				arg_103_1.text_.text = var_106_19

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_20 = 8
				local var_106_21 = utf8.len(var_106_19)
				local var_106_22 = var_106_20 <= 0 and var_106_16 or var_106_16 * (var_106_21 / var_106_20)

				if var_106_22 > 0 and var_106_16 < var_106_22 then
					arg_103_1.talkMaxDuration = var_106_22

					if var_106_22 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_22 + var_106_15
					end
				end

				arg_103_1.text_.text = var_106_19
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322191", "322191025", "story_v_out_322191.awb") ~= 0 then
					local var_106_23 = manager.audio:GetVoiceLength("story_v_out_322191", "322191025", "story_v_out_322191.awb") / 1000

					if var_106_23 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_23 + var_106_15
					end

					if var_106_18.prefab_name ~= "" and arg_103_1.actors_[var_106_18.prefab_name] ~= nil then
						local var_106_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_18.prefab_name].transform, "story_v_out_322191", "322191025", "story_v_out_322191.awb")

						arg_103_1:RecordAudio("322191025", var_106_24)
						arg_103_1:RecordAudio("322191025", var_106_24)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_322191", "322191025", "story_v_out_322191.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_322191", "322191025", "story_v_out_322191.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_25 = math.max(var_106_16, arg_103_1.talkMaxDuration)

			if var_106_15 <= arg_103_1.time_ and arg_103_1.time_ < var_106_15 + var_106_25 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_15) / var_106_25

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_15 + var_106_25 and arg_103_1.time_ < var_106_15 + var_106_25 + arg_106_0 then
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
