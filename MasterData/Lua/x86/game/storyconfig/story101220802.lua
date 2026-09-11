return {
	Play122082001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 122082001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play122082002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J08f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J08f")
				var_4_0.name = "J08f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J08f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J08f

				arg_1_1.bgs_.J08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J08f" then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if 1.30000000298023 < arg_1_1.time_ and arg_1_1.time_ <= 1.30000000298023 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_2_story_tiantongyinqing", "bgm_activity_2_2_story_tiantongyinqing", "bgm_activity_2_2_story_tiantongyinqing.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_2_story_tiantongyinqing", "bgm_activity_2_2_story_tiantongyinqing")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			local var_4_14 = 2
			local var_4_15 = 1.7

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(122082001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 68 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 68)

				if (68 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 68)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play122082002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 122082002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play122082003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_12_0 = 0.6

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				local var_12_1, var_12_2 = math.modf((arg_9_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_12_2 * 0.13, var_12_2 * 0.13, var_12_2 * 0.13) + arg_9_1.var_.shakeOldPos
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				manager.ui.mainCamera.transform.localPosition = arg_9_1.var_.shakeOldPos
			end

			local var_12_3 = 0

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_3 + arg_12_0 then
				arg_9_1.allBtn_.enabled = false
			end

			if arg_9_1.time_ >= var_12_3 + 0.6 and arg_9_1.time_ < var_12_3 + 0.6 + arg_12_0 then
				arg_9_1.allBtn_.enabled = true
			end

			local var_12_4 = 0
			local var_12_5 = 0.9

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_6 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_6:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_7 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(122082002).content)

				arg_9_1.text_.text = var_12_7

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_9 = 36 <= 0 and var_12_5 or var_12_5 * (utf8.len(var_12_7) / 36)

				if (36 <= 0 and var_12_5 or var_12_5 * (utf8.len(var_12_7) / 36)) > 0 and var_12_5 < var_12_9 then
					arg_9_1.talkMaxDuration = var_12_9
					var_12_4 = var_12_4 + 0.3

					if var_12_9 + var_12_4 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_9 + var_12_4
					end
				end

				arg_9_1.text_.text = var_12_7
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = var_12_4 + 0.3
			local var_12_11 = math.max(var_12_5, arg_9_1.talkMaxDuration)

			if var_12_4 + 0.3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_10 + var_12_11 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_10) / var_12_11

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_10 + var_12_11 and arg_9_1.time_ < var_12_10 + var_12_11 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play122082003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 122082003
		arg_15_1.duration_ = 2

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play122082004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if arg_15_1.actors_["1184ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1184ui_story"))) then
				local var_18_0 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_15_1.stage_.transform)

				var_18_0.name = "1184ui_story"
				var_18_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.actors_["1184ui_story"] = var_18_0

				local var_18_1 = var_18_0:GetComponentInChildren(typeof(CharacterEffect))

				var_18_1.enabled = true

				local var_18_2 = GameObjectTools.GetOrAddComponent(var_18_0, typeof(DynamicBoneHelper))

				if var_18_2 then
					var_18_2:EnableDynamicBone(false)
				end

				arg_15_1:ShowWeapon(var_18_1.transform, false)

				arg_15_1.var_["1184ui_story" .. "Animator"] = var_18_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_15_1.var_["1184ui_story" .. "Animator"].applyRootMotion = true
				arg_15_1.var_["1184ui_story" .. "LipSync"] = var_18_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_18_3 = arg_15_1.actors_["1184ui_story"].transform

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1184ui_story = var_18_3.localPosition
			end

			local var_18_4 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_4 then
				var_18_3.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_15_1.time_ - 0) / var_18_4)
				var_18_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_3.position).x, (manager.ui.mainCamera.transform.position - var_18_3.position).y, (manager.ui.mainCamera.transform.position - var_18_3.position).z)
				var_18_3.localEulerAngles.z = 0
				var_18_3.localEulerAngles.x = 0
				var_18_3.localEulerAngles = var_18_3.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_4 and arg_15_1.time_ < 0 + var_18_4 + arg_18_0 then
				var_18_3.localPosition = Vector3.New(0, -0.97, -6)
				var_18_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_3.position).x, (manager.ui.mainCamera.transform.position - var_18_3.position).y, (manager.ui.mainCamera.transform.position - var_18_3.position).z)
				var_18_3.localEulerAngles.z = 0
				var_18_3.localEulerAngles.x = 0
				var_18_3.localEulerAngles = var_18_3.localEulerAngles
			end

			local var_18_5 = arg_15_1.actors_["1184ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_5) and arg_15_1.var_.characterEffect1184ui_story == nil then
				arg_15_1.var_.characterEffect1184ui_story = var_18_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_6 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_6 and not isNil(var_18_5) then
				if arg_15_1.var_.characterEffect1184ui_story and not isNil(var_18_5) then
					arg_15_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_6 and arg_15_1.time_ < 0 + var_18_6 + arg_18_0 and not isNil(var_18_5) and arg_15_1.var_.characterEffect1184ui_story then
				arg_15_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_18_8 = 0
			local var_18_9 = 0.15

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_8 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_10 = arg_15_1:GetWordFromCfg(122082003)
				local var_18_11 = arg_15_1:FormatText(var_18_10.content)

				arg_15_1.text_.text = var_18_11

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_13 = 6 <= 0 and var_18_9 or var_18_9 * (utf8.len(var_18_11) / 6)

				if (6 <= 0 and var_18_9 or var_18_9 * (utf8.len(var_18_11) / 6)) > 0 and var_18_9 < var_18_13 then
					arg_15_1.talkMaxDuration = var_18_13

					if var_18_13 + var_18_8 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_13 + var_18_8
					end
				end

				arg_15_1.text_.text = var_18_11
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082003", "story_v_out_122082.awb") ~= 0 then
					local var_18_14 = manager.audio:GetVoiceLength("story_v_out_122082", "122082003", "story_v_out_122082.awb") / 1000

					if var_18_14 + var_18_8 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_14 + var_18_8
					end

					if var_18_10.prefab_name ~= "" and arg_15_1.actors_[var_18_10.prefab_name] ~= nil then
						local var_18_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_10.prefab_name].transform, "story_v_out_122082", "122082003", "story_v_out_122082.awb")

						arg_15_1:RecordAudio("122082003", var_18_15)
						arg_15_1:RecordAudio("122082003", var_18_15)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_122082", "122082003", "story_v_out_122082.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_122082", "122082003", "story_v_out_122082.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_16 = math.max(var_18_9, arg_15_1.talkMaxDuration)

			if var_18_8 <= arg_15_1.time_ and arg_15_1.time_ < var_18_8 + var_18_16 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_8) / var_18_16

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_8 + var_18_16 and arg_15_1.time_ < var_18_8 + var_18_16 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play122082004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 122082004
		arg_19_1.duration_ = 6.57

		local var_19_0 = {
			ja = 6.566,
			ko = 5.766,
			zh = 5.766
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play122082005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if arg_19_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_22_0 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_19_1.stage_.transform)

				var_22_0.name = "1071ui_story"
				var_22_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.actors_["1071ui_story"] = var_22_0

				local var_22_1 = var_22_0:GetComponentInChildren(typeof(CharacterEffect))

				var_22_1.enabled = true

				local var_22_2 = GameObjectTools.GetOrAddComponent(var_22_0, typeof(DynamicBoneHelper))

				if var_22_2 then
					var_22_2:EnableDynamicBone(false)
				end

				arg_19_1:ShowWeapon(var_22_1.transform, false)

				arg_19_1.var_["1071ui_story" .. "Animator"] = var_22_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_19_1.var_["1071ui_story" .. "Animator"].applyRootMotion = true
				arg_19_1.var_["1071ui_story" .. "LipSync"] = var_22_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_22_3 = arg_19_1.actors_["1071ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1071ui_story = var_22_3.localPosition
			end

			local var_22_4 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				var_22_3.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_19_1.time_ - 0) / var_22_4)
				var_22_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_3.position).x, (manager.ui.mainCamera.transform.position - var_22_3.position).y, (manager.ui.mainCamera.transform.position - var_22_3.position).z)
				var_22_3.localEulerAngles.z = 0
				var_22_3.localEulerAngles.x = 0
				var_22_3.localEulerAngles = var_22_3.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				var_22_3.localPosition = Vector3.New(0, -1.05, -6.2)
				var_22_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_3.position).x, (manager.ui.mainCamera.transform.position - var_22_3.position).y, (manager.ui.mainCamera.transform.position - var_22_3.position).z)
				var_22_3.localEulerAngles.z = 0
				var_22_3.localEulerAngles.x = 0
				var_22_3.localEulerAngles = var_22_3.localEulerAngles
			end

			local var_22_5 = arg_19_1.actors_["1071ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.characterEffect1071ui_story == nil then
				arg_19_1.var_.characterEffect1071ui_story = var_22_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_6 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_6 and not isNil(var_22_5) then
				if arg_19_1.var_.characterEffect1071ui_story and not isNil(var_22_5) then
					arg_19_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_6 and arg_19_1.time_ < 0 + var_22_6 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.characterEffect1071ui_story then
				arg_19_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action8_2")
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_22_8 = arg_19_1.actors_["1184ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_8) and arg_19_1.var_.characterEffect1184ui_story == nil then
				arg_19_1.var_.characterEffect1184ui_story = var_22_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_9 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_9 and not isNil(var_22_8) then
				if arg_19_1.var_.characterEffect1184ui_story and not isNil(var_22_8) then
					arg_19_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_9)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_9 and arg_19_1.time_ < 0 + var_22_9 + arg_22_0 and not isNil(var_22_8) and arg_19_1.var_.characterEffect1184ui_story then
				arg_19_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_22_10 = arg_19_1.actors_["1184ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1184ui_story = var_22_10.localPosition
			end

			local var_22_11 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_11 then
				var_22_10.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_19_1.time_ - 0) / var_22_11)
				var_22_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_10.position).x, (manager.ui.mainCamera.transform.position - var_22_10.position).y, (manager.ui.mainCamera.transform.position - var_22_10.position).z)
				var_22_10.localEulerAngles.z = 0
				var_22_10.localEulerAngles.x = 0
				var_22_10.localEulerAngles = var_22_10.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_11 and arg_19_1.time_ < 0 + var_22_11 + arg_22_0 then
				var_22_10.localPosition = Vector3.New(0, 100, 0)
				var_22_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_10.position).x, (manager.ui.mainCamera.transform.position - var_22_10.position).y, (manager.ui.mainCamera.transform.position - var_22_10.position).z)
				var_22_10.localEulerAngles.z = 0
				var_22_10.localEulerAngles.x = 0
				var_22_10.localEulerAngles = var_22_10.localEulerAngles
			end

			local var_22_12 = 0
			local var_22_13 = 0.375

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_12 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_14 = arg_19_1:GetWordFromCfg(122082004)
				local var_22_15 = arg_19_1:FormatText(var_22_14.content)

				arg_19_1.text_.text = var_22_15

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_17 = 15 <= 0 and var_22_13 or var_22_13 * (utf8.len(var_22_15) / 15)

				if (15 <= 0 and var_22_13 or var_22_13 * (utf8.len(var_22_15) / 15)) > 0 and var_22_13 < var_22_17 then
					arg_19_1.talkMaxDuration = var_22_17

					if var_22_17 + var_22_12 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_17 + var_22_12
					end
				end

				arg_19_1.text_.text = var_22_15
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082004", "story_v_out_122082.awb") ~= 0 then
					local var_22_18 = manager.audio:GetVoiceLength("story_v_out_122082", "122082004", "story_v_out_122082.awb") / 1000

					if var_22_18 + var_22_12 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_18 + var_22_12
					end

					if var_22_14.prefab_name ~= "" and arg_19_1.actors_[var_22_14.prefab_name] ~= nil then
						local var_22_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_14.prefab_name].transform, "story_v_out_122082", "122082004", "story_v_out_122082.awb")

						arg_19_1:RecordAudio("122082004", var_22_19)
						arg_19_1:RecordAudio("122082004", var_22_19)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_122082", "122082004", "story_v_out_122082.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_122082", "122082004", "story_v_out_122082.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_20 = math.max(var_22_13, arg_19_1.talkMaxDuration)

			if var_22_12 <= arg_19_1.time_ and arg_19_1.time_ < var_22_12 + var_22_20 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_12) / var_22_20

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_12 + var_22_20 and arg_19_1.time_ < var_22_12 + var_22_20 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play122082005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 122082005
		arg_23_1.duration_ = 5.07

		local var_23_0 = {
			ja = 4.966,
			ko = 5.066,
			zh = 5.066
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
				arg_23_0:Play122082006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_26_0 = 0
			local var_26_1 = 0.4

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_2 = arg_23_1:GetWordFromCfg(122082005)
				local var_26_3 = arg_23_1:FormatText(var_26_2.content)

				arg_23_1.text_.text = var_26_3

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_5 = 16 <= 0 and var_26_1 or var_26_1 * (utf8.len(var_26_3) / 16)

				if (16 <= 0 and var_26_1 or var_26_1 * (utf8.len(var_26_3) / 16)) > 0 and var_26_1 < var_26_5 then
					arg_23_1.talkMaxDuration = var_26_5

					if var_26_5 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + var_26_0
					end
				end

				arg_23_1.text_.text = var_26_3
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082005", "story_v_out_122082.awb") ~= 0 then
					local var_26_6 = manager.audio:GetVoiceLength("story_v_out_122082", "122082005", "story_v_out_122082.awb") / 1000

					if var_26_6 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_6 + var_26_0
					end

					if var_26_2.prefab_name ~= "" and arg_23_1.actors_[var_26_2.prefab_name] ~= nil then
						local var_26_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_2.prefab_name].transform, "story_v_out_122082", "122082005", "story_v_out_122082.awb")

						arg_23_1:RecordAudio("122082005", var_26_7)
						arg_23_1:RecordAudio("122082005", var_26_7)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_122082", "122082005", "story_v_out_122082.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_122082", "122082005", "story_v_out_122082.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_8 = math.max(var_26_1, arg_23_1.talkMaxDuration)

			if var_26_0 <= arg_23_1.time_ and arg_23_1.time_ < var_26_0 + var_26_8 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_0) / var_26_8

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_0 + var_26_8 and arg_23_1.time_ < var_26_0 + var_26_8 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play122082006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 122082006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play122082007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1071ui_story = arg_27_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1071ui_story"].transform.position).z)
				arg_27_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1071ui_story"].transform.localEulerAngles = arg_27_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1071ui_story"].transform.position).z)
				arg_27_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1071ui_story"].transform.localEulerAngles = arg_27_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_30_1 = arg_27_1.actors_["1071ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1071ui_story == nil then
				arg_27_1.var_.characterEffect1071ui_story = var_30_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 and not isNil(var_30_1) then
				if arg_27_1.var_.characterEffect1071ui_story and not isNil(var_30_1) then
					arg_27_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_2)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1071ui_story then
				arg_27_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_30_3 = 0
			local var_30_4 = 1.15

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_3 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_5 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(122082006).content)

				arg_27_1.text_.text = var_30_5

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_7 = 46 <= 0 and var_30_4 or var_30_4 * (utf8.len(var_30_5) / 46)

				if (46 <= 0 and var_30_4 or var_30_4 * (utf8.len(var_30_5) / 46)) > 0 and var_30_4 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_3 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_3
					end
				end

				arg_27_1.text_.text = var_30_5
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_8 = math.max(var_30_4, arg_27_1.talkMaxDuration)

			if var_30_3 <= arg_27_1.time_ and arg_27_1.time_ < var_30_3 + var_30_8 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_3) / var_30_8

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_3 + var_30_8 and arg_27_1.time_ < var_30_3 + var_30_8 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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
	Play122082007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 122082007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play122082008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_hatchdoor", "")
			end

			local var_34_1 = 0
			local var_34_2 = 1.225

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_3 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(122082007).content)

				arg_31_1.text_.text = var_34_3

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 49 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 49)

				if (49 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 49)) > 0 and var_34_2 < var_34_5 then
					arg_31_1.talkMaxDuration = var_34_5

					if var_34_5 + var_34_1 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + var_34_1
					end
				end

				arg_31_1.text_.text = var_34_3
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_6 = math.max(var_34_2, arg_31_1.talkMaxDuration)

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_6 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_1) / var_34_6

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_1 + var_34_6 and arg_31_1.time_ < var_34_1 + var_34_6 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play122082008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 122082008
		arg_35_1.duration_ = 5.57

		local var_35_0 = {
			ja = 4.133,
			ko = 5.566,
			zh = 5.566
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play122082009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1071ui_story = arg_35_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1071ui_story"].transform.position).z)
				arg_35_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1071ui_story"].transform.localEulerAngles = arg_35_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_35_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1071ui_story"].transform.position).z)
				arg_35_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1071ui_story"].transform.localEulerAngles = arg_35_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["1071ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1071ui_story == nil then
				arg_35_1.var_.characterEffect1071ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect1071ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1071ui_story then
				arg_35_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_38_4 = 0
			local var_38_5 = 0.5

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_6 = arg_35_1:GetWordFromCfg(122082008)
				local var_38_7 = arg_35_1:FormatText(var_38_6.content)

				arg_35_1.text_.text = var_38_7

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_9 = 20 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 20)

				if (20 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 20)) > 0 and var_38_5 < var_38_9 then
					arg_35_1.talkMaxDuration = var_38_9

					if var_38_9 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_9 + var_38_4
					end
				end

				arg_35_1.text_.text = var_38_7
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082008", "story_v_out_122082.awb") ~= 0 then
					local var_38_10 = manager.audio:GetVoiceLength("story_v_out_122082", "122082008", "story_v_out_122082.awb") / 1000

					if var_38_10 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_4
					end

					if var_38_6.prefab_name ~= "" and arg_35_1.actors_[var_38_6.prefab_name] ~= nil then
						local var_38_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_6.prefab_name].transform, "story_v_out_122082", "122082008", "story_v_out_122082.awb")

						arg_35_1:RecordAudio("122082008", var_38_11)
						arg_35_1:RecordAudio("122082008", var_38_11)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_122082", "122082008", "story_v_out_122082.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_122082", "122082008", "story_v_out_122082.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_12 = math.max(var_38_5, arg_35_1.talkMaxDuration)

			if var_38_4 <= arg_35_1.time_ and arg_35_1.time_ < var_38_4 + var_38_12 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_4) / var_38_12

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_4 + var_38_12 and arg_35_1.time_ < var_38_4 + var_38_12 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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
	Play122082009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 122082009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play122082010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1071ui_story"]) and arg_39_1.var_.characterEffect1071ui_story == nil then
				arg_39_1.var_.characterEffect1071ui_story = arg_39_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1071ui_story"]) then
				if arg_39_1.var_.characterEffect1071ui_story and not isNil(arg_39_1.actors_["1071ui_story"]) then
					arg_39_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1071ui_story"]) and arg_39_1.var_.characterEffect1071ui_story then
				arg_39_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_42_1 = 0
			local var_42_2 = 1.65

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(122082009).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 66 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 66)

				if (66 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 66)) > 0 and var_42_2 < var_42_5 then
					arg_39_1.talkMaxDuration = var_42_5

					if var_42_5 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + var_42_1
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_6 = math.max(var_42_2, arg_39_1.talkMaxDuration)

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_6 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_1) / var_42_6

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_1 + var_42_6 and arg_39_1.time_ < var_42_1 + var_42_6 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play122082010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 122082010
		arg_43_1.duration_ = 9.9

		local var_43_0 = {
			ja = 9.9,
			ko = 5.866,
			zh = 5.866
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
				arg_43_0:Play122082011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1071ui_story = arg_43_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1071ui_story"].transform.position).z)
				arg_43_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1071ui_story"].transform.localEulerAngles = arg_43_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_43_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1071ui_story"].transform.position).z)
				arg_43_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1071ui_story"].transform.localEulerAngles = arg_43_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["1071ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1071ui_story == nil then
				arg_43_1.var_.characterEffect1071ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect1071ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_2)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1071ui_story then
				arg_43_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_46_3 = "4037ui_story"

			if arg_43_1.actors_["4037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4037ui_story"))) then
				local var_46_4 = Object.Instantiate(Asset.Load("Char/" .. "4037ui_story"), arg_43_1.stage_.transform)

				var_46_4.name = var_46_3
				var_46_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.actors_[var_46_3] = var_46_4

				local var_46_5 = var_46_4:GetComponentInChildren(typeof(CharacterEffect))

				var_46_5.enabled = true

				local var_46_6 = GameObjectTools.GetOrAddComponent(var_46_4, typeof(DynamicBoneHelper))

				if var_46_6 then
					var_46_6:EnableDynamicBone(false)
				end

				arg_43_1:ShowWeapon(var_46_5.transform, false)

				arg_43_1.var_[var_46_3 .. "Animator"] = var_46_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_43_1.var_[var_46_3 .. "Animator"].applyRootMotion = true
				arg_43_1.var_[var_46_3 .. "LipSync"] = var_46_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_46_7 = arg_43_1.actors_["4037ui_story"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos4037ui_story = var_46_7.localPosition
			end

			local var_46_8 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_8 then
				var_46_7.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos4037ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_43_1.time_ - 0) / var_46_8)
				var_46_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_7.position).x, (manager.ui.mainCamera.transform.position - var_46_7.position).y, (manager.ui.mainCamera.transform.position - var_46_7.position).z)
				var_46_7.localEulerAngles.z = 0
				var_46_7.localEulerAngles.x = 0
				var_46_7.localEulerAngles = var_46_7.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_8 and arg_43_1.time_ < 0 + var_46_8 + arg_46_0 then
				var_46_7.localPosition = Vector3.New(0.7, -1.12, -6.2)
				var_46_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_7.position).x, (manager.ui.mainCamera.transform.position - var_46_7.position).y, (manager.ui.mainCamera.transform.position - var_46_7.position).z)
				var_46_7.localEulerAngles.z = 0
				var_46_7.localEulerAngles.x = 0
				var_46_7.localEulerAngles = var_46_7.localEulerAngles
			end

			local var_46_9 = arg_43_1.actors_["4037ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect4037ui_story == nil then
				arg_43_1.var_.characterEffect4037ui_story = var_46_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_10 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_10 and not isNil(var_46_9) then
				if arg_43_1.var_.characterEffect4037ui_story and not isNil(var_46_9) then
					arg_43_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_10 and arg_43_1.time_ < 0 + var_46_10 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect4037ui_story then
				arg_43_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_12 = 0
			local var_46_13 = 0.25

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_12 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_14 = arg_43_1:GetWordFromCfg(122082010)
				local var_46_15 = arg_43_1:FormatText(var_46_14.content)

				arg_43_1.text_.text = var_46_15

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_17 = 10 <= 0 and var_46_13 or var_46_13 * (utf8.len(var_46_15) / 10)

				if (10 <= 0 and var_46_13 or var_46_13 * (utf8.len(var_46_15) / 10)) > 0 and var_46_13 < var_46_17 then
					arg_43_1.talkMaxDuration = var_46_17

					if var_46_17 + var_46_12 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_17 + var_46_12
					end
				end

				arg_43_1.text_.text = var_46_15
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082010", "story_v_out_122082.awb") ~= 0 then
					local var_46_18 = manager.audio:GetVoiceLength("story_v_out_122082", "122082010", "story_v_out_122082.awb") / 1000

					if var_46_18 + var_46_12 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_18 + var_46_12
					end

					if var_46_14.prefab_name ~= "" and arg_43_1.actors_[var_46_14.prefab_name] ~= nil then
						local var_46_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_14.prefab_name].transform, "story_v_out_122082", "122082010", "story_v_out_122082.awb")

						arg_43_1:RecordAudio("122082010", var_46_19)
						arg_43_1:RecordAudio("122082010", var_46_19)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_122082", "122082010", "story_v_out_122082.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_122082", "122082010", "story_v_out_122082.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_20 = math.max(var_46_13, arg_43_1.talkMaxDuration)

			if var_46_12 <= arg_43_1.time_ and arg_43_1.time_ < var_46_12 + var_46_20 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_12) / var_46_20

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_12 + var_46_20 and arg_43_1.time_ < var_46_12 + var_46_20 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play122082011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 122082011
		arg_47_1.duration_ = 10.83

		local var_47_0 = {
			ja = 10.833,
			ko = 10.333,
			zh = 10.333
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play122082012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1071ui_story"]) and arg_47_1.var_.characterEffect1071ui_story == nil then
				arg_47_1.var_.characterEffect1071ui_story = arg_47_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1071ui_story"]) then
				if arg_47_1.var_.characterEffect1071ui_story and not isNil(arg_47_1.actors_["1071ui_story"]) then
					arg_47_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1071ui_story"]) and arg_47_1.var_.characterEffect1071ui_story then
				arg_47_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_50_2 = arg_47_1.actors_["4037ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.characterEffect4037ui_story == nil then
				arg_47_1.var_.characterEffect4037ui_story = var_50_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_3 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_3 and not isNil(var_50_2) then
				if arg_47_1.var_.characterEffect4037ui_story and not isNil(var_50_2) then
					arg_47_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_47_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_3)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_3 and arg_47_1.time_ < 0 + var_50_3 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.characterEffect4037ui_story then
				arg_47_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_47_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_50_4 = 0
			local var_50_5 = 1.275

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:GetWordFromCfg(122082011)
				local var_50_7 = arg_47_1:FormatText(var_50_6.content)

				arg_47_1.text_.text = var_50_7

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_9 = 51 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 51)

				if (51 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 51)) > 0 and var_50_5 < var_50_9 then
					arg_47_1.talkMaxDuration = var_50_9

					if var_50_9 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_9 + var_50_4
					end
				end

				arg_47_1.text_.text = var_50_7
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082011", "story_v_out_122082.awb") ~= 0 then
					local var_50_10 = manager.audio:GetVoiceLength("story_v_out_122082", "122082011", "story_v_out_122082.awb") / 1000

					if var_50_10 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_4
					end

					if var_50_6.prefab_name ~= "" and arg_47_1.actors_[var_50_6.prefab_name] ~= nil then
						local var_50_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_6.prefab_name].transform, "story_v_out_122082", "122082011", "story_v_out_122082.awb")

						arg_47_1:RecordAudio("122082011", var_50_11)
						arg_47_1:RecordAudio("122082011", var_50_11)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_122082", "122082011", "story_v_out_122082.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_122082", "122082011", "story_v_out_122082.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_12 = math.max(var_50_5, arg_47_1.talkMaxDuration)

			if var_50_4 <= arg_47_1.time_ and arg_47_1.time_ < var_50_4 + var_50_12 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_4) / var_50_12

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_4 + var_50_12 and arg_47_1.time_ < var_50_4 + var_50_12 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play122082012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 122082012
		arg_51_1.duration_ = 14.37

		local var_51_0 = {
			ja = 14.366,
			ko = 14.266,
			zh = 14.266
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
				arg_51_0:Play122082013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 1.4

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:GetWordFromCfg(122082012)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 56 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 56)

				if (56 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 56)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082012", "story_v_out_122082.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_122082", "122082012", "story_v_out_122082.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_122082", "122082012", "story_v_out_122082.awb")

						arg_51_1:RecordAudio("122082012", var_54_6)
						arg_51_1:RecordAudio("122082012", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_122082", "122082012", "story_v_out_122082.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_122082", "122082012", "story_v_out_122082.awb")
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
	Play122082013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 122082013
		arg_55_1.duration_ = 1.87

		local var_55_0 = {
			ja = 1.866,
			ko = 1.466,
			zh = 1.466
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
				arg_55_0:Play122082014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["4037ui_story"]) and arg_55_1.var_.characterEffect4037ui_story == nil then
				arg_55_1.var_.characterEffect4037ui_story = arg_55_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["4037ui_story"]) then
				if arg_55_1.var_.characterEffect4037ui_story and not isNil(arg_55_1.actors_["4037ui_story"]) then
					arg_55_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["4037ui_story"]) and arg_55_1.var_.characterEffect4037ui_story then
				arg_55_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_58_2 = arg_55_1.actors_["1071ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.characterEffect1071ui_story == nil then
				arg_55_1.var_.characterEffect1071ui_story = var_58_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_3 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_3 and not isNil(var_58_2) then
				if arg_55_1.var_.characterEffect1071ui_story and not isNil(var_58_2) then
					arg_55_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_3)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_3 and arg_55_1.time_ < 0 + var_58_3 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.characterEffect1071ui_story then
				arg_55_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_58_4 = 0
			local var_58_5 = 0.125

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:GetWordFromCfg(122082013)
				local var_58_7 = arg_55_1:FormatText(var_58_6.content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 5 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 5)

				if (5 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 5)) > 0 and var_58_5 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082013", "story_v_out_122082.awb") ~= 0 then
					local var_58_10 = manager.audio:GetVoiceLength("story_v_out_122082", "122082013", "story_v_out_122082.awb") / 1000

					if var_58_10 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_4
					end

					if var_58_6.prefab_name ~= "" and arg_55_1.actors_[var_58_6.prefab_name] ~= nil then
						local var_58_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_6.prefab_name].transform, "story_v_out_122082", "122082013", "story_v_out_122082.awb")

						arg_55_1:RecordAudio("122082013", var_58_11)
						arg_55_1:RecordAudio("122082013", var_58_11)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_122082", "122082013", "story_v_out_122082.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_122082", "122082013", "story_v_out_122082.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_12 = math.max(var_58_5, arg_55_1.talkMaxDuration)

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_12 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_4) / var_58_12

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_4 + var_58_12 and arg_55_1.time_ < var_58_4 + var_58_12 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play122082014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 122082014
		arg_59_1.duration_ = 9.07

		local var_59_0 = {
			ja = 7.633,
			ko = 9.066,
			zh = 9.066
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
				arg_59_0:Play122082015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1071ui_story"]) and arg_59_1.var_.characterEffect1071ui_story == nil then
				arg_59_1.var_.characterEffect1071ui_story = arg_59_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1071ui_story"]) then
				if arg_59_1.var_.characterEffect1071ui_story and not isNil(arg_59_1.actors_["1071ui_story"]) then
					arg_59_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1071ui_story"]) and arg_59_1.var_.characterEffect1071ui_story then
				arg_59_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_62_2 = arg_59_1.actors_["4037ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.characterEffect4037ui_story == nil then
				arg_59_1.var_.characterEffect4037ui_story = var_62_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_3 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_3 and not isNil(var_62_2) then
				if arg_59_1.var_.characterEffect4037ui_story and not isNil(var_62_2) then
					arg_59_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_59_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_3)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_3 and arg_59_1.time_ < 0 + var_62_3 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.characterEffect4037ui_story then
				arg_59_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_59_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_62_4 = 0
			local var_62_5 = 1

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_6 = arg_59_1:GetWordFromCfg(122082014)
				local var_62_7 = arg_59_1:FormatText(var_62_6.content)

				arg_59_1.text_.text = var_62_7

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_9 = 40 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 40)

				if (40 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 40)) > 0 and var_62_5 < var_62_9 then
					arg_59_1.talkMaxDuration = var_62_9

					if var_62_9 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_7
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082014", "story_v_out_122082.awb") ~= 0 then
					local var_62_10 = manager.audio:GetVoiceLength("story_v_out_122082", "122082014", "story_v_out_122082.awb") / 1000

					if var_62_10 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_4
					end

					if var_62_6.prefab_name ~= "" and arg_59_1.actors_[var_62_6.prefab_name] ~= nil then
						local var_62_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_6.prefab_name].transform, "story_v_out_122082", "122082014", "story_v_out_122082.awb")

						arg_59_1:RecordAudio("122082014", var_62_11)
						arg_59_1:RecordAudio("122082014", var_62_11)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_122082", "122082014", "story_v_out_122082.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_122082", "122082014", "story_v_out_122082.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_12 = math.max(var_62_5, arg_59_1.talkMaxDuration)

			if var_62_4 <= arg_59_1.time_ and arg_59_1.time_ < var_62_4 + var_62_12 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_4) / var_62_12

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_4 + var_62_12 and arg_59_1.time_ < var_62_4 + var_62_12 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play122082015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 122082015
		arg_63_1.duration_ = 13.1

		local var_63_0 = {
			ja = 13.1,
			ko = 9.833,
			zh = 9.833
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
				arg_63_0:Play122082016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 1.25

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:GetWordFromCfg(122082015)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 50 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 50)

				if (50 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 50)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082015", "story_v_out_122082.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_122082", "122082015", "story_v_out_122082.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_122082", "122082015", "story_v_out_122082.awb")

						arg_63_1:RecordAudio("122082015", var_66_6)
						arg_63_1:RecordAudio("122082015", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_122082", "122082015", "story_v_out_122082.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_122082", "122082015", "story_v_out_122082.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play122082016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 122082016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play122082017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1071ui_story"]) and arg_67_1.var_.characterEffect1071ui_story == nil then
				arg_67_1.var_.characterEffect1071ui_story = arg_67_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1071ui_story"]) then
				if arg_67_1.var_.characterEffect1071ui_story and not isNil(arg_67_1.actors_["1071ui_story"]) then
					arg_67_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_0)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1071ui_story"]) and arg_67_1.var_.characterEffect1071ui_story then
				arg_67_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_70_1 = 0
			local var_70_2 = 1.075

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(122082016).content)

				arg_67_1.text_.text = var_70_3

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 43 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 43)

				if (43 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 43)) > 0 and var_70_2 < var_70_5 then
					arg_67_1.talkMaxDuration = var_70_5

					if var_70_5 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_3
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_6 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_6 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_6

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_6 and arg_67_1.time_ < var_70_1 + var_70_6 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play122082017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 122082017
		arg_71_1.duration_ = 7.27

		local var_71_0 = {
			ja = 7.266,
			ko = 4.566,
			zh = 4.566
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
				arg_71_0:Play122082018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["4037ui_story"]) and arg_71_1.var_.characterEffect4037ui_story == nil then
				arg_71_1.var_.characterEffect4037ui_story = arg_71_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["4037ui_story"]) then
				if arg_71_1.var_.characterEffect4037ui_story and not isNil(arg_71_1.actors_["4037ui_story"]) then
					arg_71_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["4037ui_story"]) and arg_71_1.var_.characterEffect4037ui_story then
				arg_71_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_74_2 = 0
			local var_74_3 = 0.525

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_2 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_4 = arg_71_1:GetWordFromCfg(122082017)
				local var_74_5 = arg_71_1:FormatText(var_74_4.content)

				arg_71_1.text_.text = var_74_5

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_7 = 21 <= 0 and var_74_3 or var_74_3 * (utf8.len(var_74_5) / 21)

				if (21 <= 0 and var_74_3 or var_74_3 * (utf8.len(var_74_5) / 21)) > 0 and var_74_3 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_2 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_2
					end
				end

				arg_71_1.text_.text = var_74_5
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082017", "story_v_out_122082.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_122082", "122082017", "story_v_out_122082.awb") / 1000

					if var_74_8 + var_74_2 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_2
					end

					if var_74_4.prefab_name ~= "" and arg_71_1.actors_[var_74_4.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_4.prefab_name].transform, "story_v_out_122082", "122082017", "story_v_out_122082.awb")

						arg_71_1:RecordAudio("122082017", var_74_9)
						arg_71_1:RecordAudio("122082017", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_122082", "122082017", "story_v_out_122082.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_122082", "122082017", "story_v_out_122082.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_10 = math.max(var_74_3, arg_71_1.talkMaxDuration)

			if var_74_2 <= arg_71_1.time_ and arg_71_1.time_ < var_74_2 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_2) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_2 + var_74_10 and arg_71_1.time_ < var_74_2 + var_74_10 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play122082018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 122082018
		arg_75_1.duration_ = 13.57

		local var_75_0 = {
			ja = 13.566,
			ko = 10.966,
			zh = 10.966
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
				arg_75_0:Play122082019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1071ui_story"]) and arg_75_1.var_.characterEffect1071ui_story == nil then
				arg_75_1.var_.characterEffect1071ui_story = arg_75_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1071ui_story"]) then
				if arg_75_1.var_.characterEffect1071ui_story and not isNil(arg_75_1.actors_["1071ui_story"]) then
					arg_75_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1071ui_story"]) and arg_75_1.var_.characterEffect1071ui_story then
				arg_75_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_78_2 = arg_75_1.actors_["4037ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.characterEffect4037ui_story == nil then
				arg_75_1.var_.characterEffect4037ui_story = var_78_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_3 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_3 and not isNil(var_78_2) then
				if arg_75_1.var_.characterEffect4037ui_story and not isNil(var_78_2) then
					arg_75_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_75_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_3)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_3 and arg_75_1.time_ < 0 + var_78_3 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.characterEffect4037ui_story then
				arg_75_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_75_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_78_4 = 0
			local var_78_5 = 0.95

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_6 = arg_75_1:GetWordFromCfg(122082018)
				local var_78_7 = arg_75_1:FormatText(var_78_6.content)

				arg_75_1.text_.text = var_78_7

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_9 = 38 <= 0 and var_78_5 or var_78_5 * (utf8.len(var_78_7) / 38)

				if (38 <= 0 and var_78_5 or var_78_5 * (utf8.len(var_78_7) / 38)) > 0 and var_78_5 < var_78_9 then
					arg_75_1.talkMaxDuration = var_78_9

					if var_78_9 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_9 + var_78_4
					end
				end

				arg_75_1.text_.text = var_78_7
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082018", "story_v_out_122082.awb") ~= 0 then
					local var_78_10 = manager.audio:GetVoiceLength("story_v_out_122082", "122082018", "story_v_out_122082.awb") / 1000

					if var_78_10 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_4
					end

					if var_78_6.prefab_name ~= "" and arg_75_1.actors_[var_78_6.prefab_name] ~= nil then
						local var_78_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_6.prefab_name].transform, "story_v_out_122082", "122082018", "story_v_out_122082.awb")

						arg_75_1:RecordAudio("122082018", var_78_11)
						arg_75_1:RecordAudio("122082018", var_78_11)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_122082", "122082018", "story_v_out_122082.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_122082", "122082018", "story_v_out_122082.awb")
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
	Play122082019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 122082019
		arg_79_1.duration_ = 4.8

		local var_79_0 = {
			ja = 4.166,
			ko = 4.8,
			zh = 4.8
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
				arg_79_0:Play122082020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["4037ui_story"]) and arg_79_1.var_.characterEffect4037ui_story == nil then
				arg_79_1.var_.characterEffect4037ui_story = arg_79_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["4037ui_story"]) then
				if arg_79_1.var_.characterEffect4037ui_story and not isNil(arg_79_1.actors_["4037ui_story"]) then
					arg_79_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["4037ui_story"]) and arg_79_1.var_.characterEffect4037ui_story then
				arg_79_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_82_2 = arg_79_1.actors_["1071ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.characterEffect1071ui_story == nil then
				arg_79_1.var_.characterEffect1071ui_story = var_82_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_3 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 and not isNil(var_82_2) then
				if arg_79_1.var_.characterEffect1071ui_story and not isNil(var_82_2) then
					arg_79_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_3)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.characterEffect1071ui_story then
				arg_79_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_82_4 = 0
			local var_82_5 = 0.35

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(122082019)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 14 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 14)

				if (14 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 14)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082019", "story_v_out_122082.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_out_122082", "122082019", "story_v_out_122082.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_out_122082", "122082019", "story_v_out_122082.awb")

						arg_79_1:RecordAudio("122082019", var_82_11)
						arg_79_1:RecordAudio("122082019", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_122082", "122082019", "story_v_out_122082.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_122082", "122082019", "story_v_out_122082.awb")
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
	Play122082020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 122082020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play122082021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos4037ui_story = arg_83_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["4037ui_story"].transform.position).z)
				arg_83_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["4037ui_story"].transform.localEulerAngles = arg_83_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["4037ui_story"].transform.position).z)
				arg_83_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["4037ui_story"].transform.localEulerAngles = arg_83_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_86_1 = arg_83_1.actors_["4037ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect4037ui_story == nil then
				arg_83_1.var_.characterEffect4037ui_story = var_86_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 and not isNil(var_86_1) then
				if arg_83_1.var_.characterEffect4037ui_story and not isNil(var_86_1) then
					arg_83_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_83_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_2)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect4037ui_story then
				arg_83_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_83_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_86_3 = arg_83_1.actors_["1071ui_story"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1071ui_story = var_86_3.localPosition
			end

			local var_86_4 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				var_86_3.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_83_1.time_ - 0) / var_86_4)
				var_86_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_3.position).x, (manager.ui.mainCamera.transform.position - var_86_3.position).y, (manager.ui.mainCamera.transform.position - var_86_3.position).z)
				var_86_3.localEulerAngles.z = 0
				var_86_3.localEulerAngles.x = 0
				var_86_3.localEulerAngles = var_86_3.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				var_86_3.localPosition = Vector3.New(0, 100, 0)
				var_86_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_3.position).x, (manager.ui.mainCamera.transform.position - var_86_3.position).y, (manager.ui.mainCamera.transform.position - var_86_3.position).z)
				var_86_3.localEulerAngles.z = 0
				var_86_3.localEulerAngles.x = 0
				var_86_3.localEulerAngles = var_86_3.localEulerAngles
			end

			local var_86_5 = arg_83_1.actors_["1071ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.characterEffect1071ui_story == nil then
				arg_83_1.var_.characterEffect1071ui_story = var_86_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_6 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_6 and not isNil(var_86_5) then
				if arg_83_1.var_.characterEffect1071ui_story and not isNil(var_86_5) then
					arg_83_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_6)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_6 and arg_83_1.time_ < 0 + var_86_6 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.characterEffect1071ui_story then
				arg_83_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_86_7 = 0
			local var_86_8 = 1.975

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_7 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_9 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(122082020).content)

				arg_83_1.text_.text = var_86_9

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_11 = 79 <= 0 and var_86_8 or var_86_8 * (utf8.len(var_86_9) / 79)

				if (79 <= 0 and var_86_8 or var_86_8 * (utf8.len(var_86_9) / 79)) > 0 and var_86_8 < var_86_11 then
					arg_83_1.talkMaxDuration = var_86_11

					if var_86_11 + var_86_7 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_11 + var_86_7
					end
				end

				arg_83_1.text_.text = var_86_9
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_12 = math.max(var_86_8, arg_83_1.talkMaxDuration)

			if var_86_7 <= arg_83_1.time_ and arg_83_1.time_ < var_86_7 + var_86_12 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_7) / var_86_12

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_7 + var_86_12 and arg_83_1.time_ < var_86_7 + var_86_12 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play122082021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 122082021
		arg_87_1.duration_ = 2

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play122082022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1184ui_story = arg_87_1.actors_["1184ui_story"].transform.localPosition

				arg_87_1:ShowWeapon(arg_87_1.var_["1184ui_story" .. "Animator"].transform, true)
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1184ui_story"].transform.position).z)
				arg_87_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1184ui_story"].transform.localEulerAngles = arg_87_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_87_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1184ui_story"].transform.position).z)
				arg_87_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1184ui_story"].transform.localEulerAngles = arg_87_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_90_1 = arg_87_1.actors_["1184ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1184ui_story == nil then
				arg_87_1.var_.characterEffect1184ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect1184ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1184ui_story then
				arg_87_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_90_4 = 0
			local var_90_5 = 0.15

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_6 = arg_87_1:GetWordFromCfg(122082021)
				local var_90_7 = arg_87_1:FormatText(var_90_6.content)

				arg_87_1.text_.text = var_90_7

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_9 = 6 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 6)

				if (6 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 6)) > 0 and var_90_5 < var_90_9 then
					arg_87_1.talkMaxDuration = var_90_9

					if var_90_9 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_4
					end
				end

				arg_87_1.text_.text = var_90_7
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082021", "story_v_out_122082.awb") ~= 0 then
					local var_90_10 = manager.audio:GetVoiceLength("story_v_out_122082", "122082021", "story_v_out_122082.awb") / 1000

					if var_90_10 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_4
					end

					if var_90_6.prefab_name ~= "" and arg_87_1.actors_[var_90_6.prefab_name] ~= nil then
						local var_90_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_6.prefab_name].transform, "story_v_out_122082", "122082021", "story_v_out_122082.awb")

						arg_87_1:RecordAudio("122082021", var_90_11)
						arg_87_1:RecordAudio("122082021", var_90_11)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_122082", "122082021", "story_v_out_122082.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_122082", "122082021", "story_v_out_122082.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_12 = math.max(var_90_5, arg_87_1.talkMaxDuration)

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_12 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_4) / var_90_12

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_4 + var_90_12 and arg_87_1.time_ < var_90_4 + var_90_12 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play122082022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 122082022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play122082023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1184ui_story = arg_91_1.actors_["1184ui_story"].transform.localPosition

				arg_91_1:ShowWeapon(arg_91_1.var_["1184ui_story" .. "Animator"].transform, false)
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1184ui_story"].transform.position).z)
				arg_91_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1184ui_story"].transform.localEulerAngles = arg_91_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1184ui_story"].transform.position).z)
				arg_91_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1184ui_story"].transform.localEulerAngles = arg_91_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_94_1 = arg_91_1.actors_["1184ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1184ui_story == nil then
				arg_91_1.var_.characterEffect1184ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and not isNil(var_94_1) then
				if arg_91_1.var_.characterEffect1184ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_2)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1184ui_story then
				arg_91_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_94_3 = 0
			local var_94_4 = 0.15

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_3 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_5 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(122082022).content)

				arg_91_1.text_.text = var_94_5

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_7 = 6 <= 0 and var_94_4 or var_94_4 * (utf8.len(var_94_5) / 6)

				if (6 <= 0 and var_94_4 or var_94_4 * (utf8.len(var_94_5) / 6)) > 0 and var_94_4 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_3 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_3
					end
				end

				arg_91_1.text_.text = var_94_5
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_8 = math.max(var_94_4, arg_91_1.talkMaxDuration)

			if var_94_3 <= arg_91_1.time_ and arg_91_1.time_ < var_94_3 + var_94_8 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_3) / var_94_8

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_3 + var_94_8 and arg_91_1.time_ < var_94_3 + var_94_8 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play122082023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 122082023
		arg_95_1.duration_ = 7

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play122082024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_0 = 2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				local var_98_1 = Color.New(1, 1, 1)

				var_98_1.a = Mathf.Lerp(1, 0, (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.mask_.color = var_98_1
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				local var_98_2 = Color.New(1, 1, 1)

				arg_95_1.mask_.enabled = false
				var_98_2.a = 0
				arg_95_1.mask_.color = var_98_2
			end

			local var_98_3 = manager.ui.mainCamera.transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.shakeOldPos = var_98_3.localPosition
			end

			local var_98_4 = 2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				local var_98_5, var_98_6 = math.modf((arg_95_1.time_ - 0) / 0.066)

				var_98_3.localPosition = Vector3.New(var_98_6 * 0.13, var_98_6 * 0.13, var_98_6 * 0.13) + arg_95_1.var_.shakeOldPos
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				var_98_3.localPosition = arg_95_1.var_.shakeOldPos
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:AudioAction("play", "effect", "e_4038", "e_4038_tandao3", "")
			end

			if arg_95_1.frameCnt_ <= 1 then
				arg_95_1.dialog_:SetActive(false)
			end

			local var_98_8 = 2
			local var_98_9 = 1.725

			if 2 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				arg_95_1.dialog_:SetActive(true)

				arg_95_1.dialogCg_.alpha = 0

				local var_98_10 = LeanTween.value(arg_95_1.dialog_, 0, 1, 0.3)

				var_98_10:setOnUpdate(LuaHelper.FloatAction(function(arg_99_0)
					arg_95_1.dialogCg_.alpha = arg_99_0
				end))
				var_98_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_95_1.dialog_)
					var_98_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_95_1.duration_ = arg_95_1.duration_ + 0.3

				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_11 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(122082023).content)

				arg_95_1.text_.text = var_98_11

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_13 = 69 <= 0 and var_98_9 or var_98_9 * (utf8.len(var_98_11) / 69)

				if (69 <= 0 and var_98_9 or var_98_9 * (utf8.len(var_98_11) / 69)) > 0 and var_98_9 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13
					var_98_8 = var_98_8 + 0.3

					if var_98_13 + var_98_8 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_8
					end
				end

				arg_95_1.text_.text = var_98_11
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_14 = var_98_8 + 0.3
			local var_98_15 = math.max(var_98_9, arg_95_1.talkMaxDuration)

			if var_98_8 + 0.3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_14 + var_98_15 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_14) / var_98_15

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_14 + var_98_15 and arg_95_1.time_ < var_98_14 + var_98_15 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play122082024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 122082024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play122082025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 1.925

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(122082024).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 77 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 77)

				if (77 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 77)) > 0 and var_104_0 < var_104_3 then
					arg_101_1.talkMaxDuration = var_104_3

					if var_104_3 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_3 + 0
					end
				end

				arg_101_1.text_.text = var_104_1
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_4 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_4

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play122082025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 122082025
		arg_105_1.duration_ = 3.33

		local var_105_0 = {
			ja = 3,
			ko = 3.333,
			zh = 3.333
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
				arg_105_0:Play122082026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if arg_105_1.actors_["10037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10037ui_story"))) then
				local var_108_0 = Object.Instantiate(Asset.Load("Char/" .. "10037ui_story"), arg_105_1.stage_.transform)

				var_108_0.name = "10037ui_story"
				var_108_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_["10037ui_story"] = var_108_0

				local var_108_1 = var_108_0:GetComponentInChildren(typeof(CharacterEffect))

				var_108_1.enabled = true

				local var_108_2 = GameObjectTools.GetOrAddComponent(var_108_0, typeof(DynamicBoneHelper))

				if var_108_2 then
					var_108_2:EnableDynamicBone(false)
				end

				arg_105_1:ShowWeapon(var_108_1.transform, false)

				arg_105_1.var_["10037ui_story" .. "Animator"] = var_108_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_105_1.var_["10037ui_story" .. "Animator"].applyRootMotion = true
				arg_105_1.var_["10037ui_story" .. "LipSync"] = var_108_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_108_3 = arg_105_1.actors_["10037ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10037ui_story = var_108_3.localPosition
			end

			local var_108_4 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				var_108_3.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10037ui_story, Vector3.New(-0.7, -1.13, -6.2), (arg_105_1.time_ - 0) / var_108_4)
				var_108_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_3.position).x, (manager.ui.mainCamera.transform.position - var_108_3.position).y, (manager.ui.mainCamera.transform.position - var_108_3.position).z)
				var_108_3.localEulerAngles.z = 0
				var_108_3.localEulerAngles.x = 0
				var_108_3.localEulerAngles = var_108_3.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				var_108_3.localPosition = Vector3.New(-0.7, -1.13, -6.2)
				var_108_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_3.position).x, (manager.ui.mainCamera.transform.position - var_108_3.position).y, (manager.ui.mainCamera.transform.position - var_108_3.position).z)
				var_108_3.localEulerAngles.z = 0
				var_108_3.localEulerAngles.x = 0
				var_108_3.localEulerAngles = var_108_3.localEulerAngles
			end

			local var_108_5 = arg_105_1.actors_["10037ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.characterEffect10037ui_story == nil then
				arg_105_1.var_.characterEffect10037ui_story = var_108_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_6 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_6 and not isNil(var_108_5) then
				if arg_105_1.var_.characterEffect10037ui_story and not isNil(var_108_5) then
					arg_105_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_6 and arg_105_1.time_ < 0 + var_108_6 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.characterEffect10037ui_story then
				arg_105_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_108_8 = 0
			local var_108_9 = 0.225

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:GetWordFromCfg(122082025)
				local var_108_11 = arg_105_1:FormatText(var_108_10.content)

				arg_105_1.text_.text = var_108_11

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 9 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 9)

				if (9 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 9)) > 0 and var_108_9 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_11
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082025", "story_v_out_122082.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_out_122082", "122082025", "story_v_out_122082.awb") / 1000

					if var_108_14 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_8
					end

					if var_108_10.prefab_name ~= "" and arg_105_1.actors_[var_108_10.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_10.prefab_name].transform, "story_v_out_122082", "122082025", "story_v_out_122082.awb")

						arg_105_1:RecordAudio("122082025", var_108_15)
						arg_105_1:RecordAudio("122082025", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_122082", "122082025", "story_v_out_122082.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_122082", "122082025", "story_v_out_122082.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_16 and arg_105_1.time_ < var_108_8 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
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
	Play122082026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 122082026
		arg_109_1.duration_ = 3.33

		local var_109_0 = {
			ja = 3.333,
			ko = 2.133,
			zh = 2.133
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
				arg_109_0:Play122082027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos4037ui_story = arg_109_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos4037ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["4037ui_story"].transform.position).z)
				arg_109_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["4037ui_story"].transform.localEulerAngles = arg_109_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -6.2)
				arg_109_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["4037ui_story"].transform.position).z)
				arg_109_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["4037ui_story"].transform.localEulerAngles = arg_109_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["4037ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect4037ui_story == nil then
				arg_109_1.var_.characterEffect4037ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect4037ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect4037ui_story then
				arg_109_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_4 = arg_109_1.actors_["10037ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_4) and arg_109_1.var_.characterEffect10037ui_story == nil then
				arg_109_1.var_.characterEffect10037ui_story = var_112_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_5 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_5 and not isNil(var_112_4) then
				if arg_109_1.var_.characterEffect10037ui_story and not isNil(var_112_4) then
					arg_109_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_5)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_5 and arg_109_1.time_ < 0 + var_112_5 + arg_112_0 and not isNil(var_112_4) and arg_109_1.var_.characterEffect10037ui_story then
				arg_109_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10037ui_story.fillRatio = 0.5
			end

			local var_112_6 = 0
			local var_112_7 = 0.2

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_8 = arg_109_1:GetWordFromCfg(122082026)
				local var_112_9 = arg_109_1:FormatText(var_112_8.content)

				arg_109_1.text_.text = var_112_9

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 8 <= 0 and var_112_7 or var_112_7 * (utf8.len(var_112_9) / 8)

				if (8 <= 0 and var_112_7 or var_112_7 * (utf8.len(var_112_9) / 8)) > 0 and var_112_7 < var_112_11 then
					arg_109_1.talkMaxDuration = var_112_11

					if var_112_11 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_9
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082026", "story_v_out_122082.awb") ~= 0 then
					local var_112_12 = manager.audio:GetVoiceLength("story_v_out_122082", "122082026", "story_v_out_122082.awb") / 1000

					if var_112_12 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_12 + var_112_6
					end

					if var_112_8.prefab_name ~= "" and arg_109_1.actors_[var_112_8.prefab_name] ~= nil then
						local var_112_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_8.prefab_name].transform, "story_v_out_122082", "122082026", "story_v_out_122082.awb")

						arg_109_1:RecordAudio("122082026", var_112_13)
						arg_109_1:RecordAudio("122082026", var_112_13)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_122082", "122082026", "story_v_out_122082.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_122082", "122082026", "story_v_out_122082.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_14 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_14 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_14

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_14 and arg_109_1.time_ < var_112_6 + var_112_14 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play122082027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 122082027
		arg_113_1.duration_ = 5.03

		local var_113_0 = {
			ja = 4.8,
			ko = 5.033,
			zh = 5.033
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play122082028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos4037ui_story = arg_113_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["4037ui_story"].transform.position).z)
				arg_113_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["4037ui_story"].transform.localEulerAngles = arg_113_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["4037ui_story"].transform.position).z)
				arg_113_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["4037ui_story"].transform.localEulerAngles = arg_113_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["4037ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect4037ui_story == nil then
				arg_113_1.var_.characterEffect4037ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect4037ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_113_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_2)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect4037ui_story then
				arg_113_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_113_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_116_3 = arg_113_1.actors_["10037ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10037ui_story = var_116_3.localPosition
			end

			local var_116_4 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				var_116_3.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10037ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_4)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				var_116_3.localPosition = Vector3.New(0, 100, 0)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			local var_116_5 = arg_113_1.actors_["10037ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.characterEffect10037ui_story == nil then
				arg_113_1.var_.characterEffect10037ui_story = var_116_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_6 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_6 and not isNil(var_116_5) then
				if arg_113_1.var_.characterEffect10037ui_story and not isNil(var_116_5) then
					arg_113_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_113_1.var_.characterEffect10037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_6)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_6 and arg_113_1.time_ < 0 + var_116_6 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.characterEffect10037ui_story then
				arg_113_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_113_1.var_.characterEffect10037ui_story.fillRatio = 0.5
			end

			local var_116_7 = 0
			local var_116_8 = 0.3

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_7 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_9 = arg_113_1:GetWordFromCfg(122082027)
				local var_116_10 = arg_113_1:FormatText(var_116_9.content)

				arg_113_1.text_.text = var_116_10

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_12 = 12 <= 0 and var_116_8 or var_116_8 * (utf8.len(var_116_10) / 12)

				if (12 <= 0 and var_116_8 or var_116_8 * (utf8.len(var_116_10) / 12)) > 0 and var_116_8 < var_116_12 then
					arg_113_1.talkMaxDuration = var_116_12

					if var_116_12 + var_116_7 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_12 + var_116_7
					end
				end

				arg_113_1.text_.text = var_116_10
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082027", "story_v_out_122082.awb") ~= 0 then
					local var_116_13 = manager.audio:GetVoiceLength("story_v_out_122082", "122082027", "story_v_out_122082.awb") / 1000

					if var_116_13 + var_116_7 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_7
					end

					if var_116_9.prefab_name ~= "" and arg_113_1.actors_[var_116_9.prefab_name] ~= nil then
						local var_116_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_9.prefab_name].transform, "story_v_out_122082", "122082027", "story_v_out_122082.awb")

						arg_113_1:RecordAudio("122082027", var_116_14)
						arg_113_1:RecordAudio("122082027", var_116_14)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_122082", "122082027", "story_v_out_122082.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_122082", "122082027", "story_v_out_122082.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_15 = math.max(var_116_8, arg_113_1.talkMaxDuration)

			if var_116_7 <= arg_113_1.time_ and arg_113_1.time_ < var_116_7 + var_116_15 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_7) / var_116_15

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_7 + var_116_15 and arg_113_1.time_ < var_116_7 + var_116_15 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play122082028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 122082028
		arg_117_1.duration_ = 4.33

		local var_117_0 = {
			ja = 4.333,
			ko = 3.833,
			zh = 3.833
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
				arg_117_0:Play122082029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1184ui_story = arg_117_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1184ui_story"].transform.position).z)
				arg_117_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1184ui_story"].transform.localEulerAngles = arg_117_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_117_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1184ui_story"].transform.position).z)
				arg_117_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1184ui_story"].transform.localEulerAngles = arg_117_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action10_2")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_120_1 = arg_117_1.actors_["1184ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1184ui_story == nil then
				arg_117_1.var_.characterEffect1184ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1184ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1184ui_story then
				arg_117_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_120_4 = 0
			local var_120_5 = 0.1

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(122082028)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 4 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 4)

				if (4 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 4)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082028", "story_v_out_122082.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_122082", "122082028", "story_v_out_122082.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_122082", "122082028", "story_v_out_122082.awb")

						arg_117_1:RecordAudio("122082028", var_120_11)
						arg_117_1:RecordAudio("122082028", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_122082", "122082028", "story_v_out_122082.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_122082", "122082028", "story_v_out_122082.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_12 and arg_117_1.time_ < var_120_4 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play122082029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 122082029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play122082030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1184ui_story"]) and arg_121_1.var_.characterEffect1184ui_story == nil then
				arg_121_1.var_.characterEffect1184ui_story = arg_121_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1184ui_story"]) then
				if arg_121_1.var_.characterEffect1184ui_story and not isNil(arg_121_1.actors_["1184ui_story"]) then
					arg_121_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_0)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1184ui_story"]) and arg_121_1.var_.characterEffect1184ui_story then
				arg_121_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_124_1 = 0
			local var_124_2 = 0.175

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(122082029).content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 7 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 7)

				if (7 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 7)) > 0 and var_124_2 < var_124_5 then
					arg_121_1.talkMaxDuration = var_124_5

					if var_124_5 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + var_124_1
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_6 = math.max(var_124_2, arg_121_1.talkMaxDuration)

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_6 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_1) / var_124_6

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_1 + var_124_6 and arg_121_1.time_ < var_124_1 + var_124_6 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play122082030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 122082030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play122082031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1184ui_story = arg_125_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1184ui_story"].transform.position).z)
				arg_125_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1184ui_story"].transform.localEulerAngles = arg_125_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1184ui_story"].transform.position).z)
				arg_125_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1184ui_story"].transform.localEulerAngles = arg_125_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_128_1 = 0
			local var_128_2 = 1.9

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(122082030).content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 76 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 76)

				if (76 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 76)) > 0 and var_128_2 < var_128_5 then
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

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play122082031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 122082031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play122082032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 1.8

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(122082031).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 72 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 72)

				if (72 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 72)) > 0 and var_132_0 < var_132_3 then
					arg_129_1.talkMaxDuration = var_132_3

					if var_132_3 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_3 + 0
					end
				end

				arg_129_1.text_.text = var_132_1
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_4 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_4

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play122082032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 122082032
		arg_133_1.duration_ = 8.5

		local var_133_0 = {
			ja = 7.1,
			ko = 8.5,
			zh = 8.5
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
				arg_133_0:Play122082033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1184ui_story = arg_133_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1184ui_story, Vector3.New(-0.7, -0.97, -6), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1184ui_story"].transform.position).z)
				arg_133_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1184ui_story"].transform.localEulerAngles = arg_133_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_133_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1184ui_story"].transform.position).z)
				arg_133_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1184ui_story"].transform.localEulerAngles = arg_133_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1184ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1184ui_story == nil then
				arg_133_1.var_.characterEffect1184ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1184ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1184ui_story then
				arg_133_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_136_4 = 0
			local var_136_5 = 0.875

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(122082032)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 35 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 35)

				if (35 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 35)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082032", "story_v_out_122082.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_122082", "122082032", "story_v_out_122082.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_122082", "122082032", "story_v_out_122082.awb")

						arg_133_1:RecordAudio("122082032", var_136_11)
						arg_133_1:RecordAudio("122082032", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_122082", "122082032", "story_v_out_122082.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_122082", "122082032", "story_v_out_122082.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_12 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_12

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_12 and arg_133_1.time_ < var_136_4 + var_136_12 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play122082033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 122082033
		arg_137_1.duration_ = 3.6

		local var_137_0 = {
			ja = 3.6,
			ko = 2.733,
			zh = 2.733
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
				arg_137_0:Play122082034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos4037ui_story = arg_137_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos4037ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["4037ui_story"].transform.position).z)
				arg_137_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["4037ui_story"].transform.localEulerAngles = arg_137_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -6.2)
				arg_137_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["4037ui_story"].transform.position).z)
				arg_137_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["4037ui_story"].transform.localEulerAngles = arg_137_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["4037ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect4037ui_story == nil then
				arg_137_1.var_.characterEffect4037ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect4037ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect4037ui_story then
				arg_137_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_4 = arg_137_1.actors_["1184ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect1184ui_story == nil then
				arg_137_1.var_.characterEffect1184ui_story = var_140_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_5 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_5 and not isNil(var_140_4) then
				if arg_137_1.var_.characterEffect1184ui_story and not isNil(var_140_4) then
					arg_137_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_5)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_5 and arg_137_1.time_ < 0 + var_140_5 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect1184ui_story then
				arg_137_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_140_6 = 0
			local var_140_7 = 0.2

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_8 = arg_137_1:GetWordFromCfg(122082033)
				local var_140_9 = arg_137_1:FormatText(var_140_8.content)

				arg_137_1.text_.text = var_140_9

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 8 <= 0 and var_140_7 or var_140_7 * (utf8.len(var_140_9) / 8)

				if (8 <= 0 and var_140_7 or var_140_7 * (utf8.len(var_140_9) / 8)) > 0 and var_140_7 < var_140_11 then
					arg_137_1.talkMaxDuration = var_140_11

					if var_140_11 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_9
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082033", "story_v_out_122082.awb") ~= 0 then
					local var_140_12 = manager.audio:GetVoiceLength("story_v_out_122082", "122082033", "story_v_out_122082.awb") / 1000

					if var_140_12 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_12 + var_140_6
					end

					if var_140_8.prefab_name ~= "" and arg_137_1.actors_[var_140_8.prefab_name] ~= nil then
						local var_140_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_8.prefab_name].transform, "story_v_out_122082", "122082033", "story_v_out_122082.awb")

						arg_137_1:RecordAudio("122082033", var_140_13)
						arg_137_1:RecordAudio("122082033", var_140_13)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_122082", "122082033", "story_v_out_122082.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_122082", "122082033", "story_v_out_122082.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_14 and arg_137_1.time_ < var_140_6 + var_140_14 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play122082034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 122082034
		arg_141_1.duration_ = 5.57

		local var_141_0 = {
			ja = 5.566,
			ko = 2.766,
			zh = 2.766
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
				arg_141_0:Play122082035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1184ui_story = arg_141_1.actors_["1184ui_story"].transform.localPosition

				arg_141_1:ShowWeapon(arg_141_1.var_["1184ui_story" .. "Animator"].transform, true)
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1184ui_story, Vector3.New(-0.7, -0.97, -6), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1184ui_story"].transform.position).z)
				arg_141_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1184ui_story"].transform.localEulerAngles = arg_141_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_141_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1184ui_story"].transform.position).z)
				arg_141_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1184ui_story"].transform.localEulerAngles = arg_141_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["1184ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1184ui_story == nil then
				arg_141_1.var_.characterEffect1184ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1184ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1184ui_story then
				arg_141_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_144_4 = arg_141_1.actors_["4037ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect4037ui_story == nil then
				arg_141_1.var_.characterEffect4037ui_story = var_144_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_5 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_5 and not isNil(var_144_4) then
				if arg_141_1.var_.characterEffect4037ui_story and not isNil(var_144_4) then
					arg_141_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_141_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_5)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_5 and arg_141_1.time_ < 0 + var_144_5 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect4037ui_story then
				arg_141_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_141_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_144_6 = 0
			local var_144_7 = 0.225

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_8 = arg_141_1:GetWordFromCfg(122082034)
				local var_144_9 = arg_141_1:FormatText(var_144_8.content)

				arg_141_1.text_.text = var_144_9

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 9 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_9) / 9)

				if (9 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_9) / 9)) > 0 and var_144_7 < var_144_11 then
					arg_141_1.talkMaxDuration = var_144_11

					if var_144_11 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_6
					end
				end

				arg_141_1.text_.text = var_144_9
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082034", "story_v_out_122082.awb") ~= 0 then
					local var_144_12 = manager.audio:GetVoiceLength("story_v_out_122082", "122082034", "story_v_out_122082.awb") / 1000

					if var_144_12 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_12 + var_144_6
					end

					if var_144_8.prefab_name ~= "" and arg_141_1.actors_[var_144_8.prefab_name] ~= nil then
						local var_144_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_8.prefab_name].transform, "story_v_out_122082", "122082034", "story_v_out_122082.awb")

						arg_141_1:RecordAudio("122082034", var_144_13)
						arg_141_1:RecordAudio("122082034", var_144_13)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_122082", "122082034", "story_v_out_122082.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_122082", "122082034", "story_v_out_122082.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_14 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_14 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_6) / var_144_14

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_6 + var_144_14 and arg_141_1.time_ < var_144_6 + var_144_14 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play122082035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 122082035
		arg_145_1.duration_ = 3.23

		local var_145_0 = {
			ja = 3.233,
			ko = 1.533,
			zh = 1.533
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play122082036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos4037ui_story = arg_145_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos4037ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["4037ui_story"].transform.position).z)
				arg_145_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["4037ui_story"].transform.localEulerAngles = arg_145_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -6.2)
				arg_145_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["4037ui_story"].transform.position).z)
				arg_145_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["4037ui_story"].transform.localEulerAngles = arg_145_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["4037ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect4037ui_story == nil then
				arg_145_1.var_.characterEffect4037ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect4037ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect4037ui_story then
				arg_145_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_148_4 = arg_145_1.actors_["1184ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect1184ui_story == nil then
				arg_145_1.var_.characterEffect1184ui_story = var_148_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_5 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_5 and not isNil(var_148_4) then
				if arg_145_1.var_.characterEffect1184ui_story and not isNil(var_148_4) then
					arg_145_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_5)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_5 and arg_145_1.time_ < 0 + var_148_5 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect1184ui_story then
				arg_145_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_148_6 = 0
			local var_148_7 = 0.125

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_8 = arg_145_1:GetWordFromCfg(122082035)
				local var_148_9 = arg_145_1:FormatText(var_148_8.content)

				arg_145_1.text_.text = var_148_9

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_11 = 5 <= 0 and var_148_7 or var_148_7 * (utf8.len(var_148_9) / 5)

				if (5 <= 0 and var_148_7 or var_148_7 * (utf8.len(var_148_9) / 5)) > 0 and var_148_7 < var_148_11 then
					arg_145_1.talkMaxDuration = var_148_11

					if var_148_11 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_11 + var_148_6
					end
				end

				arg_145_1.text_.text = var_148_9
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082035", "story_v_out_122082.awb") ~= 0 then
					local var_148_12 = manager.audio:GetVoiceLength("story_v_out_122082", "122082035", "story_v_out_122082.awb") / 1000

					if var_148_12 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_12 + var_148_6
					end

					if var_148_8.prefab_name ~= "" and arg_145_1.actors_[var_148_8.prefab_name] ~= nil then
						local var_148_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_8.prefab_name].transform, "story_v_out_122082", "122082035", "story_v_out_122082.awb")

						arg_145_1:RecordAudio("122082035", var_148_13)
						arg_145_1:RecordAudio("122082035", var_148_13)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_122082", "122082035", "story_v_out_122082.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_122082", "122082035", "story_v_out_122082.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_14 = math.max(var_148_7, arg_145_1.talkMaxDuration)

			if var_148_6 <= arg_145_1.time_ and arg_145_1.time_ < var_148_6 + var_148_14 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_6) / var_148_14

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_6 + var_148_14 and arg_145_1.time_ < var_148_6 + var_148_14 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play122082036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 122082036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play122082037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos4037ui_story = arg_149_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["4037ui_story"].transform.position).z)
				arg_149_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["4037ui_story"].transform.localEulerAngles = arg_149_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["4037ui_story"].transform.position).z)
				arg_149_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["4037ui_story"].transform.localEulerAngles = arg_149_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["4037ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect4037ui_story == nil then
				arg_149_1.var_.characterEffect4037ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect4037ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_149_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_2)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect4037ui_story then
				arg_149_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_149_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_152_3 = arg_149_1.actors_["1184ui_story"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1184ui_story = var_152_3.localPosition
			end

			local var_152_4 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				var_152_3.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 0) / var_152_4)
				var_152_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_3.position).x, (manager.ui.mainCamera.transform.position - var_152_3.position).y, (manager.ui.mainCamera.transform.position - var_152_3.position).z)
				var_152_3.localEulerAngles.z = 0
				var_152_3.localEulerAngles.x = 0
				var_152_3.localEulerAngles = var_152_3.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				var_152_3.localPosition = Vector3.New(0, 100, 0)
				var_152_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_3.position).x, (manager.ui.mainCamera.transform.position - var_152_3.position).y, (manager.ui.mainCamera.transform.position - var_152_3.position).z)
				var_152_3.localEulerAngles.z = 0
				var_152_3.localEulerAngles.x = 0
				var_152_3.localEulerAngles = var_152_3.localEulerAngles
			end

			local var_152_5 = arg_149_1.actors_["1184ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.characterEffect1184ui_story == nil then
				arg_149_1.var_.characterEffect1184ui_story = var_152_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_6 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_6 and not isNil(var_152_5) then
				if arg_149_1.var_.characterEffect1184ui_story and not isNil(var_152_5) then
					arg_149_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_6)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_6 and arg_149_1.time_ < 0 + var_152_6 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.characterEffect1184ui_story then
				arg_149_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_152_7 = 0
			local var_152_8 = 1.375

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_7 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_9 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(122082036).content)

				arg_149_1.text_.text = var_152_9

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 55 <= 0 and var_152_8 or var_152_8 * (utf8.len(var_152_9) / 55)

				if (55 <= 0 and var_152_8 or var_152_8 * (utf8.len(var_152_9) / 55)) > 0 and var_152_8 < var_152_11 then
					arg_149_1.talkMaxDuration = var_152_11

					if var_152_11 + var_152_7 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_7
					end
				end

				arg_149_1.text_.text = var_152_9
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_8, arg_149_1.talkMaxDuration)

			if var_152_7 <= arg_149_1.time_ and arg_149_1.time_ < var_152_7 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_7) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_7 + var_152_12 and arg_149_1.time_ < var_152_7 + var_152_12 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play122082037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 122082037
		arg_153_1.duration_ = 6.47

		local var_153_0 = {
			ja = 5.533,
			ko = 6.466,
			zh = 6.466
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
				arg_153_0:Play122082038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1071ui_story = arg_153_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1071ui_story"].transform.position).z)
				arg_153_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1071ui_story"].transform.localEulerAngles = arg_153_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_153_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1071ui_story"].transform.position).z)
				arg_153_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1071ui_story"].transform.localEulerAngles = arg_153_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["1071ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1071ui_story == nil then
				arg_153_1.var_.characterEffect1071ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect1071ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1071ui_story then
				arg_153_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_156_4 = 0
			local var_156_5 = 0.5

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(122082037)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 20 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 20)

				if (20 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 20)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082037", "story_v_out_122082.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_out_122082", "122082037", "story_v_out_122082.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_out_122082", "122082037", "story_v_out_122082.awb")

						arg_153_1:RecordAudio("122082037", var_156_11)
						arg_153_1:RecordAudio("122082037", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_122082", "122082037", "story_v_out_122082.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_122082", "122082037", "story_v_out_122082.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play122082038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 122082038
		arg_157_1.duration_ = 11.13

		local var_157_0 = {
			ja = 11.133,
			ko = 8.3,
			zh = 8.3
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
				arg_157_0:Play122082039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos4037ui_story = arg_157_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos4037ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["4037ui_story"].transform.position).z)
				arg_157_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["4037ui_story"].transform.localEulerAngles = arg_157_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -6.2)
				arg_157_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["4037ui_story"].transform.position).z)
				arg_157_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["4037ui_story"].transform.localEulerAngles = arg_157_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["4037ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect4037ui_story == nil then
				arg_157_1.var_.characterEffect4037ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect4037ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect4037ui_story then
				arg_157_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_160_4 = arg_157_1.actors_["1071ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect1071ui_story == nil then
				arg_157_1.var_.characterEffect1071ui_story = var_160_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_5 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_5 and not isNil(var_160_4) then
				if arg_157_1.var_.characterEffect1071ui_story and not isNil(var_160_4) then
					arg_157_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_5)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_5 and arg_157_1.time_ < 0 + var_160_5 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect1071ui_story then
				arg_157_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_160_6 = 0
			local var_160_7 = 1.025

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_6 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_8 = arg_157_1:GetWordFromCfg(122082038)
				local var_160_9 = arg_157_1:FormatText(var_160_8.content)

				arg_157_1.text_.text = var_160_9

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_11 = 41 <= 0 and var_160_7 or var_160_7 * (utf8.len(var_160_9) / 41)

				if (41 <= 0 and var_160_7 or var_160_7 * (utf8.len(var_160_9) / 41)) > 0 and var_160_7 < var_160_11 then
					arg_157_1.talkMaxDuration = var_160_11

					if var_160_11 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_11 + var_160_6
					end
				end

				arg_157_1.text_.text = var_160_9
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082038", "story_v_out_122082.awb") ~= 0 then
					local var_160_12 = manager.audio:GetVoiceLength("story_v_out_122082", "122082038", "story_v_out_122082.awb") / 1000

					if var_160_12 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_12 + var_160_6
					end

					if var_160_8.prefab_name ~= "" and arg_157_1.actors_[var_160_8.prefab_name] ~= nil then
						local var_160_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_8.prefab_name].transform, "story_v_out_122082", "122082038", "story_v_out_122082.awb")

						arg_157_1:RecordAudio("122082038", var_160_13)
						arg_157_1:RecordAudio("122082038", var_160_13)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_122082", "122082038", "story_v_out_122082.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_122082", "122082038", "story_v_out_122082.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_14 = math.max(var_160_7, arg_157_1.talkMaxDuration)

			if var_160_6 <= arg_157_1.time_ and arg_157_1.time_ < var_160_6 + var_160_14 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_6) / var_160_14

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_6 + var_160_14 and arg_157_1.time_ < var_160_6 + var_160_14 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play122082039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 122082039
		arg_161_1.duration_ = 11.47

		local var_161_0 = {
			ja = 11.466,
			ko = 7.3,
			zh = 7.3
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
				arg_161_0:Play122082040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.85

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(122082039)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 34 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 34)

				if (34 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 34)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082039", "story_v_out_122082.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_122082", "122082039", "story_v_out_122082.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_122082", "122082039", "story_v_out_122082.awb")

						arg_161_1:RecordAudio("122082039", var_164_6)
						arg_161_1:RecordAudio("122082039", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_122082", "122082039", "story_v_out_122082.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_122082", "122082039", "story_v_out_122082.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play122082040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 122082040
		arg_165_1.duration_ = 4.73

		local var_165_0 = {
			ja = 4.733,
			ko = 3.433,
			zh = 3.433
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
				arg_165_0:Play122082041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1071ui_story = arg_165_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1071ui_story"].transform.position).z)
				arg_165_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1071ui_story"].transform.localEulerAngles = arg_165_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1071ui_story"].transform.position).z)
				arg_165_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1071ui_story"].transform.localEulerAngles = arg_165_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1071ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1071ui_story == nil then
				arg_165_1.var_.characterEffect1071ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1071ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_2)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1071ui_story then
				arg_165_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_168_3 = arg_165_1.actors_["1184ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1184ui_story = var_168_3.localPosition
			end

			local var_168_4 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				var_168_3.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1184ui_story, Vector3.New(-0.7, -0.97, -6), (arg_165_1.time_ - 0) / var_168_4)
				var_168_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_3.position).x, (manager.ui.mainCamera.transform.position - var_168_3.position).y, (manager.ui.mainCamera.transform.position - var_168_3.position).z)
				var_168_3.localEulerAngles.z = 0
				var_168_3.localEulerAngles.x = 0
				var_168_3.localEulerAngles = var_168_3.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				var_168_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_168_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_3.position).x, (manager.ui.mainCamera.transform.position - var_168_3.position).y, (manager.ui.mainCamera.transform.position - var_168_3.position).z)
				var_168_3.localEulerAngles.z = 0
				var_168_3.localEulerAngles.x = 0
				var_168_3.localEulerAngles = var_168_3.localEulerAngles
			end

			local var_168_5 = arg_165_1.actors_["1184ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.characterEffect1184ui_story == nil then
				arg_165_1.var_.characterEffect1184ui_story = var_168_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_6 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_6 and not isNil(var_168_5) then
				if arg_165_1.var_.characterEffect1184ui_story and not isNil(var_168_5) then
					arg_165_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_6 and arg_165_1.time_ < 0 + var_168_6 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.characterEffect1184ui_story then
				arg_165_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_168_8 = arg_165_1.actors_["4037ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_8) and arg_165_1.var_.characterEffect4037ui_story == nil then
				arg_165_1.var_.characterEffect4037ui_story = var_168_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_9 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_9 and not isNil(var_168_8) then
				if arg_165_1.var_.characterEffect4037ui_story and not isNil(var_168_8) then
					arg_165_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_165_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_9)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_9 and arg_165_1.time_ < 0 + var_168_9 + arg_168_0 and not isNil(var_168_8) and arg_165_1.var_.characterEffect4037ui_story then
				arg_165_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_165_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_168_10 = 0
			local var_168_11 = 0.275

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_12 = arg_165_1:GetWordFromCfg(122082040)
				local var_168_13 = arg_165_1:FormatText(var_168_12.content)

				arg_165_1.text_.text = var_168_13

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_15 = 11 <= 0 and var_168_11 or var_168_11 * (utf8.len(var_168_13) / 11)

				if (11 <= 0 and var_168_11 or var_168_11 * (utf8.len(var_168_13) / 11)) > 0 and var_168_11 < var_168_15 then
					arg_165_1.talkMaxDuration = var_168_15

					if var_168_15 + var_168_10 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_15 + var_168_10
					end
				end

				arg_165_1.text_.text = var_168_13
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082040", "story_v_out_122082.awb") ~= 0 then
					local var_168_16 = manager.audio:GetVoiceLength("story_v_out_122082", "122082040", "story_v_out_122082.awb") / 1000

					if var_168_16 + var_168_10 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_16 + var_168_10
					end

					if var_168_12.prefab_name ~= "" and arg_165_1.actors_[var_168_12.prefab_name] ~= nil then
						local var_168_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_12.prefab_name].transform, "story_v_out_122082", "122082040", "story_v_out_122082.awb")

						arg_165_1:RecordAudio("122082040", var_168_17)
						arg_165_1:RecordAudio("122082040", var_168_17)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_122082", "122082040", "story_v_out_122082.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_122082", "122082040", "story_v_out_122082.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_18 = math.max(var_168_11, arg_165_1.talkMaxDuration)

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_18 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_10) / var_168_18

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_10 + var_168_18 and arg_165_1.time_ < var_168_10 + var_168_18 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
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
	Play122082041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 122082041
		arg_169_1.duration_ = 14.03

		local var_169_0 = {
			ja = 9.733,
			ko = 14.033,
			zh = 14.033
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play122082042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos4037ui_story = arg_169_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos4037ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["4037ui_story"].transform.position).z)
				arg_169_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["4037ui_story"].transform.localEulerAngles = arg_169_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -6.2)
				arg_169_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["4037ui_story"].transform.position).z)
				arg_169_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["4037ui_story"].transform.localEulerAngles = arg_169_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["4037ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect4037ui_story == nil then
				arg_169_1.var_.characterEffect4037ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect4037ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect4037ui_story then
				arg_169_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_172_4 = arg_169_1.actors_["1184ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_4) and arg_169_1.var_.characterEffect1184ui_story == nil then
				arg_169_1.var_.characterEffect1184ui_story = var_172_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_5 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_5 and not isNil(var_172_4) then
				if arg_169_1.var_.characterEffect1184ui_story and not isNil(var_172_4) then
					arg_169_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_5)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_5 and arg_169_1.time_ < 0 + var_172_5 + arg_172_0 and not isNil(var_172_4) and arg_169_1.var_.characterEffect1184ui_story then
				arg_169_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_172_6 = 0
			local var_172_7 = 1.25

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_8 = arg_169_1:GetWordFromCfg(122082041)
				local var_172_9 = arg_169_1:FormatText(var_172_8.content)

				arg_169_1.text_.text = var_172_9

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 50 <= 0 and var_172_7 or var_172_7 * (utf8.len(var_172_9) / 50)

				if (50 <= 0 and var_172_7 or var_172_7 * (utf8.len(var_172_9) / 50)) > 0 and var_172_7 < var_172_11 then
					arg_169_1.talkMaxDuration = var_172_11

					if var_172_11 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_11 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_9
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082041", "story_v_out_122082.awb") ~= 0 then
					local var_172_12 = manager.audio:GetVoiceLength("story_v_out_122082", "122082041", "story_v_out_122082.awb") / 1000

					if var_172_12 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_12 + var_172_6
					end

					if var_172_8.prefab_name ~= "" and arg_169_1.actors_[var_172_8.prefab_name] ~= nil then
						local var_172_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_8.prefab_name].transform, "story_v_out_122082", "122082041", "story_v_out_122082.awb")

						arg_169_1:RecordAudio("122082041", var_172_13)
						arg_169_1:RecordAudio("122082041", var_172_13)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_122082", "122082041", "story_v_out_122082.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_122082", "122082041", "story_v_out_122082.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_14 = math.max(var_172_7, arg_169_1.talkMaxDuration)

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_14 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_6) / var_172_14

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_6 + var_172_14 and arg_169_1.time_ < var_172_6 + var_172_14 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play122082042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 122082042
		arg_173_1.duration_ = 18.73

		local var_173_0 = {
			ja = 18.733,
			ko = 11.633,
			zh = 11.633
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play122082043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 1.175

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_1 = arg_173_1:GetWordFromCfg(122082042)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 47 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 47)

				if (47 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 47)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082042", "story_v_out_122082.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_out_122082", "122082042", "story_v_out_122082.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_out_122082", "122082042", "story_v_out_122082.awb")

						arg_173_1:RecordAudio("122082042", var_176_6)
						arg_173_1:RecordAudio("122082042", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_122082", "122082042", "story_v_out_122082.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_122082", "122082042", "story_v_out_122082.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play122082043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 122082043
		arg_177_1.duration_ = 8.6

		local var_177_0 = {
			ja = 8.6,
			ko = 7.6,
			zh = 7.6
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
				arg_177_0:Play122082044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1184ui_story"]) and arg_177_1.var_.characterEffect1184ui_story == nil then
				arg_177_1.var_.characterEffect1184ui_story = arg_177_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1184ui_story"]) then
				if arg_177_1.var_.characterEffect1184ui_story and not isNil(arg_177_1.actors_["1184ui_story"]) then
					arg_177_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1184ui_story"]) and arg_177_1.var_.characterEffect1184ui_story then
				arg_177_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_180_2 = arg_177_1.actors_["4037ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect4037ui_story == nil then
				arg_177_1.var_.characterEffect4037ui_story = var_180_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_3 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.characterEffect4037ui_story and not isNil(var_180_2) then
					arg_177_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_177_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_3)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect4037ui_story then
				arg_177_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_177_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_180_4 = arg_177_1.actors_["1184ui_story"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1184ui_story = var_180_4.localPosition

				arg_177_1:ShowWeapon(arg_177_1.var_["1184ui_story" .. "Animator"].transform, true)
			end

			local var_180_5 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_5 then
				var_180_4.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1184ui_story, Vector3.New(-0.7, -0.97, -6), (arg_177_1.time_ - 0) / var_180_5)
				var_180_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_4.position).x, (manager.ui.mainCamera.transform.position - var_180_4.position).y, (manager.ui.mainCamera.transform.position - var_180_4.position).z)
				var_180_4.localEulerAngles.z = 0
				var_180_4.localEulerAngles.x = 0
				var_180_4.localEulerAngles = var_180_4.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_5 and arg_177_1.time_ < 0 + var_180_5 + arg_180_0 then
				var_180_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_180_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_4.position).x, (manager.ui.mainCamera.transform.position - var_180_4.position).y, (manager.ui.mainCamera.transform.position - var_180_4.position).z)
				var_180_4.localEulerAngles.z = 0
				var_180_4.localEulerAngles.x = 0
				var_180_4.localEulerAngles = var_180_4.localEulerAngles
			end

			local var_180_6 = 0
			local var_180_7 = 0.75

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_8 = arg_177_1:GetWordFromCfg(122082043)
				local var_180_9 = arg_177_1:FormatText(var_180_8.content)

				arg_177_1.text_.text = var_180_9

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_11 = 30 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_9) / 30)

				if (30 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_9) / 30)) > 0 and var_180_7 < var_180_11 then
					arg_177_1.talkMaxDuration = var_180_11

					if var_180_11 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_11 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_9
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082043", "story_v_out_122082.awb") ~= 0 then
					local var_180_12 = manager.audio:GetVoiceLength("story_v_out_122082", "122082043", "story_v_out_122082.awb") / 1000

					if var_180_12 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_12 + var_180_6
					end

					if var_180_8.prefab_name ~= "" and arg_177_1.actors_[var_180_8.prefab_name] ~= nil then
						local var_180_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_8.prefab_name].transform, "story_v_out_122082", "122082043", "story_v_out_122082.awb")

						arg_177_1:RecordAudio("122082043", var_180_13)
						arg_177_1:RecordAudio("122082043", var_180_13)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_122082", "122082043", "story_v_out_122082.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_122082", "122082043", "story_v_out_122082.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_14 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_14 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_6) / var_180_14

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_6 + var_180_14 and arg_177_1.time_ < var_180_6 + var_180_14 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play122082044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 122082044
		arg_181_1.duration_ = 10.67

		local var_181_0 = {
			ja = 10.666,
			ko = 9.1,
			zh = 9.1
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play122082045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["4037ui_story"]) and arg_181_1.var_.characterEffect4037ui_story == nil then
				arg_181_1.var_.characterEffect4037ui_story = arg_181_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["4037ui_story"]) then
				if arg_181_1.var_.characterEffect4037ui_story and not isNil(arg_181_1.actors_["4037ui_story"]) then
					arg_181_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["4037ui_story"]) and arg_181_1.var_.characterEffect4037ui_story then
				arg_181_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_184_2 = arg_181_1.actors_["1184ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.characterEffect1184ui_story == nil then
				arg_181_1.var_.characterEffect1184ui_story = var_184_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_3 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.characterEffect1184ui_story and not isNil(var_184_2) then
					arg_181_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_3)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.characterEffect1184ui_story then
				arg_181_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_184_4 = 0
			local var_184_5 = 0.85

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_6 = arg_181_1:GetWordFromCfg(122082044)
				local var_184_7 = arg_181_1:FormatText(var_184_6.content)

				arg_181_1.text_.text = var_184_7

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_9 = 34 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 34)

				if (34 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 34)) > 0 and var_184_5 < var_184_9 then
					arg_181_1.talkMaxDuration = var_184_9

					if var_184_9 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_4
					end
				end

				arg_181_1.text_.text = var_184_7
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082044", "story_v_out_122082.awb") ~= 0 then
					local var_184_10 = manager.audio:GetVoiceLength("story_v_out_122082", "122082044", "story_v_out_122082.awb") / 1000

					if var_184_10 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_4
					end

					if var_184_6.prefab_name ~= "" and arg_181_1.actors_[var_184_6.prefab_name] ~= nil then
						local var_184_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_6.prefab_name].transform, "story_v_out_122082", "122082044", "story_v_out_122082.awb")

						arg_181_1:RecordAudio("122082044", var_184_11)
						arg_181_1:RecordAudio("122082044", var_184_11)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_122082", "122082044", "story_v_out_122082.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_122082", "122082044", "story_v_out_122082.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_12 = math.max(var_184_5, arg_181_1.talkMaxDuration)

			if var_184_4 <= arg_181_1.time_ and arg_181_1.time_ < var_184_4 + var_184_12 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_4) / var_184_12

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_4 + var_184_12 and arg_181_1.time_ < var_184_4 + var_184_12 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play122082045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 122082045
		arg_185_1.duration_ = 12.63

		local var_185_0 = {
			ja = 11.733,
			ko = 12.633,
			zh = 12.633
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play122082046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 1.3

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:GetWordFromCfg(122082045)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 52 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 52)

				if (52 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 52)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082045", "story_v_out_122082.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_122082", "122082045", "story_v_out_122082.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_122082", "122082045", "story_v_out_122082.awb")

						arg_185_1:RecordAudio("122082045", var_188_6)
						arg_185_1:RecordAudio("122082045", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_122082", "122082045", "story_v_out_122082.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_122082", "122082045", "story_v_out_122082.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play122082046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 122082046
		arg_189_1.duration_ = 10.6

		local var_189_0 = {
			ja = 10.566,
			ko = 10.6,
			zh = 10.6
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play122082047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 1

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:GetWordFromCfg(122082046)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 40 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 40)

				if (40 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 40)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082046", "story_v_out_122082.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_122082", "122082046", "story_v_out_122082.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_122082", "122082046", "story_v_out_122082.awb")

						arg_189_1:RecordAudio("122082046", var_192_6)
						arg_189_1:RecordAudio("122082046", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_122082", "122082046", "story_v_out_122082.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_122082", "122082046", "story_v_out_122082.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play122082047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 122082047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play122082048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos4037ui_story = arg_193_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["4037ui_story"].transform.position).z)
				arg_193_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["4037ui_story"].transform.localEulerAngles = arg_193_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["4037ui_story"].transform.position).z)
				arg_193_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["4037ui_story"].transform.localEulerAngles = arg_193_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["4037ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect4037ui_story == nil then
				arg_193_1.var_.characterEffect4037ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect4037ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_193_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_2)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect4037ui_story then
				arg_193_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_193_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_196_3 = arg_193_1.actors_["1184ui_story"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1184ui_story = var_196_3.localPosition
			end

			local var_196_4 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				var_196_3.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_193_1.time_ - 0) / var_196_4)
				var_196_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_3.position).x, (manager.ui.mainCamera.transform.position - var_196_3.position).y, (manager.ui.mainCamera.transform.position - var_196_3.position).z)
				var_196_3.localEulerAngles.z = 0
				var_196_3.localEulerAngles.x = 0
				var_196_3.localEulerAngles = var_196_3.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				var_196_3.localPosition = Vector3.New(0, 100, 0)
				var_196_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_3.position).x, (manager.ui.mainCamera.transform.position - var_196_3.position).y, (manager.ui.mainCamera.transform.position - var_196_3.position).z)
				var_196_3.localEulerAngles.z = 0
				var_196_3.localEulerAngles.x = 0
				var_196_3.localEulerAngles = var_196_3.localEulerAngles
			end

			local var_196_5 = arg_193_1.actors_["1184ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.characterEffect1184ui_story == nil then
				arg_193_1.var_.characterEffect1184ui_story = var_196_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_6 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_6 and not isNil(var_196_5) then
				if arg_193_1.var_.characterEffect1184ui_story and not isNil(var_196_5) then
					arg_193_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_6)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_6 and arg_193_1.time_ < 0 + var_196_6 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.characterEffect1184ui_story then
				arg_193_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_196_7 = 0
			local var_196_8 = 1.15

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_7 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_9 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(122082047).content)

				arg_193_1.text_.text = var_196_9

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_11 = 46 <= 0 and var_196_8 or var_196_8 * (utf8.len(var_196_9) / 46)

				if (46 <= 0 and var_196_8 or var_196_8 * (utf8.len(var_196_9) / 46)) > 0 and var_196_8 < var_196_11 then
					arg_193_1.talkMaxDuration = var_196_11

					if var_196_11 + var_196_7 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_11 + var_196_7
					end
				end

				arg_193_1.text_.text = var_196_9
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_12 = math.max(var_196_8, arg_193_1.talkMaxDuration)

			if var_196_7 <= arg_193_1.time_ and arg_193_1.time_ < var_196_7 + var_196_12 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_7) / var_196_12

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_7 + var_196_12 and arg_193_1.time_ < var_196_7 + var_196_12 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play122082048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 122082048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play122082049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.7

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(122082048).content)

				arg_197_1.text_.text = var_200_1

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_3 = 28 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 28)

				if (28 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 28)) > 0 and var_200_0 < var_200_3 then
					arg_197_1.talkMaxDuration = var_200_3

					if var_200_3 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_3 + 0
					end
				end

				arg_197_1.text_.text = var_200_1
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_4 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_4

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play122082049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 122082049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play122082050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 1.775

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(122082049).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 71 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 71)

				if (71 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 71)) > 0 and var_204_0 < var_204_3 then
					arg_201_1.talkMaxDuration = var_204_3

					if var_204_3 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_3 + 0
					end
				end

				arg_201_1.text_.text = var_204_1
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_4 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_4

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play122082050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 122082050
		arg_205_1.duration_ = 2.43

		local var_205_0 = {
			ja = 2.433,
			ko = 1.7,
			zh = 1.7
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play122082051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.1

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_1 = arg_205_1:GetWordFromCfg(122082050)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 4 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 4)

				if (4 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 4)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082050", "story_v_out_122082.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_122082", "122082050", "story_v_out_122082.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_122082", "122082050", "story_v_out_122082.awb")

						arg_205_1:RecordAudio("122082050", var_208_6)
						arg_205_1:RecordAudio("122082050", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_122082", "122082050", "story_v_out_122082.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_122082", "122082050", "story_v_out_122082.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play122082051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 122082051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play122082052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 1.175

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(122082051).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 47 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 47)

				if (47 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 47)) > 0 and var_212_0 < var_212_3 then
					arg_209_1.talkMaxDuration = var_212_3

					if var_212_3 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_3 + 0
					end
				end

				arg_209_1.text_.text = var_212_1
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_4 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_4

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play122082052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 122082052
		arg_213_1.duration_ = 2.4

		local var_213_0 = {
			ja = 2.4,
			ko = 1.866,
			zh = 1.866
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play122082053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos4037ui_story = arg_213_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["4037ui_story"].transform.position).z)
				arg_213_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["4037ui_story"].transform.localEulerAngles = arg_213_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_213_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["4037ui_story"].transform.position).z)
				arg_213_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["4037ui_story"].transform.localEulerAngles = arg_213_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["4037ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect4037ui_story == nil then
				arg_213_1.var_.characterEffect4037ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect4037ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect4037ui_story then
				arg_213_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_216_4 = 0
			local var_216_5 = 0.175

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_6 = arg_213_1:GetWordFromCfg(122082052)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 7 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 7)

				if (7 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 7)) > 0 and var_216_5 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082052", "story_v_out_122082.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_out_122082", "122082052", "story_v_out_122082.awb") / 1000

					if var_216_10 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_4
					end

					if var_216_6.prefab_name ~= "" and arg_213_1.actors_[var_216_6.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_6.prefab_name].transform, "story_v_out_122082", "122082052", "story_v_out_122082.awb")

						arg_213_1:RecordAudio("122082052", var_216_11)
						arg_213_1:RecordAudio("122082052", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_122082", "122082052", "story_v_out_122082.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_122082", "122082052", "story_v_out_122082.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_12 and arg_213_1.time_ < var_216_4 + var_216_12 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play122082053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 122082053
		arg_217_1.duration_ = 4.4

		local var_217_0 = {
			ja = 4,
			ko = 4.4,
			zh = 4.4
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play122082054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos4037ui_story = arg_217_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["4037ui_story"].transform.position).z)
				arg_217_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["4037ui_story"].transform.localEulerAngles = arg_217_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_217_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["4037ui_story"].transform.position).z)
				arg_217_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["4037ui_story"].transform.localEulerAngles = arg_217_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_220_1 = arg_217_1.actors_["4037ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect4037ui_story == nil then
				arg_217_1.var_.characterEffect4037ui_story = var_220_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 and not isNil(var_220_1) then
				if arg_217_1.var_.characterEffect4037ui_story and not isNil(var_220_1) then
					arg_217_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_217_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_2)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect4037ui_story then
				arg_217_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_217_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_220_3 = 0
			local var_220_4 = 0.35

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_3 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_5 = arg_217_1:GetWordFromCfg(122082053)
				local var_220_6 = arg_217_1:FormatText(var_220_5.content)

				arg_217_1.text_.text = var_220_6

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_8 = 14 <= 0 and var_220_4 or var_220_4 * (utf8.len(var_220_6) / 14)

				if (14 <= 0 and var_220_4 or var_220_4 * (utf8.len(var_220_6) / 14)) > 0 and var_220_4 < var_220_8 then
					arg_217_1.talkMaxDuration = var_220_8

					if var_220_8 + var_220_3 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_3
					end
				end

				arg_217_1.text_.text = var_220_6
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082053", "story_v_out_122082.awb") ~= 0 then
					local var_220_9 = manager.audio:GetVoiceLength("story_v_out_122082", "122082053", "story_v_out_122082.awb") / 1000

					if var_220_9 + var_220_3 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_9 + var_220_3
					end

					if var_220_5.prefab_name ~= "" and arg_217_1.actors_[var_220_5.prefab_name] ~= nil then
						local var_220_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_5.prefab_name].transform, "story_v_out_122082", "122082053", "story_v_out_122082.awb")

						arg_217_1:RecordAudio("122082053", var_220_10)
						arg_217_1:RecordAudio("122082053", var_220_10)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_122082", "122082053", "story_v_out_122082.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_122082", "122082053", "story_v_out_122082.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_11 = math.max(var_220_4, arg_217_1.talkMaxDuration)

			if var_220_3 <= arg_217_1.time_ and arg_217_1.time_ < var_220_3 + var_220_11 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_3) / var_220_11

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_3 + var_220_11 and arg_217_1.time_ < var_220_3 + var_220_11 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play122082054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 122082054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play122082055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 1.1

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_1 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(122082054).content)

				arg_221_1.text_.text = var_224_1

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_3 = 44 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 44)

				if (44 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 44)) > 0 and var_224_0 < var_224_3 then
					arg_221_1.talkMaxDuration = var_224_3

					if var_224_3 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_3 + 0
					end
				end

				arg_221_1.text_.text = var_224_1
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_4 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_4 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_4

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_4 and arg_221_1.time_ < 0 + var_224_4 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play122082055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 122082055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play122082056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0.933333333333333 < arg_225_1.time_ and arg_225_1.time_ <= 0.933333333333333 + arg_228_0 then
				arg_225_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_switch", "")
			end

			local var_228_1 = 0
			local var_228_2 = 1.8

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_3 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(122082055).content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 72 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 72)

				if (72 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 72)) > 0 and var_228_2 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_6 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_6 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_6

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_6 and arg_225_1.time_ < var_228_1 + var_228_6 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play122082056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 122082056
		arg_229_1.duration_ = 5.8

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play122082057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = false

				arg_229_1:SetGaussion(false)
			end

			local var_232_0 = 3

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				local var_232_1 = Color.New(1, 1, 1)

				var_232_1.a = Mathf.Lerp(1, 0, (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.mask_.color = var_232_1
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				local var_232_2 = Color.New(1, 1, 1)

				arg_229_1.mask_.enabled = false
				var_232_2.a = 0
				arg_229_1.mask_.color = var_232_2
			end

			local var_232_3 = "J08f_blur"

			if arg_229_1.bgs_.J08f_blur == nil then
				local var_232_4 = Object.Instantiate(arg_229_1.blurPaintGo_)

				var_232_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_232_3)
				var_232_4.name = var_232_3
				var_232_4.transform.parent = arg_229_1.stage_.transform
				var_232_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_229_1.bgs_[var_232_3] = var_232_4
			end

			local var_232_5 = 0
			local var_232_6 = arg_229_1.bgs_[var_232_3]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 then
				var_232_6.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_232_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_232_7 = var_232_6:GetComponent("SpriteRenderer")

				if var_232_7 and var_232_7.sprite then
					local var_232_8 = 2 * (var_232_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_232_6.transform.localScale = Vector3.New(var_232_8 / var_232_7.sprite.bounds.size.y < var_232_8 * manager.ui.mainCameraCom_.aspect / var_232_7.sprite.bounds.size.x and var_232_8 * manager.ui.mainCameraCom_.aspect / var_232_7.sprite.bounds.size.x or var_232_8 / var_232_7.sprite.bounds.size.y, var_232_8 / var_232_7.sprite.bounds.size.y < var_232_8 * manager.ui.mainCameraCom_.aspect / var_232_7.sprite.bounds.size.x and var_232_8 * manager.ui.mainCameraCom_.aspect / var_232_7.sprite.bounds.size.x or var_232_8 / var_232_7.sprite.bounds.size.y, 0)
				end
			end

			local var_232_9 = 3

			if var_232_5 <= arg_229_1.time_ and arg_229_1.time_ < var_232_5 + var_232_9 then
				local var_232_10 = Color.New(1, 1, 1)

				var_232_10.a = Mathf.Lerp(0, 1, (arg_229_1.time_ - var_232_5) / var_232_9)

				var_232_6:GetComponent("SpriteRenderer").material:SetColor("_Color", var_232_10)
			end

			if 1.93333333333333 < arg_229_1.time_ and arg_229_1.time_ <= 1.93333333333333 + arg_232_0 then
				arg_229_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_spacejump", "")
			end

			if arg_229_1.frameCnt_ <= 1 then
				arg_229_1.dialog_:SetActive(false)
			end

			local var_232_12 = 0.8
			local var_232_13 = 1.525

			if 0.8 < arg_229_1.time_ and arg_229_1.time_ <= var_232_12 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				arg_229_1.dialog_:SetActive(true)

				arg_229_1.dialogCg_.alpha = 0

				local var_232_14 = LeanTween.value(arg_229_1.dialog_, 0, 1, 0.3)

				var_232_14:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_229_1.dialogCg_.alpha = arg_233_0
				end))
				var_232_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_229_1.dialog_)
					var_232_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_229_1.duration_ = arg_229_1.duration_ + 0.3

				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_15 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(122082056).content)

				arg_229_1.text_.text = var_232_15

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_17 = 61 <= 0 and var_232_13 or var_232_13 * (utf8.len(var_232_15) / 61)

				if (61 <= 0 and var_232_13 or var_232_13 * (utf8.len(var_232_15) / 61)) > 0 and var_232_13 < var_232_17 then
					arg_229_1.talkMaxDuration = var_232_17
					var_232_12 = var_232_12 + 0.3

					if var_232_17 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_17 + var_232_12
					end
				end

				arg_229_1.text_.text = var_232_15
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_18 = var_232_12 + 0.3
			local var_232_19 = math.max(var_232_13, arg_229_1.talkMaxDuration)

			if var_232_12 + 0.3 <= arg_229_1.time_ and arg_229_1.time_ < var_232_18 + var_232_19 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_18) / var_232_19

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_18 + var_232_19 and arg_229_1.time_ < var_232_18 + var_232_19 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play122082057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 122082057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play122082058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.6

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(122082057).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 24 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 24)

				if (24 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 24)) > 0 and var_238_0 < var_238_3 then
					arg_235_1.talkMaxDuration = var_238_3

					if var_238_3 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_3 + 0
					end
				end

				arg_235_1.text_.text = var_238_1
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_4 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_4

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play122082058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 122082058
		arg_239_1.duration_ = 9

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play122082059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if arg_239_1.bgs_.J08g == nil then
				local var_242_0 = Object.Instantiate(arg_239_1.paintGo_)

				var_242_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J08g")
				var_242_0.name = "J08g"
				var_242_0.transform.parent = arg_239_1.stage_.transform
				var_242_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_239_1.bgs_.J08g = var_242_0
			end

			if 2 < arg_239_1.time_ and arg_239_1.time_ <= 2 + arg_242_0 then
				local var_242_1 = arg_239_1.bgs_.J08g

				arg_239_1.bgs_.J08g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_242_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_242_2 = var_242_1:GetComponent("SpriteRenderer")

				if var_242_2 and var_242_2.sprite then
					local var_242_3 = 2 * (var_242_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_242_1.transform.localScale = Vector3.New(var_242_3 / var_242_2.sprite.bounds.size.y < var_242_3 * manager.ui.mainCameraCom_.aspect / var_242_2.sprite.bounds.size.x and var_242_3 * manager.ui.mainCameraCom_.aspect / var_242_2.sprite.bounds.size.x or var_242_3 / var_242_2.sprite.bounds.size.y, var_242_3 / var_242_2.sprite.bounds.size.y < var_242_3 * manager.ui.mainCameraCom_.aspect / var_242_2.sprite.bounds.size.x and var_242_3 * manager.ui.mainCameraCom_.aspect / var_242_2.sprite.bounds.size.x or var_242_3 / var_242_2.sprite.bounds.size.y, 0)
				end

				for iter_242_0, iter_242_1 in pairs(arg_239_1.bgs_) do
					if iter_242_0 ~= "J08g" then
						iter_242_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_242_4 = 0

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.mask_.enabled = true
				arg_239_1.mask_.raycastTarget = true

				arg_239_1:SetGaussion(false)
			end

			local var_242_5 = 2

			if var_242_4 <= arg_239_1.time_ and arg_239_1.time_ < var_242_4 + var_242_5 then
				local var_242_6 = Color.New(0, 0, 0)

				var_242_6.a = Mathf.Lerp(0, 1, (arg_239_1.time_ - var_242_4) / var_242_5)
				arg_239_1.mask_.color = var_242_6
			end

			if arg_239_1.time_ >= var_242_4 + var_242_5 and arg_239_1.time_ < var_242_4 + var_242_5 + arg_242_0 then
				local var_242_7 = Color.New(0, 0, 0)

				var_242_7.a = 1
				arg_239_1.mask_.color = var_242_7
			end

			local var_242_8 = 2

			if 2 < arg_239_1.time_ and arg_239_1.time_ <= var_242_8 + arg_242_0 then
				arg_239_1.mask_.enabled = true
				arg_239_1.mask_.raycastTarget = true

				arg_239_1:SetGaussion(false)
			end

			local var_242_9 = 2

			if var_242_8 <= arg_239_1.time_ and arg_239_1.time_ < var_242_8 + var_242_9 then
				local var_242_10 = Color.New(0, 0, 0)

				var_242_10.a = Mathf.Lerp(1, 0, (arg_239_1.time_ - var_242_8) / var_242_9)
				arg_239_1.mask_.color = var_242_10
			end

			if arg_239_1.time_ >= var_242_8 + var_242_9 and arg_239_1.time_ < var_242_8 + var_242_9 + arg_242_0 then
				local var_242_11 = Color.New(0, 0, 0)

				arg_239_1.mask_.enabled = false
				var_242_11.a = 0
				arg_239_1.mask_.color = var_242_11
			end

			if arg_239_1.frameCnt_ <= 1 then
				arg_239_1.dialog_:SetActive(false)
			end

			local var_242_12 = 4
			local var_242_13 = 1.175

			if 4 < arg_239_1.time_ and arg_239_1.time_ <= var_242_12 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0

				arg_239_1.dialog_:SetActive(true)

				arg_239_1.dialogCg_.alpha = 0

				local var_242_14 = LeanTween.value(arg_239_1.dialog_, 0, 1, 0.3)

				var_242_14:setOnUpdate(LuaHelper.FloatAction(function(arg_243_0)
					arg_239_1.dialogCg_.alpha = arg_243_0
				end))
				var_242_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_239_1.dialog_)
					var_242_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_239_1.duration_ = arg_239_1.duration_ + 0.3

				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_15 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(122082058).content)

				arg_239_1.text_.text = var_242_15

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_17 = 47 <= 0 and var_242_13 or var_242_13 * (utf8.len(var_242_15) / 47)

				if (47 <= 0 and var_242_13 or var_242_13 * (utf8.len(var_242_15) / 47)) > 0 and var_242_13 < var_242_17 then
					arg_239_1.talkMaxDuration = var_242_17
					var_242_12 = var_242_12 + 0.3

					if var_242_17 + var_242_12 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_17 + var_242_12
					end
				end

				arg_239_1.text_.text = var_242_15
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_18 = var_242_12 + 0.3
			local var_242_19 = math.max(var_242_13, arg_239_1.talkMaxDuration)

			if var_242_12 + 0.3 <= arg_239_1.time_ and arg_239_1.time_ < var_242_18 + var_242_19 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_18) / var_242_19

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_18 + var_242_19 and arg_239_1.time_ < var_242_18 + var_242_19 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play122082059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 122082059
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play122082060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 1.35

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_1 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(122082059).content)

				arg_245_1.text_.text = var_248_1

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_3 = 53 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 53)

				if (53 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 53)) > 0 and var_248_0 < var_248_3 then
					arg_245_1.talkMaxDuration = var_248_3

					if var_248_3 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_3 + 0
					end
				end

				arg_245_1.text_.text = var_248_1
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_4 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_4

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play122082060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 122082060
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play122082061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0.975

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_1 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(122082060).content)

				arg_249_1.text_.text = var_252_1

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_3 = 39 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 39)

				if (39 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 39)) > 0 and var_252_0 < var_252_3 then
					arg_249_1.talkMaxDuration = var_252_3

					if var_252_3 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_3 + 0
					end
				end

				arg_249_1.text_.text = var_252_1
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_4 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_4

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play122082061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 122082061
		arg_253_1.duration_ = 2.47

		local var_253_0 = {
			ja = 2.466,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play122082062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos4037ui_story = arg_253_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["4037ui_story"].transform.position).z)
				arg_253_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["4037ui_story"].transform.localEulerAngles = arg_253_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_253_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["4037ui_story"].transform.position).z)
				arg_253_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["4037ui_story"].transform.localEulerAngles = arg_253_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["4037ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect4037ui_story == nil then
				arg_253_1.var_.characterEffect4037ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect4037ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect4037ui_story then
				arg_253_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_256_4 = 0
			local var_256_5 = 0.125

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_6 = arg_253_1:GetWordFromCfg(122082061)
				local var_256_7 = arg_253_1:FormatText(var_256_6.content)

				arg_253_1.text_.text = var_256_7

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_9 = 5 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 5)

				if (5 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 5)) > 0 and var_256_5 < var_256_9 then
					arg_253_1.talkMaxDuration = var_256_9

					if var_256_9 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_9 + var_256_4
					end
				end

				arg_253_1.text_.text = var_256_7
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082061", "story_v_out_122082.awb") ~= 0 then
					local var_256_10 = manager.audio:GetVoiceLength("story_v_out_122082", "122082061", "story_v_out_122082.awb") / 1000

					if var_256_10 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_10 + var_256_4
					end

					if var_256_6.prefab_name ~= "" and arg_253_1.actors_[var_256_6.prefab_name] ~= nil then
						local var_256_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_6.prefab_name].transform, "story_v_out_122082", "122082061", "story_v_out_122082.awb")

						arg_253_1:RecordAudio("122082061", var_256_11)
						arg_253_1:RecordAudio("122082061", var_256_11)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_122082", "122082061", "story_v_out_122082.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_122082", "122082061", "story_v_out_122082.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_12 = math.max(var_256_5, arg_253_1.talkMaxDuration)

			if var_256_4 <= arg_253_1.time_ and arg_253_1.time_ < var_256_4 + var_256_12 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_4) / var_256_12

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_4 + var_256_12 and arg_253_1.time_ < var_256_4 + var_256_12 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play122082062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 122082062
		arg_257_1.duration_ = 5.6

		local var_257_0 = {
			ja = 5.6,
			ko = 5.433,
			zh = 5.433
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play122082063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["4037ui_story"]) and arg_257_1.var_.characterEffect4037ui_story == nil then
				arg_257_1.var_.characterEffect4037ui_story = arg_257_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_0 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["4037ui_story"]) then
				if arg_257_1.var_.characterEffect4037ui_story and not isNil(arg_257_1.actors_["4037ui_story"]) then
					arg_257_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_257_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_0)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["4037ui_story"]) and arg_257_1.var_.characterEffect4037ui_story then
				arg_257_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_257_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_260_1 = 0
			local var_260_2 = 0.75

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_3 = arg_257_1:GetWordFromCfg(122082062)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_6 = 30 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_4) / 30)

				if (30 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_4) / 30)) > 0 and var_260_2 < var_260_6 then
					arg_257_1.talkMaxDuration = var_260_6

					if var_260_6 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_6 + var_260_1
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082062", "story_v_out_122082.awb") ~= 0 then
					local var_260_7 = manager.audio:GetVoiceLength("story_v_out_122082", "122082062", "story_v_out_122082.awb") / 1000

					if var_260_7 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_1
					end

					if var_260_3.prefab_name ~= "" and arg_257_1.actors_[var_260_3.prefab_name] ~= nil then
						local var_260_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_3.prefab_name].transform, "story_v_out_122082", "122082062", "story_v_out_122082.awb")

						arg_257_1:RecordAudio("122082062", var_260_8)
						arg_257_1:RecordAudio("122082062", var_260_8)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_122082", "122082062", "story_v_out_122082.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_122082", "122082062", "story_v_out_122082.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_9 = math.max(var_260_2, arg_257_1.talkMaxDuration)

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_9 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_1) / var_260_9

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_1 + var_260_9 and arg_257_1.time_ < var_260_1 + var_260_9 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play122082063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 122082063
		arg_261_1.duration_ = 15.27

		local var_261_0 = {
			ja = 15.266,
			ko = 12.166,
			zh = 12.166
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play122082064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 1.525

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_1 = arg_261_1:GetWordFromCfg(122082063)
				local var_264_2 = arg_261_1:FormatText(var_264_1.content)

				arg_261_1.text_.text = var_264_2

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 61 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 61)

				if (61 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 61)) > 0 and var_264_0 < var_264_4 then
					arg_261_1.talkMaxDuration = var_264_4

					if var_264_4 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_4 + 0
					end
				end

				arg_261_1.text_.text = var_264_2
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082063", "story_v_out_122082.awb") ~= 0 then
					local var_264_5 = manager.audio:GetVoiceLength("story_v_out_122082", "122082063", "story_v_out_122082.awb") / 1000

					if var_264_5 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + 0
					end

					if var_264_1.prefab_name ~= "" and arg_261_1.actors_[var_264_1.prefab_name] ~= nil then
						local var_264_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_1.prefab_name].transform, "story_v_out_122082", "122082063", "story_v_out_122082.awb")

						arg_261_1:RecordAudio("122082063", var_264_6)
						arg_261_1:RecordAudio("122082063", var_264_6)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_122082", "122082063", "story_v_out_122082.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_122082", "122082063", "story_v_out_122082.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_7 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_7 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_7

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_7 and arg_261_1.time_ < 0 + var_264_7 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play122082064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 122082064
		arg_265_1.duration_ = 4.77

		local var_265_0 = {
			ja = 4.766,
			ko = 3.9,
			zh = 3.9
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play122082065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos4037ui_story = arg_265_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos4037ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["4037ui_story"].transform.position).z)
				arg_265_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["4037ui_story"].transform.localEulerAngles = arg_265_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				arg_265_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["4037ui_story"].transform.position).z)
				arg_265_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["4037ui_story"].transform.localEulerAngles = arg_265_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_268_1 = arg_265_1.actors_["1071ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1071ui_story == nil then
				arg_265_1.var_.characterEffect1071ui_story = var_268_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_2 and not isNil(var_268_1) then
				if arg_265_1.var_.characterEffect1071ui_story and not isNil(var_268_1) then
					arg_265_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_2)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_2 and arg_265_1.time_ < 0 + var_268_2 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1071ui_story then
				arg_265_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_268_3 = "10045ui_story"

			if arg_265_1.actors_["10045ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10045ui_story"))) then
				local var_268_4 = Object.Instantiate(Asset.Load("Char/" .. "10045ui_story"), arg_265_1.stage_.transform)

				var_268_4.name = var_268_3
				var_268_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_265_1.actors_[var_268_3] = var_268_4

				local var_268_5 = var_268_4:GetComponentInChildren(typeof(CharacterEffect))

				var_268_5.enabled = true

				local var_268_6 = GameObjectTools.GetOrAddComponent(var_268_4, typeof(DynamicBoneHelper))

				if var_268_6 then
					var_268_6:EnableDynamicBone(false)
				end

				arg_265_1:ShowWeapon(var_268_5.transform, false)

				arg_265_1.var_[var_268_3 .. "Animator"] = var_268_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_265_1.var_[var_268_3 .. "Animator"].applyRootMotion = true
				arg_265_1.var_[var_268_3 .. "LipSync"] = var_268_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_268_7 = arg_265_1.actors_["10045ui_story"].transform

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos10045ui_story = var_268_7.localPosition
			end

			local var_268_8 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_8 then
				var_268_7.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10045ui_story, Vector3.New(0.7, -1.18, -6.05), (arg_265_1.time_ - 0) / var_268_8)
				var_268_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_7.position).x, (manager.ui.mainCamera.transform.position - var_268_7.position).y, (manager.ui.mainCamera.transform.position - var_268_7.position).z)
				var_268_7.localEulerAngles.z = 0
				var_268_7.localEulerAngles.x = 0
				var_268_7.localEulerAngles = var_268_7.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_8 and arg_265_1.time_ < 0 + var_268_8 + arg_268_0 then
				var_268_7.localPosition = Vector3.New(0.7, -1.18, -6.05)
				var_268_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_7.position).x, (manager.ui.mainCamera.transform.position - var_268_7.position).y, (manager.ui.mainCamera.transform.position - var_268_7.position).z)
				var_268_7.localEulerAngles.z = 0
				var_268_7.localEulerAngles.x = 0
				var_268_7.localEulerAngles = var_268_7.localEulerAngles
			end

			local var_268_9 = arg_265_1.actors_["10045ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_9) and arg_265_1.var_.characterEffect10045ui_story == nil then
				arg_265_1.var_.characterEffect10045ui_story = var_268_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_10 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_10 and not isNil(var_268_9) then
				if arg_265_1.var_.characterEffect10045ui_story and not isNil(var_268_9) then
					arg_265_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_10 and arg_265_1.time_ < 0 + var_268_10 + arg_268_0 and not isNil(var_268_9) and arg_265_1.var_.characterEffect10045ui_story then
				arg_265_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action1_1")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_268_12 = 0
			local var_268_13 = 0.325

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_12 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_14 = arg_265_1:GetWordFromCfg(122082064)
				local var_268_15 = arg_265_1:FormatText(var_268_14.content)

				arg_265_1.text_.text = var_268_15

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_17 = 13 <= 0 and var_268_13 or var_268_13 * (utf8.len(var_268_15) / 13)

				if (13 <= 0 and var_268_13 or var_268_13 * (utf8.len(var_268_15) / 13)) > 0 and var_268_13 < var_268_17 then
					arg_265_1.talkMaxDuration = var_268_17

					if var_268_17 + var_268_12 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_17 + var_268_12
					end
				end

				arg_265_1.text_.text = var_268_15
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082064", "story_v_out_122082.awb") ~= 0 then
					local var_268_18 = manager.audio:GetVoiceLength("story_v_out_122082", "122082064", "story_v_out_122082.awb") / 1000

					if var_268_18 + var_268_12 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_18 + var_268_12
					end

					if var_268_14.prefab_name ~= "" and arg_265_1.actors_[var_268_14.prefab_name] ~= nil then
						local var_268_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_14.prefab_name].transform, "story_v_out_122082", "122082064", "story_v_out_122082.awb")

						arg_265_1:RecordAudio("122082064", var_268_19)
						arg_265_1:RecordAudio("122082064", var_268_19)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_122082", "122082064", "story_v_out_122082.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_122082", "122082064", "story_v_out_122082.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_20 = math.max(var_268_13, arg_265_1.talkMaxDuration)

			if var_268_12 <= arg_265_1.time_ and arg_265_1.time_ < var_268_12 + var_268_20 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_12) / var_268_20

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_12 + var_268_20 and arg_265_1.time_ < var_268_12 + var_268_20 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play122082065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 122082065
		arg_269_1.duration_ = 7.57

		local var_269_0 = {
			ja = 7.566,
			ko = 6.7,
			zh = 6.7
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play122082066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["4037ui_story"]) and arg_269_1.var_.characterEffect4037ui_story == nil then
				arg_269_1.var_.characterEffect4037ui_story = arg_269_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["4037ui_story"]) then
				if arg_269_1.var_.characterEffect4037ui_story and not isNil(arg_269_1.actors_["4037ui_story"]) then
					arg_269_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["4037ui_story"]) and arg_269_1.var_.characterEffect4037ui_story then
				arg_269_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_272_2 = arg_269_1.actors_["10045ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.characterEffect10045ui_story == nil then
				arg_269_1.var_.characterEffect10045ui_story = var_272_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_3 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_3 and not isNil(var_272_2) then
				if arg_269_1.var_.characterEffect10045ui_story and not isNil(var_272_2) then
					arg_269_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_269_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_3)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_3 and arg_269_1.time_ < 0 + var_272_3 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.characterEffect10045ui_story then
				arg_269_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_269_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			local var_272_4 = 0
			local var_272_5 = 0.575

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(122082065)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 23 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 23)

				if (23 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 23)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082065", "story_v_out_122082.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_out_122082", "122082065", "story_v_out_122082.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_out_122082", "122082065", "story_v_out_122082.awb")

						arg_269_1:RecordAudio("122082065", var_272_11)
						arg_269_1:RecordAudio("122082065", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_122082", "122082065", "story_v_out_122082.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_122082", "122082065", "story_v_out_122082.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_12 = math.max(var_272_5, arg_269_1.talkMaxDuration)

			if var_272_4 <= arg_269_1.time_ and arg_269_1.time_ < var_272_4 + var_272_12 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_4) / var_272_12

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_4 + var_272_12 and arg_269_1.time_ < var_272_4 + var_272_12 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play122082066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 122082066
		arg_273_1.duration_ = 2.07

		local var_273_0 = {
			ja = 2.066,
			ko = 2,
			zh = 2
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play122082067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos10045ui_story = arg_273_1.actors_["10045ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["10045ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10045ui_story, Vector3.New(0.7, -1.18, -6.05), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["10045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["10045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10045ui_story"].transform.position).z)
				arg_273_1.actors_["10045ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["10045ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["10045ui_story"].transform.localEulerAngles = arg_273_1.actors_["10045ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["10045ui_story"].transform.localPosition = Vector3.New(0.7, -1.18, -6.05)
				arg_273_1.actors_["10045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["10045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10045ui_story"].transform.position).z)
				arg_273_1.actors_["10045ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["10045ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["10045ui_story"].transform.localEulerAngles = arg_273_1.actors_["10045ui_story"].transform.localEulerAngles
			end

			local var_276_1 = arg_273_1.actors_["10045ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect10045ui_story == nil then
				arg_273_1.var_.characterEffect10045ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 and not isNil(var_276_1) then
				if arg_273_1.var_.characterEffect10045ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect10045ui_story then
				arg_273_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_276_4 = arg_273_1.actors_["4037ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_4) and arg_273_1.var_.characterEffect4037ui_story == nil then
				arg_273_1.var_.characterEffect4037ui_story = var_276_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_5 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_5 and not isNil(var_276_4) then
				if arg_273_1.var_.characterEffect4037ui_story and not isNil(var_276_4) then
					arg_273_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_273_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_5)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_5 and arg_273_1.time_ < 0 + var_276_5 + arg_276_0 and not isNil(var_276_4) and arg_273_1.var_.characterEffect4037ui_story then
				arg_273_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_273_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_276_6 = 0
			local var_276_7 = 0.175

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_8 = arg_273_1:GetWordFromCfg(122082066)
				local var_276_9 = arg_273_1:FormatText(var_276_8.content)

				arg_273_1.text_.text = var_276_9

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_11 = 7 <= 0 and var_276_7 or var_276_7 * (utf8.len(var_276_9) / 7)

				if (7 <= 0 and var_276_7 or var_276_7 * (utf8.len(var_276_9) / 7)) > 0 and var_276_7 < var_276_11 then
					arg_273_1.talkMaxDuration = var_276_11

					if var_276_11 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_11 + var_276_6
					end
				end

				arg_273_1.text_.text = var_276_9
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082066", "story_v_out_122082.awb") ~= 0 then
					local var_276_12 = manager.audio:GetVoiceLength("story_v_out_122082", "122082066", "story_v_out_122082.awb") / 1000

					if var_276_12 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_12 + var_276_6
					end

					if var_276_8.prefab_name ~= "" and arg_273_1.actors_[var_276_8.prefab_name] ~= nil then
						local var_276_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_8.prefab_name].transform, "story_v_out_122082", "122082066", "story_v_out_122082.awb")

						arg_273_1:RecordAudio("122082066", var_276_13)
						arg_273_1:RecordAudio("122082066", var_276_13)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_122082", "122082066", "story_v_out_122082.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_122082", "122082066", "story_v_out_122082.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_14 = math.max(var_276_7, arg_273_1.talkMaxDuration)

			if var_276_6 <= arg_273_1.time_ and arg_273_1.time_ < var_276_6 + var_276_14 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_6) / var_276_14

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_6 + var_276_14 and arg_273_1.time_ < var_276_6 + var_276_14 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play122082067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 122082067
		arg_277_1.duration_ = 2.33

		local var_277_0 = {
			ja = 2.333,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play122082068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos4037ui_story = arg_277_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos4037ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["4037ui_story"].transform.position).z)
				arg_277_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["4037ui_story"].transform.localEulerAngles = arg_277_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				arg_277_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["4037ui_story"].transform.position).z)
				arg_277_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["4037ui_story"].transform.localEulerAngles = arg_277_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_280_1 = arg_277_1.actors_["4037ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect4037ui_story == nil then
				arg_277_1.var_.characterEffect4037ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect4037ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect4037ui_story then
				arg_277_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_280_4 = arg_277_1.actors_["10045ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_4) and arg_277_1.var_.characterEffect10045ui_story == nil then
				arg_277_1.var_.characterEffect10045ui_story = var_280_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_5 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_5 and not isNil(var_280_4) then
				if arg_277_1.var_.characterEffect10045ui_story and not isNil(var_280_4) then
					arg_277_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_277_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_5)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_5 and arg_277_1.time_ < 0 + var_280_5 + arg_280_0 and not isNil(var_280_4) and arg_277_1.var_.characterEffect10045ui_story then
				arg_277_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_277_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			local var_280_6 = 0
			local var_280_7 = 0.15

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_6 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_8 = arg_277_1:GetWordFromCfg(122082067)
				local var_280_9 = arg_277_1:FormatText(var_280_8.content)

				arg_277_1.text_.text = var_280_9

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_11 = 6 <= 0 and var_280_7 or var_280_7 * (utf8.len(var_280_9) / 6)

				if (6 <= 0 and var_280_7 or var_280_7 * (utf8.len(var_280_9) / 6)) > 0 and var_280_7 < var_280_11 then
					arg_277_1.talkMaxDuration = var_280_11

					if var_280_11 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_11 + var_280_6
					end
				end

				arg_277_1.text_.text = var_280_9
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082067", "story_v_out_122082.awb") ~= 0 then
					local var_280_12 = manager.audio:GetVoiceLength("story_v_out_122082", "122082067", "story_v_out_122082.awb") / 1000

					if var_280_12 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_12 + var_280_6
					end

					if var_280_8.prefab_name ~= "" and arg_277_1.actors_[var_280_8.prefab_name] ~= nil then
						local var_280_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_8.prefab_name].transform, "story_v_out_122082", "122082067", "story_v_out_122082.awb")

						arg_277_1:RecordAudio("122082067", var_280_13)
						arg_277_1:RecordAudio("122082067", var_280_13)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_122082", "122082067", "story_v_out_122082.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_122082", "122082067", "story_v_out_122082.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_14 = math.max(var_280_7, arg_277_1.talkMaxDuration)

			if var_280_6 <= arg_277_1.time_ and arg_277_1.time_ < var_280_6 + var_280_14 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_6) / var_280_14

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_6 + var_280_14 and arg_277_1.time_ < var_280_6 + var_280_14 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play122082068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 122082068
		arg_281_1.duration_ = 9.93

		local var_281_0 = {
			ja = 9.933,
			ko = 8.8,
			zh = 8.8
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play122082069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["10045ui_story"]) and arg_281_1.var_.characterEffect10045ui_story == nil then
				arg_281_1.var_.characterEffect10045ui_story = arg_281_1.actors_["10045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_0 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["10045ui_story"]) then
				if arg_281_1.var_.characterEffect10045ui_story and not isNil(arg_281_1.actors_["10045ui_story"]) then
					arg_281_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["10045ui_story"]) and arg_281_1.var_.characterEffect10045ui_story then
				arg_281_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action6_1")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_284_2 = arg_281_1.actors_["4037ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.characterEffect4037ui_story == nil then
				arg_281_1.var_.characterEffect4037ui_story = var_284_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_3 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_3 and not isNil(var_284_2) then
				if arg_281_1.var_.characterEffect4037ui_story and not isNil(var_284_2) then
					arg_281_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_281_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_3)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_3 and arg_281_1.time_ < 0 + var_284_3 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.characterEffect4037ui_story then
				arg_281_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_281_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_284_4 = 0
			local var_284_5 = 0.7

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_6 = arg_281_1:GetWordFromCfg(122082068)
				local var_284_7 = arg_281_1:FormatText(var_284_6.content)

				arg_281_1.text_.text = var_284_7

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_9 = 28 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 28)

				if (28 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 28)) > 0 and var_284_5 < var_284_9 then
					arg_281_1.talkMaxDuration = var_284_9

					if var_284_9 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_4
					end
				end

				arg_281_1.text_.text = var_284_7
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082068", "story_v_out_122082.awb") ~= 0 then
					local var_284_10 = manager.audio:GetVoiceLength("story_v_out_122082", "122082068", "story_v_out_122082.awb") / 1000

					if var_284_10 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_4
					end

					if var_284_6.prefab_name ~= "" and arg_281_1.actors_[var_284_6.prefab_name] ~= nil then
						local var_284_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_6.prefab_name].transform, "story_v_out_122082", "122082068", "story_v_out_122082.awb")

						arg_281_1:RecordAudio("122082068", var_284_11)
						arg_281_1:RecordAudio("122082068", var_284_11)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_122082", "122082068", "story_v_out_122082.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_122082", "122082068", "story_v_out_122082.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_12 = math.max(var_284_5, arg_281_1.talkMaxDuration)

			if var_284_4 <= arg_281_1.time_ and arg_281_1.time_ < var_284_4 + var_284_12 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_4) / var_284_12

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_4 + var_284_12 and arg_281_1.time_ < var_284_4 + var_284_12 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play122082069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 122082069
		arg_285_1.duration_ = 7.63

		local var_285_0 = {
			ja = 7.5,
			ko = 7.633,
			zh = 7.633
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play122082070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["4037ui_story"]) and arg_285_1.var_.characterEffect4037ui_story == nil then
				arg_285_1.var_.characterEffect4037ui_story = arg_285_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["4037ui_story"]) then
				if arg_285_1.var_.characterEffect4037ui_story and not isNil(arg_285_1.actors_["4037ui_story"]) then
					arg_285_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["4037ui_story"]) and arg_285_1.var_.characterEffect4037ui_story then
				arg_285_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_288_2 = arg_285_1.actors_["10045ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect10045ui_story == nil then
				arg_285_1.var_.characterEffect10045ui_story = var_288_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_3 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_3 and not isNil(var_288_2) then
				if arg_285_1.var_.characterEffect10045ui_story and not isNil(var_288_2) then
					arg_285_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_285_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_3)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_3 and arg_285_1.time_ < 0 + var_288_3 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect10045ui_story then
				arg_285_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_285_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			local var_288_4 = 0
			local var_288_5 = 0.8

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:GetWordFromCfg(122082069)
				local var_288_7 = arg_285_1:FormatText(var_288_6.content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 32 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 32)

				if (32 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 32)) > 0 and var_288_5 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082069", "story_v_out_122082.awb") ~= 0 then
					local var_288_10 = manager.audio:GetVoiceLength("story_v_out_122082", "122082069", "story_v_out_122082.awb") / 1000

					if var_288_10 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_4
					end

					if var_288_6.prefab_name ~= "" and arg_285_1.actors_[var_288_6.prefab_name] ~= nil then
						local var_288_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_6.prefab_name].transform, "story_v_out_122082", "122082069", "story_v_out_122082.awb")

						arg_285_1:RecordAudio("122082069", var_288_11)
						arg_285_1:RecordAudio("122082069", var_288_11)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_122082", "122082069", "story_v_out_122082.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_122082", "122082069", "story_v_out_122082.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_12 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_12 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_12

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_12 and arg_285_1.time_ < var_288_4 + var_288_12 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play122082070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 122082070
		arg_289_1.duration_ = 2.77

		local var_289_0 = {
			ja = 2.766,
			ko = 2.166,
			zh = 2.166
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play122082071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["10045ui_story"]) and arg_289_1.var_.characterEffect10045ui_story == nil then
				arg_289_1.var_.characterEffect10045ui_story = arg_289_1.actors_["10045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_0 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["10045ui_story"]) then
				if arg_289_1.var_.characterEffect10045ui_story and not isNil(arg_289_1.actors_["10045ui_story"]) then
					arg_289_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["10045ui_story"]) and arg_289_1.var_.characterEffect10045ui_story then
				arg_289_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action6_2")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_292_2 = arg_289_1.actors_["4037ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.characterEffect4037ui_story == nil then
				arg_289_1.var_.characterEffect4037ui_story = var_292_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_3 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_3 and not isNil(var_292_2) then
				if arg_289_1.var_.characterEffect4037ui_story and not isNil(var_292_2) then
					arg_289_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_289_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_3)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_3 and arg_289_1.time_ < 0 + var_292_3 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.characterEffect4037ui_story then
				arg_289_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_289_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_292_4 = 0
			local var_292_5 = 0.1

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_6 = arg_289_1:GetWordFromCfg(122082070)
				local var_292_7 = arg_289_1:FormatText(var_292_6.content)

				arg_289_1.text_.text = var_292_7

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_9 = 4 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 4)

				if (4 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 4)) > 0 and var_292_5 < var_292_9 then
					arg_289_1.talkMaxDuration = var_292_9

					if var_292_9 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_4
					end
				end

				arg_289_1.text_.text = var_292_7
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082070", "story_v_out_122082.awb") ~= 0 then
					local var_292_10 = manager.audio:GetVoiceLength("story_v_out_122082", "122082070", "story_v_out_122082.awb") / 1000

					if var_292_10 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_4
					end

					if var_292_6.prefab_name ~= "" and arg_289_1.actors_[var_292_6.prefab_name] ~= nil then
						local var_292_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_6.prefab_name].transform, "story_v_out_122082", "122082070", "story_v_out_122082.awb")

						arg_289_1:RecordAudio("122082070", var_292_11)
						arg_289_1:RecordAudio("122082070", var_292_11)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_122082", "122082070", "story_v_out_122082.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_122082", "122082070", "story_v_out_122082.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_12 = math.max(var_292_5, arg_289_1.talkMaxDuration)

			if var_292_4 <= arg_289_1.time_ and arg_289_1.time_ < var_292_4 + var_292_12 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_4) / var_292_12

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_4 + var_292_12 and arg_289_1.time_ < var_292_4 + var_292_12 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play122082071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 122082071
		arg_293_1.duration_ = 4.6

		local var_293_0 = {
			ja = 4.4,
			ko = 4.6,
			zh = 4.6
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play122082072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["4037ui_story"]) and arg_293_1.var_.characterEffect4037ui_story == nil then
				arg_293_1.var_.characterEffect4037ui_story = arg_293_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["4037ui_story"]) then
				if arg_293_1.var_.characterEffect4037ui_story and not isNil(arg_293_1.actors_["4037ui_story"]) then
					arg_293_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["4037ui_story"]) and arg_293_1.var_.characterEffect4037ui_story then
				arg_293_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_296_2 = arg_293_1.actors_["10045ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.characterEffect10045ui_story == nil then
				arg_293_1.var_.characterEffect10045ui_story = var_296_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_3 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_3 and not isNil(var_296_2) then
				if arg_293_1.var_.characterEffect10045ui_story and not isNil(var_296_2) then
					arg_293_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_293_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_3)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_3 and arg_293_1.time_ < 0 + var_296_3 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.characterEffect10045ui_story then
				arg_293_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_293_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			local var_296_4 = 0
			local var_296_5 = 0.325

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_6 = arg_293_1:GetWordFromCfg(122082071)
				local var_296_7 = arg_293_1:FormatText(var_296_6.content)

				arg_293_1.text_.text = var_296_7

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_9 = 13 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_7) / 13)

				if (13 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_7) / 13)) > 0 and var_296_5 < var_296_9 then
					arg_293_1.talkMaxDuration = var_296_9

					if var_296_9 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_9 + var_296_4
					end
				end

				arg_293_1.text_.text = var_296_7
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082071", "story_v_out_122082.awb") ~= 0 then
					local var_296_10 = manager.audio:GetVoiceLength("story_v_out_122082", "122082071", "story_v_out_122082.awb") / 1000

					if var_296_10 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_4
					end

					if var_296_6.prefab_name ~= "" and arg_293_1.actors_[var_296_6.prefab_name] ~= nil then
						local var_296_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_6.prefab_name].transform, "story_v_out_122082", "122082071", "story_v_out_122082.awb")

						arg_293_1:RecordAudio("122082071", var_296_11)
						arg_293_1:RecordAudio("122082071", var_296_11)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_122082", "122082071", "story_v_out_122082.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_122082", "122082071", "story_v_out_122082.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_12 = math.max(var_296_5, arg_293_1.talkMaxDuration)

			if var_296_4 <= arg_293_1.time_ and arg_293_1.time_ < var_296_4 + var_296_12 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_4) / var_296_12

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_4 + var_296_12 and arg_293_1.time_ < var_296_4 + var_296_12 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play122082072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 122082072
		arg_297_1.duration_ = 3.63

		local var_297_0 = {
			ja = 2.2,
			ko = 3.633,
			zh = 3.633
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play122082073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos10037ui_story = arg_297_1.actors_["10037ui_story"].transform.localPosition
			end

			local var_300_0 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 then
				arg_297_1.actors_["10037ui_story"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10037ui_story, Vector3.New(0.7, -1.13, -6.2), (arg_297_1.time_ - 0) / var_300_0)
				arg_297_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["10037ui_story"].transform.position).z)
				arg_297_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["10037ui_story"].transform.localEulerAngles = arg_297_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 then
				arg_297_1.actors_["10037ui_story"].transform.localPosition = Vector3.New(0.7, -1.13, -6.2)
				arg_297_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["10037ui_story"].transform.position).z)
				arg_297_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["10037ui_story"].transform.localEulerAngles = arg_297_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			local var_300_1 = arg_297_1.actors_["10037ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect10037ui_story == nil then
				arg_297_1.var_.characterEffect10037ui_story = var_300_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_2 and not isNil(var_300_1) then
				if arg_297_1.var_.characterEffect10037ui_story and not isNil(var_300_1) then
					arg_297_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_2 and arg_297_1.time_ < 0 + var_300_2 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect10037ui_story then
				arg_297_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_300_4 = arg_297_1.actors_["10045ui_story"].transform

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos10045ui_story = var_300_4.localPosition
			end

			local var_300_5 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_5 then
				var_300_4.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10045ui_story, Vector3.New(0, 100, 0), (arg_297_1.time_ - 0) / var_300_5)
				var_300_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_4.position).x, (manager.ui.mainCamera.transform.position - var_300_4.position).y, (manager.ui.mainCamera.transform.position - var_300_4.position).z)
				var_300_4.localEulerAngles.z = 0
				var_300_4.localEulerAngles.x = 0
				var_300_4.localEulerAngles = var_300_4.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_5 and arg_297_1.time_ < 0 + var_300_5 + arg_300_0 then
				var_300_4.localPosition = Vector3.New(0, 100, 0)
				var_300_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_4.position).x, (manager.ui.mainCamera.transform.position - var_300_4.position).y, (manager.ui.mainCamera.transform.position - var_300_4.position).z)
				var_300_4.localEulerAngles.z = 0
				var_300_4.localEulerAngles.x = 0
				var_300_4.localEulerAngles = var_300_4.localEulerAngles
			end

			local var_300_6 = arg_297_1.actors_["10045ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_6) and arg_297_1.var_.characterEffect10045ui_story == nil then
				arg_297_1.var_.characterEffect10045ui_story = var_300_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_7 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_7 and not isNil(var_300_6) then
				if arg_297_1.var_.characterEffect10045ui_story and not isNil(var_300_6) then
					arg_297_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_297_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_7)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_7 and arg_297_1.time_ < 0 + var_300_7 + arg_300_0 and not isNil(var_300_6) and arg_297_1.var_.characterEffect10045ui_story then
				arg_297_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_297_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			local var_300_8 = arg_297_1.actors_["4037ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_8) and arg_297_1.var_.characterEffect4037ui_story == nil then
				arg_297_1.var_.characterEffect4037ui_story = var_300_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_9 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_9 and not isNil(var_300_8) then
				if arg_297_1.var_.characterEffect4037ui_story and not isNil(var_300_8) then
					arg_297_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_297_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_9)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_9 and arg_297_1.time_ < 0 + var_300_9 + arg_300_0 and not isNil(var_300_8) and arg_297_1.var_.characterEffect4037ui_story then
				arg_297_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_297_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_300_10 = 0
			local var_300_11 = 0.35

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_10 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_12 = arg_297_1:GetWordFromCfg(122082072)
				local var_300_13 = arg_297_1:FormatText(var_300_12.content)

				arg_297_1.text_.text = var_300_13

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_15 = 14 <= 0 and var_300_11 or var_300_11 * (utf8.len(var_300_13) / 14)

				if (14 <= 0 and var_300_11 or var_300_11 * (utf8.len(var_300_13) / 14)) > 0 and var_300_11 < var_300_15 then
					arg_297_1.talkMaxDuration = var_300_15

					if var_300_15 + var_300_10 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_15 + var_300_10
					end
				end

				arg_297_1.text_.text = var_300_13
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082072", "story_v_out_122082.awb") ~= 0 then
					local var_300_16 = manager.audio:GetVoiceLength("story_v_out_122082", "122082072", "story_v_out_122082.awb") / 1000

					if var_300_16 + var_300_10 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_16 + var_300_10
					end

					if var_300_12.prefab_name ~= "" and arg_297_1.actors_[var_300_12.prefab_name] ~= nil then
						local var_300_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_12.prefab_name].transform, "story_v_out_122082", "122082072", "story_v_out_122082.awb")

						arg_297_1:RecordAudio("122082072", var_300_17)
						arg_297_1:RecordAudio("122082072", var_300_17)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_122082", "122082072", "story_v_out_122082.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_122082", "122082072", "story_v_out_122082.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_18 = math.max(var_300_11, arg_297_1.talkMaxDuration)

			if var_300_10 <= arg_297_1.time_ and arg_297_1.time_ < var_300_10 + var_300_18 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_10) / var_300_18

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_10 + var_300_18 and arg_297_1.time_ < var_300_10 + var_300_18 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play122082073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 122082073
		arg_301_1.duration_ = 8.3

		local var_301_0 = {
			ja = 8.3,
			ko = 8.133,
			zh = 8.133
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
			arg_301_1.auto_ = false
		end

		function arg_301_1.playNext_(arg_303_0)
			arg_301_1.onStoryFinished_()
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos4037ui_story = arg_301_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_304_0 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 then
				arg_301_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos4037ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_301_1.time_ - 0) / var_304_0)
				arg_301_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["4037ui_story"].transform.position).z)
				arg_301_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["4037ui_story"].transform.localEulerAngles = arg_301_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 then
				arg_301_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				arg_301_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["4037ui_story"].transform.position).z)
				arg_301_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["4037ui_story"].transform.localEulerAngles = arg_301_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_304_1 = arg_301_1.actors_["4037ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect4037ui_story == nil then
				arg_301_1.var_.characterEffect4037ui_story = var_304_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_2 and not isNil(var_304_1) then
				if arg_301_1.var_.characterEffect4037ui_story and not isNil(var_304_1) then
					arg_301_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_2 and arg_301_1.time_ < 0 + var_304_2 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect4037ui_story then
				arg_301_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_304_4 = arg_301_1.actors_["10037ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_4) and arg_301_1.var_.characterEffect10037ui_story == nil then
				arg_301_1.var_.characterEffect10037ui_story = var_304_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_5 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_5 and not isNil(var_304_4) then
				if arg_301_1.var_.characterEffect10037ui_story and not isNil(var_304_4) then
					arg_301_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_301_1.var_.characterEffect10037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_301_1.time_ - 0) / var_304_5)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_5 and arg_301_1.time_ < 0 + var_304_5 + arg_304_0 and not isNil(var_304_4) and arg_301_1.var_.characterEffect10037ui_story then
				arg_301_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_301_1.var_.characterEffect10037ui_story.fillRatio = 0.5
			end

			local var_304_6 = 0
			local var_304_7 = 0.625

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_6 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_8 = arg_301_1:GetWordFromCfg(122082073)
				local var_304_9 = arg_301_1:FormatText(var_304_8.content)

				arg_301_1.text_.text = var_304_9

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_11 = 25 <= 0 and var_304_7 or var_304_7 * (utf8.len(var_304_9) / 25)

				if (25 <= 0 and var_304_7 or var_304_7 * (utf8.len(var_304_9) / 25)) > 0 and var_304_7 < var_304_11 then
					arg_301_1.talkMaxDuration = var_304_11

					if var_304_11 + var_304_6 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_11 + var_304_6
					end
				end

				arg_301_1.text_.text = var_304_9
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122082", "122082073", "story_v_out_122082.awb") ~= 0 then
					local var_304_12 = manager.audio:GetVoiceLength("story_v_out_122082", "122082073", "story_v_out_122082.awb") / 1000

					if var_304_12 + var_304_6 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_12 + var_304_6
					end

					if var_304_8.prefab_name ~= "" and arg_301_1.actors_[var_304_8.prefab_name] ~= nil then
						local var_304_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_8.prefab_name].transform, "story_v_out_122082", "122082073", "story_v_out_122082.awb")

						arg_301_1:RecordAudio("122082073", var_304_13)
						arg_301_1:RecordAudio("122082073", var_304_13)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_122082", "122082073", "story_v_out_122082.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_122082", "122082073", "story_v_out_122082.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_14 = math.max(var_304_7, arg_301_1.talkMaxDuration)

			if var_304_6 <= arg_301_1.time_ and arg_301_1.time_ < var_304_6 + var_304_14 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_6) / var_304_14

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_6 + var_304_14 and arg_301_1.time_ < var_304_6 + var_304_14 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J08f",
		"TextureConfig/Background/J08g"
	},
	voices = {
		"story_v_out_122082.awb"
	}
}
