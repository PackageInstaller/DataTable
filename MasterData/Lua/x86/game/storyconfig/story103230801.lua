return {
	Play323081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 323081001
		arg_1_1.duration_ = 6.43

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play323081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J23f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J23f")
				var_4_0.name = "J23f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J23f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J23f

				arg_1_1.bgs_.J23f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J23f" then
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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
				arg_1_1:AudioAction("play", "effect", "se_story_side_1070", "se_story_1070_wind01_loop", "")
			end

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_142", "se_story_142_chopper01", "")
			end

			if 1.16666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.16666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_down", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_18 = 1.43333333333333
			local var_4_19 = 1.65

			if 1.43333333333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_20 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_20:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_21 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(323081001).content)

				arg_1_1.text_.text = var_4_21

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_23 = 66 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 66)

				if (66 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 66)) > 0 and var_4_19 < var_4_23 then
					arg_1_1.talkMaxDuration = var_4_23
					var_4_18 = var_4_18 + 0.3

					if var_4_23 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_18
					end
				end

				arg_1_1.text_.text = var_4_21
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_18 + 0.3
			local var_4_25 = math.max(var_4_19, arg_1_1.talkMaxDuration)

			if var_4_18 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play323081002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 323081002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play323081003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.2

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(323081002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 8 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 8)

				if (8 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 8)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play323081003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 323081003
		arg_13_1.duration_ = 4.5

		local var_13_0 = {
			zh = 2.066,
			ja = 4.5
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play323081004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["10171ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10171ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "10171ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "10171ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["10171ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["10171ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["10171ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["10171ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["10171ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10171ui_story = var_16_3.localPosition

				local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_3.gameObject, typeof(DynamicBoneHelper))

				if var_16_4 then
					var_16_4:EnableDynamicBone(false)
				end
			end

			local var_16_5 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_5 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_13_1.time_ - 0) / var_16_5)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_5 and arg_13_1.time_ < 0 + var_16_5 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -0.95, -6.05)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles

				local var_16_6 = GameObjectTools.GetOrAddComponent(var_16_3.gameObject, typeof(DynamicBoneHelper))

				if var_16_6 then
					var_16_6:EnableDynamicBone(true)
				end
			end

			local var_16_7 = arg_13_1.actors_["10171ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.characterEffect10171ui_story == nil then
				arg_13_1.var_.characterEffect10171ui_story = var_16_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_8 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_8 and not isNil(var_16_7) then
				if arg_13_1.var_.characterEffect10171ui_story and not isNil(var_16_7) then
					arg_13_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_8 and arg_13_1.time_ < 0 + var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.characterEffect10171ui_story then
				arg_13_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_16_10 = 0
			local var_16_11 = 0.225

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_12 = arg_13_1:GetWordFromCfg(323081003)
				local var_16_13 = arg_13_1:FormatText(var_16_12.content)

				arg_13_1.text_.text = var_16_13

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_15 = 9 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 9)

				if (9 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 9)) > 0 and var_16_11 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_13
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081003", "story_v_out_323081.awb") ~= 0 then
					local var_16_16 = manager.audio:GetVoiceLength("story_v_out_323081", "323081003", "story_v_out_323081.awb") / 1000

					if var_16_16 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_10
					end

					if var_16_12.prefab_name ~= "" and arg_13_1.actors_[var_16_12.prefab_name] ~= nil then
						local var_16_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_12.prefab_name].transform, "story_v_out_323081", "323081003", "story_v_out_323081.awb")

						arg_13_1:RecordAudio("323081003", var_16_17)
						arg_13_1:RecordAudio("323081003", var_16_17)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_323081", "323081003", "story_v_out_323081.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_323081", "323081003", "story_v_out_323081.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = math.max(var_16_11, arg_13_1.talkMaxDuration)

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_18 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_10) / var_16_18

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_10 + var_16_18 and arg_13_1.time_ < var_16_10 + var_16_18 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play323081004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 323081004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play323081005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10171ui_story"]) and arg_17_1.var_.characterEffect10171ui_story == nil then
				arg_17_1.var_.characterEffect10171ui_story = arg_17_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10171ui_story"]) then
				if arg_17_1.var_.characterEffect10171ui_story and not isNil(arg_17_1.actors_["10171ui_story"]) then
					arg_17_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10171ui_story"]) and arg_17_1.var_.characterEffect10171ui_story then
				arg_17_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.6

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(323081004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 24 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 24)

				if (24 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 24)) > 0 and var_20_2 < var_20_5 then
					arg_17_1.talkMaxDuration = var_20_5

					if var_20_5 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_6 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_6 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_6

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_6 and arg_17_1.time_ < var_20_1 + var_20_6 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play323081005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 323081005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play323081006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10171ui_story = arg_21_1.actors_["10171ui_story"].transform.localPosition

				local var_24_0 = GameObjectTools.GetOrAddComponent(arg_21_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_24_0 then
					var_24_0:EnableDynamicBone(false)
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_1)
				arg_21_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10171ui_story"].transform.position).z)
				arg_21_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["10171ui_story"].transform.localEulerAngles = arg_21_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10171ui_story"].transform.position).z)
				arg_21_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["10171ui_story"].transform.localEulerAngles = arg_21_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_24_2 = GameObjectTools.GetOrAddComponent(arg_21_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(true)
				end
			end

			local var_24_3 = 0
			local var_24_4 = 1.4

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_3 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_5 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(323081005).content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 56 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_5) / 56)

				if (56 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_5) / 56)) > 0 and var_24_4 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_3 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_3
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_8 = math.max(var_24_4, arg_21_1.talkMaxDuration)

			if var_24_3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_3 + var_24_8 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_3) / var_24_8

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_3 + var_24_8 and arg_21_1.time_ < var_24_3 + var_24_8 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play323081006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 323081006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play323081007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.575

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(323081006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 23 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 23)

				if (23 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 23)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play323081007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 323081007
		arg_29_1.duration_ = 5.67

		local var_29_0 = {
			zh = 5,
			ja = 5.666
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play323081008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10171ui_story = arg_29_1.actors_["10171ui_story"].transform.localPosition

				local var_32_0 = GameObjectTools.GetOrAddComponent(arg_29_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_32_0 then
					var_32_0:EnableDynamicBone(false)
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_29_1.time_ - 0) / var_32_1)
				arg_29_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10171ui_story"].transform.position).z)
				arg_29_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10171ui_story"].transform.localEulerAngles = arg_29_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_29_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10171ui_story"].transform.position).z)
				arg_29_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10171ui_story"].transform.localEulerAngles = arg_29_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_32_2 = GameObjectTools.GetOrAddComponent(arg_29_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(true)
				end
			end

			local var_32_3 = arg_29_1.actors_["10171ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_3) and arg_29_1.var_.characterEffect10171ui_story == nil then
				arg_29_1.var_.characterEffect10171ui_story = var_32_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_4 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 and not isNil(var_32_3) then
				if arg_29_1.var_.characterEffect10171ui_story and not isNil(var_32_3) then
					arg_29_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 and not isNil(var_32_3) and arg_29_1.var_.characterEffect10171ui_story then
				arg_29_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_1")
			end

			local var_32_6 = 0
			local var_32_7 = 0.575

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_8 = arg_29_1:GetWordFromCfg(323081007)
				local var_32_9 = arg_29_1:FormatText(var_32_8.content)

				arg_29_1.text_.text = var_32_9

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 23 <= 0 and var_32_7 or var_32_7 * (utf8.len(var_32_9) / 23)

				if (23 <= 0 and var_32_7 or var_32_7 * (utf8.len(var_32_9) / 23)) > 0 and var_32_7 < var_32_11 then
					arg_29_1.talkMaxDuration = var_32_11

					if var_32_11 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_9
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081007", "story_v_out_323081.awb") ~= 0 then
					local var_32_12 = manager.audio:GetVoiceLength("story_v_out_323081", "323081007", "story_v_out_323081.awb") / 1000

					if var_32_12 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_6
					end

					if var_32_8.prefab_name ~= "" and arg_29_1.actors_[var_32_8.prefab_name] ~= nil then
						local var_32_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_8.prefab_name].transform, "story_v_out_323081", "323081007", "story_v_out_323081.awb")

						arg_29_1:RecordAudio("323081007", var_32_13)
						arg_29_1:RecordAudio("323081007", var_32_13)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_323081", "323081007", "story_v_out_323081.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_323081", "323081007", "story_v_out_323081.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_14 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_14 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_14

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_14 and arg_29_1.time_ < var_32_6 + var_32_14 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play323081008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 323081008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play323081009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10171ui_story"]) and arg_33_1.var_.characterEffect10171ui_story == nil then
				arg_33_1.var_.characterEffect10171ui_story = arg_33_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10171ui_story"]) then
				if arg_33_1.var_.characterEffect10171ui_story and not isNil(arg_33_1.actors_["10171ui_story"]) then
					arg_33_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10171ui_story"]) and arg_33_1.var_.characterEffect10171ui_story then
				arg_33_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.525

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(323081008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 21 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 21)

				if (21 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 21)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play323081009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 323081009
		arg_37_1.duration_ = 10.8

		local var_37_0 = {
			zh = 7.033,
			ja = 10.8
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play323081010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["10171ui_story"]) and arg_37_1.var_.characterEffect10171ui_story == nil then
				arg_37_1.var_.characterEffect10171ui_story = arg_37_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["10171ui_story"]) then
				if arg_37_1.var_.characterEffect10171ui_story and not isNil(arg_37_1.actors_["10171ui_story"]) then
					arg_37_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["10171ui_story"]) and arg_37_1.var_.characterEffect10171ui_story then
				arg_37_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_2")
			end

			local var_40_2 = 0
			local var_40_3 = 0.825

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:GetWordFromCfg(323081009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 33 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 33)

				if (33 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 33)) > 0 and var_40_3 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081009", "story_v_out_323081.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_323081", "323081009", "story_v_out_323081.awb") / 1000

					if var_40_8 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_2
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_out_323081", "323081009", "story_v_out_323081.awb")

						arg_37_1:RecordAudio("323081009", var_40_9)
						arg_37_1:RecordAudio("323081009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_323081", "323081009", "story_v_out_323081.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_323081", "323081009", "story_v_out_323081.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_10 and arg_37_1.time_ < var_40_2 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play323081010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 323081010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play323081011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["10171ui_story"]) and arg_41_1.var_.characterEffect10171ui_story == nil then
				arg_41_1.var_.characterEffect10171ui_story = arg_41_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["10171ui_story"]) then
				if arg_41_1.var_.characterEffect10171ui_story and not isNil(arg_41_1.actors_["10171ui_story"]) then
					arg_41_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["10171ui_story"]) and arg_41_1.var_.characterEffect10171ui_story then
				arg_41_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 0.1

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(323081010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 4 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 4)

				if (4 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 4)) > 0 and var_44_2 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_6 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_6 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_6

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_6 and arg_41_1.time_ < var_44_1 + var_44_6 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play323081011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 323081011
		arg_45_1.duration_ = 15.75

		local var_45_0 = {
			zh = 11.7826666666667,
			ja = 15.7496666666667
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play323081012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if arg_45_1.bgs_.J02b == nil then
				local var_48_0 = Object.Instantiate(arg_45_1.paintGo_)

				var_48_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J02b")
				var_48_0.name = "J02b"
				var_48_0.transform.parent = arg_45_1.stage_.transform
				var_48_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.bgs_.J02b = var_48_0
			end

			if 2.01666666666667 < arg_45_1.time_ and arg_45_1.time_ <= 2.01666666666667 + arg_48_0 then
				local var_48_1 = arg_45_1.bgs_.J02b

				arg_45_1.bgs_.J02b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_48_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_48_2 = var_48_1:GetComponent("SpriteRenderer")

				if var_48_2 and var_48_2.sprite then
					local var_48_3 = 2 * (var_48_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_48_1.transform.localScale = Vector3.New(var_48_3 / var_48_2.sprite.bounds.size.y < var_48_3 * manager.ui.mainCameraCom_.aspect / var_48_2.sprite.bounds.size.x and var_48_3 * manager.ui.mainCameraCom_.aspect / var_48_2.sprite.bounds.size.x or var_48_3 / var_48_2.sprite.bounds.size.y, var_48_3 / var_48_2.sprite.bounds.size.y < var_48_3 * manager.ui.mainCameraCom_.aspect / var_48_2.sprite.bounds.size.x and var_48_3 * manager.ui.mainCameraCom_.aspect / var_48_2.sprite.bounds.size.x or var_48_3 / var_48_2.sprite.bounds.size.y, 0)
				end

				for iter_48_0, iter_48_1 in pairs(arg_45_1.bgs_) do
					if iter_48_0 ~= "J02b" then
						iter_48_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_48_4 = 0

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_5 = 2

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_5 then
				local var_48_6 = Color.New(0, 0, 0)

				var_48_6.a = Mathf.Lerp(0, 1, (arg_45_1.time_ - var_48_4) / var_48_5)
				arg_45_1.mask_.color = var_48_6
			end

			if arg_45_1.time_ >= var_48_4 + var_48_5 and arg_45_1.time_ < var_48_4 + var_48_5 + arg_48_0 then
				local var_48_7 = Color.New(0, 0, 0)

				var_48_7.a = 1
				arg_45_1.mask_.color = var_48_7
			end

			local var_48_8 = 2

			if 2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_9 = 2

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_9 then
				local var_48_10 = Color.New(0, 0, 0)

				var_48_10.a = Mathf.Lerp(1, 0, (arg_45_1.time_ - var_48_8) / var_48_9)
				arg_45_1.mask_.color = var_48_10
			end

			if arg_45_1.time_ >= var_48_8 + var_48_9 and arg_45_1.time_ < var_48_8 + var_48_9 + arg_48_0 then
				local var_48_11 = Color.New(0, 0, 0)

				arg_45_1.mask_.enabled = false
				var_48_11.a = 0
				arg_45_1.mask_.color = var_48_11
			end

			local var_48_12 = "1069ui_story"

			if arg_45_1.actors_["1069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1069ui_story"))) then
				local var_48_13 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_45_1.stage_.transform)

				var_48_13.name = var_48_12
				var_48_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_[var_48_12] = var_48_13

				local var_48_14 = var_48_13:GetComponentInChildren(typeof(CharacterEffect))

				var_48_14.enabled = true

				local var_48_15 = GameObjectTools.GetOrAddComponent(var_48_13, typeof(DynamicBoneHelper))

				if var_48_15 then
					var_48_15:EnableDynamicBone(false)
				end

				arg_45_1:ShowWeapon(var_48_14.transform, false)

				arg_45_1.var_[var_48_12 .. "Animator"] = var_48_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_45_1.var_[var_48_12 .. "Animator"].applyRootMotion = true
				arg_45_1.var_[var_48_12 .. "LipSync"] = var_48_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_48_16 = arg_45_1.actors_["1069ui_story"].transform

			if 3.73333333333333 < arg_45_1.time_ and arg_45_1.time_ <= 3.73333333333333 + arg_48_0 then
				arg_45_1.var_.moveOldPos1069ui_story = var_48_16.localPosition
			end

			local var_48_17 = 0.001

			if 3.73333333333333 <= arg_45_1.time_ and arg_45_1.time_ < 3.73333333333333 + var_48_17 then
				var_48_16.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1069ui_story, Vector3.New(0, -1, -6), (arg_45_1.time_ - 3.73333333333333) / var_48_17)
				var_48_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_16.position).x, (manager.ui.mainCamera.transform.position - var_48_16.position).y, (manager.ui.mainCamera.transform.position - var_48_16.position).z)
				var_48_16.localEulerAngles.z = 0
				var_48_16.localEulerAngles.x = 0
				var_48_16.localEulerAngles = var_48_16.localEulerAngles
			end

			if arg_45_1.time_ >= 3.73333333333333 + var_48_17 and arg_45_1.time_ < 3.73333333333333 + var_48_17 + arg_48_0 then
				var_48_16.localPosition = Vector3.New(0, -1, -6)
				var_48_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_16.position).x, (manager.ui.mainCamera.transform.position - var_48_16.position).y, (manager.ui.mainCamera.transform.position - var_48_16.position).z)
				var_48_16.localEulerAngles.z = 0
				var_48_16.localEulerAngles.x = 0
				var_48_16.localEulerAngles = var_48_16.localEulerAngles
			end

			local var_48_18 = arg_45_1.actors_["1069ui_story"]

			if 3.73333333333333 < arg_45_1.time_ and arg_45_1.time_ <= 3.73333333333333 + arg_48_0 and not isNil(var_48_18) and arg_45_1.var_.characterEffect1069ui_story == nil then
				arg_45_1.var_.characterEffect1069ui_story = var_48_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_19 = 0.200000002980232

			if 3.73333333333333 <= arg_45_1.time_ and arg_45_1.time_ < 3.73333333333333 + var_48_19 and not isNil(var_48_18) then
				if arg_45_1.var_.characterEffect1069ui_story and not isNil(var_48_18) then
					arg_45_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 3.73333333333333 + var_48_19 and arg_45_1.time_ < 3.73333333333333 + var_48_19 + arg_48_0 and not isNil(var_48_18) and arg_45_1.var_.characterEffect1069ui_story then
				arg_45_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 3.73333333333333 < arg_45_1.time_ and arg_45_1.time_ <= 3.73333333333333 + arg_48_0 then
				arg_45_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action4_1")
			end

			if 3.73333333333333 < arg_45_1.time_ and arg_45_1.time_ <= 3.73333333333333 + arg_48_0 then
				arg_45_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_48_21 = arg_45_1.actors_["10171ui_story"].transform

			if 2 < arg_45_1.time_ and arg_45_1.time_ <= 2 + arg_48_0 then
				arg_45_1.var_.moveOldPos10171ui_story = var_48_21.localPosition

				local var_48_22 = GameObjectTools.GetOrAddComponent(var_48_21.gameObject, typeof(DynamicBoneHelper))

				if var_48_22 then
					var_48_22:EnableDynamicBone(false)
				end
			end

			local var_48_23 = 0.001

			if 2 <= arg_45_1.time_ and arg_45_1.time_ < 2 + var_48_23 then
				var_48_21.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 2) / var_48_23)
				var_48_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_21.position).x, (manager.ui.mainCamera.transform.position - var_48_21.position).y, (manager.ui.mainCamera.transform.position - var_48_21.position).z)
				var_48_21.localEulerAngles.z = 0
				var_48_21.localEulerAngles.x = 0
				var_48_21.localEulerAngles = var_48_21.localEulerAngles
			end

			if arg_45_1.time_ >= 2 + var_48_23 and arg_45_1.time_ < 2 + var_48_23 + arg_48_0 then
				var_48_21.localPosition = Vector3.New(0, 100, 0)
				var_48_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_21.position).x, (manager.ui.mainCamera.transform.position - var_48_21.position).y, (manager.ui.mainCamera.transform.position - var_48_21.position).z)
				var_48_21.localEulerAngles.z = 0
				var_48_21.localEulerAngles.x = 0
				var_48_21.localEulerAngles = var_48_21.localEulerAngles

				local var_48_24 = GameObjectTools.GetOrAddComponent(var_48_21.gameObject, typeof(DynamicBoneHelper))

				if var_48_24 then
					var_48_24:EnableDynamicBone(true)
				end
			end

			local var_48_25 = 2.01666666666667

			arg_45_1.isInRecall_ = false

			if var_48_25 < arg_45_1.time_ and arg_45_1.time_ <= var_48_25 + arg_48_0 then
				arg_45_1.screenFilterGo_:SetActive(true)

				arg_45_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_48_2, iter_48_3 in pairs(arg_45_1.actors_) do
					for iter_48_4, iter_48_5 in ipairs((iter_48_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_48_5.color = iter_48_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_48_26 = 0.0166666666666667

			if var_48_25 <= arg_45_1.time_ and arg_45_1.time_ < var_48_25 + var_48_26 then
				arg_45_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_45_1.time_ - var_48_25) / var_48_26)
			end

			if arg_45_1.time_ >= var_48_25 + var_48_26 and arg_45_1.time_ < var_48_25 + var_48_26 + arg_48_0 then
				arg_45_1.screenFilterEffect_.weight = 1
			end

			if 0.433333333333333 < arg_45_1.time_ and arg_45_1.time_ <= 0.433333333333333 + arg_48_0 then
				arg_45_1:AudioAction("stop", "effect", "se_story_side_1070", "se_story_1070_wind01_loop", "")
			end

			if 1.66666666666667 < arg_45_1.time_ and arg_45_1.time_ <= 1.66666666666667 + arg_48_0 then
				arg_45_1:AudioAction("play", "effect", "se_story_side_1096", "se_story_1096_crowd_loop", "")
			end

			if arg_45_1.frameCnt_ <= 1 then
				arg_45_1.dialog_:SetActive(false)
			end

			local var_48_29 = 4.01666666666667
			local var_48_30 = 1.025

			if 4.01666666666667 < arg_45_1.time_ and arg_45_1.time_ <= var_48_29 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_31 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_31:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_45_1.dialogCg_.alpha = arg_49_0
				end))
				var_48_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_32 = arg_45_1:GetWordFromCfg(323081011)
				local var_48_33 = arg_45_1:FormatText(var_48_32.content)

				arg_45_1.text_.text = var_48_33

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_35 = 41 <= 0 and var_48_30 or var_48_30 * (utf8.len(var_48_33) / 41)

				if (41 <= 0 and var_48_30 or var_48_30 * (utf8.len(var_48_33) / 41)) > 0 and var_48_30 < var_48_35 then
					arg_45_1.talkMaxDuration = var_48_35
					var_48_29 = var_48_29 + 0.3

					if var_48_35 + var_48_29 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_35 + var_48_29
					end
				end

				arg_45_1.text_.text = var_48_33
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081011", "story_v_out_323081.awb") ~= 0 then
					local var_48_36 = manager.audio:GetVoiceLength("story_v_out_323081", "323081011", "story_v_out_323081.awb") / 1000

					if var_48_36 + var_48_29 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_36 + var_48_29
					end

					if var_48_32.prefab_name ~= "" and arg_45_1.actors_[var_48_32.prefab_name] ~= nil then
						local var_48_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_32.prefab_name].transform, "story_v_out_323081", "323081011", "story_v_out_323081.awb")

						arg_45_1:RecordAudio("323081011", var_48_37)
						arg_45_1:RecordAudio("323081011", var_48_37)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_323081", "323081011", "story_v_out_323081.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_323081", "323081011", "story_v_out_323081.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_38 = var_48_29 + 0.3
			local var_48_39 = math.max(var_48_30, arg_45_1.talkMaxDuration)

			if var_48_29 + 0.3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_38 + var_48_39 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_38) / var_48_39

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_38 + var_48_39 and arg_45_1.time_ < var_48_38 + var_48_39 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play323081012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 323081012
		arg_51_1.duration_ = 10.5

		local var_51_0 = {
			zh = 8.2,
			ja = 10.5
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
				arg_51_0:Play323081013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 1.075

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:GetWordFromCfg(323081012)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 43 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 43)

				if (43 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 43)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081012", "story_v_out_323081.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_323081", "323081012", "story_v_out_323081.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_323081", "323081012", "story_v_out_323081.awb")

						arg_51_1:RecordAudio("323081012", var_54_6)
						arg_51_1:RecordAudio("323081012", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_323081", "323081012", "story_v_out_323081.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_323081", "323081012", "story_v_out_323081.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play323081013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 323081013
		arg_55_1.duration_ = 7.67

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play323081014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 1.26666666666667 < arg_55_1.time_ and arg_55_1.time_ <= 1.26666666666667 + arg_58_0 then
				local var_58_0 = arg_55_1.bgs_.J23f

				arg_55_1.bgs_.J23f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_58_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_58_1 = var_58_0:GetComponent("SpriteRenderer")

				if var_58_1 and var_58_1.sprite then
					local var_58_2 = 2 * (var_58_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_58_0.transform.localScale = Vector3.New(var_58_2 / var_58_1.sprite.bounds.size.y < var_58_2 * manager.ui.mainCameraCom_.aspect / var_58_1.sprite.bounds.size.x and var_58_2 * manager.ui.mainCameraCom_.aspect / var_58_1.sprite.bounds.size.x or var_58_2 / var_58_1.sprite.bounds.size.y, var_58_2 / var_58_1.sprite.bounds.size.y < var_58_2 * manager.ui.mainCameraCom_.aspect / var_58_1.sprite.bounds.size.x and var_58_2 * manager.ui.mainCameraCom_.aspect / var_58_1.sprite.bounds.size.x or var_58_2 / var_58_1.sprite.bounds.size.y, 0)
				end

				for iter_58_0, iter_58_1 in pairs(arg_55_1.bgs_) do
					if iter_58_0 ~= "J23f" then
						iter_58_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_58_3 = 1.26666666666667

			if 1.26666666666667 < arg_55_1.time_ and arg_55_1.time_ <= var_58_3 + arg_58_0 then
				arg_55_1.allBtn_.enabled = false
			end

			if arg_55_1.time_ >= var_58_3 + 0.3 and arg_55_1.time_ < var_58_3 + 0.3 + arg_58_0 then
				arg_55_1.allBtn_.enabled = true
			end

			local var_58_4 = 0

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_5 = 1.26666666666667

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_5 then
				local var_58_6 = Color.New(0, 0, 0)

				var_58_6.a = Mathf.Lerp(0, 1, (arg_55_1.time_ - var_58_4) / var_58_5)
				arg_55_1.mask_.color = var_58_6
			end

			if arg_55_1.time_ >= var_58_4 + var_58_5 and arg_55_1.time_ < var_58_4 + var_58_5 + arg_58_0 then
				local var_58_7 = Color.New(0, 0, 0)

				var_58_7.a = 1
				arg_55_1.mask_.color = var_58_7
			end

			local var_58_8 = 1.26666666666667

			if 1.26666666666667 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_9 = 2

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_9 then
				local var_58_10 = Color.New(0, 0, 0)

				var_58_10.a = Mathf.Lerp(1, 0, (arg_55_1.time_ - var_58_8) / var_58_9)
				arg_55_1.mask_.color = var_58_10
			end

			if arg_55_1.time_ >= var_58_8 + var_58_9 and arg_55_1.time_ < var_58_8 + var_58_9 + arg_58_0 then
				local var_58_11 = Color.New(0, 0, 0)

				arg_55_1.mask_.enabled = false
				var_58_11.a = 0
				arg_55_1.mask_.color = var_58_11
			end

			local var_58_12 = arg_55_1.actors_["1069ui_story"].transform

			if 1.26666666666667 < arg_55_1.time_ and arg_55_1.time_ <= 1.26666666666667 + arg_58_0 then
				arg_55_1.var_.moveOldPos1069ui_story = var_58_12.localPosition
			end

			local var_58_13 = 0.001

			if 1.26666666666667 <= arg_55_1.time_ and arg_55_1.time_ < 1.26666666666667 + var_58_13 then
				var_58_12.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 1.26666666666667) / var_58_13)
				var_58_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_12.position).x, (manager.ui.mainCamera.transform.position - var_58_12.position).y, (manager.ui.mainCamera.transform.position - var_58_12.position).z)
				var_58_12.localEulerAngles.z = 0
				var_58_12.localEulerAngles.x = 0
				var_58_12.localEulerAngles = var_58_12.localEulerAngles
			end

			if arg_55_1.time_ >= 1.26666666666667 + var_58_13 and arg_55_1.time_ < 1.26666666666667 + var_58_13 + arg_58_0 then
				var_58_12.localPosition = Vector3.New(0, 100, 0)
				var_58_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_12.position).x, (manager.ui.mainCamera.transform.position - var_58_12.position).y, (manager.ui.mainCamera.transform.position - var_58_12.position).z)
				var_58_12.localEulerAngles.z = 0
				var_58_12.localEulerAngles.x = 0
				var_58_12.localEulerAngles = var_58_12.localEulerAngles
			end

			local var_58_14 = arg_55_1.actors_["1069ui_story"]

			if 1.26666666666667 < arg_55_1.time_ and arg_55_1.time_ <= 1.26666666666667 + arg_58_0 and not isNil(var_58_14) and arg_55_1.var_.characterEffect1069ui_story == nil then
				arg_55_1.var_.characterEffect1069ui_story = var_58_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_15 = 0.200000002980232

			if 1.26666666666667 <= arg_55_1.time_ and arg_55_1.time_ < 1.26666666666667 + var_58_15 and not isNil(var_58_14) then
				if arg_55_1.var_.characterEffect1069ui_story and not isNil(var_58_14) then
					arg_55_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 1.26666666666667) / var_58_15)
				end
			end

			if arg_55_1.time_ >= 1.26666666666667 + var_58_15 and arg_55_1.time_ < 1.26666666666667 + var_58_15 + arg_58_0 and not isNil(var_58_14) and arg_55_1.var_.characterEffect1069ui_story then
				arg_55_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_58_16 = 1.26666666666667

			arg_55_1.isInRecall_ = false

			if var_58_16 < arg_55_1.time_ and arg_55_1.time_ <= var_58_16 + arg_58_0 then
				arg_55_1.screenFilterGo_:SetActive(false)

				for iter_58_2, iter_58_3 in pairs(arg_55_1.actors_) do
					for iter_58_4, iter_58_5 in ipairs((iter_58_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_58_5.color = iter_58_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_58_17 = 0.0166666666666667

			if var_58_16 <= arg_55_1.time_ and arg_55_1.time_ < var_58_16 + var_58_17 then
				arg_55_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_55_1.time_ - var_58_16) / var_58_17)
			end

			if arg_55_1.time_ >= var_58_16 + var_58_17 and arg_55_1.time_ < var_58_16 + var_58_17 + arg_58_0 then
				arg_55_1.screenFilterEffect_.weight = 0
			end

			if 0.166666666666667 < arg_55_1.time_ and arg_55_1.time_ <= 0.166666666666667 + arg_58_0 then
				arg_55_1:AudioAction("stop", "effect", "se_story_side_1096", "se_story_1096_crowd_loop", "")
			end

			if 1 < arg_55_1.time_ and arg_55_1.time_ <= 1 + arg_58_0 then
				arg_55_1:AudioAction("play", "effect", "se_story_side_1070", "se_story_1070_wind01_loop", "")
			end

			if arg_55_1.frameCnt_ <= 1 then
				arg_55_1.dialog_:SetActive(false)
			end

			local var_58_20 = 2.66666666666667
			local var_58_21 = 1.475

			if 2.66666666666667 < arg_55_1.time_ and arg_55_1.time_ <= var_58_20 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				arg_55_1.dialog_:SetActive(true)

				arg_55_1.dialogCg_.alpha = 0

				local var_58_22 = LeanTween.value(arg_55_1.dialog_, 0, 1, 0.3)

				var_58_22:setOnUpdate(LuaHelper.FloatAction(function(arg_59_0)
					arg_55_1.dialogCg_.alpha = arg_59_0
				end))
				var_58_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_55_1.dialog_)
					var_58_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_55_1.duration_ = arg_55_1.duration_ + 0.3

				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_23 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(323081013).content)

				arg_55_1.text_.text = var_58_23

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_25 = 59 <= 0 and var_58_21 or var_58_21 * (utf8.len(var_58_23) / 59)

				if (59 <= 0 and var_58_21 or var_58_21 * (utf8.len(var_58_23) / 59)) > 0 and var_58_21 < var_58_25 then
					arg_55_1.talkMaxDuration = var_58_25
					var_58_20 = var_58_20 + 0.3

					if var_58_25 + var_58_20 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_25 + var_58_20
					end
				end

				arg_55_1.text_.text = var_58_23
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_26 = var_58_20 + 0.3
			local var_58_27 = math.max(var_58_21, arg_55_1.talkMaxDuration)

			if var_58_20 + 0.3 <= arg_55_1.time_ and arg_55_1.time_ < var_58_26 + var_58_27 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_26) / var_58_27

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_26 + var_58_27 and arg_55_1.time_ < var_58_26 + var_58_27 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.26666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play323081014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 323081014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play323081015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.575

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(323081014).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 23 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 23)

				if (23 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 23)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play323081015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 323081015
		arg_65_1.duration_ = 11.47

		local var_65_0 = {
			zh = 8.533,
			ja = 11.466
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play323081016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10171ui_story = arg_65_1.actors_["10171ui_story"].transform.localPosition

				local var_68_0 = GameObjectTools.GetOrAddComponent(arg_65_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_68_0 then
					var_68_0:EnableDynamicBone(false)
				end
			end

			local var_68_1 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 then
				arg_65_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_65_1.time_ - 0) / var_68_1)
				arg_65_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10171ui_story"].transform.position).z)
				arg_65_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10171ui_story"].transform.localEulerAngles = arg_65_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 then
				arg_65_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_65_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10171ui_story"].transform.position).z)
				arg_65_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10171ui_story"].transform.localEulerAngles = arg_65_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_68_2 = GameObjectTools.GetOrAddComponent(arg_65_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_68_2 then
					var_68_2:EnableDynamicBone(true)
				end
			end

			local var_68_3 = arg_65_1.actors_["10171ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_3) and arg_65_1.var_.characterEffect10171ui_story == nil then
				arg_65_1.var_.characterEffect10171ui_story = var_68_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_4 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 and not isNil(var_68_3) then
				if arg_65_1.var_.characterEffect10171ui_story and not isNil(var_68_3) then
					arg_65_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 and not isNil(var_68_3) and arg_65_1.var_.characterEffect10171ui_story then
				arg_65_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action27_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_68_6 = 0
			local var_68_7 = 1.125

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_8 = arg_65_1:GetWordFromCfg(323081015)
				local var_68_9 = arg_65_1:FormatText(var_68_8.content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 45 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_9) / 45)

				if (45 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_9) / 45)) > 0 and var_68_7 < var_68_11 then
					arg_65_1.talkMaxDuration = var_68_11

					if var_68_11 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_9
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081015", "story_v_out_323081.awb") ~= 0 then
					local var_68_12 = manager.audio:GetVoiceLength("story_v_out_323081", "323081015", "story_v_out_323081.awb") / 1000

					if var_68_12 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_6
					end

					if var_68_8.prefab_name ~= "" and arg_65_1.actors_[var_68_8.prefab_name] ~= nil then
						local var_68_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_8.prefab_name].transform, "story_v_out_323081", "323081015", "story_v_out_323081.awb")

						arg_65_1:RecordAudio("323081015", var_68_13)
						arg_65_1:RecordAudio("323081015", var_68_13)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_323081", "323081015", "story_v_out_323081.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_323081", "323081015", "story_v_out_323081.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_14 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_14 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_14

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_14 and arg_65_1.time_ < var_68_6 + var_68_14 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play323081016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 323081016
		arg_69_1.duration_ = 11.83

		local var_69_0 = {
			zh = 10.633,
			ja = 11.833
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play323081017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 1.375

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(323081016)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 55 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 55)

				if (55 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 55)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081016", "story_v_out_323081.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_323081", "323081016", "story_v_out_323081.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_323081", "323081016", "story_v_out_323081.awb")

						arg_69_1:RecordAudio("323081016", var_72_6)
						arg_69_1:RecordAudio("323081016", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_323081", "323081016", "story_v_out_323081.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_323081", "323081016", "story_v_out_323081.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play323081017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 323081017
		arg_73_1.duration_ = 12.3

		local var_73_0 = {
			zh = 11.2,
			ja = 12.3
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play323081018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action27_2")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_76_0 = 0
			local var_76_1 = 1.5

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_2 = arg_73_1:GetWordFromCfg(323081017)
				local var_76_3 = arg_73_1:FormatText(var_76_2.content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 60 <= 0 and var_76_1 or var_76_1 * (utf8.len(var_76_3) / 60)

				if (60 <= 0 and var_76_1 or var_76_1 * (utf8.len(var_76_3) / 60)) > 0 and var_76_1 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081017", "story_v_out_323081.awb") ~= 0 then
					local var_76_6 = manager.audio:GetVoiceLength("story_v_out_323081", "323081017", "story_v_out_323081.awb") / 1000

					if var_76_6 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_0
					end

					if var_76_2.prefab_name ~= "" and arg_73_1.actors_[var_76_2.prefab_name] ~= nil then
						local var_76_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_2.prefab_name].transform, "story_v_out_323081", "323081017", "story_v_out_323081.awb")

						arg_73_1:RecordAudio("323081017", var_76_7)
						arg_73_1:RecordAudio("323081017", var_76_7)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_323081", "323081017", "story_v_out_323081.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_323081", "323081017", "story_v_out_323081.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_8 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_8 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_8

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_8 and arg_73_1.time_ < var_76_0 + var_76_8 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play323081018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 323081018
		arg_77_1.duration_ = 3.8

		local var_77_0 = {
			zh = 2.533,
			ja = 3.8
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play323081019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if arg_77_1.actors_["1070ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1070ui_story"))) then
				local var_80_0 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_77_1.stage_.transform)

				var_80_0.name = "1070ui_story"
				var_80_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_["1070ui_story"] = var_80_0

				local var_80_1 = var_80_0:GetComponentInChildren(typeof(CharacterEffect))

				var_80_1.enabled = true

				local var_80_2 = GameObjectTools.GetOrAddComponent(var_80_0, typeof(DynamicBoneHelper))

				if var_80_2 then
					var_80_2:EnableDynamicBone(false)
				end

				arg_77_1:ShowWeapon(var_80_1.transform, false)

				arg_77_1.var_["1070ui_story" .. "Animator"] = var_80_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_77_1.var_["1070ui_story" .. "Animator"].applyRootMotion = true
				arg_77_1.var_["1070ui_story" .. "LipSync"] = var_80_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_80_3 = arg_77_1.actors_["1070ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_3) and arg_77_1.var_.characterEffect1070ui_story == nil then
				arg_77_1.var_.characterEffect1070ui_story = var_80_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_4 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 and not isNil(var_80_3) then
				if arg_77_1.var_.characterEffect1070ui_story and not isNil(var_80_3) then
					arg_77_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 and not isNil(var_80_3) and arg_77_1.var_.characterEffect1070ui_story then
				arg_77_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_80_6 = arg_77_1.actors_["10171ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_6) and arg_77_1.var_.characterEffect10171ui_story == nil then
				arg_77_1.var_.characterEffect10171ui_story = var_80_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_7 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 and not isNil(var_80_6) then
				if arg_77_1.var_.characterEffect10171ui_story and not isNil(var_80_6) then
					arg_77_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_7)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 and not isNil(var_80_6) and arg_77_1.var_.characterEffect10171ui_story then
				arg_77_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_80_8 = 0
			local var_80_9 = 0.25

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_10 = arg_77_1:GetWordFromCfg(323081018)
				local var_80_11 = arg_77_1:FormatText(var_80_10.content)

				arg_77_1.text_.text = var_80_11

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 10 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 10)

				if (10 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 10)) > 0 and var_80_9 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_11
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081018", "story_v_out_323081.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_out_323081", "323081018", "story_v_out_323081.awb") / 1000

					if var_80_14 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_8
					end

					if var_80_10.prefab_name ~= "" and arg_77_1.actors_[var_80_10.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_10.prefab_name].transform, "story_v_out_323081", "323081018", "story_v_out_323081.awb")

						arg_77_1:RecordAudio("323081018", var_80_15)
						arg_77_1:RecordAudio("323081018", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_323081", "323081018", "story_v_out_323081.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_323081", "323081018", "story_v_out_323081.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = math.max(var_80_9, arg_77_1.talkMaxDuration)

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_16 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_8) / var_80_16

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_8 + var_80_16 and arg_77_1.time_ < var_80_8 + var_80_16 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play323081019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 323081019
		arg_81_1.duration_ = 2.6

		local var_81_0 = {
			zh = 2.6,
			ja = 2.566
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play323081020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["10171ui_story"]) and arg_81_1.var_.characterEffect10171ui_story == nil then
				arg_81_1.var_.characterEffect10171ui_story = arg_81_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["10171ui_story"]) then
				if arg_81_1.var_.characterEffect10171ui_story and not isNil(arg_81_1.actors_["10171ui_story"]) then
					arg_81_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["10171ui_story"]) and arg_81_1.var_.characterEffect10171ui_story then
				arg_81_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_84_2 = arg_81_1.actors_["1070ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1070ui_story == nil then
				arg_81_1.var_.characterEffect1070ui_story = var_84_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_3 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.characterEffect1070ui_story and not isNil(var_84_2) then
					arg_81_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_3)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1070ui_story then
				arg_81_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_84_4 = 0
			local var_84_5 = 0.325

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(323081019)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 13 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 13)

				if (13 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 13)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081019", "story_v_out_323081.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_323081", "323081019", "story_v_out_323081.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_323081", "323081019", "story_v_out_323081.awb")

						arg_81_1:RecordAudio("323081019", var_84_11)
						arg_81_1:RecordAudio("323081019", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_323081", "323081019", "story_v_out_323081.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_323081", "323081019", "story_v_out_323081.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_12 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_12 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_12

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_12 and arg_81_1.time_ < var_84_4 + var_84_12 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play323081020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 323081020
		arg_85_1.duration_ = 8.93

		local var_85_0 = {
			zh = 6.766,
			ja = 8.933
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play323081021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.9

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:GetWordFromCfg(323081020)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 36 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 36)

				if (36 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 36)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081020", "story_v_out_323081.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_323081", "323081020", "story_v_out_323081.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_323081", "323081020", "story_v_out_323081.awb")

						arg_85_1:RecordAudio("323081020", var_88_6)
						arg_85_1:RecordAudio("323081020", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_323081", "323081020", "story_v_out_323081.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_323081", "323081020", "story_v_out_323081.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play323081021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 323081021
		arg_89_1.duration_ = 9.57

		local var_89_0 = {
			zh = 8.1,
			ja = 9.566
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play323081022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_92_0 = 0
			local var_92_1 = 1.075

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_2 = arg_89_1:GetWordFromCfg(323081021)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 43 <= 0 and var_92_1 or var_92_1 * (utf8.len(var_92_3) / 43)

				if (43 <= 0 and var_92_1 or var_92_1 * (utf8.len(var_92_3) / 43)) > 0 and var_92_1 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081021", "story_v_out_323081.awb") ~= 0 then
					local var_92_6 = manager.audio:GetVoiceLength("story_v_out_323081", "323081021", "story_v_out_323081.awb") / 1000

					if var_92_6 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_0
					end

					if var_92_2.prefab_name ~= "" and arg_89_1.actors_[var_92_2.prefab_name] ~= nil then
						local var_92_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_2.prefab_name].transform, "story_v_out_323081", "323081021", "story_v_out_323081.awb")

						arg_89_1:RecordAudio("323081021", var_92_7)
						arg_89_1:RecordAudio("323081021", var_92_7)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_323081", "323081021", "story_v_out_323081.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_323081", "323081021", "story_v_out_323081.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_8 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_8 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_8

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_8 and arg_89_1.time_ < var_92_0 + var_92_8 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play323081022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 323081022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play323081023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["10171ui_story"]) and arg_93_1.var_.characterEffect10171ui_story == nil then
				arg_93_1.var_.characterEffect10171ui_story = arg_93_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["10171ui_story"]) then
				if arg_93_1.var_.characterEffect10171ui_story and not isNil(arg_93_1.actors_["10171ui_story"]) then
					arg_93_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["10171ui_story"]) and arg_93_1.var_.characterEffect10171ui_story then
				arg_93_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_96_1 = 0
			local var_96_2 = 1.475

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(323081022).content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 59 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 59)

				if (59 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 59)) > 0 and var_96_2 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_6 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_6 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_6

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_6 and arg_93_1.time_ < var_96_1 + var_96_6 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play323081023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 323081023
		arg_97_1.duration_ = 3.73

		local var_97_0 = {
			zh = 2.3,
			ja = 3.733
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play323081024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10171ui_story = arg_97_1.actors_["10171ui_story"].transform.localPosition

				local var_100_0 = GameObjectTools.GetOrAddComponent(arg_97_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_100_0 then
					var_100_0:EnableDynamicBone(false)
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_97_1.time_ - 0) / var_100_1)
				arg_97_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10171ui_story"].transform.position).z)
				arg_97_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10171ui_story"].transform.localEulerAngles = arg_97_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_97_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10171ui_story"].transform.position).z)
				arg_97_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10171ui_story"].transform.localEulerAngles = arg_97_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_100_2 = GameObjectTools.GetOrAddComponent(arg_97_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_100_2 then
					var_100_2:EnableDynamicBone(true)
				end
			end

			local var_100_3 = arg_97_1.actors_["1070ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1070ui_story = var_100_3.localPosition
			end

			local var_100_4 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				var_100_3.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_4)
				var_100_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_3.position).x, (manager.ui.mainCamera.transform.position - var_100_3.position).y, (manager.ui.mainCamera.transform.position - var_100_3.position).z)
				var_100_3.localEulerAngles.z = 0
				var_100_3.localEulerAngles.x = 0
				var_100_3.localEulerAngles = var_100_3.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				var_100_3.localPosition = Vector3.New(0, 100, 0)
				var_100_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_3.position).x, (manager.ui.mainCamera.transform.position - var_100_3.position).y, (manager.ui.mainCamera.transform.position - var_100_3.position).z)
				var_100_3.localEulerAngles.z = 0
				var_100_3.localEulerAngles.x = 0
				var_100_3.localEulerAngles = var_100_3.localEulerAngles
			end

			local var_100_5 = arg_97_1.actors_["1070ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.characterEffect1070ui_story == nil then
				arg_97_1.var_.characterEffect1070ui_story = var_100_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_6 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_6 and not isNil(var_100_5) then
				if arg_97_1.var_.characterEffect1070ui_story and not isNil(var_100_5) then
					arg_97_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_6 and arg_97_1.time_ < 0 + var_100_6 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.characterEffect1070ui_story then
				arg_97_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_100_8 = 0
			local var_100_9 = 0.3

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070_split_8")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_10 = arg_97_1:GetWordFromCfg(323081023)
				local var_100_11 = arg_97_1:FormatText(var_100_10.content)

				arg_97_1.text_.text = var_100_11

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 12 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 12)

				if (12 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 12)) > 0 and var_100_9 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_11
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081023", "story_v_out_323081.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_out_323081", "323081023", "story_v_out_323081.awb") / 1000

					if var_100_14 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_8
					end

					if var_100_10.prefab_name ~= "" and arg_97_1.actors_[var_100_10.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_10.prefab_name].transform, "story_v_out_323081", "323081023", "story_v_out_323081.awb")

						arg_97_1:RecordAudio("323081023", var_100_15)
						arg_97_1:RecordAudio("323081023", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_323081", "323081023", "story_v_out_323081.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_323081", "323081023", "story_v_out_323081.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_9, arg_97_1.talkMaxDuration)

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_8) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_8 + var_100_16 and arg_97_1.time_ < var_100_8 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play323081024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 323081024
		arg_101_1.duration_ = 14.6

		local var_101_0 = {
			zh = 11.666,
			ja = 14.6
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play323081025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10171ui_story"]) and arg_101_1.var_.characterEffect10171ui_story == nil then
				arg_101_1.var_.characterEffect10171ui_story = arg_101_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10171ui_story"]) then
				if arg_101_1.var_.characterEffect10171ui_story and not isNil(arg_101_1.actors_["10171ui_story"]) then
					arg_101_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10171ui_story"]) and arg_101_1.var_.characterEffect10171ui_story then
				arg_101_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_104_2 = arg_101_1.actors_["1070ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.characterEffect1070ui_story == nil then
				arg_101_1.var_.characterEffect1070ui_story = var_104_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_3 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.characterEffect1070ui_story and not isNil(var_104_2) then
					arg_101_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_3)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.characterEffect1070ui_story then
				arg_101_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_2")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_104_4 = 0
			local var_104_5 = 1.475

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(323081024)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 59 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 59)

				if (59 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 59)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081024", "story_v_out_323081.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_out_323081", "323081024", "story_v_out_323081.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_out_323081", "323081024", "story_v_out_323081.awb")

						arg_101_1:RecordAudio("323081024", var_104_11)
						arg_101_1:RecordAudio("323081024", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_323081", "323081024", "story_v_out_323081.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_323081", "323081024", "story_v_out_323081.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_12 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_12 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_12

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_12 and arg_101_1.time_ < var_104_4 + var_104_12 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play323081025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 323081025
		arg_105_1.duration_ = 11.5

		local var_105_0 = {
			zh = 11.5,
			ja = 9.4
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
				arg_105_0:Play323081026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 1.45

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(323081025)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 58 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 58)

				if (58 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 58)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081025", "story_v_out_323081.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_323081", "323081025", "story_v_out_323081.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_323081", "323081025", "story_v_out_323081.awb")

						arg_105_1:RecordAudio("323081025", var_108_6)
						arg_105_1:RecordAudio("323081025", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_323081", "323081025", "story_v_out_323081.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_323081", "323081025", "story_v_out_323081.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play323081026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 323081026
		arg_109_1.duration_ = 6.33

		local var_109_0 = {
			zh = 5.1,
			ja = 6.333
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play323081027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.7

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(323081026)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 28 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 28)

				if (28 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 28)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081026", "story_v_out_323081.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_323081", "323081026", "story_v_out_323081.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_323081", "323081026", "story_v_out_323081.awb")

						arg_109_1:RecordAudio("323081026", var_112_6)
						arg_109_1:RecordAudio("323081026", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_323081", "323081026", "story_v_out_323081.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_323081", "323081026", "story_v_out_323081.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play323081027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 323081027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play323081028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["10171ui_story"]) and arg_113_1.var_.characterEffect10171ui_story == nil then
				arg_113_1.var_.characterEffect10171ui_story = arg_113_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["10171ui_story"]) then
				if arg_113_1.var_.characterEffect10171ui_story and not isNil(arg_113_1.actors_["10171ui_story"]) then
					arg_113_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_113_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["10171ui_story"]) and arg_113_1.var_.characterEffect10171ui_story then
				arg_113_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_113_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_116_1 = 0
			local var_116_2 = 0.225

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_3 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(323081027).content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 9 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 9)

				if (9 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 9)) > 0 and var_116_2 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_6 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_6 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_6

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_6 and arg_113_1.time_ < var_116_1 + var_116_6 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play323081028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 323081028
		arg_117_1.duration_ = 7.2

		local var_117_0 = {
			zh = 6.066,
			ja = 7.2
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play323081029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["10171ui_story"]) and arg_117_1.var_.characterEffect10171ui_story == nil then
				arg_117_1.var_.characterEffect10171ui_story = arg_117_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["10171ui_story"]) then
				if arg_117_1.var_.characterEffect10171ui_story and not isNil(arg_117_1.actors_["10171ui_story"]) then
					arg_117_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["10171ui_story"]) and arg_117_1.var_.characterEffect10171ui_story then
				arg_117_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_120_2 = 0
			local var_120_3 = 0.85

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_4 = arg_117_1:GetWordFromCfg(323081028)
				local var_120_5 = arg_117_1:FormatText(var_120_4.content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 34 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 34)

				if (34 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 34)) > 0 and var_120_3 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081028", "story_v_out_323081.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_323081", "323081028", "story_v_out_323081.awb") / 1000

					if var_120_8 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_2
					end

					if var_120_4.prefab_name ~= "" and arg_117_1.actors_[var_120_4.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_4.prefab_name].transform, "story_v_out_323081", "323081028", "story_v_out_323081.awb")

						arg_117_1:RecordAudio("323081028", var_120_9)
						arg_117_1:RecordAudio("323081028", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_323081", "323081028", "story_v_out_323081.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_323081", "323081028", "story_v_out_323081.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_3, arg_117_1.talkMaxDuration)

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_2) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_2 + var_120_10 and arg_117_1.time_ < var_120_2 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play323081029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 323081029
		arg_121_1.duration_ = 5.07

		local var_121_0 = {
			zh = 5.066,
			ja = 4.1
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play323081030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.725

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:GetWordFromCfg(323081029)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 29 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 29)

				if (29 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 29)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081029", "story_v_out_323081.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_323081", "323081029", "story_v_out_323081.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_323081", "323081029", "story_v_out_323081.awb")

						arg_121_1:RecordAudio("323081029", var_124_6)
						arg_121_1:RecordAudio("323081029", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_323081", "323081029", "story_v_out_323081.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_323081", "323081029", "story_v_out_323081.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play323081030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 323081030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play323081031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["10171ui_story"]) and arg_125_1.var_.characterEffect10171ui_story == nil then
				arg_125_1.var_.characterEffect10171ui_story = arg_125_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["10171ui_story"]) then
				if arg_125_1.var_.characterEffect10171ui_story and not isNil(arg_125_1.actors_["10171ui_story"]) then
					arg_125_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_0)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["10171ui_story"]) and arg_125_1.var_.characterEffect10171ui_story then
				arg_125_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_128_1 = 0
			local var_128_2 = 0.225

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_3 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(323081030).content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 9 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 9)

				if (9 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 9)) > 0 and var_128_2 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_1 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_1
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_6 = math.max(var_128_2, arg_125_1.talkMaxDuration)

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_6 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_1) / var_128_6

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_1 + var_128_6 and arg_125_1.time_ < var_128_1 + var_128_6 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play323081031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 323081031
		arg_129_1.duration_ = 10.87

		local var_129_0 = {
			zh = 8.4,
			ja = 10.866
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play323081032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1070ui_story"]) and arg_129_1.var_.characterEffect1070ui_story == nil then
				arg_129_1.var_.characterEffect1070ui_story = arg_129_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1070ui_story"]) then
				if arg_129_1.var_.characterEffect1070ui_story and not isNil(arg_129_1.actors_["1070ui_story"]) then
					arg_129_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1070ui_story"]) and arg_129_1.var_.characterEffect1070ui_story then
				arg_129_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_132_2 = arg_129_1.actors_["1070ui_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1070ui_story = var_132_2.localPosition
			end

			local var_132_3 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 then
				var_132_2.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_129_1.time_ - 0) / var_132_3)
				var_132_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_2.position).x, (manager.ui.mainCamera.transform.position - var_132_2.position).y, (manager.ui.mainCamera.transform.position - var_132_2.position).z)
				var_132_2.localEulerAngles.z = 0
				var_132_2.localEulerAngles.x = 0
				var_132_2.localEulerAngles = var_132_2.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 then
				var_132_2.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_132_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_2.position).x, (manager.ui.mainCamera.transform.position - var_132_2.position).y, (manager.ui.mainCamera.transform.position - var_132_2.position).z)
				var_132_2.localEulerAngles.z = 0
				var_132_2.localEulerAngles.x = 0
				var_132_2.localEulerAngles = var_132_2.localEulerAngles
			end

			local var_132_4 = arg_129_1.actors_["10171ui_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10171ui_story = var_132_4.localPosition

				local var_132_5 = GameObjectTools.GetOrAddComponent(var_132_4.gameObject, typeof(DynamicBoneHelper))

				if var_132_5 then
					var_132_5:EnableDynamicBone(false)
				end
			end

			local var_132_6 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_6 then
				var_132_4.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10171ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_129_1.time_ - 0) / var_132_6)
				var_132_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_4.position).x, (manager.ui.mainCamera.transform.position - var_132_4.position).y, (manager.ui.mainCamera.transform.position - var_132_4.position).z)
				var_132_4.localEulerAngles.z = 0
				var_132_4.localEulerAngles.x = 0
				var_132_4.localEulerAngles = var_132_4.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_6 and arg_129_1.time_ < 0 + var_132_6 + arg_132_0 then
				var_132_4.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_132_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_4.position).x, (manager.ui.mainCamera.transform.position - var_132_4.position).y, (manager.ui.mainCamera.transform.position - var_132_4.position).z)
				var_132_4.localEulerAngles.z = 0
				var_132_4.localEulerAngles.x = 0
				var_132_4.localEulerAngles = var_132_4.localEulerAngles

				local var_132_7 = GameObjectTools.GetOrAddComponent(var_132_4.gameObject, typeof(DynamicBoneHelper))

				if var_132_7 then
					var_132_7:EnableDynamicBone(true)
				end
			end

			local var_132_8 = 0
			local var_132_9 = 1.025

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_10 = arg_129_1:GetWordFromCfg(323081031)
				local var_132_11 = arg_129_1:FormatText(var_132_10.content)

				arg_129_1.text_.text = var_132_11

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_13 = 41 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_11) / 41)

				if (41 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_11) / 41)) > 0 and var_132_9 < var_132_13 then
					arg_129_1.talkMaxDuration = var_132_13

					if var_132_13 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_8
					end
				end

				arg_129_1.text_.text = var_132_11
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081031", "story_v_out_323081.awb") ~= 0 then
					local var_132_14 = manager.audio:GetVoiceLength("story_v_out_323081", "323081031", "story_v_out_323081.awb") / 1000

					if var_132_14 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_14 + var_132_8
					end

					if var_132_10.prefab_name ~= "" and arg_129_1.actors_[var_132_10.prefab_name] ~= nil then
						local var_132_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_10.prefab_name].transform, "story_v_out_323081", "323081031", "story_v_out_323081.awb")

						arg_129_1:RecordAudio("323081031", var_132_15)
						arg_129_1:RecordAudio("323081031", var_132_15)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_323081", "323081031", "story_v_out_323081.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_323081", "323081031", "story_v_out_323081.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_16 = math.max(var_132_9, arg_129_1.talkMaxDuration)

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_16 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_8) / var_132_16

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_8 + var_132_16 and arg_129_1.time_ < var_132_8 + var_132_16 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play323081032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 323081032
		arg_133_1.duration_ = 6.6

		local var_133_0 = {
			zh = 5.5,
			ja = 6.6
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play323081033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.65

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:GetWordFromCfg(323081032)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 26 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 26)

				if (26 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 26)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081032", "story_v_out_323081.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_323081", "323081032", "story_v_out_323081.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_323081", "323081032", "story_v_out_323081.awb")

						arg_133_1:RecordAudio("323081032", var_136_6)
						arg_133_1:RecordAudio("323081032", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_323081", "323081032", "story_v_out_323081.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_323081", "323081032", "story_v_out_323081.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play323081033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 323081033
		arg_137_1.duration_ = 3.93

		local var_137_0 = {
			zh = 2.6,
			ja = 3.933
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play323081034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["10171ui_story"]) and arg_137_1.var_.characterEffect10171ui_story == nil then
				arg_137_1.var_.characterEffect10171ui_story = arg_137_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["10171ui_story"]) then
				if arg_137_1.var_.characterEffect10171ui_story and not isNil(arg_137_1.actors_["10171ui_story"]) then
					arg_137_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["10171ui_story"]) and arg_137_1.var_.characterEffect10171ui_story then
				arg_137_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_140_2 = arg_137_1.actors_["1070ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.characterEffect1070ui_story == nil then
				arg_137_1.var_.characterEffect1070ui_story = var_140_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_3 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 and not isNil(var_140_2) then
				if arg_137_1.var_.characterEffect1070ui_story and not isNil(var_140_2) then
					arg_137_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_3)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.characterEffect1070ui_story then
				arg_137_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action31_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_140_4 = 0
			local var_140_5 = 0.375

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:GetWordFromCfg(323081033)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 15 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 15)

				if (15 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 15)) > 0 and var_140_5 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081033", "story_v_out_323081.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_out_323081", "323081033", "story_v_out_323081.awb") / 1000

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end

					if var_140_6.prefab_name ~= "" and arg_137_1.actors_[var_140_6.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_6.prefab_name].transform, "story_v_out_323081", "323081033", "story_v_out_323081.awb")

						arg_137_1:RecordAudio("323081033", var_140_11)
						arg_137_1:RecordAudio("323081033", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_323081", "323081033", "story_v_out_323081.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_323081", "323081033", "story_v_out_323081.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_12 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_12 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_12

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_12 and arg_137_1.time_ < var_140_4 + var_140_12 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play323081034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 323081034
		arg_141_1.duration_ = 4.57

		local var_141_0 = {
			zh = 3.366,
			ja = 4.566
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play323081035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1070ui_story"]) and arg_141_1.var_.characterEffect1070ui_story == nil then
				arg_141_1.var_.characterEffect1070ui_story = arg_141_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1070ui_story"]) then
				if arg_141_1.var_.characterEffect1070ui_story and not isNil(arg_141_1.actors_["1070ui_story"]) then
					arg_141_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1070ui_story"]) and arg_141_1.var_.characterEffect1070ui_story then
				arg_141_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_144_2 = arg_141_1.actors_["10171ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect10171ui_story == nil then
				arg_141_1.var_.characterEffect10171ui_story = var_144_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_3 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.characterEffect10171ui_story and not isNil(var_144_2) then
					arg_141_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_3)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect10171ui_story then
				arg_141_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_144_4 = 0
			local var_144_5 = 0.275

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(323081034)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 11 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 11)

				if (11 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 11)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081034", "story_v_out_323081.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_323081", "323081034", "story_v_out_323081.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_out_323081", "323081034", "story_v_out_323081.awb")

						arg_141_1:RecordAudio("323081034", var_144_11)
						arg_141_1:RecordAudio("323081034", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_323081", "323081034", "story_v_out_323081.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_323081", "323081034", "story_v_out_323081.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play323081035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 323081035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play323081036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1070ui_story"]) and arg_145_1.var_.characterEffect1070ui_story == nil then
				arg_145_1.var_.characterEffect1070ui_story = arg_145_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1070ui_story"]) then
				if arg_145_1.var_.characterEffect1070ui_story and not isNil(arg_145_1.actors_["1070ui_story"]) then
					arg_145_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1070ui_story"]) and arg_145_1.var_.characterEffect1070ui_story then
				arg_145_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_148_1 = 0
			local var_148_2 = 1.025

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(323081035).content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 41 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 41)

				if (41 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 41)) > 0 and var_148_2 < var_148_5 then
					arg_145_1.talkMaxDuration = var_148_5

					if var_148_5 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + var_148_1
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_6 = math.max(var_148_2, arg_145_1.talkMaxDuration)

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_6 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_1) / var_148_6

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_1 + var_148_6 and arg_145_1.time_ < var_148_1 + var_148_6 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play323081036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 323081036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play323081037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 1.025

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(323081036).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 41 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 41)

				if (41 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 41)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play323081037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 323081037
		arg_153_1.duration_ = 7.9

		local var_153_0 = {
			zh = 5.166,
			ja = 7.9
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play323081038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["10171ui_story"]) and arg_153_1.var_.characterEffect10171ui_story == nil then
				arg_153_1.var_.characterEffect10171ui_story = arg_153_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["10171ui_story"]) then
				if arg_153_1.var_.characterEffect10171ui_story and not isNil(arg_153_1.actors_["10171ui_story"]) then
					arg_153_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["10171ui_story"]) and arg_153_1.var_.characterEffect10171ui_story then
				arg_153_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action31_2")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_153_1.time_ and arg_153_1.time_ <= 0.1 + arg_156_0 then
				arg_153_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_monster_fight_loop", "")
			end

			local var_156_3 = 0
			local var_156_4 = 0.7

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_3 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_5 = arg_153_1:GetWordFromCfg(323081037)
				local var_156_6 = arg_153_1:FormatText(var_156_5.content)

				arg_153_1.text_.text = var_156_6

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_8 = 28 <= 0 and var_156_4 or var_156_4 * (utf8.len(var_156_6) / 28)

				if (28 <= 0 and var_156_4 or var_156_4 * (utf8.len(var_156_6) / 28)) > 0 and var_156_4 < var_156_8 then
					arg_153_1.talkMaxDuration = var_156_8

					if var_156_8 + var_156_3 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_3
					end
				end

				arg_153_1.text_.text = var_156_6
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081037", "story_v_out_323081.awb") ~= 0 then
					local var_156_9 = manager.audio:GetVoiceLength("story_v_out_323081", "323081037", "story_v_out_323081.awb") / 1000

					if var_156_9 + var_156_3 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_3
					end

					if var_156_5.prefab_name ~= "" and arg_153_1.actors_[var_156_5.prefab_name] ~= nil then
						local var_156_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_5.prefab_name].transform, "story_v_out_323081", "323081037", "story_v_out_323081.awb")

						arg_153_1:RecordAudio("323081037", var_156_10)
						arg_153_1:RecordAudio("323081037", var_156_10)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_323081", "323081037", "story_v_out_323081.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_323081", "323081037", "story_v_out_323081.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_11 = math.max(var_156_4, arg_153_1.talkMaxDuration)

			if var_156_3 <= arg_153_1.time_ and arg_153_1.time_ < var_156_3 + var_156_11 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_3) / var_156_11

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_3 + var_156_11 and arg_153_1.time_ < var_156_3 + var_156_11 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play323081038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 323081038
		arg_157_1.duration_ = 2.9

		local var_157_0 = {
			zh = 2.6,
			ja = 2.9
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play323081039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_160_0 = 0
			local var_160_1 = 0.35

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_2 = arg_157_1:GetWordFromCfg(323081038)
				local var_160_3 = arg_157_1:FormatText(var_160_2.content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 14 <= 0 and var_160_1 or var_160_1 * (utf8.len(var_160_3) / 14)

				if (14 <= 0 and var_160_1 or var_160_1 * (utf8.len(var_160_3) / 14)) > 0 and var_160_1 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081038", "story_v_out_323081.awb") ~= 0 then
					local var_160_6 = manager.audio:GetVoiceLength("story_v_out_323081", "323081038", "story_v_out_323081.awb") / 1000

					if var_160_6 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_0
					end

					if var_160_2.prefab_name ~= "" and arg_157_1.actors_[var_160_2.prefab_name] ~= nil then
						local var_160_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_2.prefab_name].transform, "story_v_out_323081", "323081038", "story_v_out_323081.awb")

						arg_157_1:RecordAudio("323081038", var_160_7)
						arg_157_1:RecordAudio("323081038", var_160_7)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_323081", "323081038", "story_v_out_323081.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_323081", "323081038", "story_v_out_323081.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_8 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_8 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_8

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_8 and arg_157_1.time_ < var_160_0 + var_160_8 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play323081039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 323081039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play323081040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["10171ui_story"]) and arg_161_1.var_.characterEffect10171ui_story == nil then
				arg_161_1.var_.characterEffect10171ui_story = arg_161_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_0 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["10171ui_story"]) then
				if arg_161_1.var_.characterEffect10171ui_story and not isNil(arg_161_1.actors_["10171ui_story"]) then
					arg_161_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_161_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_0)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["10171ui_story"]) and arg_161_1.var_.characterEffect10171ui_story then
				arg_161_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_161_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_164_1 = 0
			local var_164_2 = 0.35

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_3 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(323081039).content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 14 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_3) / 14)

				if (14 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_3) / 14)) > 0 and var_164_2 < var_164_5 then
					arg_161_1.talkMaxDuration = var_164_5

					if var_164_5 + var_164_1 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + var_164_1
					end
				end

				arg_161_1.text_.text = var_164_3
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_6 = math.max(var_164_2, arg_161_1.talkMaxDuration)

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_6 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_1) / var_164_6

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_1 + var_164_6 and arg_161_1.time_ < var_164_1 + var_164_6 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play323081040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 323081040
		arg_165_1.duration_ = 1.87

		local var_165_0 = {
			zh = 1.866,
			ja = 1.633
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
				arg_165_0:Play323081041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["10171ui_story"]) and arg_165_1.var_.characterEffect10171ui_story == nil then
				arg_165_1.var_.characterEffect10171ui_story = arg_165_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["10171ui_story"]) then
				if arg_165_1.var_.characterEffect10171ui_story and not isNil(arg_165_1.actors_["10171ui_story"]) then
					arg_165_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["10171ui_story"]) and arg_165_1.var_.characterEffect10171ui_story then
				arg_165_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_168_2 = 0
			local var_168_3 = 0.15

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_2 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_4 = arg_165_1:GetWordFromCfg(323081040)
				local var_168_5 = arg_165_1:FormatText(var_168_4.content)

				arg_165_1.text_.text = var_168_5

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_7 = 6 <= 0 and var_168_3 or var_168_3 * (utf8.len(var_168_5) / 6)

				if (6 <= 0 and var_168_3 or var_168_3 * (utf8.len(var_168_5) / 6)) > 0 and var_168_3 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_2 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_2
					end
				end

				arg_165_1.text_.text = var_168_5
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081040", "story_v_out_323081.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_323081", "323081040", "story_v_out_323081.awb") / 1000

					if var_168_8 + var_168_2 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_2
					end

					if var_168_4.prefab_name ~= "" and arg_165_1.actors_[var_168_4.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_4.prefab_name].transform, "story_v_out_323081", "323081040", "story_v_out_323081.awb")

						arg_165_1:RecordAudio("323081040", var_168_9)
						arg_165_1:RecordAudio("323081040", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_323081", "323081040", "story_v_out_323081.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_323081", "323081040", "story_v_out_323081.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_3, arg_165_1.talkMaxDuration)

			if var_168_2 <= arg_165_1.time_ and arg_165_1.time_ < var_168_2 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_2) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_2 + var_168_10 and arg_165_1.time_ < var_168_2 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play323081041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 323081041
		arg_169_1.duration_ = 2

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play323081042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1070ui_story"]) and arg_169_1.var_.characterEffect1070ui_story == nil then
				arg_169_1.var_.characterEffect1070ui_story = arg_169_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1070ui_story"]) then
				if arg_169_1.var_.characterEffect1070ui_story and not isNil(arg_169_1.actors_["1070ui_story"]) then
					arg_169_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1070ui_story"]) and arg_169_1.var_.characterEffect1070ui_story then
				arg_169_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_172_2 = arg_169_1.actors_["10171ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.characterEffect10171ui_story == nil then
				arg_169_1.var_.characterEffect10171ui_story = var_172_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_3 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_3 and not isNil(var_172_2) then
				if arg_169_1.var_.characterEffect10171ui_story and not isNil(var_172_2) then
					arg_169_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_169_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_3)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.characterEffect10171ui_story then
				arg_169_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_169_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2204cva", "EmotionTimelineAnimator")
			end

			local var_172_4 = 0
			local var_172_5 = 0.125

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(323081041)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 5 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 5)

				if (5 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 5)) > 0 and var_172_5 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081041", "story_v_out_323081.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_out_323081", "323081041", "story_v_out_323081.awb") / 1000

					if var_172_10 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_4
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_out_323081", "323081041", "story_v_out_323081.awb")

						arg_169_1:RecordAudio("323081041", var_172_11)
						arg_169_1:RecordAudio("323081041", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_323081", "323081041", "story_v_out_323081.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_323081", "323081041", "story_v_out_323081.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_5, arg_169_1.talkMaxDuration)

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_4) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_4 + var_172_12 and arg_169_1.time_ < var_172_4 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play323081042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 323081042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play323081043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10171ui_story = arg_173_1.actors_["10171ui_story"].transform.localPosition

				local var_176_0 = GameObjectTools.GetOrAddComponent(arg_173_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_176_0 then
					var_176_0:EnableDynamicBone(false)
				end
			end

			local var_176_1 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_1 then
				arg_173_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_173_1.time_ - 0) / var_176_1)
				arg_173_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10171ui_story"].transform.position).z)
				arg_173_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10171ui_story"].transform.localEulerAngles = arg_173_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_1 and arg_173_1.time_ < 0 + var_176_1 + arg_176_0 then
				arg_173_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_173_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10171ui_story"].transform.position).z)
				arg_173_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10171ui_story"].transform.localEulerAngles = arg_173_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_176_2 = GameObjectTools.GetOrAddComponent(arg_173_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_176_2 then
					var_176_2:EnableDynamicBone(true)
				end
			end

			local var_176_3 = arg_173_1.actors_["1070ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1070ui_story = var_176_3.localPosition
			end

			local var_176_4 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 then
				var_176_3.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_173_1.time_ - 0) / var_176_4)
				var_176_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_3.position).x, (manager.ui.mainCamera.transform.position - var_176_3.position).y, (manager.ui.mainCamera.transform.position - var_176_3.position).z)
				var_176_3.localEulerAngles.z = 0
				var_176_3.localEulerAngles.x = 0
				var_176_3.localEulerAngles = var_176_3.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 then
				var_176_3.localPosition = Vector3.New(0, 100, 0)
				var_176_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_3.position).x, (manager.ui.mainCamera.transform.position - var_176_3.position).y, (manager.ui.mainCamera.transform.position - var_176_3.position).z)
				var_176_3.localEulerAngles.z = 0
				var_176_3.localEulerAngles.x = 0
				var_176_3.localEulerAngles = var_176_3.localEulerAngles
			end

			local var_176_5 = arg_173_1.actors_["1070ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_5) and arg_173_1.var_.characterEffect1070ui_story == nil then
				arg_173_1.var_.characterEffect1070ui_story = var_176_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_6 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_6 and not isNil(var_176_5) then
				if arg_173_1.var_.characterEffect1070ui_story and not isNil(var_176_5) then
					arg_173_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_6)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_6 and arg_173_1.time_ < 0 + var_176_6 + arg_176_0 and not isNil(var_176_5) and arg_173_1.var_.characterEffect1070ui_story then
				arg_173_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0.166666666666667 < arg_173_1.time_ and arg_173_1.time_ <= 0.166666666666667 + arg_176_0 then
				arg_173_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_hold", "")
			end

			local var_176_8 = 0
			local var_176_9 = 0.65

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_10 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(323081042).content)

				arg_173_1.text_.text = var_176_10

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_12 = 26 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_10) / 26)

				if (26 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_10) / 26)) > 0 and var_176_9 < var_176_12 then
					arg_173_1.talkMaxDuration = var_176_12

					if var_176_12 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_12 + var_176_8
					end
				end

				arg_173_1.text_.text = var_176_10
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_13 = math.max(var_176_9, arg_173_1.talkMaxDuration)

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_13 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_8) / var_176_13

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_8 + var_176_13 and arg_173_1.time_ < var_176_8 + var_176_13 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play323081043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 323081043
		arg_177_1.duration_ = 1.4

		local var_177_0 = {
			zh = 1.133,
			ja = 1.4
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play323081044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1070ui_story = arg_177_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1070ui_story"].transform.position).z)
				arg_177_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1070ui_story"].transform.localEulerAngles = arg_177_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_177_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1070ui_story"].transform.position).z)
				arg_177_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1070ui_story"].transform.localEulerAngles = arg_177_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["1070ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1070ui_story == nil then
				arg_177_1.var_.characterEffect1070ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect1070ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1070ui_story then
				arg_177_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_180_4 = 0
			local var_180_5 = 0.1

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(323081043)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 4 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 4)

				if (4 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 4)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081043", "story_v_out_323081.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_323081", "323081043", "story_v_out_323081.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_out_323081", "323081043", "story_v_out_323081.awb")

						arg_177_1:RecordAudio("323081043", var_180_11)
						arg_177_1:RecordAudio("323081043", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_323081", "323081043", "story_v_out_323081.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_323081", "323081043", "story_v_out_323081.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_12 = math.max(var_180_5, arg_177_1.talkMaxDuration)

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_12 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_4) / var_180_12

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_4 + var_180_12 and arg_177_1.time_ < var_180_4 + var_180_12 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play323081044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 323081044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play323081045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1070ui_story"]) and arg_181_1.var_.characterEffect1070ui_story == nil then
				arg_181_1.var_.characterEffect1070ui_story = arg_181_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1070ui_story"]) then
				if arg_181_1.var_.characterEffect1070ui_story and not isNil(arg_181_1.actors_["1070ui_story"]) then
					arg_181_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_0)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1070ui_story"]) and arg_181_1.var_.characterEffect1070ui_story then
				arg_181_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_184_1 = 0
			local var_184_2 = 0.2

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(323081044).content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 8 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 8)

				if (8 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 8)) > 0 and var_184_2 < var_184_5 then
					arg_181_1.talkMaxDuration = var_184_5

					if var_184_5 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + var_184_1
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_6 = math.max(var_184_2, arg_181_1.talkMaxDuration)

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_6 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_1) / var_184_6

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_1 + var_184_6 and arg_181_1.time_ < var_184_1 + var_184_6 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play323081045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 323081045
		arg_185_1.duration_ = 7.47

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play323081046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_9002
			local var_188_9001
			local var_188_9000

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1070ui_story = arg_185_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1070ui_story"].transform.position).z)
				arg_185_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1070ui_story"].transform.localEulerAngles = arg_185_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_185_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1070ui_story"].transform.position).z)
				arg_185_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1070ui_story"].transform.localEulerAngles = arg_185_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				local var_188_1 = arg_185_1.var_.effect4dd

				if not arg_185_1.var_.effect4dd then
					var_188_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_scan_in_out"), manager.ui.mainCamera.transform)
					var_188_1.name = "4dd"
					arg_185_1.var_.effect4dd = var_188_1
				else
					var_188_1.transform:SetParent(var_188_9002)
				end

				var_188_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_188_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_188_1.transform.localScale = Vector3.New(var_188_1.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_188_1.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_188_1.transform.localScale.z)
			end

			if 4 < arg_185_1.time_ and arg_185_1.time_ <= 4 + arg_188_0 then
				if arg_185_1.var_.effect4dd then
					Object.Destroy(arg_185_1.var_.effect4dd)

					arg_185_1.var_.effect4dd = nil
				end
			end

			if 2.06666666666667 < arg_185_1.time_ and arg_185_1.time_ <= 2.06666666666667 + arg_188_0 then
				local var_188_4 = arg_185_1.var_.effect4dd1

				if not arg_185_1.var_.effect4dd1 then
					var_188_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_target_gantan_in"), manager.ui.mainCamera.transform)
					var_188_4.name = "4dd1"
					arg_185_1.var_.effect4dd1 = var_188_4
				else
					var_188_4.transform:SetParent(var_188_9001)
				end

				var_188_4.transform.localPosition = Vector3.New(-0.49, 2.33, 4.74)
				var_188_4.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_188_6 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_188_4.transform.localScale = Vector3.New(var_188_4.transform.localScale.x * var_188_6, var_188_4.transform.localScale.y * var_188_6, var_188_4.transform.localScale.z * var_188_6)
			end

			if 3.46666666666667 < arg_185_1.time_ and arg_185_1.time_ <= 3.46666666666667 + arg_188_0 then
				if arg_185_1.var_.effect4dd1 then
					Object.Destroy(arg_185_1.var_.effect4dd1)

					arg_185_1.var_.effect4dd1 = nil
				end
			end

			local var_188_8 = 0

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.allBtn_.enabled = false
			end

			if arg_185_1.time_ >= var_188_8 + 3.16666666666667 and arg_185_1.time_ < var_188_8 + 3.16666666666667 + arg_188_0 then
				arg_185_1.allBtn_.enabled = true
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:AudioAction("play", "effect", "se_story_148", "se_story_148_scan", "")
			end

			if 1.8 < arg_185_1.time_ and arg_185_1.time_ <= 1.8 + arg_188_0 then
				arg_185_1:AudioAction("play", "effect", "se_story_148", "se_story_148_scan", "")
			end

			if 2.06666666666667 < arg_185_1.time_ and arg_185_1.time_ <= 2.06666666666667 + arg_188_0 then
				arg_185_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_beep", "")
			end

			if 3.46666666666667 < arg_185_1.time_ and arg_185_1.time_ <= 3.46666666666667 + arg_188_0 then
				local var_188_12 = arg_185_1.var_.effecterrew

				if not arg_185_1.var_.effecterrew then
					var_188_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_target_gantan_out"), manager.ui.mainCamera.transform)
					var_188_12.name = "errew"
					arg_185_1.var_.effecterrew = var_188_12
				else
					var_188_12.transform:SetParent(var_188_9000)
				end

				var_188_12.transform.localPosition = Vector3.New(-0.49, 2.33, 4.74)
				var_188_12.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_188_14 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_188_12.transform.localScale = Vector3.New(var_188_12.transform.localScale.x * var_188_14, var_188_12.transform.localScale.y * var_188_14, var_188_12.transform.localScale.z * var_188_14)
			end

			if 4.86666666666667 < arg_185_1.time_ and arg_185_1.time_ <= 4.86666666666667 + arg_188_0 then
				if arg_185_1.var_.effecterrew then
					Object.Destroy(arg_185_1.var_.effecterrew)

					arg_185_1.var_.effecterrew = nil
				end
			end

			if arg_185_1.frameCnt_ <= 1 then
				arg_185_1.dialog_:SetActive(false)
			end

			local var_188_16 = 2.34166666666667
			local var_188_17 = 0.825

			if 2.34166666666667 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_18 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_18:setOnUpdate(LuaHelper.FloatAction(function(arg_189_0)
					arg_185_1.dialogCg_.alpha = arg_189_0
				end))
				var_188_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_19 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(323081045).content)

				arg_185_1.text_.text = var_188_19

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_21 = 33 <= 0 and var_188_17 or var_188_17 * (utf8.len(var_188_19) / 33)

				if (33 <= 0 and var_188_17 or var_188_17 * (utf8.len(var_188_19) / 33)) > 0 and var_188_17 < var_188_21 then
					arg_185_1.talkMaxDuration = var_188_21
					var_188_16 = var_188_16 + 0.3

					if var_188_21 + var_188_16 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_21 + var_188_16
					end
				end

				arg_185_1.text_.text = var_188_19
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_22 = var_188_16 + 0.3
			local var_188_23 = math.max(var_188_17, arg_185_1.talkMaxDuration)

			if var_188_16 + 0.3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_22 + var_188_23 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_22) / var_188_23

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_22 + var_188_23 and arg_185_1.time_ < var_188_22 + var_188_23 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play323081046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 323081046
		arg_191_1.duration_ = 2.87

		local var_191_0 = {
			zh = 2.433,
			ja = 2.866
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play323081047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10171ui_story = arg_191_1.actors_["10171ui_story"].transform.localPosition

				local var_194_0 = GameObjectTools.GetOrAddComponent(arg_191_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_194_0 then
					var_194_0:EnableDynamicBone(false)
				end
			end

			local var_194_1 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_1 then
				arg_191_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_191_1.time_ - 0) / var_194_1)
				arg_191_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10171ui_story"].transform.position).z)
				arg_191_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["10171ui_story"].transform.localEulerAngles = arg_191_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_1 and arg_191_1.time_ < 0 + var_194_1 + arg_194_0 then
				arg_191_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_191_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10171ui_story"].transform.position).z)
				arg_191_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["10171ui_story"].transform.localEulerAngles = arg_191_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_194_2 = GameObjectTools.GetOrAddComponent(arg_191_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_194_2 then
					var_194_2:EnableDynamicBone(true)
				end
			end

			local var_194_3 = arg_191_1.actors_["10171ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_3) and arg_191_1.var_.characterEffect10171ui_story == nil then
				arg_191_1.var_.characterEffect10171ui_story = var_194_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_4 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 and not isNil(var_194_3) then
				if arg_191_1.var_.characterEffect10171ui_story and not isNil(var_194_3) then
					arg_191_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 and not isNil(var_194_3) and arg_191_1.var_.characterEffect10171ui_story then
				arg_191_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_194_6 = 0
			local var_194_7 = 0.375

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_8 = arg_191_1:GetWordFromCfg(323081046)
				local var_194_9 = arg_191_1:FormatText(var_194_8.content)

				arg_191_1.text_.text = var_194_9

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_11 = 15 <= 0 and var_194_7 or var_194_7 * (utf8.len(var_194_9) / 15)

				if (15 <= 0 and var_194_7 or var_194_7 * (utf8.len(var_194_9) / 15)) > 0 and var_194_7 < var_194_11 then
					arg_191_1.talkMaxDuration = var_194_11

					if var_194_11 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_11 + var_194_6
					end
				end

				arg_191_1.text_.text = var_194_9
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323081", "323081046", "story_v_out_323081.awb") ~= 0 then
					local var_194_12 = manager.audio:GetVoiceLength("story_v_out_323081", "323081046", "story_v_out_323081.awb") / 1000

					if var_194_12 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_12 + var_194_6
					end

					if var_194_8.prefab_name ~= "" and arg_191_1.actors_[var_194_8.prefab_name] ~= nil then
						local var_194_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_8.prefab_name].transform, "story_v_out_323081", "323081046", "story_v_out_323081.awb")

						arg_191_1:RecordAudio("323081046", var_194_13)
						arg_191_1:RecordAudio("323081046", var_194_13)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_323081", "323081046", "story_v_out_323081.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_323081", "323081046", "story_v_out_323081.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_14 = math.max(var_194_7, arg_191_1.talkMaxDuration)

			if var_194_6 <= arg_191_1.time_ and arg_191_1.time_ < var_194_6 + var_194_14 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_6) / var_194_14

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_6 + var_194_14 and arg_191_1.time_ < var_194_6 + var_194_14 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play323081047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 323081047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play323081048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["10171ui_story"]) and arg_195_1.var_.characterEffect10171ui_story == nil then
				arg_195_1.var_.characterEffect10171ui_story = arg_195_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["10171ui_story"]) then
				if arg_195_1.var_.characterEffect10171ui_story and not isNil(arg_195_1.actors_["10171ui_story"]) then
					arg_195_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["10171ui_story"]) and arg_195_1.var_.characterEffect10171ui_story then
				arg_195_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_198_1 = 0
			local var_198_2 = 0.375

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(323081047).content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 15 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 15)

				if (15 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 15)) > 0 and var_198_2 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5

					if var_198_5 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_1
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_6 = math.max(var_198_2, arg_195_1.talkMaxDuration)

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_6 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_1) / var_198_6

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_1 + var_198_6 and arg_195_1.time_ < var_198_1 + var_198_6 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play323081048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 323081048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play323081049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10171ui_story = arg_199_1.actors_["10171ui_story"].transform.localPosition

				local var_202_0 = GameObjectTools.GetOrAddComponent(arg_199_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_202_0 then
					var_202_0:EnableDynamicBone(false)
				end
			end

			local var_202_1 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_1 then
				arg_199_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 0) / var_202_1)
				arg_199_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10171ui_story"].transform.position).z)
				arg_199_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["10171ui_story"].transform.localEulerAngles = arg_199_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_1 and arg_199_1.time_ < 0 + var_202_1 + arg_202_0 then
				arg_199_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_199_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10171ui_story"].transform.position).z)
				arg_199_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["10171ui_story"].transform.localEulerAngles = arg_199_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_202_2 = GameObjectTools.GetOrAddComponent(arg_199_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_202_2 then
					var_202_2:EnableDynamicBone(true)
				end
			end

			if 0.133333333333333 < arg_199_1.time_ and arg_199_1.time_ <= 0.133333333333333 + arg_202_0 then
				arg_199_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_gun01", "")
			end

			local var_202_4 = 0
			local var_202_5 = 1.6

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_6 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(323081048).content)

				arg_199_1.text_.text = var_202_6

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_8 = 64 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_6) / 64)

				if (64 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_6) / 64)) > 0 and var_202_5 < var_202_8 then
					arg_199_1.talkMaxDuration = var_202_8

					if var_202_8 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_6
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_9 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_9 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_9

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_9 and arg_199_1.time_ < var_202_4 + var_202_9 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play323081049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 323081049
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
			arg_203_1.auto_ = false
		end

		function arg_203_1.playNext_(arg_205_0)
			arg_203_1.onStoryFinished_()
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.6

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_1 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(323081049).content)

				arg_203_1.text_.text = var_206_1

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_3 = 24 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 24)

				if (24 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 24)) > 0 and var_206_0 < var_206_3 then
					arg_203_1.talkMaxDuration = var_206_3

					if var_206_3 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_3 + 0
					end
				end

				arg_203_1.text_.text = var_206_1
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_4 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_4

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J23f",
		"TextureConfig/Background/J02b"
	},
	voices = {
		"story_v_out_323081.awb"
	}
}
