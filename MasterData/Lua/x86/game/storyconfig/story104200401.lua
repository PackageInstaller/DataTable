return {
	Play420041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 420041001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play420041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 2 + 0.466666666666667 and arg_1_1.time_ < 2 + 0.466666666666667 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = "L01f"

			if arg_1_1.bgs_.L01f == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_2 = arg_1_1.bgs_.L01f

				arg_1_1.bgs_.L01f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_3 = var_4_2:GetComponent("SpriteRenderer")

				if var_4_3 and var_4_3.sprite then
					local var_4_4 = 2 * (var_4_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_2.transform.localScale = Vector3.New(var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L01f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			if 0.333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.333333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 0.775

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(420041001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 31 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 31)

				if (31 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 31)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play420041002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 420041002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play420041003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0.133333333333333 < arg_9_1.time_ and arg_9_1.time_ <= 0.133333333333333 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_140", "se_story_140_camera01", "")
			end

			local var_12_1 = 0.433333333333333

			if 0.433333333333333 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.mask_.enabled = true
				arg_9_1.mask_.raycastTarget = true

				arg_9_1:SetGaussion(false)
			end

			local var_12_2 = 0.2

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 then
				local var_12_3 = Color.New(1, 1, 1)

				var_12_3.a = Mathf.Lerp(1, 0, (arg_9_1.time_ - var_12_1) / var_12_2)
				arg_9_1.mask_.color = var_12_3
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 then
				local var_12_4 = Color.New(1, 1, 1)

				arg_9_1.mask_.enabled = false
				var_12_4.a = 0
				arg_9_1.mask_.color = var_12_4
			end

			local var_12_5 = 0
			local var_12_6 = 1.625

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_7 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(420041002).content)

				arg_9_1.text_.text = var_12_7

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_9 = 65 <= 0 and var_12_6 or var_12_6 * (utf8.len(var_12_7) / 65)

				if (65 <= 0 and var_12_6 or var_12_6 * (utf8.len(var_12_7) / 65)) > 0 and var_12_6 < var_12_9 then
					arg_9_1.talkMaxDuration = var_12_9

					if var_12_9 + var_12_5 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_9 + var_12_5
					end
				end

				arg_9_1.text_.text = var_12_7
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = math.max(var_12_6, arg_9_1.talkMaxDuration)

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_10 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_5) / var_12_10

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_5 + var_12_10 and arg_9_1.time_ < var_12_5 + var_12_10 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play420041003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 420041003
		arg_13_1.duration_ = 6.07

		local var_13_0 = {
			zh = 3.166,
			ja = 6.066
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
				arg_13_0:Play420041004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "404001ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["404001ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["404001ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["404001ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["404001ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["404001ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos404001ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -1.55, -5.5)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["404001ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect404001ui_story == nil then
				arg_13_1.var_.characterEffect404001ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect404001ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect404001ui_story then
				arg_13_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_16_8 = 0

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.allBtn_.enabled = false
			end

			if arg_13_1.time_ >= var_16_8 + 0.7 and arg_13_1.time_ < var_16_8 + 0.7 + arg_16_0 then
				arg_13_1.allBtn_.enabled = true
			end

			local var_16_9 = 0
			local var_16_10 = 0.4

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_9 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_11 = arg_13_1:GetWordFromCfg(420041003)
				local var_16_12 = arg_13_1:FormatText(var_16_11.content)

				arg_13_1.text_.text = var_16_12

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_14 = 16 <= 0 and var_16_10 or var_16_10 * (utf8.len(var_16_12) / 16)

				if (16 <= 0 and var_16_10 or var_16_10 * (utf8.len(var_16_12) / 16)) > 0 and var_16_10 < var_16_14 then
					arg_13_1.talkMaxDuration = var_16_14

					if var_16_14 + var_16_9 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_9
					end
				end

				arg_13_1.text_.text = var_16_12
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041003", "story_v_out_420041.awb") ~= 0 then
					local var_16_15 = manager.audio:GetVoiceLength("story_v_out_420041", "420041003", "story_v_out_420041.awb") / 1000

					if var_16_15 + var_16_9 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_9
					end

					if var_16_11.prefab_name ~= "" and arg_13_1.actors_[var_16_11.prefab_name] ~= nil then
						local var_16_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_11.prefab_name].transform, "story_v_out_420041", "420041003", "story_v_out_420041.awb")

						arg_13_1:RecordAudio("420041003", var_16_16)
						arg_13_1:RecordAudio("420041003", var_16_16)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_420041", "420041003", "story_v_out_420041.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_420041", "420041003", "story_v_out_420041.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_17 = math.max(var_16_10, arg_13_1.talkMaxDuration)

			if var_16_9 <= arg_13_1.time_ and arg_13_1.time_ < var_16_9 + var_16_17 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_9) / var_16_17

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_9 + var_16_17 and arg_13_1.time_ < var_16_9 + var_16_17 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play420041004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 420041004
		arg_17_1.duration_ = 5.13

		local var_17_0 = {
			zh = 4.466,
			ja = 5.133
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play420041005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos404001ui_story = arg_17_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).z)
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles = arg_17_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).z)
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles = arg_17_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_20_1 = "1085ui_story"

			if arg_17_1.actors_["1085ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1085ui_story"))) then
				local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_17_1.stage_.transform)

				var_20_2.name = var_20_1
				var_20_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_[var_20_1] = var_20_2

				local var_20_3 = var_20_2:GetComponentInChildren(typeof(CharacterEffect))

				var_20_3.enabled = true

				local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_2, typeof(DynamicBoneHelper))

				if var_20_4 then
					var_20_4:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_3.transform, false)

				arg_17_1.var_[var_20_1 .. "Animator"] = var_20_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_[var_20_1 .. "Animator"].applyRootMotion = true
				arg_17_1.var_[var_20_1 .. "LipSync"] = var_20_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_5 = arg_17_1.actors_["1085ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1085ui_story = var_20_5.localPosition
			end

			local var_20_6 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 then
				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_17_1.time_ - 0) / var_20_6)
				var_20_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_5.position).x, (manager.ui.mainCamera.transform.position - var_20_5.position).y, (manager.ui.mainCamera.transform.position - var_20_5.position).z)
				var_20_5.localEulerAngles.z = 0
				var_20_5.localEulerAngles.x = 0
				var_20_5.localEulerAngles = var_20_5.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0, -1.01, -5.83)
				var_20_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_5.position).x, (manager.ui.mainCamera.transform.position - var_20_5.position).y, (manager.ui.mainCamera.transform.position - var_20_5.position).z)
				var_20_5.localEulerAngles.z = 0
				var_20_5.localEulerAngles.x = 0
				var_20_5.localEulerAngles = var_20_5.localEulerAngles
			end

			local var_20_7 = arg_17_1.actors_["1085ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.characterEffect1085ui_story == nil then
				arg_17_1.var_.characterEffect1085ui_story = var_20_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_8 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_8 and not isNil(var_20_7) then
				if arg_17_1.var_.characterEffect1085ui_story and not isNil(var_20_7) then
					arg_17_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_8 and arg_17_1.time_ < 0 + var_20_8 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.characterEffect1085ui_story then
				arg_17_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_20_10 = arg_17_1.actors_["404001ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect404001ui_story == nil then
				arg_17_1.var_.characterEffect404001ui_story = var_20_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_11 and not isNil(var_20_10) then
				if arg_17_1.var_.characterEffect404001ui_story and not isNil(var_20_10) then
					arg_17_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_17_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_11)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_11 and arg_17_1.time_ < 0 + var_20_11 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect404001ui_story then
				arg_17_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_17_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_20_12 = 0
			local var_20_13 = 0.275

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_14 = arg_17_1:GetWordFromCfg(420041004)
				local var_20_15 = arg_17_1:FormatText(var_20_14.content)

				arg_17_1.text_.text = var_20_15

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_17 = 11 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 11)

				if (11 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 11)) > 0 and var_20_13 < var_20_17 then
					arg_17_1.talkMaxDuration = var_20_17

					if var_20_17 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_12
					end
				end

				arg_17_1.text_.text = var_20_15
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041004", "story_v_out_420041.awb") ~= 0 then
					local var_20_18 = manager.audio:GetVoiceLength("story_v_out_420041", "420041004", "story_v_out_420041.awb") / 1000

					if var_20_18 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_12
					end

					if var_20_14.prefab_name ~= "" and arg_17_1.actors_[var_20_14.prefab_name] ~= nil then
						local var_20_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_14.prefab_name].transform, "story_v_out_420041", "420041004", "story_v_out_420041.awb")

						arg_17_1:RecordAudio("420041004", var_20_19)
						arg_17_1:RecordAudio("420041004", var_20_19)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_420041", "420041004", "story_v_out_420041.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_420041", "420041004", "story_v_out_420041.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_20 = math.max(var_20_13, arg_17_1.talkMaxDuration)

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_20 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_12) / var_20_20

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_12 + var_20_20 and arg_17_1.time_ < var_20_12 + var_20_20 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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

		arg_17_1:InitPlayNodeList()
	end,
	Play420041005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 420041005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play420041006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1085ui_story"]) and arg_21_1.var_.characterEffect1085ui_story == nil then
				arg_21_1.var_.characterEffect1085ui_story = arg_21_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1085ui_story"]) then
				if arg_21_1.var_.characterEffect1085ui_story and not isNil(arg_21_1.actors_["1085ui_story"]) then
					arg_21_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1085ui_story"]) and arg_21_1.var_.characterEffect1085ui_story then
				arg_21_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.175

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(420041005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 7 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 7)

				if (7 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 7)) > 0 and var_24_2 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_6 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_6 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_6

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_6 and arg_21_1.time_ < var_24_1 + var_24_6 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play420041006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 420041006
		arg_25_1.duration_ = 11.4

		local var_25_0 = {
			zh = 10.566,
			ja = 11.4
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play420041007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1085ui_story"]) and arg_25_1.var_.characterEffect1085ui_story == nil then
				arg_25_1.var_.characterEffect1085ui_story = arg_25_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1085ui_story"]) then
				if arg_25_1.var_.characterEffect1085ui_story and not isNil(arg_25_1.actors_["1085ui_story"]) then
					arg_25_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1085ui_story"]) and arg_25_1.var_.characterEffect1085ui_story then
				arg_25_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_28_2 = 0
			local var_28_3 = 0.85

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_4 = arg_25_1:GetWordFromCfg(420041006)
				local var_28_5 = arg_25_1:FormatText(var_28_4.content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 34 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 34)

				if (34 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 34)) > 0 and var_28_3 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041006", "story_v_out_420041.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_420041", "420041006", "story_v_out_420041.awb") / 1000

					if var_28_8 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_2
					end

					if var_28_4.prefab_name ~= "" and arg_25_1.actors_[var_28_4.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_4.prefab_name].transform, "story_v_out_420041", "420041006", "story_v_out_420041.awb")

						arg_25_1:RecordAudio("420041006", var_28_9)
						arg_25_1:RecordAudio("420041006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_420041", "420041006", "story_v_out_420041.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_420041", "420041006", "story_v_out_420041.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_3, arg_25_1.talkMaxDuration)

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_2) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_2 + var_28_10 and arg_25_1.time_ < var_28_2 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play420041007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 420041007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play420041008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1085ui_story = arg_29_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1085ui_story"].transform.position).z)
				arg_29_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1085ui_story"].transform.localEulerAngles = arg_29_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1085ui_story"].transform.position).z)
				arg_29_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1085ui_story"].transform.localEulerAngles = arg_29_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_32_1 = 0
			local var_32_2 = 1.275

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(420041007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 51 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 51)

				if (51 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 51)) > 0 and var_32_2 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_6 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_6 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_6

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_6 and arg_29_1.time_ < var_32_1 + var_32_6 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play420041008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 420041008
		arg_33_1.duration_ = 11.97

		local var_33_0 = {
			zh = 8.733,
			ja = 11.966
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play420041009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1085ui_story = arg_33_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1085ui_story"].transform.position).z)
				arg_33_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1085ui_story"].transform.localEulerAngles = arg_33_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_33_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1085ui_story"].transform.position).z)
				arg_33_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1085ui_story"].transform.localEulerAngles = arg_33_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1085ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1085ui_story == nil then
				arg_33_1.var_.characterEffect1085ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1085ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1085ui_story then
				arg_33_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_36_4 = 0
			local var_36_5 = 0.675

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(420041008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 27 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 27)

				if (27 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 27)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041008", "story_v_out_420041.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_420041", "420041008", "story_v_out_420041.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_out_420041", "420041008", "story_v_out_420041.awb")

						arg_33_1:RecordAudio("420041008", var_36_11)
						arg_33_1:RecordAudio("420041008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_420041", "420041008", "story_v_out_420041.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_420041", "420041008", "story_v_out_420041.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_12 and arg_33_1.time_ < var_36_4 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play420041009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 420041009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play420041010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1085ui_story"]) and arg_37_1.var_.characterEffect1085ui_story == nil then
				arg_37_1.var_.characterEffect1085ui_story = arg_37_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1085ui_story"]) then
				if arg_37_1.var_.characterEffect1085ui_story and not isNil(arg_37_1.actors_["1085ui_story"]) then
					arg_37_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1085ui_story"]) and arg_37_1.var_.characterEffect1085ui_story then
				arg_37_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.175

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(420041009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 7 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 7)

				if (7 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 7)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play420041010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 420041010
		arg_41_1.duration_ = 8.67

		local var_41_0 = {
			zh = 6.333,
			ja = 8.666
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play420041011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1085ui_story = arg_41_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1085ui_story"].transform.position).z)
				arg_41_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1085ui_story"].transform.localEulerAngles = arg_41_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1085ui_story"].transform.position).z)
				arg_41_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1085ui_story"].transform.localEulerAngles = arg_41_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["404001ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos404001ui_story = var_44_1.localPosition
			end

			local var_44_2 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 then
				var_44_1.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_41_1.time_ - 0) / var_44_2)
				var_44_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_1.position).x, (manager.ui.mainCamera.transform.position - var_44_1.position).y, (manager.ui.mainCamera.transform.position - var_44_1.position).z)
				var_44_1.localEulerAngles.z = 0
				var_44_1.localEulerAngles.x = 0
				var_44_1.localEulerAngles = var_44_1.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 then
				var_44_1.localPosition = Vector3.New(0, -1.55, -5.5)
				var_44_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_1.position).x, (manager.ui.mainCamera.transform.position - var_44_1.position).y, (manager.ui.mainCamera.transform.position - var_44_1.position).z)
				var_44_1.localEulerAngles.z = 0
				var_44_1.localEulerAngles.x = 0
				var_44_1.localEulerAngles = var_44_1.localEulerAngles
			end

			local var_44_3 = arg_41_1.actors_["404001ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_3) and arg_41_1.var_.characterEffect404001ui_story == nil then
				arg_41_1.var_.characterEffect404001ui_story = var_44_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_4 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 and not isNil(var_44_3) then
				if arg_41_1.var_.characterEffect404001ui_story and not isNil(var_44_3) then
					arg_41_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 and not isNil(var_44_3) and arg_41_1.var_.characterEffect404001ui_story then
				arg_41_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_44_6 = 0
			local var_44_7 = 0.825

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_8 = arg_41_1:GetWordFromCfg(420041010)
				local var_44_9 = arg_41_1:FormatText(var_44_8.content)

				arg_41_1.text_.text = var_44_9

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 32 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 32)

				if (32 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 32)) > 0 and var_44_7 < var_44_11 then
					arg_41_1.talkMaxDuration = var_44_11

					if var_44_11 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_9
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041010", "story_v_out_420041.awb") ~= 0 then
					local var_44_12 = manager.audio:GetVoiceLength("story_v_out_420041", "420041010", "story_v_out_420041.awb") / 1000

					if var_44_12 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_6
					end

					if var_44_8.prefab_name ~= "" and arg_41_1.actors_[var_44_8.prefab_name] ~= nil then
						local var_44_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_8.prefab_name].transform, "story_v_out_420041", "420041010", "story_v_out_420041.awb")

						arg_41_1:RecordAudio("420041010", var_44_13)
						arg_41_1:RecordAudio("420041010", var_44_13)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_420041", "420041010", "story_v_out_420041.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_420041", "420041010", "story_v_out_420041.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play420041011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 420041011
		arg_45_1.duration_ = 11.4

		local var_45_0 = {
			zh = 7.733,
			ja = 11.4
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
				arg_45_0:Play420041012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.95

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(420041011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 38 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 38)

				if (38 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 38)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041011", "story_v_out_420041.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_420041", "420041011", "story_v_out_420041.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_420041", "420041011", "story_v_out_420041.awb")

						arg_45_1:RecordAudio("420041011", var_48_6)
						arg_45_1:RecordAudio("420041011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_420041", "420041011", "story_v_out_420041.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_420041", "420041011", "story_v_out_420041.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play420041012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 420041012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play420041013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["404001ui_story"]) and arg_49_1.var_.characterEffect404001ui_story == nil then
				arg_49_1.var_.characterEffect404001ui_story = arg_49_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["404001ui_story"]) then
				if arg_49_1.var_.characterEffect404001ui_story and not isNil(arg_49_1.actors_["404001ui_story"]) then
					arg_49_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_49_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["404001ui_story"]) and arg_49_1.var_.characterEffect404001ui_story then
				arg_49_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_49_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.925

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(420041012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 37 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 37)

				if (37 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 37)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play420041013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 420041013
		arg_53_1.duration_ = 8.07

		local var_53_0 = {
			zh = 4.766,
			ja = 8.066
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play420041014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["404001ui_story"]) and arg_53_1.var_.characterEffect404001ui_story == nil then
				arg_53_1.var_.characterEffect404001ui_story = arg_53_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["404001ui_story"]) then
				if arg_53_1.var_.characterEffect404001ui_story and not isNil(arg_53_1.actors_["404001ui_story"]) then
					arg_53_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["404001ui_story"]) and arg_53_1.var_.characterEffect404001ui_story then
				arg_53_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_56_2 = 0
			local var_56_3 = 0.475

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(420041013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 19 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 19)

				if (19 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 19)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041013", "story_v_out_420041.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_420041", "420041013", "story_v_out_420041.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_420041", "420041013", "story_v_out_420041.awb")

						arg_53_1:RecordAudio("420041013", var_56_9)
						arg_53_1:RecordAudio("420041013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_420041", "420041013", "story_v_out_420041.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_420041", "420041013", "story_v_out_420041.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_10 and arg_53_1.time_ < var_56_2 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play420041014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 420041014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play420041015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos404001ui_story = arg_57_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["404001ui_story"].transform.position).z)
				arg_57_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["404001ui_story"].transform.localEulerAngles = arg_57_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["404001ui_story"].transform.position).z)
				arg_57_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["404001ui_story"].transform.localEulerAngles = arg_57_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_60_1 = 0
			local var_60_2 = 1.05

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(420041014).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 42 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 42)

				if (42 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 42)) > 0 and var_60_2 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_6 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_6 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_6

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_6 and arg_57_1.time_ < var_60_1 + var_60_6 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play420041015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 420041015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play420041016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.425

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(420041015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 17 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 17)

				if (17 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 17)) > 0 and var_64_0 < var_64_3 then
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
	Play420041016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 420041016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play420041017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0.9 < arg_65_1.time_ and arg_65_1.time_ <= 0.9 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_0 = 0.2

			if 0.9 <= arg_65_1.time_ and arg_65_1.time_ < 0.9 + var_68_0 then
				local var_68_1 = Color.New(1, 1, 1)

				var_68_1.a = Mathf.Lerp(1, 0, (arg_65_1.time_ - 0.9) / var_68_0)
				arg_65_1.mask_.color = var_68_1
			end

			if arg_65_1.time_ >= 0.9 + var_68_0 and arg_65_1.time_ < 0.9 + var_68_0 + arg_68_0 then
				local var_68_2 = Color.New(1, 1, 1)

				arg_65_1.mask_.enabled = false
				var_68_2.a = 0
				arg_65_1.mask_.color = var_68_2
			end

			if 0.899787800386548 < arg_65_1.time_ and arg_65_1.time_ <= 0.899787800386548 + arg_68_0 then
				arg_65_1:AudioAction("play", "effect", "se_story_140", "se_story_140_camera02", "")
			end

			local var_68_4 = 0
			local var_68_5 = 1.1

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(420041016).content)

				arg_65_1.text_.text = var_68_6

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_8 = 44 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_6) / 44)

				if (44 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_6) / 44)) > 0 and var_68_5 < var_68_8 then
					arg_65_1.talkMaxDuration = var_68_8

					if var_68_8 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_6
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_9 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_9 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_9

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_9 and arg_65_1.time_ < var_68_4 + var_68_9 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play420041017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 420041017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play420041018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.15

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_2 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_2:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(420041017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 6 <= 0 and var_72_1 or var_72_1 * (utf8.len(var_72_3) / 6)

				if (6 <= 0 and var_72_1 or var_72_1 * (utf8.len(var_72_3) / 6)) > 0 and var_72_1 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5
					var_72_0 = var_72_0 + 0.3

					if var_72_5 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = var_72_0 + 0.3
			local var_72_7 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_7 and arg_69_1.time_ < var_72_6 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play420041018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 420041018
		arg_75_1.duration_ = 7.6

		local var_75_0 = {
			zh = 5.833,
			ja = 7.6
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
				arg_75_0:Play420041019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1085ui_story = arg_75_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1085ui_story"].transform.position).z)
				arg_75_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1085ui_story"].transform.localEulerAngles = arg_75_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_75_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1085ui_story"].transform.position).z)
				arg_75_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1085ui_story"].transform.localEulerAngles = arg_75_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_78_1 = arg_75_1.actors_["1085ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1085ui_story == nil then
				arg_75_1.var_.characterEffect1085ui_story = var_78_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_2 and not isNil(var_78_1) then
				if arg_75_1.var_.characterEffect1085ui_story and not isNil(var_78_1) then
					arg_75_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_2 and arg_75_1.time_ < 0 + var_78_2 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1085ui_story then
				arg_75_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_78_4 = 0
			local var_78_5 = 0.7

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_6 = arg_75_1:GetWordFromCfg(420041018)
				local var_78_7 = arg_75_1:FormatText(var_78_6.content)

				arg_75_1.text_.text = var_78_7

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_9 = 28 <= 0 and var_78_5 or var_78_5 * (utf8.len(var_78_7) / 28)

				if (28 <= 0 and var_78_5 or var_78_5 * (utf8.len(var_78_7) / 28)) > 0 and var_78_5 < var_78_9 then
					arg_75_1.talkMaxDuration = var_78_9

					if var_78_9 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_9 + var_78_4
					end
				end

				arg_75_1.text_.text = var_78_7
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041018", "story_v_out_420041.awb") ~= 0 then
					local var_78_10 = manager.audio:GetVoiceLength("story_v_out_420041", "420041018", "story_v_out_420041.awb") / 1000

					if var_78_10 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_4
					end

					if var_78_6.prefab_name ~= "" and arg_75_1.actors_[var_78_6.prefab_name] ~= nil then
						local var_78_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_6.prefab_name].transform, "story_v_out_420041", "420041018", "story_v_out_420041.awb")

						arg_75_1:RecordAudio("420041018", var_78_11)
						arg_75_1:RecordAudio("420041018", var_78_11)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_420041", "420041018", "story_v_out_420041.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_420041", "420041018", "story_v_out_420041.awb")
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

		arg_75_1.nodeConfigList_ = {
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

		arg_75_1:InitPlayNodeList()
	end,
	Play420041019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 420041019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play420041020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1085ui_story = arg_79_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1085ui_story"].transform.position).z)
				arg_79_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1085ui_story"].transform.localEulerAngles = arg_79_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1085ui_story"].transform.position).z)
				arg_79_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1085ui_story"].transform.localEulerAngles = arg_79_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_82_1 = 0
			local var_82_2 = 0.425

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_3 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(420041019).content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 17 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 17)

				if (17 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 17)) > 0 and var_82_2 < var_82_5 then
					arg_79_1.talkMaxDuration = var_82_5

					if var_82_5 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + var_82_1
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_6 = math.max(var_82_2, arg_79_1.talkMaxDuration)

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_6 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_1) / var_82_6

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_1 + var_82_6 and arg_79_1.time_ < var_82_1 + var_82_6 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
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

		arg_79_1:InitPlayNodeList()
	end,
	Play420041020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 420041020
		arg_83_1.duration_ = 6

		local var_83_0 = {
			zh = 5.799999997019,
			ja = 6
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
				arg_83_0:Play420041021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if arg_83_1.bgs_.L16f == nil then
				local var_86_0 = Object.Instantiate(arg_83_1.paintGo_)

				var_86_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L16f")
				var_86_0.name = "L16f"
				var_86_0.transform.parent = arg_83_1.stage_.transform
				var_86_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.bgs_.L16f = var_86_0
			end

			if 2 < arg_83_1.time_ and arg_83_1.time_ <= 2 + arg_86_0 then
				local var_86_1 = arg_83_1.bgs_.L16f

				arg_83_1.bgs_.L16f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_86_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_86_2 = var_86_1:GetComponent("SpriteRenderer")

				if var_86_2 and var_86_2.sprite then
					local var_86_3 = 2 * (var_86_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_86_1.transform.localScale = Vector3.New(var_86_3 / var_86_2.sprite.bounds.size.y < var_86_3 * manager.ui.mainCameraCom_.aspect / var_86_2.sprite.bounds.size.x and var_86_3 * manager.ui.mainCameraCom_.aspect / var_86_2.sprite.bounds.size.x or var_86_3 / var_86_2.sprite.bounds.size.y, var_86_3 / var_86_2.sprite.bounds.size.y < var_86_3 * manager.ui.mainCameraCom_.aspect / var_86_2.sprite.bounds.size.x and var_86_3 * manager.ui.mainCameraCom_.aspect / var_86_2.sprite.bounds.size.x or var_86_3 / var_86_2.sprite.bounds.size.y, 0)
				end

				for iter_86_0, iter_86_1 in pairs(arg_83_1.bgs_) do
					if iter_86_0 ~= "L16f" then
						iter_86_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_86_4 = 0

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_5 = 2

			if var_86_4 <= arg_83_1.time_ and arg_83_1.time_ < var_86_4 + var_86_5 then
				local var_86_6 = Color.New(0, 0, 0)

				var_86_6.a = Mathf.Lerp(0, 1, (arg_83_1.time_ - var_86_4) / var_86_5)
				arg_83_1.mask_.color = var_86_6
			end

			if arg_83_1.time_ >= var_86_4 + var_86_5 and arg_83_1.time_ < var_86_4 + var_86_5 + arg_86_0 then
				local var_86_7 = Color.New(0, 0, 0)

				var_86_7.a = 1
				arg_83_1.mask_.color = var_86_7
			end

			local var_86_8 = 2

			if 2 < arg_83_1.time_ and arg_83_1.time_ <= var_86_8 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_9 = 2

			if var_86_8 <= arg_83_1.time_ and arg_83_1.time_ < var_86_8 + var_86_9 then
				local var_86_10 = Color.New(0, 0, 0)

				var_86_10.a = Mathf.Lerp(1, 0, (arg_83_1.time_ - var_86_8) / var_86_9)
				arg_83_1.mask_.color = var_86_10
			end

			if arg_83_1.time_ >= var_86_8 + var_86_9 and arg_83_1.time_ < var_86_8 + var_86_9 + arg_86_0 then
				local var_86_11 = Color.New(0, 0, 0)

				arg_83_1.mask_.enabled = false
				var_86_11.a = 0
				arg_83_1.mask_.color = var_86_11
			end

			local var_86_12 = arg_83_1.actors_["1085ui_story"].transform

			if 1.96599999815226 < arg_83_1.time_ and arg_83_1.time_ <= 1.96599999815226 + arg_86_0 then
				arg_83_1.var_.moveOldPos1085ui_story = var_86_12.localPosition
			end

			local var_86_13 = 0.001

			if 1.96599999815226 <= arg_83_1.time_ and arg_83_1.time_ < 1.96599999815226 + var_86_13 then
				var_86_12.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_83_1.time_ - 1.96599999815226) / var_86_13)
				var_86_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_12.position).x, (manager.ui.mainCamera.transform.position - var_86_12.position).y, (manager.ui.mainCamera.transform.position - var_86_12.position).z)
				var_86_12.localEulerAngles.z = 0
				var_86_12.localEulerAngles.x = 0
				var_86_12.localEulerAngles = var_86_12.localEulerAngles
			end

			if arg_83_1.time_ >= 1.96599999815226 + var_86_13 and arg_83_1.time_ < 1.96599999815226 + var_86_13 + arg_86_0 then
				var_86_12.localPosition = Vector3.New(0, 100, 0)
				var_86_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_12.position).x, (manager.ui.mainCamera.transform.position - var_86_12.position).y, (manager.ui.mainCamera.transform.position - var_86_12.position).z)
				var_86_12.localEulerAngles.z = 0
				var_86_12.localEulerAngles.x = 0
				var_86_12.localEulerAngles = var_86_12.localEulerAngles
			end

			local var_86_14 = arg_83_1.actors_["1085ui_story"].transform

			if 3.79999999701977 < arg_83_1.time_ and arg_83_1.time_ <= 3.79999999701977 + arg_86_0 then
				arg_83_1.var_.moveOldPos1085ui_story = var_86_14.localPosition
			end

			local var_86_15 = 0.001

			if 3.79999999701977 <= arg_83_1.time_ and arg_83_1.time_ < 3.79999999701977 + var_86_15 then
				var_86_14.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_83_1.time_ - 3.79999999701977) / var_86_15)
				var_86_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_14.position).x, (manager.ui.mainCamera.transform.position - var_86_14.position).y, (manager.ui.mainCamera.transform.position - var_86_14.position).z)
				var_86_14.localEulerAngles.z = 0
				var_86_14.localEulerAngles.x = 0
				var_86_14.localEulerAngles = var_86_14.localEulerAngles
			end

			if arg_83_1.time_ >= 3.79999999701977 + var_86_15 and arg_83_1.time_ < 3.79999999701977 + var_86_15 + arg_86_0 then
				var_86_14.localPosition = Vector3.New(0, -1.01, -5.83)
				var_86_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_14.position).x, (manager.ui.mainCamera.transform.position - var_86_14.position).y, (manager.ui.mainCamera.transform.position - var_86_14.position).z)
				var_86_14.localEulerAngles.z = 0
				var_86_14.localEulerAngles.x = 0
				var_86_14.localEulerAngles = var_86_14.localEulerAngles
			end

			local var_86_16 = arg_83_1.actors_["1085ui_story"]

			if 3.79999999701977 < arg_83_1.time_ and arg_83_1.time_ <= 3.79999999701977 + arg_86_0 and not isNil(var_86_16) and arg_83_1.var_.characterEffect1085ui_story == nil then
				arg_83_1.var_.characterEffect1085ui_story = var_86_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_17 = 0.200000002980232

			if 3.79999999701977 <= arg_83_1.time_ and arg_83_1.time_ < 3.79999999701977 + var_86_17 and not isNil(var_86_16) then
				if arg_83_1.var_.characterEffect1085ui_story and not isNil(var_86_16) then
					arg_83_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 3.79999999701977 + var_86_17 and arg_83_1.time_ < 3.79999999701977 + var_86_17 + arg_86_0 and not isNil(var_86_16) and arg_83_1.var_.characterEffect1085ui_story then
				arg_83_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 3.79999999701977 < arg_83_1.time_ and arg_83_1.time_ <= 3.79999999701977 + arg_86_0 then
				arg_83_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 3.79999999701977 < arg_83_1.time_ and arg_83_1.time_ <= 3.79999999701977 + arg_86_0 then
				arg_83_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.333333333333333 < arg_83_1.time_ and arg_83_1.time_ <= 0.333333333333333 + arg_86_0 then
				arg_83_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_86_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_83_1.bgmTxt_.text ~= var_86_21 and arg_83_1.bgmTxt_.text ~= "" then
						if arg_83_1.bgmTxt2_.text ~= "" then
							arg_83_1.bgmTxt_.text = arg_83_1.bgmTxt2_.text
						end

						arg_83_1.bgmTxt2_.text = var_86_21

						arg_83_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_83_1.bgmTxt_.text = var_86_21
						arg_83_1.bgmTxt2_.text = var_86_21
					end

					if arg_83_1.bgmTimer then
						arg_83_1.bgmTimer:Stop()

						arg_83_1.bgmTimer = nil
					end

					if arg_83_1.settingData.show_music_name == 1 then
						arg_83_1.musicController:SetSelectedState("show")
						arg_83_1.musicAnimator_:Play("open", 0, 0)

						if arg_83_1.settingData.music_time ~= 0 then
							arg_83_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_83_1.settingData.music_time), function()
								if arg_83_1 == nil or isNil(arg_83_1.bgmTxt_) then
									return
								end

								arg_83_1.musicController:SetSelectedState("hide")
								arg_83_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.8 < arg_83_1.time_ and arg_83_1.time_ <= 1.8 + arg_86_0 then
				arg_83_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_dreamland", "")
			end

			if arg_83_1.frameCnt_ <= 1 then
				arg_83_1.dialog_:SetActive(false)
			end

			local var_86_23 = 4
			local var_86_24 = 0.1

			if 4 < arg_83_1.time_ and arg_83_1.time_ <= var_86_23 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				arg_83_1.dialog_:SetActive(true)

				arg_83_1.dialogCg_.alpha = 0

				local var_86_25 = LeanTween.value(arg_83_1.dialog_, 0, 1, 0.3)

				var_86_25:setOnUpdate(LuaHelper.FloatAction(function(arg_88_0)
					arg_83_1.dialogCg_.alpha = arg_88_0
				end))
				var_86_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_83_1.dialog_)
					var_86_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_83_1.duration_ = arg_83_1.duration_ + 0.3

				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_26 = arg_83_1:GetWordFromCfg(420041020)
				local var_86_27 = arg_83_1:FormatText(var_86_26.content)

				arg_83_1.text_.text = var_86_27

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_29 = 4 <= 0 and var_86_24 or var_86_24 * (utf8.len(var_86_27) / 4)

				if (4 <= 0 and var_86_24 or var_86_24 * (utf8.len(var_86_27) / 4)) > 0 and var_86_24 < var_86_29 then
					arg_83_1.talkMaxDuration = var_86_29
					var_86_23 = var_86_23 + 0.3

					if var_86_29 + var_86_23 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_29 + var_86_23
					end
				end

				arg_83_1.text_.text = var_86_27
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041020", "story_v_out_420041.awb") ~= 0 then
					local var_86_30 = manager.audio:GetVoiceLength("story_v_out_420041", "420041020", "story_v_out_420041.awb") / 1000

					if var_86_30 + var_86_23 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_30 + var_86_23
					end

					if var_86_26.prefab_name ~= "" and arg_83_1.actors_[var_86_26.prefab_name] ~= nil then
						local var_86_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_26.prefab_name].transform, "story_v_out_420041", "420041020", "story_v_out_420041.awb")

						arg_83_1:RecordAudio("420041020", var_86_31)
						arg_83_1:RecordAudio("420041020", var_86_31)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_420041", "420041020", "story_v_out_420041.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_420041", "420041020", "story_v_out_420041.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_32 = var_86_23 + 0.3
			local var_86_33 = math.max(var_86_24, arg_83_1.talkMaxDuration)

			if var_86_23 + 0.3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_32 + var_86_33 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_32) / var_86_33

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_32 + var_86_33 and arg_83_1.time_ < var_86_32 + var_86_33 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.79999999701977,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play420041021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 420041021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play420041022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1085ui_story"]) and arg_90_1.var_.characterEffect1085ui_story == nil then
				arg_90_1.var_.characterEffect1085ui_story = arg_90_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1085ui_story"]) then
				if arg_90_1.var_.characterEffect1085ui_story and not isNil(arg_90_1.actors_["1085ui_story"]) then
					arg_90_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_0)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1085ui_story"]) and arg_90_1.var_.characterEffect1085ui_story then
				arg_90_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_93_1 = 0
			local var_93_2 = 0.2

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(420041021).content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 8 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 8)

				if (8 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 8)) > 0 and var_93_2 < var_93_5 then
					arg_90_1.talkMaxDuration = var_93_5

					if var_93_5 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + var_93_1
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_6 = math.max(var_93_2, arg_90_1.talkMaxDuration)

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_6 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_1) / var_93_6

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_1 + var_93_6 and arg_90_1.time_ < var_93_1 + var_93_6 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play420041022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 420041022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play420041023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1085ui_story = arg_94_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_97_0 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 then
				arg_94_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_94_1.time_ - 0) / var_97_0)
				arg_94_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1085ui_story"].transform.position).z)
				arg_94_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["1085ui_story"].transform.localEulerAngles = arg_94_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 then
				arg_94_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_94_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1085ui_story"].transform.position).z)
				arg_94_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["1085ui_story"].transform.localEulerAngles = arg_94_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_97_1 = 0
			local var_97_2 = 1.525

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_3 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(420041022).content)

				arg_94_1.text_.text = var_97_3

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 61 <= 0 and var_97_2 or var_97_2 * (utf8.len(var_97_3) / 61)

				if (61 <= 0 and var_97_2 or var_97_2 * (utf8.len(var_97_3) / 61)) > 0 and var_97_2 < var_97_5 then
					arg_94_1.talkMaxDuration = var_97_5

					if var_97_5 + var_97_1 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + var_97_1
					end
				end

				arg_94_1.text_.text = var_97_3
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_6 = math.max(var_97_2, arg_94_1.talkMaxDuration)

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_6 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_1) / var_97_6

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_1 + var_97_6 and arg_94_1.time_ < var_97_1 + var_97_6 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
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

		arg_94_1:InitPlayNodeList()
	end,
	Play420041023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 420041023
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play420041024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.35

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_1 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(420041023).content)

				arg_98_1.text_.text = var_101_1

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_3 = 14 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_1) / 14)

				if (14 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_1) / 14)) > 0 and var_101_0 < var_101_3 then
					arg_98_1.talkMaxDuration = var_101_3

					if var_101_3 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_3 + 0
					end
				end

				arg_98_1.text_.text = var_101_1
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_4 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_4

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play420041024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 420041024
		arg_102_1.duration_ = 4.63

		local var_102_0 = {
			zh = 3.1,
			ja = 4.633
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play420041025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos404001ui_story = arg_102_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_105_0 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 then
				arg_102_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_102_1.time_ - 0) / var_105_0)
				arg_102_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["404001ui_story"].transform.position).z)
				arg_102_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["404001ui_story"].transform.localEulerAngles = arg_102_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 then
				arg_102_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_102_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["404001ui_story"].transform.position).z)
				arg_102_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["404001ui_story"].transform.localEulerAngles = arg_102_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_105_1 = arg_102_1.actors_["404001ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect404001ui_story == nil then
				arg_102_1.var_.characterEffect404001ui_story = var_105_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_2 and not isNil(var_105_1) then
				if arg_102_1.var_.characterEffect404001ui_story and not isNil(var_105_1) then
					arg_102_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_2 and arg_102_1.time_ < 0 + var_105_2 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect404001ui_story then
				arg_102_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_105_4 = 0
			local var_105_5 = 0.35

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_6 = arg_102_1:GetWordFromCfg(420041024)
				local var_105_7 = arg_102_1:FormatText(var_105_6.content)

				arg_102_1.text_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 14 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 14)

				if (14 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 14)) > 0 and var_105_5 < var_105_9 then
					arg_102_1.talkMaxDuration = var_105_9

					if var_105_9 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_4
					end
				end

				arg_102_1.text_.text = var_105_7
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041024", "story_v_out_420041.awb") ~= 0 then
					local var_105_10 = manager.audio:GetVoiceLength("story_v_out_420041", "420041024", "story_v_out_420041.awb") / 1000

					if var_105_10 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_4
					end

					if var_105_6.prefab_name ~= "" and arg_102_1.actors_[var_105_6.prefab_name] ~= nil then
						local var_105_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_6.prefab_name].transform, "story_v_out_420041", "420041024", "story_v_out_420041.awb")

						arg_102_1:RecordAudio("420041024", var_105_11)
						arg_102_1:RecordAudio("420041024", var_105_11)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_420041", "420041024", "story_v_out_420041.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_420041", "420041024", "story_v_out_420041.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_12 = math.max(var_105_5, arg_102_1.talkMaxDuration)

			if var_105_4 <= arg_102_1.time_ and arg_102_1.time_ < var_105_4 + var_105_12 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_4) / var_105_12

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_4 + var_105_12 and arg_102_1.time_ < var_105_4 + var_105_12 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play420041025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 420041025
		arg_106_1.duration_ = 2.57

		local var_106_0 = {
			zh = 2.133,
			ja = 2.566
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play420041026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos404001ui_story = arg_106_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_109_0 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 then
				arg_106_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_106_1.time_ - 0) / var_109_0)
				arg_106_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["404001ui_story"].transform.position).z)
				arg_106_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["404001ui_story"].transform.localEulerAngles = arg_106_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 then
				arg_106_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_106_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["404001ui_story"].transform.position).z)
				arg_106_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["404001ui_story"].transform.localEulerAngles = arg_106_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_109_1 = arg_106_1.actors_["1085ui_story"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1085ui_story = var_109_1.localPosition
			end

			local var_109_2 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_2 then
				var_109_1.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_106_1.time_ - 0) / var_109_2)
				var_109_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_1.position).x, (manager.ui.mainCamera.transform.position - var_109_1.position).y, (manager.ui.mainCamera.transform.position - var_109_1.position).z)
				var_109_1.localEulerAngles.z = 0
				var_109_1.localEulerAngles.x = 0
				var_109_1.localEulerAngles = var_109_1.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_2 and arg_106_1.time_ < 0 + var_109_2 + arg_109_0 then
				var_109_1.localPosition = Vector3.New(0.75, -1.01, -5.83)
				var_109_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_1.position).x, (manager.ui.mainCamera.transform.position - var_109_1.position).y, (manager.ui.mainCamera.transform.position - var_109_1.position).z)
				var_109_1.localEulerAngles.z = 0
				var_109_1.localEulerAngles.x = 0
				var_109_1.localEulerAngles = var_109_1.localEulerAngles
			end

			local var_109_3 = arg_106_1.actors_["1085ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_3) and arg_106_1.var_.characterEffect1085ui_story == nil then
				arg_106_1.var_.characterEffect1085ui_story = var_109_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_4 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_4 and not isNil(var_109_3) then
				if arg_106_1.var_.characterEffect1085ui_story and not isNil(var_109_3) then
					arg_106_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_4 and arg_106_1.time_ < 0 + var_109_4 + arg_109_0 and not isNil(var_109_3) and arg_106_1.var_.characterEffect1085ui_story then
				arg_106_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_109_6 = arg_106_1.actors_["404001ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_6) and arg_106_1.var_.characterEffect404001ui_story == nil then
				arg_106_1.var_.characterEffect404001ui_story = var_109_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_7 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 and not isNil(var_109_6) then
				if arg_106_1.var_.characterEffect404001ui_story and not isNil(var_109_6) then
					arg_106_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_106_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_7)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 and not isNil(var_109_6) and arg_106_1.var_.characterEffect404001ui_story then
				arg_106_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_106_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_109_8 = 0
			local var_109_9 = 0.175

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_8 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_10 = arg_106_1:GetWordFromCfg(420041025)
				local var_109_11 = arg_106_1:FormatText(var_109_10.content)

				arg_106_1.text_.text = var_109_11

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_13 = 7 <= 0 and var_109_9 or var_109_9 * (utf8.len(var_109_11) / 7)

				if (7 <= 0 and var_109_9 or var_109_9 * (utf8.len(var_109_11) / 7)) > 0 and var_109_9 < var_109_13 then
					arg_106_1.talkMaxDuration = var_109_13

					if var_109_13 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_13 + var_109_8
					end
				end

				arg_106_1.text_.text = var_109_11
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041025", "story_v_out_420041.awb") ~= 0 then
					local var_109_14 = manager.audio:GetVoiceLength("story_v_out_420041", "420041025", "story_v_out_420041.awb") / 1000

					if var_109_14 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_14 + var_109_8
					end

					if var_109_10.prefab_name ~= "" and arg_106_1.actors_[var_109_10.prefab_name] ~= nil then
						local var_109_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_10.prefab_name].transform, "story_v_out_420041", "420041025", "story_v_out_420041.awb")

						arg_106_1:RecordAudio("420041025", var_109_15)
						arg_106_1:RecordAudio("420041025", var_109_15)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_420041", "420041025", "story_v_out_420041.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_420041", "420041025", "story_v_out_420041.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_16 = math.max(var_109_9, arg_106_1.talkMaxDuration)

			if var_109_8 <= arg_106_1.time_ and arg_106_1.time_ < var_109_8 + var_109_16 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_8) / var_109_16

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_8 + var_109_16 and arg_106_1.time_ < var_109_8 + var_109_16 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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

		arg_106_1:InitPlayNodeList()
	end,
	Play420041026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 420041026
		arg_110_1.duration_ = 16.47

		local var_110_0 = {
			zh = 9.833,
			ja = 16.466
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play420041027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["404001ui_story"]) and arg_110_1.var_.characterEffect404001ui_story == nil then
				arg_110_1.var_.characterEffect404001ui_story = arg_110_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["404001ui_story"]) then
				if arg_110_1.var_.characterEffect404001ui_story and not isNil(arg_110_1.actors_["404001ui_story"]) then
					arg_110_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["404001ui_story"]) and arg_110_1.var_.characterEffect404001ui_story then
				arg_110_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_113_2 = arg_110_1.actors_["1085ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.characterEffect1085ui_story == nil then
				arg_110_1.var_.characterEffect1085ui_story = var_113_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_3 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_3 and not isNil(var_113_2) then
				if arg_110_1.var_.characterEffect1085ui_story and not isNil(var_113_2) then
					arg_110_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_3)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_3 and arg_110_1.time_ < 0 + var_113_3 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.characterEffect1085ui_story then
				arg_110_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_113_4 = 0
			local var_113_5 = 1.25

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_6 = arg_110_1:GetWordFromCfg(420041026)
				local var_113_7 = arg_110_1:FormatText(var_113_6.content)

				arg_110_1.text_.text = var_113_7

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_9 = 50 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 50)

				if (50 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 50)) > 0 and var_113_5 < var_113_9 then
					arg_110_1.talkMaxDuration = var_113_9

					if var_113_9 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_9 + var_113_4
					end
				end

				arg_110_1.text_.text = var_113_7
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041026", "story_v_out_420041.awb") ~= 0 then
					local var_113_10 = manager.audio:GetVoiceLength("story_v_out_420041", "420041026", "story_v_out_420041.awb") / 1000

					if var_113_10 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_10 + var_113_4
					end

					if var_113_6.prefab_name ~= "" and arg_110_1.actors_[var_113_6.prefab_name] ~= nil then
						local var_113_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_6.prefab_name].transform, "story_v_out_420041", "420041026", "story_v_out_420041.awb")

						arg_110_1:RecordAudio("420041026", var_113_11)
						arg_110_1:RecordAudio("420041026", var_113_11)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_420041", "420041026", "story_v_out_420041.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_420041", "420041026", "story_v_out_420041.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_12 = math.max(var_113_5, arg_110_1.talkMaxDuration)

			if var_113_4 <= arg_110_1.time_ and arg_110_1.time_ < var_113_4 + var_113_12 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_4) / var_113_12

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_4 + var_113_12 and arg_110_1.time_ < var_113_4 + var_113_12 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play420041027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 420041027
		arg_114_1.duration_ = 5.3

		local var_114_0 = {
			zh = 2.8,
			ja = 5.3
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play420041028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.325

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_1 = arg_114_1:GetWordFromCfg(420041027)
				local var_117_2 = arg_114_1:FormatText(var_117_1.content)

				arg_114_1.text_.text = var_117_2

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 13 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 13)

				if (13 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 13)) > 0 and var_117_0 < var_117_4 then
					arg_114_1.talkMaxDuration = var_117_4

					if var_117_4 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_4 + 0
					end
				end

				arg_114_1.text_.text = var_117_2
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041027", "story_v_out_420041.awb") ~= 0 then
					local var_117_5 = manager.audio:GetVoiceLength("story_v_out_420041", "420041027", "story_v_out_420041.awb") / 1000

					if var_117_5 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + 0
					end

					if var_117_1.prefab_name ~= "" and arg_114_1.actors_[var_117_1.prefab_name] ~= nil then
						local var_117_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_1.prefab_name].transform, "story_v_out_420041", "420041027", "story_v_out_420041.awb")

						arg_114_1:RecordAudio("420041027", var_117_6)
						arg_114_1:RecordAudio("420041027", var_117_6)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_420041", "420041027", "story_v_out_420041.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_420041", "420041027", "story_v_out_420041.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_7 and arg_114_1.time_ < 0 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play420041028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 420041028
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play420041029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos404001ui_story = arg_118_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_121_0 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 then
				arg_118_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_118_1.time_ - 0) / var_121_0)
				arg_118_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["404001ui_story"].transform.position).z)
				arg_118_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["404001ui_story"].transform.localEulerAngles = arg_118_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 then
				arg_118_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_118_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["404001ui_story"].transform.position).z)
				arg_118_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["404001ui_story"].transform.localEulerAngles = arg_118_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_121_1 = arg_118_1.actors_["1085ui_story"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1085ui_story = var_121_1.localPosition
			end

			local var_121_2 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_2 then
				var_121_1.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_118_1.time_ - 0) / var_121_2)
				var_121_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_1.position).x, (manager.ui.mainCamera.transform.position - var_121_1.position).y, (manager.ui.mainCamera.transform.position - var_121_1.position).z)
				var_121_1.localEulerAngles.z = 0
				var_121_1.localEulerAngles.x = 0
				var_121_1.localEulerAngles = var_121_1.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_2 and arg_118_1.time_ < 0 + var_121_2 + arg_121_0 then
				var_121_1.localPosition = Vector3.New(0, 100, 0)
				var_121_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_1.position).x, (manager.ui.mainCamera.transform.position - var_121_1.position).y, (manager.ui.mainCamera.transform.position - var_121_1.position).z)
				var_121_1.localEulerAngles.z = 0
				var_121_1.localEulerAngles.x = 0
				var_121_1.localEulerAngles = var_121_1.localEulerAngles
			end

			local var_121_3 = 0
			local var_121_4 = 1.675

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_3 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_5 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(420041028).content)

				arg_118_1.text_.text = var_121_5

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_7 = 67 <= 0 and var_121_4 or var_121_4 * (utf8.len(var_121_5) / 67)

				if (67 <= 0 and var_121_4 or var_121_4 * (utf8.len(var_121_5) / 67)) > 0 and var_121_4 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_3 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_3
					end
				end

				arg_118_1.text_.text = var_121_5
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_8 = math.max(var_121_4, arg_118_1.talkMaxDuration)

			if var_121_3 <= arg_118_1.time_ and arg_118_1.time_ < var_121_3 + var_121_8 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_3) / var_121_8

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_3 + var_121_8 and arg_118_1.time_ < var_121_3 + var_121_8 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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

		arg_118_1:InitPlayNodeList()
	end,
	Play420041029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 420041029
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play420041030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0.05 < arg_122_1.time_ and arg_122_1.time_ <= 0.05 + arg_125_0 then
				arg_122_1:AudioAction("play", "effect", "se_story_140", "se_story_140_carhorn", "")
			end

			local var_125_1 = 0
			local var_125_2 = 0.975

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_3 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(420041029).content)

				arg_122_1.text_.text = var_125_3

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 39 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_3) / 39)

				if (39 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_3) / 39)) > 0 and var_125_2 < var_125_5 then
					arg_122_1.talkMaxDuration = var_125_5

					if var_125_5 + var_125_1 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_5 + var_125_1
					end
				end

				arg_122_1.text_.text = var_125_3
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_6 = math.max(var_125_2, arg_122_1.talkMaxDuration)

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_6 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_1) / var_125_6

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_1 + var_125_6 and arg_122_1.time_ < var_125_1 + var_125_6 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play420041030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 420041030
		arg_126_1.duration_ = 4

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play420041031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_129_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_126_1.bgmTxt_.text ~= var_129_2 and arg_126_1.bgmTxt_.text ~= "" then
						if arg_126_1.bgmTxt2_.text ~= "" then
							arg_126_1.bgmTxt_.text = arg_126_1.bgmTxt2_.text
						end

						arg_126_1.bgmTxt2_.text = var_129_2

						arg_126_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_126_1.bgmTxt_.text = var_129_2
						arg_126_1.bgmTxt2_.text = var_129_2
					end

					if arg_126_1.bgmTimer then
						arg_126_1.bgmTimer:Stop()

						arg_126_1.bgmTimer = nil
					end

					if arg_126_1.settingData.show_music_name == 1 then
						arg_126_1.musicController:SetSelectedState("show")
						arg_126_1.musicAnimator_:Play("open", 0, 0)

						if arg_126_1.settingData.music_time ~= 0 then
							arg_126_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_126_1.settingData.music_time), function()
								if arg_126_1 == nil or isNil(arg_126_1.bgmTxt_) then
									return
								end

								arg_126_1.musicController:SetSelectedState("hide")
								arg_126_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2.7 < arg_126_1.time_ and arg_126_1.time_ <= 2.7 + arg_129_0 then
				arg_126_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_129_5 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_126_1.bgmTxt_.text ~= var_129_5 and arg_126_1.bgmTxt_.text ~= "" then
						if arg_126_1.bgmTxt2_.text ~= "" then
							arg_126_1.bgmTxt_.text = arg_126_1.bgmTxt2_.text
						end

						arg_126_1.bgmTxt2_.text = var_129_5

						arg_126_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_126_1.bgmTxt_.text = var_129_5
						arg_126_1.bgmTxt2_.text = var_129_5
					end

					if arg_126_1.bgmTimer then
						arg_126_1.bgmTimer:Stop()

						arg_126_1.bgmTimer = nil
					end

					if arg_126_1.settingData.show_music_name == 1 then
						arg_126_1.musicController:SetSelectedState("show")
						arg_126_1.musicAnimator_:Play("open", 0, 0)

						if arg_126_1.settingData.music_time ~= 0 then
							arg_126_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_126_1.settingData.music_time), function()
								if arg_126_1 == nil or isNil(arg_126_1.bgmTxt_) then
									return
								end

								arg_126_1.musicController:SetSelectedState("hide")
								arg_126_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.05 < arg_126_1.time_ and arg_126_1.time_ <= 0.05 + arg_129_0 then
				arg_126_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car_hit", "")
			end

			local var_129_7 = manager.ui.mainCamera.transform

			if 1.86666666666667 < arg_126_1.time_ and arg_126_1.time_ <= 1.86666666666667 + arg_129_0 then
				arg_126_1.var_.shakeOldPos = var_129_7.localPosition
			end

			local var_129_8 = 0.833333333333333

			if 1.86666666666667 <= arg_126_1.time_ and arg_126_1.time_ < 1.86666666666667 + var_129_8 then
				local var_129_9, var_129_10 = math.modf((arg_126_1.time_ - 1.86666666666667) / 0.066)

				var_129_7.localPosition = Vector3.New(var_129_10 * 0.13, var_129_10 * 0.13, var_129_10 * 0.13) + arg_126_1.var_.shakeOldPos
			end

			if arg_126_1.time_ >= 1.86666666666667 + var_129_8 and arg_126_1.time_ < 1.86666666666667 + var_129_8 + arg_129_0 then
				var_129_7.localPosition = arg_126_1.var_.shakeOldPos
			end

			local var_129_11 = manager.ui.mainCamera.transform

			if 1.86666666666667 < arg_126_1.time_ and arg_126_1.time_ <= 1.86666666666667 + arg_129_0 then
				arg_126_1.var_.shakeOldPos = var_129_11.localPosition
			end

			local var_129_12 = 0.333333333333333

			if 1.86666666666667 <= arg_126_1.time_ and arg_126_1.time_ < 1.86666666666667 + var_129_12 then
				local var_129_13, var_129_14 = math.modf((arg_126_1.time_ - 1.86666666666667) / 0.066)

				var_129_11.localPosition = Vector3.New(var_129_14 * 0.13, var_129_14 * 0.13, var_129_14 * 0.13) + arg_126_1.var_.shakeOldPos
			end

			if arg_126_1.time_ >= 1.86666666666667 + var_129_12 and arg_126_1.time_ < 1.86666666666667 + var_129_12 + arg_129_0 then
				var_129_11.localPosition = arg_126_1.var_.shakeOldPos
			end

			local var_129_15 = 0
			local var_129_16 = 0.4

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_15 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_17 = arg_126_1:GetWordFromCfg(420041030)
				local var_129_18 = arg_126_1:FormatText(var_129_17.content)

				arg_126_1.text_.text = var_129_18

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_20 = 16 <= 0 and var_129_16 or var_129_16 * (utf8.len(var_129_18) / 16)

				if (16 <= 0 and var_129_16 or var_129_16 * (utf8.len(var_129_18) / 16)) > 0 and var_129_16 < var_129_20 then
					arg_126_1.talkMaxDuration = var_129_20

					if var_129_20 + var_129_15 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_20 + var_129_15
					end
				end

				arg_126_1.text_.text = var_129_18
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041030", "story_v_out_420041.awb") ~= 0 then
					local var_129_21 = manager.audio:GetVoiceLength("story_v_out_420041", "420041030", "story_v_out_420041.awb") / 1000

					if var_129_21 + var_129_15 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_21 + var_129_15
					end

					if var_129_17.prefab_name ~= "" and arg_126_1.actors_[var_129_17.prefab_name] ~= nil then
						local var_129_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_17.prefab_name].transform, "story_v_out_420041", "420041030", "story_v_out_420041.awb")

						arg_126_1:RecordAudio("420041030", var_129_22)
						arg_126_1:RecordAudio("420041030", var_129_22)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_420041", "420041030", "story_v_out_420041.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_420041", "420041030", "story_v_out_420041.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_23 = math.max(var_129_16, arg_126_1.talkMaxDuration)

			if var_129_15 <= arg_126_1.time_ and arg_126_1.time_ < var_129_15 + var_129_23 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_15) / var_129_23

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_15 + var_129_23 and arg_126_1.time_ < var_129_15 + var_129_23 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play420041031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 420041031
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play420041032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 1.125

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_1 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(420041031).content)

				arg_132_1.text_.text = var_135_1

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_3 = 45 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_1) / 45)

				if (45 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_1) / 45)) > 0 and var_135_0 < var_135_3 then
					arg_132_1.talkMaxDuration = var_135_3

					if var_135_3 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_3 + 0
					end
				end

				arg_132_1.text_.text = var_135_1
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_4 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_4 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_4

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_4 and arg_132_1.time_ < 0 + var_135_4 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play420041032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 420041032
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play420041033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0.05 < arg_136_1.time_ and arg_136_1.time_ <= 0.05 + arg_139_0 then
				arg_136_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car01", "")
			end

			local var_139_1 = 0
			local var_139_2 = 1.125

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_3 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(420041032).content)

				arg_136_1.text_.text = var_139_3

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 45 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 45)

				if (45 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 45)) > 0 and var_139_2 < var_139_5 then
					arg_136_1.talkMaxDuration = var_139_5

					if var_139_5 + var_139_1 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + var_139_1
					end
				end

				arg_136_1.text_.text = var_139_3
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_6 = math.max(var_139_2, arg_136_1.talkMaxDuration)

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_6 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_1) / var_139_6

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_1 + var_139_6 and arg_136_1.time_ < var_139_1 + var_139_6 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play420041033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 420041033
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play420041034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0.05 < arg_140_1.time_ and arg_140_1.time_ <= 0.05 + arg_143_0 then
				arg_140_1:AudioAction("play", "effect", "se_story_140", "se_story_140_surround", "")
			end

			local var_143_1 = 0
			local var_143_2 = 1.325

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_3 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(420041033).content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 53 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 53)

				if (53 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 53)) > 0 and var_143_2 < var_143_5 then
					arg_140_1.talkMaxDuration = var_143_5

					if var_143_5 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + var_143_1
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_6 = math.max(var_143_2, arg_140_1.talkMaxDuration)

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_6 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_1) / var_143_6

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_1 + var_143_6 and arg_140_1.time_ < var_143_1 + var_143_6 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play420041034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 420041034
		arg_144_1.duration_ = 5

		local var_144_0 = {
			zh = 4.5,
			ja = 5
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play420041035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.55

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1159].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2124")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_1 = arg_144_1:GetWordFromCfg(420041034)
				local var_147_2 = arg_144_1:FormatText(var_147_1.content)

				arg_144_1.text_.text = var_147_2

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 22 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 22)

				if (22 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 22)) > 0 and var_147_0 < var_147_4 then
					arg_144_1.talkMaxDuration = var_147_4

					if var_147_4 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_4 + 0
					end
				end

				arg_144_1.text_.text = var_147_2
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041034", "story_v_out_420041.awb") ~= 0 then
					local var_147_5 = manager.audio:GetVoiceLength("story_v_out_420041", "420041034", "story_v_out_420041.awb") / 1000

					if var_147_5 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + 0
					end

					if var_147_1.prefab_name ~= "" and arg_144_1.actors_[var_147_1.prefab_name] ~= nil then
						local var_147_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_1.prefab_name].transform, "story_v_out_420041", "420041034", "story_v_out_420041.awb")

						arg_144_1:RecordAudio("420041034", var_147_6)
						arg_144_1:RecordAudio("420041034", var_147_6)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_420041", "420041034", "story_v_out_420041.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_420041", "420041034", "story_v_out_420041.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_7 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play420041035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 420041035
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play420041036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0.200000002980232 < arg_148_1.time_ and arg_148_1.time_ <= 0.200000002980232 + arg_151_0 then
				arg_148_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car_door", "")
			end

			local var_151_1 = 0
			local var_151_2 = 1.325

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_3 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(420041035).content)

				arg_148_1.text_.text = var_151_3

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 53 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_3) / 53)

				if (53 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_3) / 53)) > 0 and var_151_2 < var_151_5 then
					arg_148_1.talkMaxDuration = var_151_5

					if var_151_5 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + var_151_1
					end
				end

				arg_148_1.text_.text = var_151_3
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_6 = math.max(var_151_2, arg_148_1.talkMaxDuration)

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_6 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_1) / var_151_6

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_1 + var_151_6 and arg_148_1.time_ < var_151_1 + var_151_6 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play420041036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 420041036
		arg_152_1.duration_ = 9.67

		local var_152_0 = {
			zh = 6.866,
			ja = 9.666
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play420041037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0.95

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1159].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2124")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_1 = arg_152_1:GetWordFromCfg(420041036)
				local var_155_2 = arg_152_1:FormatText(var_155_1.content)

				arg_152_1.text_.text = var_155_2

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_4 = 38 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 38)

				if (38 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 38)) > 0 and var_155_0 < var_155_4 then
					arg_152_1.talkMaxDuration = var_155_4

					if var_155_4 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_4 + 0
					end
				end

				arg_152_1.text_.text = var_155_2
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041036", "story_v_out_420041.awb") ~= 0 then
					local var_155_5 = manager.audio:GetVoiceLength("story_v_out_420041", "420041036", "story_v_out_420041.awb") / 1000

					if var_155_5 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + 0
					end

					if var_155_1.prefab_name ~= "" and arg_152_1.actors_[var_155_1.prefab_name] ~= nil then
						local var_155_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_1.prefab_name].transform, "story_v_out_420041", "420041036", "story_v_out_420041.awb")

						arg_152_1:RecordAudio("420041036", var_155_6)
						arg_152_1:RecordAudio("420041036", var_155_6)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_420041", "420041036", "story_v_out_420041.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_420041", "420041036", "story_v_out_420041.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_7 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_7 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_7

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_7 and arg_152_1.time_ < 0 + var_155_7 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play420041037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 420041037
		arg_156_1.duration_ = 10.57

		local var_156_0 = {
			zh = 6.333,
			ja = 10.566
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play420041038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0.675

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[238].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_1 = arg_156_1:GetWordFromCfg(420041037)
				local var_159_2 = arg_156_1:FormatText(var_159_1.content)

				arg_156_1.text_.text = var_159_2

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_4 = 27 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 27)

				if (27 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 27)) > 0 and var_159_0 < var_159_4 then
					arg_156_1.talkMaxDuration = var_159_4

					if var_159_4 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_4 + 0
					end
				end

				arg_156_1.text_.text = var_159_2
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041037", "story_v_out_420041.awb") ~= 0 then
					local var_159_5 = manager.audio:GetVoiceLength("story_v_out_420041", "420041037", "story_v_out_420041.awb") / 1000

					if var_159_5 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + 0
					end

					if var_159_1.prefab_name ~= "" and arg_156_1.actors_[var_159_1.prefab_name] ~= nil then
						local var_159_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_1.prefab_name].transform, "story_v_out_420041", "420041037", "story_v_out_420041.awb")

						arg_156_1:RecordAudio("420041037", var_159_6)
						arg_156_1:RecordAudio("420041037", var_159_6)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_420041", "420041037", "story_v_out_420041.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_420041", "420041037", "story_v_out_420041.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_7 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_7 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_7

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_7 and arg_156_1.time_ < 0 + var_159_7 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play420041038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 420041038
		arg_160_1.duration_ = 10.4

		local var_160_0 = {
			zh = 7.066,
			ja = 10.4
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play420041039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.9

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[1159].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2124")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_1 = arg_160_1:GetWordFromCfg(420041038)
				local var_163_2 = arg_160_1:FormatText(var_163_1.content)

				arg_160_1.text_.text = var_163_2

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_4 = 36 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 36)

				if (36 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 36)) > 0 and var_163_0 < var_163_4 then
					arg_160_1.talkMaxDuration = var_163_4

					if var_163_4 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_4 + 0
					end
				end

				arg_160_1.text_.text = var_163_2
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041038", "story_v_out_420041.awb") ~= 0 then
					local var_163_5 = manager.audio:GetVoiceLength("story_v_out_420041", "420041038", "story_v_out_420041.awb") / 1000

					if var_163_5 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + 0
					end

					if var_163_1.prefab_name ~= "" and arg_160_1.actors_[var_163_1.prefab_name] ~= nil then
						local var_163_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_1.prefab_name].transform, "story_v_out_420041", "420041038", "story_v_out_420041.awb")

						arg_160_1:RecordAudio("420041038", var_163_6)
						arg_160_1:RecordAudio("420041038", var_163_6)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_420041", "420041038", "story_v_out_420041.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_420041", "420041038", "story_v_out_420041.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_7 = math.max(var_163_0, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_7 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - 0) / var_163_7

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_7 and arg_160_1.time_ < 0 + var_163_7 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play420041039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 420041039
		arg_164_1.duration_ = 6.63

		local var_164_0 = {
			zh = 4.066,
			ja = 6.633
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play420041040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0.575

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[1159].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2124")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_1 = arg_164_1:GetWordFromCfg(420041039)
				local var_167_2 = arg_164_1:FormatText(var_167_1.content)

				arg_164_1.text_.text = var_167_2

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_4 = 23 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 23)

				if (23 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 23)) > 0 and var_167_0 < var_167_4 then
					arg_164_1.talkMaxDuration = var_167_4

					if var_167_4 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_4 + 0
					end
				end

				arg_164_1.text_.text = var_167_2
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041039", "story_v_out_420041.awb") ~= 0 then
					local var_167_5 = manager.audio:GetVoiceLength("story_v_out_420041", "420041039", "story_v_out_420041.awb") / 1000

					if var_167_5 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + 0
					end

					if var_167_1.prefab_name ~= "" and arg_164_1.actors_[var_167_1.prefab_name] ~= nil then
						local var_167_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_1.prefab_name].transform, "story_v_out_420041", "420041039", "story_v_out_420041.awb")

						arg_164_1:RecordAudio("420041039", var_167_6)
						arg_164_1:RecordAudio("420041039", var_167_6)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_420041", "420041039", "story_v_out_420041.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_420041", "420041039", "story_v_out_420041.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_7 = math.max(var_167_0, arg_164_1.talkMaxDuration)

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_7 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - 0) / var_167_7

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= 0 + var_167_7 and arg_164_1.time_ < 0 + var_167_7 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play420041040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 420041040
		arg_168_1.duration_ = 3.37

		local var_168_0 = {
			zh = 2.866,
			ja = 3.366
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play420041041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1085ui_story = arg_168_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_171_0 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 then
				arg_168_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_168_1.time_ - 0) / var_171_0)
				arg_168_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1085ui_story"].transform.position).z)
				arg_168_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1085ui_story"].transform.localEulerAngles = arg_168_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 then
				arg_168_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_168_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1085ui_story"].transform.position).z)
				arg_168_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1085ui_story"].transform.localEulerAngles = arg_168_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_171_1 = arg_168_1.actors_["1085ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect1085ui_story == nil then
				arg_168_1.var_.characterEffect1085ui_story = var_171_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_2 and not isNil(var_171_1) then
				if arg_168_1.var_.characterEffect1085ui_story and not isNil(var_171_1) then
					arg_168_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_2 and arg_168_1.time_ < 0 + var_171_2 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect1085ui_story then
				arg_168_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_171_4 = 0

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1.allBtn_.enabled = false
			end

			if arg_168_1.time_ >= var_171_4 + 1 and arg_168_1.time_ < var_171_4 + 1 + arg_171_0 then
				arg_168_1.allBtn_.enabled = true
			end

			local var_171_5 = 0
			local var_171_6 = 0.2

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_5 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_7 = arg_168_1:GetWordFromCfg(420041040)
				local var_171_8 = arg_168_1:FormatText(var_171_7.content)

				arg_168_1.text_.text = var_171_8

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_10 = 8 <= 0 and var_171_6 or var_171_6 * (utf8.len(var_171_8) / 8)

				if (8 <= 0 and var_171_6 or var_171_6 * (utf8.len(var_171_8) / 8)) > 0 and var_171_6 < var_171_10 then
					arg_168_1.talkMaxDuration = var_171_10

					if var_171_10 + var_171_5 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_10 + var_171_5
					end
				end

				arg_168_1.text_.text = var_171_8
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041040", "story_v_out_420041.awb") ~= 0 then
					local var_171_11 = manager.audio:GetVoiceLength("story_v_out_420041", "420041040", "story_v_out_420041.awb") / 1000

					if var_171_11 + var_171_5 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_11 + var_171_5
					end

					if var_171_7.prefab_name ~= "" and arg_168_1.actors_[var_171_7.prefab_name] ~= nil then
						local var_171_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_7.prefab_name].transform, "story_v_out_420041", "420041040", "story_v_out_420041.awb")

						arg_168_1:RecordAudio("420041040", var_171_12)
						arg_168_1:RecordAudio("420041040", var_171_12)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_420041", "420041040", "story_v_out_420041.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_420041", "420041040", "story_v_out_420041.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_13 = math.max(var_171_6, arg_168_1.talkMaxDuration)

			if var_171_5 <= arg_168_1.time_ and arg_168_1.time_ < var_171_5 + var_171_13 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_5) / var_171_13

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_5 + var_171_13 and arg_168_1.time_ < var_171_5 + var_171_13 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
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

		arg_168_1:InitPlayNodeList()
	end,
	Play420041041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 420041041
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play420041042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["1085ui_story"]) and arg_172_1.var_.characterEffect1085ui_story == nil then
				arg_172_1.var_.characterEffect1085ui_story = arg_172_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["1085ui_story"]) then
				if arg_172_1.var_.characterEffect1085ui_story and not isNil(arg_172_1.actors_["1085ui_story"]) then
					arg_172_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_0)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["1085ui_story"]) and arg_172_1.var_.characterEffect1085ui_story then
				arg_172_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_175_1 = 0
			local var_175_2 = 1.3

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_3 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(420041041).content)

				arg_172_1.text_.text = var_175_3

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 52 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 52)

				if (52 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 52)) > 0 and var_175_2 < var_175_5 then
					arg_172_1.talkMaxDuration = var_175_5

					if var_175_5 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + var_175_1
					end
				end

				arg_172_1.text_.text = var_175_3
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_6 = math.max(var_175_2, arg_172_1.talkMaxDuration)

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_6 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_1) / var_175_6

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_1 + var_175_6 and arg_172_1.time_ < var_175_1 + var_175_6 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play420041042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 420041042
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play420041043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 1 < arg_176_1.time_ and arg_176_1.time_ <= 1 + arg_179_0 then
				arg_176_1.mask_.enabled = true
				arg_176_1.mask_.raycastTarget = true

				arg_176_1:SetGaussion(false)
			end

			local var_179_0 = 0.2

			if 1 <= arg_176_1.time_ and arg_176_1.time_ < 1 + var_179_0 then
				local var_179_1 = Color.New(1, 1, 1)

				var_179_1.a = Mathf.Lerp(1, 0, (arg_176_1.time_ - 1) / var_179_0)
				arg_176_1.mask_.color = var_179_1
			end

			if arg_176_1.time_ >= 1 + var_179_0 and arg_176_1.time_ < 1 + var_179_0 + arg_179_0 then
				local var_179_2 = Color.New(1, 1, 1)

				arg_176_1.mask_.enabled = false
				var_179_2.a = 0
				arg_176_1.mask_.color = var_179_2
			end

			if 1 < arg_176_1.time_ and arg_176_1.time_ <= 1 + arg_179_0 then
				arg_176_1:AudioAction("play", "effect", "se_story_140", "se_story_140_camera01", "")
			end

			local var_179_4 = arg_176_1.actors_["1085ui_story"].transform

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos1085ui_story = var_179_4.localPosition
			end

			local var_179_5 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_5 then
				var_179_4.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_176_1.time_ - 0) / var_179_5)
				var_179_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_179_4.position).x, (manager.ui.mainCamera.transform.position - var_179_4.position).y, (manager.ui.mainCamera.transform.position - var_179_4.position).z)
				var_179_4.localEulerAngles.z = 0
				var_179_4.localEulerAngles.x = 0
				var_179_4.localEulerAngles = var_179_4.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_5 and arg_176_1.time_ < 0 + var_179_5 + arg_179_0 then
				var_179_4.localPosition = Vector3.New(0, 100, 0)
				var_179_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_179_4.position).x, (manager.ui.mainCamera.transform.position - var_179_4.position).y, (manager.ui.mainCamera.transform.position - var_179_4.position).z)
				var_179_4.localEulerAngles.z = 0
				var_179_4.localEulerAngles.x = 0
				var_179_4.localEulerAngles = var_179_4.localEulerAngles
			end

			local var_179_6 = 0
			local var_179_7 = 1.5

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_6 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_8 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(420041042).content)

				arg_176_1.text_.text = var_179_8

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_10 = 60 <= 0 and var_179_7 or var_179_7 * (utf8.len(var_179_8) / 60)

				if (60 <= 0 and var_179_7 or var_179_7 * (utf8.len(var_179_8) / 60)) > 0 and var_179_7 < var_179_10 then
					arg_176_1.talkMaxDuration = var_179_10

					if var_179_10 + var_179_6 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_10 + var_179_6
					end
				end

				arg_176_1.text_.text = var_179_8
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_11 = math.max(var_179_7, arg_176_1.talkMaxDuration)

			if var_179_6 <= arg_176_1.time_ and arg_176_1.time_ < var_179_6 + var_179_11 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_6) / var_179_11

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_6 + var_179_11 and arg_176_1.time_ < var_179_6 + var_179_11 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
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

		arg_176_1:InitPlayNodeList()
	end,
	Play420041043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 420041043
		arg_180_1.duration_ = 4

		local var_180_0 = {
			zh = 1.9,
			ja = 4
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play420041044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0
			local var_183_1 = 0.275

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0

				arg_180_1.dialog_:SetActive(true)

				arg_180_1.dialogCg_.alpha = 0

				local var_183_2 = LeanTween.value(arg_180_1.dialog_, 0, 1, 0.3)

				var_183_2:setOnUpdate(LuaHelper.FloatAction(function(arg_184_0)
					arg_180_1.dialogCg_.alpha = arg_184_0
				end))
				var_183_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_180_1.dialog_)
					var_183_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_180_1.duration_ = arg_180_1.duration_ + 0.3

				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[1159].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2124")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_3 = arg_180_1:GetWordFromCfg(420041043)
				local var_183_4 = arg_180_1:FormatText(var_183_3.content)

				arg_180_1.text_.text = var_183_4

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_6 = 11 <= 0 and var_183_1 or var_183_1 * (utf8.len(var_183_4) / 11)

				if (11 <= 0 and var_183_1 or var_183_1 * (utf8.len(var_183_4) / 11)) > 0 and var_183_1 < var_183_6 then
					arg_180_1.talkMaxDuration = var_183_6
					var_183_0 = var_183_0 + 0.3

					if var_183_6 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_6 + var_183_0
					end
				end

				arg_180_1.text_.text = var_183_4
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041043", "story_v_out_420041.awb") ~= 0 then
					local var_183_7 = manager.audio:GetVoiceLength("story_v_out_420041", "420041043", "story_v_out_420041.awb") / 1000

					if var_183_7 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_7 + var_183_0
					end

					if var_183_3.prefab_name ~= "" and arg_180_1.actors_[var_183_3.prefab_name] ~= nil then
						local var_183_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_3.prefab_name].transform, "story_v_out_420041", "420041043", "story_v_out_420041.awb")

						arg_180_1:RecordAudio("420041043", var_183_8)
						arg_180_1:RecordAudio("420041043", var_183_8)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_420041", "420041043", "story_v_out_420041.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_420041", "420041043", "story_v_out_420041.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_9 = var_183_0 + 0.3
			local var_183_10 = math.max(var_183_1, arg_180_1.talkMaxDuration)

			if var_183_0 + 0.3 <= arg_180_1.time_ and arg_180_1.time_ < var_183_9 + var_183_10 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_9) / var_183_10

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_9 + var_183_10 and arg_180_1.time_ < var_183_9 + var_183_10 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play420041044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 420041044
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play420041045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 1.55

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_1 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(420041044).content)

				arg_186_1.text_.text = var_189_1

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_3 = 62 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 62)

				if (62 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 62)) > 0 and var_189_0 < var_189_3 then
					arg_186_1.talkMaxDuration = var_189_3

					if var_189_3 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_3 + 0
					end
				end

				arg_186_1.text_.text = var_189_1
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_4 = math.max(var_189_0, arg_186_1.talkMaxDuration)

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_4 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - 0) / var_189_4

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= 0 + var_189_4 and arg_186_1.time_ < 0 + var_189_4 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play420041045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 420041045
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play420041046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0.5 < arg_190_1.time_ and arg_190_1.time_ <= 0.5 + arg_193_0 then
				arg_190_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car02", "")
			end

			local var_193_1 = 0
			local var_193_2 = 1.25

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_3 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(420041045).content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 50 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 50)

				if (50 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 50)) > 0 and var_193_2 < var_193_5 then
					arg_190_1.talkMaxDuration = var_193_5

					if var_193_5 + var_193_1 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + var_193_1
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_6 = math.max(var_193_2, arg_190_1.talkMaxDuration)

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_6 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_1) / var_193_6

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_1 + var_193_6 and arg_190_1.time_ < var_193_1 + var_193_6 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play420041046 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 420041046
		arg_194_1.duration_ = 3.9

		local var_194_0 = {
			zh = 3.133,
			ja = 3.9
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play420041047(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if arg_194_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_197_0 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_194_1.stage_.transform)

				var_197_0.name = "10102ui_story"
				var_197_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_194_1.actors_["10102ui_story"] = var_197_0

				local var_197_1 = var_197_0:GetComponentInChildren(typeof(CharacterEffect))

				var_197_1.enabled = true

				local var_197_2 = GameObjectTools.GetOrAddComponent(var_197_0, typeof(DynamicBoneHelper))

				if var_197_2 then
					var_197_2:EnableDynamicBone(false)
				end

				arg_194_1:ShowWeapon(var_197_1.transform, false)

				arg_194_1.var_["10102ui_story" .. "Animator"] = var_197_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_194_1.var_["10102ui_story" .. "Animator"].applyRootMotion = true
				arg_194_1.var_["10102ui_story" .. "LipSync"] = var_197_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_197_3 = arg_194_1.actors_["10102ui_story"].transform

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos10102ui_story = var_197_3.localPosition
			end

			local var_197_4 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_4 then
				var_197_3.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_194_1.time_ - 0) / var_197_4)
				var_197_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_3.position).x, (manager.ui.mainCamera.transform.position - var_197_3.position).y, (manager.ui.mainCamera.transform.position - var_197_3.position).z)
				var_197_3.localEulerAngles.z = 0
				var_197_3.localEulerAngles.x = 0
				var_197_3.localEulerAngles = var_197_3.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_4 and arg_194_1.time_ < 0 + var_197_4 + arg_197_0 then
				var_197_3.localPosition = Vector3.New(0, -0.985, -6.275)
				var_197_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_3.position).x, (manager.ui.mainCamera.transform.position - var_197_3.position).y, (manager.ui.mainCamera.transform.position - var_197_3.position).z)
				var_197_3.localEulerAngles.z = 0
				var_197_3.localEulerAngles.x = 0
				var_197_3.localEulerAngles = var_197_3.localEulerAngles
			end

			local var_197_5 = arg_194_1.actors_["10102ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_5) and arg_194_1.var_.characterEffect10102ui_story == nil then
				arg_194_1.var_.characterEffect10102ui_story = var_197_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_6 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_6 and not isNil(var_197_5) then
				if arg_194_1.var_.characterEffect10102ui_story and not isNil(var_197_5) then
					arg_194_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_6 and arg_194_1.time_ < 0 + var_197_6 + arg_197_0 and not isNil(var_197_5) and arg_194_1.var_.characterEffect10102ui_story then
				arg_194_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action3_1")
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_197_8 = 0
			local var_197_9 = 0.25

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_8 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_10 = arg_194_1:GetWordFromCfg(420041046)
				local var_197_11 = arg_194_1:FormatText(var_197_10.content)

				arg_194_1.text_.text = var_197_11

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_13 = 10 <= 0 and var_197_9 or var_197_9 * (utf8.len(var_197_11) / 10)

				if (10 <= 0 and var_197_9 or var_197_9 * (utf8.len(var_197_11) / 10)) > 0 and var_197_9 < var_197_13 then
					arg_194_1.talkMaxDuration = var_197_13

					if var_197_13 + var_197_8 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_13 + var_197_8
					end
				end

				arg_194_1.text_.text = var_197_11
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041046", "story_v_out_420041.awb") ~= 0 then
					local var_197_14 = manager.audio:GetVoiceLength("story_v_out_420041", "420041046", "story_v_out_420041.awb") / 1000

					if var_197_14 + var_197_8 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_14 + var_197_8
					end

					if var_197_10.prefab_name ~= "" and arg_194_1.actors_[var_197_10.prefab_name] ~= nil then
						local var_197_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_10.prefab_name].transform, "story_v_out_420041", "420041046", "story_v_out_420041.awb")

						arg_194_1:RecordAudio("420041046", var_197_15)
						arg_194_1:RecordAudio("420041046", var_197_15)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_420041", "420041046", "story_v_out_420041.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_420041", "420041046", "story_v_out_420041.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_16 = math.max(var_197_9, arg_194_1.talkMaxDuration)

			if var_197_8 <= arg_194_1.time_ and arg_194_1.time_ < var_197_8 + var_197_16 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_8) / var_197_16

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_8 + var_197_16 and arg_194_1.time_ < var_197_8 + var_197_16 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play420041047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 420041047
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play420041048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos10102ui_story = arg_198_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_201_0 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 then
				arg_198_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_198_1.time_ - 0) / var_201_0)
				arg_198_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["10102ui_story"].transform.position).z)
				arg_198_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["10102ui_story"].transform.localEulerAngles = arg_198_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 then
				arg_198_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_198_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["10102ui_story"].transform.position).z)
				arg_198_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["10102ui_story"].transform.localEulerAngles = arg_198_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_201_1 = 0
			local var_201_2 = 0.25

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
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

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_3 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(420041047).content)

				arg_198_1.text_.text = var_201_3

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 10 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 10)

				if (10 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 10)) > 0 and var_201_2 < var_201_5 then
					arg_198_1.talkMaxDuration = var_201_5

					if var_201_5 + var_201_1 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + var_201_1
					end
				end

				arg_198_1.text_.text = var_201_3
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_6 = math.max(var_201_2, arg_198_1.talkMaxDuration)

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_6 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_1) / var_201_6

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_1 + var_201_6 and arg_198_1.time_ < var_201_1 + var_201_6 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play420041048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 420041048
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play420041049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0.166666666666667 < arg_202_1.time_ and arg_202_1.time_ <= 0.166666666666667 + arg_205_0 then
				arg_202_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_cardoor02", "")
			end

			local var_205_1 = 0
			local var_205_2 = 1.5

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_3 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(420041048).content)

				arg_202_1.text_.text = var_205_3

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_5 = 60 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_3) / 60)

				if (60 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_3) / 60)) > 0 and var_205_2 < var_205_5 then
					arg_202_1.talkMaxDuration = var_205_5

					if var_205_5 + var_205_1 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + var_205_1
					end
				end

				arg_202_1.text_.text = var_205_3
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_6 = math.max(var_205_2, arg_202_1.talkMaxDuration)

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_6 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_1) / var_205_6

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_1 + var_205_6 and arg_202_1.time_ < var_205_1 + var_205_6 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play420041049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 420041049
		arg_206_1.duration_ = 2.6

		local var_206_0 = {
			zh = 1.999999999999,
			ja = 2.6
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play420041050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if arg_206_1.actors_["1056ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1056ui_story"))) then
				local var_209_0 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_206_1.stage_.transform)

				var_209_0.name = "1056ui_story"
				var_209_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_206_1.actors_["1056ui_story"] = var_209_0

				local var_209_1 = var_209_0:GetComponentInChildren(typeof(CharacterEffect))

				var_209_1.enabled = true

				local var_209_2 = GameObjectTools.GetOrAddComponent(var_209_0, typeof(DynamicBoneHelper))

				if var_209_2 then
					var_209_2:EnableDynamicBone(false)
				end

				arg_206_1:ShowWeapon(var_209_1.transform, false)

				arg_206_1.var_["1056ui_story" .. "Animator"] = var_209_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_206_1.var_["1056ui_story" .. "Animator"].applyRootMotion = true
				arg_206_1.var_["1056ui_story" .. "LipSync"] = var_209_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_209_3 = arg_206_1.actors_["1056ui_story"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1056ui_story = var_209_3.localPosition

				arg_206_1:ShowWeapon(arg_206_1.var_["1056ui_story" .. "Animator"].transform, false)
			end

			local var_209_4 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_4 then
				var_209_3.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_206_1.time_ - 0) / var_209_4)
				var_209_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_3.position).x, (manager.ui.mainCamera.transform.position - var_209_3.position).y, (manager.ui.mainCamera.transform.position - var_209_3.position).z)
				var_209_3.localEulerAngles.z = 0
				var_209_3.localEulerAngles.x = 0
				var_209_3.localEulerAngles = var_209_3.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_4 and arg_206_1.time_ < 0 + var_209_4 + arg_209_0 then
				var_209_3.localPosition = Vector3.New(0, -1, -5.75)
				var_209_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_3.position).x, (manager.ui.mainCamera.transform.position - var_209_3.position).y, (manager.ui.mainCamera.transform.position - var_209_3.position).z)
				var_209_3.localEulerAngles.z = 0
				var_209_3.localEulerAngles.x = 0
				var_209_3.localEulerAngles = var_209_3.localEulerAngles
			end

			local var_209_5 = arg_206_1.actors_["1056ui_story"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_5) and arg_206_1.var_.characterEffect1056ui_story == nil then
				arg_206_1.var_.characterEffect1056ui_story = var_209_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_6 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_6 and not isNil(var_209_5) then
				if arg_206_1.var_.characterEffect1056ui_story and not isNil(var_209_5) then
					arg_206_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_6 and arg_206_1.time_ < 0 + var_209_6 + arg_209_0 and not isNil(var_209_5) and arg_206_1.var_.characterEffect1056ui_story then
				arg_206_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_209_8 = 0
			local var_209_9 = 0.175

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_8 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_10 = arg_206_1:GetWordFromCfg(420041049)
				local var_209_11 = arg_206_1:FormatText(var_209_10.content)

				arg_206_1.text_.text = var_209_11

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_13 = 7 <= 0 and var_209_9 or var_209_9 * (utf8.len(var_209_11) / 7)

				if (7 <= 0 and var_209_9 or var_209_9 * (utf8.len(var_209_11) / 7)) > 0 and var_209_9 < var_209_13 then
					arg_206_1.talkMaxDuration = var_209_13

					if var_209_13 + var_209_8 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_13 + var_209_8
					end
				end

				arg_206_1.text_.text = var_209_11
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041049", "story_v_out_420041.awb") ~= 0 then
					local var_209_14 = manager.audio:GetVoiceLength("story_v_out_420041", "420041049", "story_v_out_420041.awb") / 1000

					if var_209_14 + var_209_8 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_14 + var_209_8
					end

					if var_209_10.prefab_name ~= "" and arg_206_1.actors_[var_209_10.prefab_name] ~= nil then
						local var_209_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_10.prefab_name].transform, "story_v_out_420041", "420041049", "story_v_out_420041.awb")

						arg_206_1:RecordAudio("420041049", var_209_15)
						arg_206_1:RecordAudio("420041049", var_209_15)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_420041", "420041049", "story_v_out_420041.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_420041", "420041049", "story_v_out_420041.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_16 = math.max(var_209_9, arg_206_1.talkMaxDuration)

			if var_209_8 <= arg_206_1.time_ and arg_206_1.time_ < var_209_8 + var_209_16 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_8) / var_209_16

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_8 + var_209_16 and arg_206_1.time_ < var_209_8 + var_209_16 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play420041050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 420041050
		arg_210_1.duration_ = 5.27

		local var_210_0 = {
			zh = 4.633,
			ja = 5.266
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play420041051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1056ui_story"]) and arg_210_1.var_.characterEffect1056ui_story == nil then
				arg_210_1.var_.characterEffect1056ui_story = arg_210_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1056ui_story"]) then
				if arg_210_1.var_.characterEffect1056ui_story and not isNil(arg_210_1.actors_["1056ui_story"]) then
					arg_210_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_210_1.time_ - 0) / var_213_0)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1056ui_story"]) and arg_210_1.var_.characterEffect1056ui_story then
				arg_210_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_213_1 = 0
			local var_213_2 = 0.525

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[1159].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2124")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_3 = arg_210_1:GetWordFromCfg(420041050)
				local var_213_4 = arg_210_1:FormatText(var_213_3.content)

				arg_210_1.text_.text = var_213_4

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_6 = 21 <= 0 and var_213_2 or var_213_2 * (utf8.len(var_213_4) / 21)

				if (21 <= 0 and var_213_2 or var_213_2 * (utf8.len(var_213_4) / 21)) > 0 and var_213_2 < var_213_6 then
					arg_210_1.talkMaxDuration = var_213_6

					if var_213_6 + var_213_1 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_6 + var_213_1
					end
				end

				arg_210_1.text_.text = var_213_4
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041050", "story_v_out_420041.awb") ~= 0 then
					local var_213_7 = manager.audio:GetVoiceLength("story_v_out_420041", "420041050", "story_v_out_420041.awb") / 1000

					if var_213_7 + var_213_1 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_1
					end

					if var_213_3.prefab_name ~= "" and arg_210_1.actors_[var_213_3.prefab_name] ~= nil then
						local var_213_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_3.prefab_name].transform, "story_v_out_420041", "420041050", "story_v_out_420041.awb")

						arg_210_1:RecordAudio("420041050", var_213_8)
						arg_210_1:RecordAudio("420041050", var_213_8)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_420041", "420041050", "story_v_out_420041.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_420041", "420041050", "story_v_out_420041.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_9 = math.max(var_213_2, arg_210_1.talkMaxDuration)

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_9 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_1) / var_213_9

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_1 + var_213_9 and arg_210_1.time_ < var_213_1 + var_213_9 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play420041051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 420041051
		arg_214_1.duration_ = 9.5

		local var_214_0 = {
			zh = 6.966,
			ja = 9.5
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play420041052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["1056ui_story"]) and arg_214_1.var_.characterEffect1056ui_story == nil then
				arg_214_1.var_.characterEffect1056ui_story = arg_214_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["1056ui_story"]) then
				if arg_214_1.var_.characterEffect1056ui_story and not isNil(arg_214_1.actors_["1056ui_story"]) then
					arg_214_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["1056ui_story"]) and arg_214_1.var_.characterEffect1056ui_story then
				arg_214_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_217_2 = arg_214_1.actors_["1056ui_story"].transform

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1056ui_story = var_217_2.localPosition

				arg_214_1:ShowWeapon(arg_214_1.var_["1056ui_story" .. "Animator"].transform, false)
			end

			local var_217_3 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_3 then
				var_217_2.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_214_1.time_ - 0) / var_217_3)
				var_217_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_217_2.position).x, (manager.ui.mainCamera.transform.position - var_217_2.position).y, (manager.ui.mainCamera.transform.position - var_217_2.position).z)
				var_217_2.localEulerAngles.z = 0
				var_217_2.localEulerAngles.x = 0
				var_217_2.localEulerAngles = var_217_2.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_3 and arg_214_1.time_ < 0 + var_217_3 + arg_217_0 then
				var_217_2.localPosition = Vector3.New(0, -1, -5.75)
				var_217_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_217_2.position).x, (manager.ui.mainCamera.transform.position - var_217_2.position).y, (manager.ui.mainCamera.transform.position - var_217_2.position).z)
				var_217_2.localEulerAngles.z = 0
				var_217_2.localEulerAngles.x = 0
				var_217_2.localEulerAngles = var_217_2.localEulerAngles
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action7_1")
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_217_4 = 0
			local var_217_5 = 0.775

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_4 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_6 = arg_214_1:GetWordFromCfg(420041051)
				local var_217_7 = arg_214_1:FormatText(var_217_6.content)

				arg_214_1.text_.text = var_217_7

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_9 = 31 <= 0 and var_217_5 or var_217_5 * (utf8.len(var_217_7) / 31)

				if (31 <= 0 and var_217_5 or var_217_5 * (utf8.len(var_217_7) / 31)) > 0 and var_217_5 < var_217_9 then
					arg_214_1.talkMaxDuration = var_217_9

					if var_217_9 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_9 + var_217_4
					end
				end

				arg_214_1.text_.text = var_217_7
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041051", "story_v_out_420041.awb") ~= 0 then
					local var_217_10 = manager.audio:GetVoiceLength("story_v_out_420041", "420041051", "story_v_out_420041.awb") / 1000

					if var_217_10 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_10 + var_217_4
					end

					if var_217_6.prefab_name ~= "" and arg_214_1.actors_[var_217_6.prefab_name] ~= nil then
						local var_217_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_6.prefab_name].transform, "story_v_out_420041", "420041051", "story_v_out_420041.awb")

						arg_214_1:RecordAudio("420041051", var_217_11)
						arg_214_1:RecordAudio("420041051", var_217_11)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_420041", "420041051", "story_v_out_420041.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_420041", "420041051", "story_v_out_420041.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_12 = math.max(var_217_5, arg_214_1.talkMaxDuration)

			if var_217_4 <= arg_214_1.time_ and arg_214_1.time_ < var_217_4 + var_217_12 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_4) / var_217_12

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_4 + var_217_12 and arg_214_1.time_ < var_217_4 + var_217_12 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play420041052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 420041052
		arg_218_1.duration_ = 7.53

		local var_218_0 = {
			zh = 3.866,
			ja = 7.533
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play420041053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["1056ui_story"]) and arg_218_1.var_.characterEffect1056ui_story == nil then
				arg_218_1.var_.characterEffect1056ui_story = arg_218_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_0 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["1056ui_story"]) then
				if arg_218_1.var_.characterEffect1056ui_story and not isNil(arg_218_1.actors_["1056ui_story"]) then
					arg_218_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_0)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["1056ui_story"]) and arg_218_1.var_.characterEffect1056ui_story then
				arg_218_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_221_1 = 0
			local var_221_2 = 0.4

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[1159].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2124")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_3 = arg_218_1:GetWordFromCfg(420041052)
				local var_221_4 = arg_218_1:FormatText(var_221_3.content)

				arg_218_1.text_.text = var_221_4

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_6 = 16 <= 0 and var_221_2 or var_221_2 * (utf8.len(var_221_4) / 16)

				if (16 <= 0 and var_221_2 or var_221_2 * (utf8.len(var_221_4) / 16)) > 0 and var_221_2 < var_221_6 then
					arg_218_1.talkMaxDuration = var_221_6

					if var_221_6 + var_221_1 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_6 + var_221_1
					end
				end

				arg_218_1.text_.text = var_221_4
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041052", "story_v_out_420041.awb") ~= 0 then
					local var_221_7 = manager.audio:GetVoiceLength("story_v_out_420041", "420041052", "story_v_out_420041.awb") / 1000

					if var_221_7 + var_221_1 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_7 + var_221_1
					end

					if var_221_3.prefab_name ~= "" and arg_218_1.actors_[var_221_3.prefab_name] ~= nil then
						local var_221_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_3.prefab_name].transform, "story_v_out_420041", "420041052", "story_v_out_420041.awb")

						arg_218_1:RecordAudio("420041052", var_221_8)
						arg_218_1:RecordAudio("420041052", var_221_8)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_420041", "420041052", "story_v_out_420041.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_420041", "420041052", "story_v_out_420041.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_9 = math.max(var_221_2, arg_218_1.talkMaxDuration)

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_9 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_1) / var_221_9

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_1 + var_221_9 and arg_218_1.time_ < var_221_1 + var_221_9 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play420041053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 420041053
		arg_222_1.duration_ = 3.97

		local var_222_0 = {
			zh = 3.4,
			ja = 3.966
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play420041054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1056ui_story = arg_222_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_225_0 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 then
				arg_222_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_222_1.time_ - 0) / var_225_0)
				arg_222_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1056ui_story"].transform.position).z)
				arg_222_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1056ui_story"].transform.localEulerAngles = arg_222_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 then
				arg_222_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_222_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1056ui_story"].transform.position).z)
				arg_222_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1056ui_story"].transform.localEulerAngles = arg_222_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_225_1 = arg_222_1.actors_["404001ui_story"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos404001ui_story = var_225_1.localPosition
			end

			local var_225_2 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_2 then
				var_225_1.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_222_1.time_ - 0) / var_225_2)
				var_225_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_1.position).x, (manager.ui.mainCamera.transform.position - var_225_1.position).y, (manager.ui.mainCamera.transform.position - var_225_1.position).z)
				var_225_1.localEulerAngles.z = 0
				var_225_1.localEulerAngles.x = 0
				var_225_1.localEulerAngles = var_225_1.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_2 and arg_222_1.time_ < 0 + var_225_2 + arg_225_0 then
				var_225_1.localPosition = Vector3.New(0, -1.55, -5.5)
				var_225_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_1.position).x, (manager.ui.mainCamera.transform.position - var_225_1.position).y, (manager.ui.mainCamera.transform.position - var_225_1.position).z)
				var_225_1.localEulerAngles.z = 0
				var_225_1.localEulerAngles.x = 0
				var_225_1.localEulerAngles = var_225_1.localEulerAngles
			end

			local var_225_3 = arg_222_1.actors_["404001ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_3) and arg_222_1.var_.characterEffect404001ui_story == nil then
				arg_222_1.var_.characterEffect404001ui_story = var_225_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_4 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 and not isNil(var_225_3) then
				if arg_222_1.var_.characterEffect404001ui_story and not isNil(var_225_3) then
					arg_222_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 and not isNil(var_225_3) and arg_222_1.var_.characterEffect404001ui_story then
				arg_222_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_225_6 = 0
			local var_225_7 = 0.3

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_6 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_8 = arg_222_1:GetWordFromCfg(420041053)
				local var_225_9 = arg_222_1:FormatText(var_225_8.content)

				arg_222_1.text_.text = var_225_9

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_11 = 12 <= 0 and var_225_7 or var_225_7 * (utf8.len(var_225_9) / 12)

				if (12 <= 0 and var_225_7 or var_225_7 * (utf8.len(var_225_9) / 12)) > 0 and var_225_7 < var_225_11 then
					arg_222_1.talkMaxDuration = var_225_11

					if var_225_11 + var_225_6 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_11 + var_225_6
					end
				end

				arg_222_1.text_.text = var_225_9
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041053", "story_v_out_420041.awb") ~= 0 then
					local var_225_12 = manager.audio:GetVoiceLength("story_v_out_420041", "420041053", "story_v_out_420041.awb") / 1000

					if var_225_12 + var_225_6 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_12 + var_225_6
					end

					if var_225_8.prefab_name ~= "" and arg_222_1.actors_[var_225_8.prefab_name] ~= nil then
						local var_225_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_8.prefab_name].transform, "story_v_out_420041", "420041053", "story_v_out_420041.awb")

						arg_222_1:RecordAudio("420041053", var_225_13)
						arg_222_1:RecordAudio("420041053", var_225_13)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_420041", "420041053", "story_v_out_420041.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_420041", "420041053", "story_v_out_420041.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_14 = math.max(var_225_7, arg_222_1.talkMaxDuration)

			if var_225_6 <= arg_222_1.time_ and arg_222_1.time_ < var_225_6 + var_225_14 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_6) / var_225_14

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_6 + var_225_14 and arg_222_1.time_ < var_225_6 + var_225_14 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play420041054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 420041054
		arg_226_1.duration_ = 1

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"

			SetActive(arg_226_1.choicesGo_, true)

			for iter_227_0, iter_227_1 in ipairs(arg_226_1.choices_) do
				SetActive(iter_227_1.go, iter_227_0 <= 1)
			end

			arg_226_1.choices_[1].txt.text = arg_226_1:FormatText(StoryChoiceCfg[1228].name)
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play420041055(arg_226_1)
			end

			arg_226_1:RecordChoiceLog(420041054, 1228)
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["404001ui_story"]) and arg_226_1.var_.characterEffect404001ui_story == nil then
				arg_226_1.var_.characterEffect404001ui_story = arg_226_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_0 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["404001ui_story"]) then
				if arg_226_1.var_.characterEffect404001ui_story and not isNil(arg_226_1.actors_["404001ui_story"]) then
					arg_226_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_226_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_0)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["404001ui_story"]) and arg_226_1.var_.characterEffect404001ui_story then
				arg_226_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_226_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play420041055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 420041055
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play420041056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0.275

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_1 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(420041055).content)

				arg_230_1.text_.text = var_233_1

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_3 = 11 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 11)

				if (11 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 11)) > 0 and var_233_0 < var_233_3 then
					arg_230_1.talkMaxDuration = var_233_3

					if var_233_3 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_3 + 0
					end
				end

				arg_230_1.text_.text = var_233_1
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_4 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_4 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_4

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_4 and arg_230_1.time_ < 0 + var_233_4 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play420041056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 420041056
		arg_234_1.duration_ = 7

		local var_234_0 = {
			zh = 4.366,
			ja = 7
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
			arg_234_1.auto_ = false
		end

		function arg_234_1.playNext_(arg_236_0)
			arg_234_1.onStoryFinished_()
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["404001ui_story"]) and arg_234_1.var_.characterEffect404001ui_story == nil then
				arg_234_1.var_.characterEffect404001ui_story = arg_234_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_0 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["404001ui_story"]) then
				if arg_234_1.var_.characterEffect404001ui_story and not isNil(arg_234_1.actors_["404001ui_story"]) then
					arg_234_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["404001ui_story"]) and arg_234_1.var_.characterEffect404001ui_story then
				arg_234_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_237_2 = 0
			local var_237_3 = 0.475

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_2 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_4 = arg_234_1:GetWordFromCfg(420041056)
				local var_237_5 = arg_234_1:FormatText(var_237_4.content)

				arg_234_1.text_.text = var_237_5

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_7 = 19 <= 0 and var_237_3 or var_237_3 * (utf8.len(var_237_5) / 19)

				if (19 <= 0 and var_237_3 or var_237_3 * (utf8.len(var_237_5) / 19)) > 0 and var_237_3 < var_237_7 then
					arg_234_1.talkMaxDuration = var_237_7

					if var_237_7 + var_237_2 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_7 + var_237_2
					end
				end

				arg_234_1.text_.text = var_237_5
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420041", "420041056", "story_v_out_420041.awb") ~= 0 then
					local var_237_8 = manager.audio:GetVoiceLength("story_v_out_420041", "420041056", "story_v_out_420041.awb") / 1000

					if var_237_8 + var_237_2 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_8 + var_237_2
					end

					if var_237_4.prefab_name ~= "" and arg_234_1.actors_[var_237_4.prefab_name] ~= nil then
						local var_237_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_4.prefab_name].transform, "story_v_out_420041", "420041056", "story_v_out_420041.awb")

						arg_234_1:RecordAudio("420041056", var_237_9)
						arg_234_1:RecordAudio("420041056", var_237_9)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_420041", "420041056", "story_v_out_420041.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_420041", "420041056", "story_v_out_420041.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_10 = math.max(var_237_3, arg_234_1.talkMaxDuration)

			if var_237_2 <= arg_234_1.time_ and arg_234_1.time_ < var_237_2 + var_237_10 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_2) / var_237_10

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_2 + var_237_10 and arg_234_1.time_ < var_237_2 + var_237_10 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L01f",
		"TextureConfig/Background/L16f"
	},
	voices = {
		"story_v_out_420041.awb"
	}
}
