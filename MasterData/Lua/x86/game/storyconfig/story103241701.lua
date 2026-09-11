return {
	Play324171001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324171001
		arg_1_1.duration_ = 6.4

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324171002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J15 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J15")
				var_4_0.name = "J15"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J15 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J15

				arg_1_1.bgs_.J15.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J15" then
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_150", "se_story_150_amb_painting", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_2_story_ruomuhuajing", "bgm_activity_2_2_story_ruomuhuajing", "bgm_activity_2_2_story_ruomuhuajing.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_2_story_ruomuhuajing", "bgm_activity_2_2_story_ruomuhuajing")

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

			local var_4_14 = 1.4
			local var_4_15 = 1.025

			if 1.4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(324171001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 41 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 41)

				if (41 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 41)) > 0 and var_4_15 < var_4_19 then
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
	Play324171002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324171002
		arg_8_1.duration_ = 2

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play324171003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1053ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1053ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1053ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1053ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1053ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1053ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1053ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1053ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1053ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1053ui_story = var_11_3.localPosition

				local var_11_4 = GameObjectTools.GetOrAddComponent(var_11_3.gameObject, typeof(DynamicBoneHelper))

				if var_11_4 then
					var_11_4:EnableDynamicBone(false)
				end
			end

			local var_11_5 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_5 then
				var_11_3.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_8_1.time_ - 0) / var_11_5)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_5 and arg_8_1.time_ < 0 + var_11_5 + arg_11_0 then
				var_11_3.localPosition = Vector3.New(0, -1.08, -6)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles

				local var_11_6 = GameObjectTools.GetOrAddComponent(var_11_3.gameObject, typeof(DynamicBoneHelper))

				if var_11_6 then
					var_11_6:EnableDynamicBone(true)
				end
			end

			local var_11_7 = arg_8_1.actors_["1053ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_7) and arg_8_1.var_.characterEffect1053ui_story == nil then
				arg_8_1.var_.characterEffect1053ui_story = var_11_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_8 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_8 and not isNil(var_11_7) then
				if arg_8_1.var_.characterEffect1053ui_story and not isNil(var_11_7) then
					arg_8_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_8 and arg_8_1.time_ < 0 + var_11_8 + arg_11_0 and not isNil(var_11_7) and arg_8_1.var_.characterEffect1053ui_story then
				arg_8_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_11_10 = 0
			local var_11_11 = 0.075

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_12 = arg_8_1:GetWordFromCfg(324171002)
				local var_11_13 = arg_8_1:FormatText(var_11_12.content)

				arg_8_1.text_.text = var_11_13

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_15 = 3 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 3)

				if (3 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 3)) > 0 and var_11_11 < var_11_15 then
					arg_8_1.talkMaxDuration = var_11_15

					if var_11_15 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_15 + var_11_10
					end
				end

				arg_8_1.text_.text = var_11_13
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171002", "story_v_out_324171.awb") ~= 0 then
					local var_11_16 = manager.audio:GetVoiceLength("story_v_out_324171", "324171002", "story_v_out_324171.awb") / 1000

					if var_11_16 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_16 + var_11_10
					end

					if var_11_12.prefab_name ~= "" and arg_8_1.actors_[var_11_12.prefab_name] ~= nil then
						local var_11_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_12.prefab_name].transform, "story_v_out_324171", "324171002", "story_v_out_324171.awb")

						arg_8_1:RecordAudio("324171002", var_11_17)
						arg_8_1:RecordAudio("324171002", var_11_17)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_324171", "324171002", "story_v_out_324171.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_324171", "324171002", "story_v_out_324171.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_18 = math.max(var_11_11, arg_8_1.talkMaxDuration)

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_18 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_10) / var_11_18

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_10 + var_11_18 and arg_8_1.time_ < var_11_10 + var_11_18 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play324171003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324171003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324171004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1053ui_story"]) and arg_12_1.var_.characterEffect1053ui_story == nil then
				arg_12_1.var_.characterEffect1053ui_story = arg_12_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1053ui_story"]) then
				if arg_12_1.var_.characterEffect1053ui_story and not isNil(arg_12_1.actors_["1053ui_story"]) then
					arg_12_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_0)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1053ui_story"]) and arg_12_1.var_.characterEffect1053ui_story then
				arg_12_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_15_1 = 0
			local var_15_2 = 0.5

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_3 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(324171003).content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 20 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 20)

				if (20 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 20)) > 0 and var_15_2 < var_15_5 then
					arg_12_1.talkMaxDuration = var_15_5

					if var_15_5 + var_15_1 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + var_15_1
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_6 = math.max(var_15_2, arg_12_1.talkMaxDuration)

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_6 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_1) / var_15_6

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_1 + var_15_6 and arg_12_1.time_ < var_15_1 + var_15_6 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324171004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324171004
		arg_16_1.duration_ = 2

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play324171005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["1170ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1170ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1170ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1170ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1170ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1170ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1170ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1170ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1170ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1170ui_story = var_19_3.localPosition

				local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_3.gameObject, typeof(DynamicBoneHelper))

				if var_19_4 then
					var_19_4:EnableDynamicBone(false)
				end
			end

			local var_19_5 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_5 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1170ui_story, Vector3.New(-0.68, -0.95, -6.08), (arg_16_1.time_ - 0) / var_19_5)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_5 and arg_16_1.time_ < 0 + var_19_5 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(-0.68, -0.95, -6.08)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles

				local var_19_6 = GameObjectTools.GetOrAddComponent(var_19_3.gameObject, typeof(DynamicBoneHelper))

				if var_19_6 then
					var_19_6:EnableDynamicBone(true)
				end
			end

			local var_19_7 = arg_16_1.actors_["1053ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1053ui_story = var_19_7.localPosition

				local var_19_8 = GameObjectTools.GetOrAddComponent(var_19_7.gameObject, typeof(DynamicBoneHelper))

				if var_19_8 then
					var_19_8:EnableDynamicBone(false)
				end
			end

			local var_19_9 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_9 then
				var_19_7.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1053ui_story, Vector3.New(0.7, -1.08, -6), (arg_16_1.time_ - 0) / var_19_9)
				var_19_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_7.position).x, (manager.ui.mainCamera.transform.position - var_19_7.position).y, (manager.ui.mainCamera.transform.position - var_19_7.position).z)
				var_19_7.localEulerAngles.z = 0
				var_19_7.localEulerAngles.x = 0
				var_19_7.localEulerAngles = var_19_7.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_9 and arg_16_1.time_ < 0 + var_19_9 + arg_19_0 then
				var_19_7.localPosition = Vector3.New(0.7, -1.08, -6)
				var_19_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_7.position).x, (manager.ui.mainCamera.transform.position - var_19_7.position).y, (manager.ui.mainCamera.transform.position - var_19_7.position).z)
				var_19_7.localEulerAngles.z = 0
				var_19_7.localEulerAngles.x = 0
				var_19_7.localEulerAngles = var_19_7.localEulerAngles

				local var_19_10 = GameObjectTools.GetOrAddComponent(var_19_7.gameObject, typeof(DynamicBoneHelper))

				if var_19_10 then
					var_19_10:EnableDynamicBone(true)
				end
			end

			local var_19_11 = arg_16_1.actors_["1170ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_11) and arg_16_1.var_.characterEffect1170ui_story == nil then
				arg_16_1.var_.characterEffect1170ui_story = var_19_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_12 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_12 and not isNil(var_19_11) then
				if arg_16_1.var_.characterEffect1170ui_story and not isNil(var_19_11) then
					arg_16_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_12 and arg_16_1.time_ < 0 + var_19_12 + arg_19_0 and not isNil(var_19_11) and arg_16_1.var_.characterEffect1170ui_story then
				arg_16_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action1_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_19_14 = 0
			local var_19_15 = 0.1

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_14 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_16 = arg_16_1:GetWordFromCfg(324171004)
				local var_19_17 = arg_16_1:FormatText(var_19_16.content)

				arg_16_1.text_.text = var_19_17

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_19 = 4 <= 0 and var_19_15 or var_19_15 * (utf8.len(var_19_17) / 4)

				if (4 <= 0 and var_19_15 or var_19_15 * (utf8.len(var_19_17) / 4)) > 0 and var_19_15 < var_19_19 then
					arg_16_1.talkMaxDuration = var_19_19

					if var_19_19 + var_19_14 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_19 + var_19_14
					end
				end

				arg_16_1.text_.text = var_19_17
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171004", "story_v_out_324171.awb") ~= 0 then
					local var_19_20 = manager.audio:GetVoiceLength("story_v_out_324171", "324171004", "story_v_out_324171.awb") / 1000

					if var_19_20 + var_19_14 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_20 + var_19_14
					end

					if var_19_16.prefab_name ~= "" and arg_16_1.actors_[var_19_16.prefab_name] ~= nil then
						local var_19_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_16.prefab_name].transform, "story_v_out_324171", "324171004", "story_v_out_324171.awb")

						arg_16_1:RecordAudio("324171004", var_19_21)
						arg_16_1:RecordAudio("324171004", var_19_21)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_324171", "324171004", "story_v_out_324171.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_324171", "324171004", "story_v_out_324171.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_22 = math.max(var_19_15, arg_16_1.talkMaxDuration)

			if var_19_14 <= arg_16_1.time_ and arg_16_1.time_ < var_19_14 + var_19_22 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_14) / var_19_22

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_14 + var_19_22 and arg_16_1.time_ < var_19_14 + var_19_22 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play324171005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324171005
		arg_20_1.duration_ = 5.8

		local var_20_0 = {
			zh = 4.933,
			ja = 5.8
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play324171006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1053ui_story"]) and arg_20_1.var_.characterEffect1053ui_story == nil then
				arg_20_1.var_.characterEffect1053ui_story = arg_20_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1053ui_story"]) then
				if arg_20_1.var_.characterEffect1053ui_story and not isNil(arg_20_1.actors_["1053ui_story"]) then
					arg_20_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1053ui_story"]) and arg_20_1.var_.characterEffect1053ui_story then
				arg_20_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_23_2 = arg_20_1.actors_["1170ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1170ui_story == nil then
				arg_20_1.var_.characterEffect1170ui_story = var_23_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_3 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.characterEffect1170ui_story and not isNil(var_23_2) then
					arg_20_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_3)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1170ui_story then
				arg_20_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_23_4 = 0
			local var_23_5 = 0.425

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_6 = arg_20_1:GetWordFromCfg(324171005)
				local var_23_7 = arg_20_1:FormatText(var_23_6.content)

				arg_20_1.text_.text = var_23_7

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_9 = 17 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 17)

				if (17 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 17)) > 0 and var_23_5 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_4
					end
				end

				arg_20_1.text_.text = var_23_7
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171005", "story_v_out_324171.awb") ~= 0 then
					local var_23_10 = manager.audio:GetVoiceLength("story_v_out_324171", "324171005", "story_v_out_324171.awb") / 1000

					if var_23_10 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_4
					end

					if var_23_6.prefab_name ~= "" and arg_20_1.actors_[var_23_6.prefab_name] ~= nil then
						local var_23_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_6.prefab_name].transform, "story_v_out_324171", "324171005", "story_v_out_324171.awb")

						arg_20_1:RecordAudio("324171005", var_23_11)
						arg_20_1:RecordAudio("324171005", var_23_11)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_324171", "324171005", "story_v_out_324171.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_324171", "324171005", "story_v_out_324171.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_12 = math.max(var_23_5, arg_20_1.talkMaxDuration)

			if var_23_4 <= arg_20_1.time_ and arg_20_1.time_ < var_23_4 + var_23_12 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_4) / var_23_12

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_4 + var_23_12 and arg_20_1.time_ < var_23_4 + var_23_12 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play324171006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324171006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324171007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1053ui_story = arg_24_1.actors_["1053ui_story"].transform.localPosition

				local var_27_0 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_0 then
					var_27_0:EnableDynamicBone(false)
				end
			end

			local var_27_1 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_1 then
				arg_24_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_1)
				arg_24_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1053ui_story"].transform.position).z)
				arg_24_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1053ui_story"].transform.localEulerAngles = arg_24_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_1 and arg_24_1.time_ < 0 + var_27_1 + arg_27_0 then
				arg_24_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1053ui_story"].transform.position).z)
				arg_24_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1053ui_story"].transform.localEulerAngles = arg_24_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_27_2 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(true)
				end
			end

			local var_27_3 = arg_24_1.actors_["1170ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1170ui_story = var_27_3.localPosition

				local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_3.gameObject, typeof(DynamicBoneHelper))

				if var_27_4 then
					var_27_4:EnableDynamicBone(false)
				end
			end

			local var_27_5 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_5 then
				var_27_3.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1170ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_5)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_5 and arg_24_1.time_ < 0 + var_27_5 + arg_27_0 then
				var_27_3.localPosition = Vector3.New(0, 100, 0)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles

				local var_27_6 = GameObjectTools.GetOrAddComponent(var_27_3.gameObject, typeof(DynamicBoneHelper))

				if var_27_6 then
					var_27_6:EnableDynamicBone(true)
				end
			end

			local var_27_7 = arg_24_1.actors_["1053ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_7) and arg_24_1.var_.characterEffect1053ui_story == nil then
				arg_24_1.var_.characterEffect1053ui_story = var_27_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_8 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_8 and not isNil(var_27_7) then
				if arg_24_1.var_.characterEffect1053ui_story and not isNil(var_27_7) then
					arg_24_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_8)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_8 and arg_24_1.time_ < 0 + var_27_8 + arg_27_0 and not isNil(var_27_7) and arg_24_1.var_.characterEffect1053ui_story then
				arg_24_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_27_9 = 0
			local var_27_10 = 1.05

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_9 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_11 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(324171006).content)

				arg_24_1.text_.text = var_27_11

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_13 = 42 <= 0 and var_27_10 or var_27_10 * (utf8.len(var_27_11) / 42)

				if (42 <= 0 and var_27_10 or var_27_10 * (utf8.len(var_27_11) / 42)) > 0 and var_27_10 < var_27_13 then
					arg_24_1.talkMaxDuration = var_27_13

					if var_27_13 + var_27_9 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_9
					end
				end

				arg_24_1.text_.text = var_27_11
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_14 = math.max(var_27_10, arg_24_1.talkMaxDuration)

			if var_27_9 <= arg_24_1.time_ and arg_24_1.time_ < var_27_9 + var_27_14 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_9) / var_27_14

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_9 + var_27_14 and arg_24_1.time_ < var_27_9 + var_27_14 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play324171007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324171007
		arg_28_1.duration_ = 2

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play324171008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1170ui_story = arg_28_1.actors_["1170ui_story"].transform.localPosition

				local var_31_0 = GameObjectTools.GetOrAddComponent(arg_28_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_31_0 then
					var_31_0:EnableDynamicBone(false)
				end
			end

			local var_31_1 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_1 then
				arg_28_1.actors_["1170ui_story"].transform.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1170ui_story, Vector3.New(-0.68, -0.95, -6.08), (arg_28_1.time_ - 0) / var_31_1)
				arg_28_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1170ui_story"].transform.position).z)
				arg_28_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1170ui_story"].transform.localEulerAngles = arg_28_1.actors_["1170ui_story"].transform.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_1 and arg_28_1.time_ < 0 + var_31_1 + arg_31_0 then
				arg_28_1.actors_["1170ui_story"].transform.localPosition = Vector3.New(-0.68, -0.95, -6.08)
				arg_28_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1170ui_story"].transform.position).z)
				arg_28_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1170ui_story"].transform.localEulerAngles = arg_28_1.actors_["1170ui_story"].transform.localEulerAngles

				local var_31_2 = GameObjectTools.GetOrAddComponent(arg_28_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(true)
				end
			end

			local var_31_3 = arg_28_1.actors_["1170ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_3) and arg_28_1.var_.characterEffect1170ui_story == nil then
				arg_28_1.var_.characterEffect1170ui_story = var_31_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_4 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 and not isNil(var_31_3) then
				if arg_28_1.var_.characterEffect1170ui_story and not isNil(var_31_3) then
					arg_28_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 and not isNil(var_31_3) and arg_28_1.var_.characterEffect1170ui_story then
				arg_28_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action3_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_31_6 = 0
			local var_31_7 = 0.075

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_8 = arg_28_1:GetWordFromCfg(324171007)
				local var_31_9 = arg_28_1:FormatText(var_31_8.content)

				arg_28_1.text_.text = var_31_9

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_11 = 3 <= 0 and var_31_7 or var_31_7 * (utf8.len(var_31_9) / 3)

				if (3 <= 0 and var_31_7 or var_31_7 * (utf8.len(var_31_9) / 3)) > 0 and var_31_7 < var_31_11 then
					arg_28_1.talkMaxDuration = var_31_11

					if var_31_11 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_11 + var_31_6
					end
				end

				arg_28_1.text_.text = var_31_9
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171007", "story_v_out_324171.awb") ~= 0 then
					local var_31_12 = manager.audio:GetVoiceLength("story_v_out_324171", "324171007", "story_v_out_324171.awb") / 1000

					if var_31_12 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_12 + var_31_6
					end

					if var_31_8.prefab_name ~= "" and arg_28_1.actors_[var_31_8.prefab_name] ~= nil then
						local var_31_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_8.prefab_name].transform, "story_v_out_324171", "324171007", "story_v_out_324171.awb")

						arg_28_1:RecordAudio("324171007", var_31_13)
						arg_28_1:RecordAudio("324171007", var_31_13)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_324171", "324171007", "story_v_out_324171.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_324171", "324171007", "story_v_out_324171.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_14 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_14 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_14

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_14 and arg_28_1.time_ < var_31_6 + var_31_14 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play324171008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324171008
		arg_32_1.duration_ = 7.53

		local var_32_0 = {
			zh = 3.833,
			ja = 7.533
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play324171009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1053ui_story = arg_32_1.actors_["1053ui_story"].transform.localPosition

				local var_35_0 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_0 then
					var_35_0:EnableDynamicBone(false)
				end
			end

			local var_35_1 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_1 then
				arg_32_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1053ui_story, Vector3.New(0.7, -1.08, -6), (arg_32_1.time_ - 0) / var_35_1)
				arg_32_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1053ui_story"].transform.position).z)
				arg_32_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1053ui_story"].transform.localEulerAngles = arg_32_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_1 and arg_32_1.time_ < 0 + var_35_1 + arg_35_0 then
				arg_32_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -6)
				arg_32_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1053ui_story"].transform.position).z)
				arg_32_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1053ui_story"].transform.localEulerAngles = arg_32_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_35_2 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(true)
				end
			end

			local var_35_3 = arg_32_1.actors_["1053ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_3) and arg_32_1.var_.characterEffect1053ui_story == nil then
				arg_32_1.var_.characterEffect1053ui_story = var_35_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_4 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 and not isNil(var_35_3) then
				if arg_32_1.var_.characterEffect1053ui_story and not isNil(var_35_3) then
					arg_32_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 and not isNil(var_35_3) and arg_32_1.var_.characterEffect1053ui_story then
				arg_32_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_35_6 = arg_32_1.actors_["1170ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_6) and arg_32_1.var_.characterEffect1170ui_story == nil then
				arg_32_1.var_.characterEffect1170ui_story = var_35_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_7 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 and not isNil(var_35_6) then
				if arg_32_1.var_.characterEffect1170ui_story and not isNil(var_35_6) then
					arg_32_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_7)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 and not isNil(var_35_6) and arg_32_1.var_.characterEffect1170ui_story then
				arg_32_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action2_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_35_8 = 0
			local var_35_9 = 0.475

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_8 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_10 = arg_32_1:GetWordFromCfg(324171008)
				local var_35_11 = arg_32_1:FormatText(var_35_10.content)

				arg_32_1.text_.text = var_35_11

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_13 = 19 <= 0 and var_35_9 or var_35_9 * (utf8.len(var_35_11) / 19)

				if (19 <= 0 and var_35_9 or var_35_9 * (utf8.len(var_35_11) / 19)) > 0 and var_35_9 < var_35_13 then
					arg_32_1.talkMaxDuration = var_35_13

					if var_35_13 + var_35_8 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_8
					end
				end

				arg_32_1.text_.text = var_35_11
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171008", "story_v_out_324171.awb") ~= 0 then
					local var_35_14 = manager.audio:GetVoiceLength("story_v_out_324171", "324171008", "story_v_out_324171.awb") / 1000

					if var_35_14 + var_35_8 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_14 + var_35_8
					end

					if var_35_10.prefab_name ~= "" and arg_32_1.actors_[var_35_10.prefab_name] ~= nil then
						local var_35_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_10.prefab_name].transform, "story_v_out_324171", "324171008", "story_v_out_324171.awb")

						arg_32_1:RecordAudio("324171008", var_35_15)
						arg_32_1:RecordAudio("324171008", var_35_15)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_324171", "324171008", "story_v_out_324171.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_324171", "324171008", "story_v_out_324171.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_16 = math.max(var_35_9, arg_32_1.talkMaxDuration)

			if var_35_8 <= arg_32_1.time_ and arg_32_1.time_ < var_35_8 + var_35_16 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_8) / var_35_16

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_8 + var_35_16 and arg_32_1.time_ < var_35_8 + var_35_16 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play324171009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324171009
		arg_36_1.duration_ = 7.13

		local var_36_0 = {
			zh = 7.133,
			ja = 6.9
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play324171010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1170ui_story"]) and arg_36_1.var_.characterEffect1170ui_story == nil then
				arg_36_1.var_.characterEffect1170ui_story = arg_36_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1170ui_story"]) then
				if arg_36_1.var_.characterEffect1170ui_story and not isNil(arg_36_1.actors_["1170ui_story"]) then
					arg_36_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1170ui_story"]) and arg_36_1.var_.characterEffect1170ui_story then
				arg_36_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_39_2 = arg_36_1.actors_["1053ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1053ui_story == nil then
				arg_36_1.var_.characterEffect1053ui_story = var_39_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_3 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.characterEffect1053ui_story and not isNil(var_39_2) then
					arg_36_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_3)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1053ui_story then
				arg_36_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_39_4 = 0
			local var_39_5 = 0.6

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_6 = arg_36_1:GetWordFromCfg(324171009)
				local var_39_7 = arg_36_1:FormatText(var_39_6.content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 24 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 24)

				if (24 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 24)) > 0 and var_39_5 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171009", "story_v_out_324171.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_out_324171", "324171009", "story_v_out_324171.awb") / 1000

					if var_39_10 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_4
					end

					if var_39_6.prefab_name ~= "" and arg_36_1.actors_[var_39_6.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_6.prefab_name].transform, "story_v_out_324171", "324171009", "story_v_out_324171.awb")

						arg_36_1:RecordAudio("324171009", var_39_11)
						arg_36_1:RecordAudio("324171009", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_324171", "324171009", "story_v_out_324171.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_324171", "324171009", "story_v_out_324171.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_12 = math.max(var_39_5, arg_36_1.talkMaxDuration)

			if var_39_4 <= arg_36_1.time_ and arg_36_1.time_ < var_39_4 + var_39_12 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_4) / var_39_12

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_4 + var_39_12 and arg_36_1.time_ < var_39_4 + var_39_12 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play324171010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324171010
		arg_40_1.duration_ = 13.63

		local var_40_0 = {
			zh = 9.633,
			ja = 13.633
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play324171011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170actionlink/1170action432")
			end

			local var_43_0 = 0
			local var_43_1 = 0.975

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_2 = arg_40_1:GetWordFromCfg(324171010)
				local var_43_3 = arg_40_1:FormatText(var_43_2.content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 39 <= 0 and var_43_1 or var_43_1 * (utf8.len(var_43_3) / 39)

				if (39 <= 0 and var_43_1 or var_43_1 * (utf8.len(var_43_3) / 39)) > 0 and var_43_1 < var_43_5 then
					arg_40_1.talkMaxDuration = var_43_5

					if var_43_5 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171010", "story_v_out_324171.awb") ~= 0 then
					local var_43_6 = manager.audio:GetVoiceLength("story_v_out_324171", "324171010", "story_v_out_324171.awb") / 1000

					if var_43_6 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_0
					end

					if var_43_2.prefab_name ~= "" and arg_40_1.actors_[var_43_2.prefab_name] ~= nil then
						local var_43_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_2.prefab_name].transform, "story_v_out_324171", "324171010", "story_v_out_324171.awb")

						arg_40_1:RecordAudio("324171010", var_43_7)
						arg_40_1:RecordAudio("324171010", var_43_7)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_324171", "324171010", "story_v_out_324171.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_324171", "324171010", "story_v_out_324171.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_8 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_8 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_8

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_8 and arg_40_1.time_ < var_43_0 + var_43_8 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play324171011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324171011
		arg_44_1.duration_ = 5.8

		local var_44_0 = {
			zh = 3.666,
			ja = 5.8
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play324171012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1053ui_story"]) and arg_44_1.var_.characterEffect1053ui_story == nil then
				arg_44_1.var_.characterEffect1053ui_story = arg_44_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1053ui_story"]) then
				if arg_44_1.var_.characterEffect1053ui_story and not isNil(arg_44_1.actors_["1053ui_story"]) then
					arg_44_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1053ui_story"]) and arg_44_1.var_.characterEffect1053ui_story then
				arg_44_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_47_2 = arg_44_1.actors_["1170ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1170ui_story == nil then
				arg_44_1.var_.characterEffect1170ui_story = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.characterEffect1170ui_story and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_3)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1170ui_story then
				arg_44_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053actionlink/1053action425")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_47_4 = 0
			local var_47_5 = 0.35

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(324171011)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 14 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 14)

				if (14 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 14)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171011", "story_v_out_324171.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_324171", "324171011", "story_v_out_324171.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_out_324171", "324171011", "story_v_out_324171.awb")

						arg_44_1:RecordAudio("324171011", var_47_11)
						arg_44_1:RecordAudio("324171011", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_324171", "324171011", "story_v_out_324171.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_324171", "324171011", "story_v_out_324171.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_12 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_12 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_12

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_12 and arg_44_1.time_ < var_47_4 + var_47_12 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play324171012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324171012
		arg_48_1.duration_ = 5.77

		local var_48_0 = {
			zh = 4,
			ja = 5.766
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play324171013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1170ui_story"]) and arg_48_1.var_.characterEffect1170ui_story == nil then
				arg_48_1.var_.characterEffect1170ui_story = arg_48_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1170ui_story"]) then
				if arg_48_1.var_.characterEffect1170ui_story and not isNil(arg_48_1.actors_["1170ui_story"]) then
					arg_48_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1170ui_story"]) and arg_48_1.var_.characterEffect1170ui_story then
				arg_48_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["1053ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1053ui_story == nil then
				arg_48_1.var_.characterEffect1053ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect1053ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1053ui_story then
				arg_48_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_51_4 = 0
			local var_51_5 = 0.4

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(324171012)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 16 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 16)

				if (16 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 16)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171012", "story_v_out_324171.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_324171", "324171012", "story_v_out_324171.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_324171", "324171012", "story_v_out_324171.awb")

						arg_48_1:RecordAudio("324171012", var_51_11)
						arg_48_1:RecordAudio("324171012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_324171", "324171012", "story_v_out_324171.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_324171", "324171012", "story_v_out_324171.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_12 and arg_48_1.time_ < var_51_4 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play324171013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 324171013
		arg_52_1.duration_ = 9.9

		local var_52_0 = {
			zh = 6.633,
			ja = 9.9
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play324171014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action2_2")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_55_0 = 0
			local var_55_1 = 0.775

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_2 = arg_52_1:GetWordFromCfg(324171013)
				local var_55_3 = arg_52_1:FormatText(var_55_2.content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 31 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 31)

				if (31 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 31)) > 0 and var_55_1 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171013", "story_v_out_324171.awb") ~= 0 then
					local var_55_6 = manager.audio:GetVoiceLength("story_v_out_324171", "324171013", "story_v_out_324171.awb") / 1000

					if var_55_6 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_0
					end

					if var_55_2.prefab_name ~= "" and arg_52_1.actors_[var_55_2.prefab_name] ~= nil then
						local var_55_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_2.prefab_name].transform, "story_v_out_324171", "324171013", "story_v_out_324171.awb")

						arg_52_1:RecordAudio("324171013", var_55_7)
						arg_52_1:RecordAudio("324171013", var_55_7)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_324171", "324171013", "story_v_out_324171.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_324171", "324171013", "story_v_out_324171.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_8 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_8 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_8

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_8 and arg_52_1.time_ < var_55_0 + var_55_8 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play324171014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 324171014
		arg_56_1.duration_ = 2.43

		local var_56_0 = {
			zh = 1.999999999999,
			ja = 2.433
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play324171015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1053ui_story"]) and arg_56_1.var_.characterEffect1053ui_story == nil then
				arg_56_1.var_.characterEffect1053ui_story = arg_56_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1053ui_story"]) then
				if arg_56_1.var_.characterEffect1053ui_story and not isNil(arg_56_1.actors_["1053ui_story"]) then
					arg_56_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1053ui_story"]) and arg_56_1.var_.characterEffect1053ui_story then
				arg_56_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_59_2 = arg_56_1.actors_["1170ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect1170ui_story == nil then
				arg_56_1.var_.characterEffect1170ui_story = var_59_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_3 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 and not isNil(var_59_2) then
				if arg_56_1.var_.characterEffect1170ui_story and not isNil(var_59_2) then
					arg_56_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_3)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect1170ui_story then
				arg_56_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action5_2")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_59_4 = 0
			local var_59_5 = 0.075

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_6 = arg_56_1:GetWordFromCfg(324171014)
				local var_59_7 = arg_56_1:FormatText(var_59_6.content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 3 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 3)

				if (3 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 3)) > 0 and var_59_5 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171014", "story_v_out_324171.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_324171", "324171014", "story_v_out_324171.awb") / 1000

					if var_59_10 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_4
					end

					if var_59_6.prefab_name ~= "" and arg_56_1.actors_[var_59_6.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_6.prefab_name].transform, "story_v_out_324171", "324171014", "story_v_out_324171.awb")

						arg_56_1:RecordAudio("324171014", var_59_11)
						arg_56_1:RecordAudio("324171014", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_324171", "324171014", "story_v_out_324171.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_324171", "324171014", "story_v_out_324171.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_5, arg_56_1.talkMaxDuration)

			if var_59_4 <= arg_56_1.time_ and arg_56_1.time_ < var_59_4 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_4) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_4 + var_59_12 and arg_56_1.time_ < var_59_4 + var_59_12 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play324171015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 324171015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play324171016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1053ui_story = arg_60_1.actors_["1053ui_story"].transform.localPosition

				local var_63_0 = GameObjectTools.GetOrAddComponent(arg_60_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_63_0 then
					var_63_0:EnableDynamicBone(false)
				end
			end

			local var_63_1 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_1 then
				arg_60_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_1)
				arg_60_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1053ui_story"].transform.position).z)
				arg_60_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1053ui_story"].transform.localEulerAngles = arg_60_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_1 and arg_60_1.time_ < 0 + var_63_1 + arg_63_0 then
				arg_60_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1053ui_story"].transform.position).z)
				arg_60_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1053ui_story"].transform.localEulerAngles = arg_60_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_63_2 = GameObjectTools.GetOrAddComponent(arg_60_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(true)
				end
			end

			local var_63_3 = arg_60_1.actors_["1170ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1170ui_story = var_63_3.localPosition

				local var_63_4 = GameObjectTools.GetOrAddComponent(var_63_3.gameObject, typeof(DynamicBoneHelper))

				if var_63_4 then
					var_63_4:EnableDynamicBone(false)
				end
			end

			local var_63_5 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_5 then
				var_63_3.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1170ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_5)
				var_63_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_3.position).x, (manager.ui.mainCamera.transform.position - var_63_3.position).y, (manager.ui.mainCamera.transform.position - var_63_3.position).z)
				var_63_3.localEulerAngles.z = 0
				var_63_3.localEulerAngles.x = 0
				var_63_3.localEulerAngles = var_63_3.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_5 and arg_60_1.time_ < 0 + var_63_5 + arg_63_0 then
				var_63_3.localPosition = Vector3.New(0, 100, 0)
				var_63_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_3.position).x, (manager.ui.mainCamera.transform.position - var_63_3.position).y, (manager.ui.mainCamera.transform.position - var_63_3.position).z)
				var_63_3.localEulerAngles.z = 0
				var_63_3.localEulerAngles.x = 0
				var_63_3.localEulerAngles = var_63_3.localEulerAngles

				local var_63_6 = GameObjectTools.GetOrAddComponent(var_63_3.gameObject, typeof(DynamicBoneHelper))

				if var_63_6 then
					var_63_6:EnableDynamicBone(true)
				end
			end

			local var_63_7 = arg_60_1.actors_["1053ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_7) and arg_60_1.var_.characterEffect1053ui_story == nil then
				arg_60_1.var_.characterEffect1053ui_story = var_63_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_8 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_8 and not isNil(var_63_7) then
				if arg_60_1.var_.characterEffect1053ui_story and not isNil(var_63_7) then
					arg_60_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_8)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_8 and arg_60_1.time_ < 0 + var_63_8 + arg_63_0 and not isNil(var_63_7) and arg_60_1.var_.characterEffect1053ui_story then
				arg_60_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 1 < arg_60_1.time_ and arg_60_1.time_ <= 1 + arg_63_0 then
				arg_60_1:AudioAction("play", "effect", "se_story_side_1034", "se_story_side_1034_clap", "")
			end

			local var_63_10 = 0
			local var_63_11 = 1.025

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_12 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(324171015).content)

				arg_60_1.text_.text = var_63_12

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_14 = 41 <= 0 and var_63_11 or var_63_11 * (utf8.len(var_63_12) / 41)

				if (41 <= 0 and var_63_11 or var_63_11 * (utf8.len(var_63_12) / 41)) > 0 and var_63_11 < var_63_14 then
					arg_60_1.talkMaxDuration = var_63_14

					if var_63_14 + var_63_10 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_14 + var_63_10
					end
				end

				arg_60_1.text_.text = var_63_12
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_15 = math.max(var_63_11, arg_60_1.talkMaxDuration)

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_15 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_10) / var_63_15

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_10 + var_63_15 and arg_60_1.time_ < var_63_10 + var_63_15 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play324171016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 324171016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play324171017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.6

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_1 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(324171016).content)

				arg_64_1.text_.text = var_67_1

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_3 = 24 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 24)

				if (24 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 24)) > 0 and var_67_0 < var_67_3 then
					arg_64_1.talkMaxDuration = var_67_3

					if var_67_3 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_3 + 0
					end
				end

				arg_64_1.text_.text = var_67_1
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_4 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_4

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play324171017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 324171017
		arg_68_1.duration_ = 11.4

		local var_68_0 = {
			zh = 8.033,
			ja = 11.4
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play324171018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1053ui_story = arg_68_1.actors_["1053ui_story"].transform.localPosition

				local var_71_0 = GameObjectTools.GetOrAddComponent(arg_68_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_71_0 then
					var_71_0:EnableDynamicBone(false)
				end
			end

			local var_71_1 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_1 then
				arg_68_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_68_1.time_ - 0) / var_71_1)
				arg_68_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1053ui_story"].transform.position).z)
				arg_68_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1053ui_story"].transform.localEulerAngles = arg_68_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_1 and arg_68_1.time_ < 0 + var_71_1 + arg_71_0 then
				arg_68_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_68_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1053ui_story"].transform.position).z)
				arg_68_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1053ui_story"].transform.localEulerAngles = arg_68_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_71_2 = GameObjectTools.GetOrAddComponent(arg_68_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_71_2 then
					var_71_2:EnableDynamicBone(true)
				end
			end

			local var_71_3 = arg_68_1.actors_["1053ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_3) and arg_68_1.var_.characterEffect1053ui_story == nil then
				arg_68_1.var_.characterEffect1053ui_story = var_71_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_4 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 and not isNil(var_71_3) then
				if arg_68_1.var_.characterEffect1053ui_story and not isNil(var_71_3) then
					arg_68_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 and not isNil(var_71_3) and arg_68_1.var_.characterEffect1053ui_story then
				arg_68_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action6_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_71_6 = 0
			local var_71_7 = 0.725

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_8 = arg_68_1:GetWordFromCfg(324171017)
				local var_71_9 = arg_68_1:FormatText(var_71_8.content)

				arg_68_1.text_.text = var_71_9

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_11 = 29 <= 0 and var_71_7 or var_71_7 * (utf8.len(var_71_9) / 29)

				if (29 <= 0 and var_71_7 or var_71_7 * (utf8.len(var_71_9) / 29)) > 0 and var_71_7 < var_71_11 then
					arg_68_1.talkMaxDuration = var_71_11

					if var_71_11 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_11 + var_71_6
					end
				end

				arg_68_1.text_.text = var_71_9
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171017", "story_v_out_324171.awb") ~= 0 then
					local var_71_12 = manager.audio:GetVoiceLength("story_v_out_324171", "324171017", "story_v_out_324171.awb") / 1000

					if var_71_12 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_12 + var_71_6
					end

					if var_71_8.prefab_name ~= "" and arg_68_1.actors_[var_71_8.prefab_name] ~= nil then
						local var_71_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_8.prefab_name].transform, "story_v_out_324171", "324171017", "story_v_out_324171.awb")

						arg_68_1:RecordAudio("324171017", var_71_13)
						arg_68_1:RecordAudio("324171017", var_71_13)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_324171", "324171017", "story_v_out_324171.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_324171", "324171017", "story_v_out_324171.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_14 = math.max(var_71_7, arg_68_1.talkMaxDuration)

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_14 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_6) / var_71_14

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_6 + var_71_14 and arg_68_1.time_ < var_71_6 + var_71_14 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play324171018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 324171018
		arg_72_1.duration_ = 12.67

		local var_72_0 = {
			zh = 12.666,
			ja = 10.666
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play324171019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 1.075

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_1 = arg_72_1:GetWordFromCfg(324171018)
				local var_75_2 = arg_72_1:FormatText(var_75_1.content)

				arg_72_1.text_.text = var_75_2

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 43 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 43)

				if (43 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 43)) > 0 and var_75_0 < var_75_4 then
					arg_72_1.talkMaxDuration = var_75_4

					if var_75_4 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_4 + 0
					end
				end

				arg_72_1.text_.text = var_75_2
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171018", "story_v_out_324171.awb") ~= 0 then
					local var_75_5 = manager.audio:GetVoiceLength("story_v_out_324171", "324171018", "story_v_out_324171.awb") / 1000

					if var_75_5 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + 0
					end

					if var_75_1.prefab_name ~= "" and arg_72_1.actors_[var_75_1.prefab_name] ~= nil then
						local var_75_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_1.prefab_name].transform, "story_v_out_324171", "324171018", "story_v_out_324171.awb")

						arg_72_1:RecordAudio("324171018", var_75_6)
						arg_72_1:RecordAudio("324171018", var_75_6)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_324171", "324171018", "story_v_out_324171.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_324171", "324171018", "story_v_out_324171.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play324171019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 324171019
		arg_76_1.duration_ = 4.53

		local var_76_0 = {
			zh = 3.366,
			ja = 4.533
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play324171020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.325

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_1 = arg_76_1:GetWordFromCfg(324171019)
				local var_79_2 = arg_76_1:FormatText(var_79_1.content)

				arg_76_1.text_.text = var_79_2

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 13 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 13)

				if (13 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 13)) > 0 and var_79_0 < var_79_4 then
					arg_76_1.talkMaxDuration = var_79_4

					if var_79_4 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_4 + 0
					end
				end

				arg_76_1.text_.text = var_79_2
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171019", "story_v_out_324171.awb") ~= 0 then
					local var_79_5 = manager.audio:GetVoiceLength("story_v_out_324171", "324171019", "story_v_out_324171.awb") / 1000

					if var_79_5 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + 0
					end

					if var_79_1.prefab_name ~= "" and arg_76_1.actors_[var_79_1.prefab_name] ~= nil then
						local var_79_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_1.prefab_name].transform, "story_v_out_324171", "324171019", "story_v_out_324171.awb")

						arg_76_1:RecordAudio("324171019", var_79_6)
						arg_76_1:RecordAudio("324171019", var_79_6)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_324171", "324171019", "story_v_out_324171.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_324171", "324171019", "story_v_out_324171.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play324171020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 324171020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play324171021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1053ui_story = arg_80_1.actors_["1053ui_story"].transform.localPosition

				local var_83_0 = GameObjectTools.GetOrAddComponent(arg_80_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_83_0 then
					var_83_0:EnableDynamicBone(false)
				end
			end

			local var_83_1 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_1 then
				arg_80_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_1)
				arg_80_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1053ui_story"].transform.position).z)
				arg_80_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1053ui_story"].transform.localEulerAngles = arg_80_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_1 and arg_80_1.time_ < 0 + var_83_1 + arg_83_0 then
				arg_80_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1053ui_story"].transform.position).z)
				arg_80_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1053ui_story"].transform.localEulerAngles = arg_80_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_83_2 = GameObjectTools.GetOrAddComponent(arg_80_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_83_2 then
					var_83_2:EnableDynamicBone(true)
				end
			end

			local var_83_3 = arg_80_1.actors_["1053ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_3) and arg_80_1.var_.characterEffect1053ui_story == nil then
				arg_80_1.var_.characterEffect1053ui_story = var_83_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_4 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 and not isNil(var_83_3) then
				if arg_80_1.var_.characterEffect1053ui_story and not isNil(var_83_3) then
					arg_80_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_4)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 and not isNil(var_83_3) and arg_80_1.var_.characterEffect1053ui_story then
				arg_80_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_83_5 = 0
			local var_83_6 = 0.9

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_7 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(324171020).content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 36 <= 0 and var_83_6 or var_83_6 * (utf8.len(var_83_7) / 36)

				if (36 <= 0 and var_83_6 or var_83_6 * (utf8.len(var_83_7) / 36)) > 0 and var_83_6 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9

					if var_83_9 + var_83_5 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_5
					end
				end

				arg_80_1.text_.text = var_83_7
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_6, arg_80_1.talkMaxDuration)

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_5) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_5 + var_83_10 and arg_80_1.time_ < var_83_5 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play324171021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 324171021
		arg_84_1.duration_ = 7.03

		local var_84_0 = {
			zh = 4.833,
			ja = 7.033
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play324171022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1053ui_story = arg_84_1.actors_["1053ui_story"].transform.localPosition

				local var_87_0 = GameObjectTools.GetOrAddComponent(arg_84_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_87_0 then
					var_87_0:EnableDynamicBone(false)
				end
			end

			local var_87_1 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_1 then
				arg_84_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_84_1.time_ - 0) / var_87_1)
				arg_84_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1053ui_story"].transform.position).z)
				arg_84_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1053ui_story"].transform.localEulerAngles = arg_84_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_1 and arg_84_1.time_ < 0 + var_87_1 + arg_87_0 then
				arg_84_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_84_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1053ui_story"].transform.position).z)
				arg_84_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1053ui_story"].transform.localEulerAngles = arg_84_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_87_2 = GameObjectTools.GetOrAddComponent(arg_84_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_87_2 then
					var_87_2:EnableDynamicBone(true)
				end
			end

			local var_87_3 = arg_84_1.actors_["1053ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_3) and arg_84_1.var_.characterEffect1053ui_story == nil then
				arg_84_1.var_.characterEffect1053ui_story = var_87_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_4 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 and not isNil(var_87_3) then
				if arg_84_1.var_.characterEffect1053ui_story and not isNil(var_87_3) then
					arg_84_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 and not isNil(var_87_3) and arg_84_1.var_.characterEffect1053ui_story then
				arg_84_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053actionlink/1053action465")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_87_6 = 0
			local var_87_7 = 0.6

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_8 = arg_84_1:GetWordFromCfg(324171021)
				local var_87_9 = arg_84_1:FormatText(var_87_8.content)

				arg_84_1.text_.text = var_87_9

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_11 = 24 <= 0 and var_87_7 or var_87_7 * (utf8.len(var_87_9) / 24)

				if (24 <= 0 and var_87_7 or var_87_7 * (utf8.len(var_87_9) / 24)) > 0 and var_87_7 < var_87_11 then
					arg_84_1.talkMaxDuration = var_87_11

					if var_87_11 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_11 + var_87_6
					end
				end

				arg_84_1.text_.text = var_87_9
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171021", "story_v_out_324171.awb") ~= 0 then
					local var_87_12 = manager.audio:GetVoiceLength("story_v_out_324171", "324171021", "story_v_out_324171.awb") / 1000

					if var_87_12 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_12 + var_87_6
					end

					if var_87_8.prefab_name ~= "" and arg_84_1.actors_[var_87_8.prefab_name] ~= nil then
						local var_87_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_8.prefab_name].transform, "story_v_out_324171", "324171021", "story_v_out_324171.awb")

						arg_84_1:RecordAudio("324171021", var_87_13)
						arg_84_1:RecordAudio("324171021", var_87_13)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_324171", "324171021", "story_v_out_324171.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_324171", "324171021", "story_v_out_324171.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_14 = math.max(var_87_7, arg_84_1.talkMaxDuration)

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_14 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_6) / var_87_14

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_6 + var_87_14 and arg_84_1.time_ < var_87_6 + var_87_14 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play324171022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 324171022
		arg_88_1.duration_ = 3.97

		local var_88_0 = {
			zh = 3,
			ja = 3.966
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play324171023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1170ui_story = arg_88_1.actors_["1170ui_story"].transform.localPosition

				local var_91_0 = GameObjectTools.GetOrAddComponent(arg_88_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_91_0 then
					var_91_0:EnableDynamicBone(false)
				end
			end

			local var_91_1 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_1 then
				arg_88_1.actors_["1170ui_story"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1170ui_story, Vector3.New(-0.68, -0.95, -6.08), (arg_88_1.time_ - 0) / var_91_1)
				arg_88_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1170ui_story"].transform.position).z)
				arg_88_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1170ui_story"].transform.localEulerAngles = arg_88_1.actors_["1170ui_story"].transform.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_1 and arg_88_1.time_ < 0 + var_91_1 + arg_91_0 then
				arg_88_1.actors_["1170ui_story"].transform.localPosition = Vector3.New(-0.68, -0.95, -6.08)
				arg_88_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1170ui_story"].transform.position).z)
				arg_88_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1170ui_story"].transform.localEulerAngles = arg_88_1.actors_["1170ui_story"].transform.localEulerAngles

				local var_91_2 = GameObjectTools.GetOrAddComponent(arg_88_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_91_2 then
					var_91_2:EnableDynamicBone(true)
				end
			end

			local var_91_3 = arg_88_1.actors_["1053ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1053ui_story = var_91_3.localPosition

				local var_91_4 = GameObjectTools.GetOrAddComponent(var_91_3.gameObject, typeof(DynamicBoneHelper))

				if var_91_4 then
					var_91_4:EnableDynamicBone(false)
				end
			end

			local var_91_5 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_5 then
				var_91_3.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1053ui_story, Vector3.New(0.7, -1.08, -6), (arg_88_1.time_ - 0) / var_91_5)
				var_91_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_3.position).x, (manager.ui.mainCamera.transform.position - var_91_3.position).y, (manager.ui.mainCamera.transform.position - var_91_3.position).z)
				var_91_3.localEulerAngles.z = 0
				var_91_3.localEulerAngles.x = 0
				var_91_3.localEulerAngles = var_91_3.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_5 and arg_88_1.time_ < 0 + var_91_5 + arg_91_0 then
				var_91_3.localPosition = Vector3.New(0.7, -1.08, -6)
				var_91_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_3.position).x, (manager.ui.mainCamera.transform.position - var_91_3.position).y, (manager.ui.mainCamera.transform.position - var_91_3.position).z)
				var_91_3.localEulerAngles.z = 0
				var_91_3.localEulerAngles.x = 0
				var_91_3.localEulerAngles = var_91_3.localEulerAngles

				local var_91_6 = GameObjectTools.GetOrAddComponent(var_91_3.gameObject, typeof(DynamicBoneHelper))

				if var_91_6 then
					var_91_6:EnableDynamicBone(true)
				end
			end

			local var_91_7 = arg_88_1.actors_["1170ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_7) and arg_88_1.var_.characterEffect1170ui_story == nil then
				arg_88_1.var_.characterEffect1170ui_story = var_91_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_8 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_8 and not isNil(var_91_7) then
				if arg_88_1.var_.characterEffect1170ui_story and not isNil(var_91_7) then
					arg_88_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_8 and arg_88_1.time_ < 0 + var_91_8 + arg_91_0 and not isNil(var_91_7) and arg_88_1.var_.characterEffect1170ui_story then
				arg_88_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_91_10 = arg_88_1.actors_["1053ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_10) and arg_88_1.var_.characterEffect1053ui_story == nil then
				arg_88_1.var_.characterEffect1053ui_story = var_91_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_11 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_11 and not isNil(var_91_10) then
				if arg_88_1.var_.characterEffect1053ui_story and not isNil(var_91_10) then
					arg_88_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_11)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_11 and arg_88_1.time_ < 0 + var_91_11 + arg_91_0 and not isNil(var_91_10) and arg_88_1.var_.characterEffect1053ui_story then
				arg_88_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action6_1")
			end

			local var_91_12 = 0
			local var_91_13 = 0.2

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_12 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_14 = arg_88_1:GetWordFromCfg(324171022)
				local var_91_15 = arg_88_1:FormatText(var_91_14.content)

				arg_88_1.text_.text = var_91_15

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_17 = 8 <= 0 and var_91_13 or var_91_13 * (utf8.len(var_91_15) / 8)

				if (8 <= 0 and var_91_13 or var_91_13 * (utf8.len(var_91_15) / 8)) > 0 and var_91_13 < var_91_17 then
					arg_88_1.talkMaxDuration = var_91_17

					if var_91_17 + var_91_12 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_17 + var_91_12
					end
				end

				arg_88_1.text_.text = var_91_15
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171022", "story_v_out_324171.awb") ~= 0 then
					local var_91_18 = manager.audio:GetVoiceLength("story_v_out_324171", "324171022", "story_v_out_324171.awb") / 1000

					if var_91_18 + var_91_12 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_18 + var_91_12
					end

					if var_91_14.prefab_name ~= "" and arg_88_1.actors_[var_91_14.prefab_name] ~= nil then
						local var_91_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_14.prefab_name].transform, "story_v_out_324171", "324171022", "story_v_out_324171.awb")

						arg_88_1:RecordAudio("324171022", var_91_19)
						arg_88_1:RecordAudio("324171022", var_91_19)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_324171", "324171022", "story_v_out_324171.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_324171", "324171022", "story_v_out_324171.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_20 = math.max(var_91_13, arg_88_1.talkMaxDuration)

			if var_91_12 <= arg_88_1.time_ and arg_88_1.time_ < var_91_12 + var_91_20 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_12) / var_91_20

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_12 + var_91_20 and arg_88_1.time_ < var_91_12 + var_91_20 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play324171023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 324171023
		arg_92_1.duration_ = 9.23

		local var_92_0 = {
			zh = 6,
			ja = 9.233
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play324171024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1053ui_story = arg_92_1.actors_["1053ui_story"].transform.localPosition

				local var_95_0 = GameObjectTools.GetOrAddComponent(arg_92_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_95_0 then
					var_95_0:EnableDynamicBone(false)
				end
			end

			local var_95_1 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_1 then
				arg_92_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1053ui_story, Vector3.New(0.7, -1.08, -6), (arg_92_1.time_ - 0) / var_95_1)
				arg_92_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1053ui_story"].transform.position).z)
				arg_92_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1053ui_story"].transform.localEulerAngles = arg_92_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_1 and arg_92_1.time_ < 0 + var_95_1 + arg_95_0 then
				arg_92_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -6)
				arg_92_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1053ui_story"].transform.position).z)
				arg_92_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1053ui_story"].transform.localEulerAngles = arg_92_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_95_2 = GameObjectTools.GetOrAddComponent(arg_92_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(true)
				end
			end

			local var_95_3 = arg_92_1.actors_["1053ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_3) and arg_92_1.var_.characterEffect1053ui_story == nil then
				arg_92_1.var_.characterEffect1053ui_story = var_95_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_4 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 and not isNil(var_95_3) then
				if arg_92_1.var_.characterEffect1053ui_story and not isNil(var_95_3) then
					arg_92_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 and not isNil(var_95_3) and arg_92_1.var_.characterEffect1053ui_story then
				arg_92_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_95_6 = arg_92_1.actors_["1170ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_6) and arg_92_1.var_.characterEffect1170ui_story == nil then
				arg_92_1.var_.characterEffect1170ui_story = var_95_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_7 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 and not isNil(var_95_6) then
				if arg_92_1.var_.characterEffect1170ui_story and not isNil(var_95_6) then
					arg_92_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_7)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 and not isNil(var_95_6) and arg_92_1.var_.characterEffect1170ui_story then
				arg_92_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action5_2")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_95_8 = 0
			local var_95_9 = 0.575

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_8 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_10 = arg_92_1:GetWordFromCfg(324171023)
				local var_95_11 = arg_92_1:FormatText(var_95_10.content)

				arg_92_1.text_.text = var_95_11

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_13 = 23 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 23)

				if (23 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 23)) > 0 and var_95_9 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_8
					end
				end

				arg_92_1.text_.text = var_95_11
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171023", "story_v_out_324171.awb") ~= 0 then
					local var_95_14 = manager.audio:GetVoiceLength("story_v_out_324171", "324171023", "story_v_out_324171.awb") / 1000

					if var_95_14 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_14 + var_95_8
					end

					if var_95_10.prefab_name ~= "" and arg_92_1.actors_[var_95_10.prefab_name] ~= nil then
						local var_95_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_10.prefab_name].transform, "story_v_out_324171", "324171023", "story_v_out_324171.awb")

						arg_92_1:RecordAudio("324171023", var_95_15)
						arg_92_1:RecordAudio("324171023", var_95_15)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_324171", "324171023", "story_v_out_324171.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_324171", "324171023", "story_v_out_324171.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_16 = math.max(var_95_9, arg_92_1.talkMaxDuration)

			if var_95_8 <= arg_92_1.time_ and arg_92_1.time_ < var_95_8 + var_95_16 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_8) / var_95_16

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_8 + var_95_16 and arg_92_1.time_ < var_95_8 + var_95_16 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play324171024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 324171024
		arg_96_1.duration_ = 2.03

		local var_96_0 = {
			zh = 2.033,
			ja = 1.666
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play324171025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1170ui_story"]) and arg_96_1.var_.characterEffect1170ui_story == nil then
				arg_96_1.var_.characterEffect1170ui_story = arg_96_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1170ui_story"]) then
				if arg_96_1.var_.characterEffect1170ui_story and not isNil(arg_96_1.actors_["1170ui_story"]) then
					arg_96_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1170ui_story"]) and arg_96_1.var_.characterEffect1170ui_story then
				arg_96_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_99_2 = arg_96_1.actors_["1053ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect1053ui_story == nil then
				arg_96_1.var_.characterEffect1053ui_story = var_99_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_3 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_3 and not isNil(var_99_2) then
				if arg_96_1.var_.characterEffect1053ui_story and not isNil(var_99_2) then
					arg_96_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_3)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_3 and arg_96_1.time_ < 0 + var_99_3 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect1053ui_story then
				arg_96_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_99_4 = 0
			local var_99_5 = 0.1

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_6 = arg_96_1:GetWordFromCfg(324171024)
				local var_99_7 = arg_96_1:FormatText(var_99_6.content)

				arg_96_1.text_.text = var_99_7

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 4 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 4)

				if (4 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 4)) > 0 and var_99_5 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_4
					end
				end

				arg_96_1.text_.text = var_99_7
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171024", "story_v_out_324171.awb") ~= 0 then
					local var_99_10 = manager.audio:GetVoiceLength("story_v_out_324171", "324171024", "story_v_out_324171.awb") / 1000

					if var_99_10 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_4
					end

					if var_99_6.prefab_name ~= "" and arg_96_1.actors_[var_99_6.prefab_name] ~= nil then
						local var_99_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_6.prefab_name].transform, "story_v_out_324171", "324171024", "story_v_out_324171.awb")

						arg_96_1:RecordAudio("324171024", var_99_11)
						arg_96_1:RecordAudio("324171024", var_99_11)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_324171", "324171024", "story_v_out_324171.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_324171", "324171024", "story_v_out_324171.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_12 = math.max(var_99_5, arg_96_1.talkMaxDuration)

			if var_99_4 <= arg_96_1.time_ and arg_96_1.time_ < var_99_4 + var_99_12 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_4) / var_99_12

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_4 + var_99_12 and arg_96_1.time_ < var_99_4 + var_99_12 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play324171025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 324171025
		arg_100_1.duration_ = 4.7

		local var_100_0 = {
			zh = 4.433,
			ja = 4.7
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play324171026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action3_1")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_103_0 = 0
			local var_103_1 = 0.3

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_2 = arg_100_1:GetWordFromCfg(324171025)
				local var_103_3 = arg_100_1:FormatText(var_103_2.content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 12 <= 0 and var_103_1 or var_103_1 * (utf8.len(var_103_3) / 12)

				if (12 <= 0 and var_103_1 or var_103_1 * (utf8.len(var_103_3) / 12)) > 0 and var_103_1 < var_103_5 then
					arg_100_1.talkMaxDuration = var_103_5

					if var_103_5 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_3
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171025", "story_v_out_324171.awb") ~= 0 then
					local var_103_6 = manager.audio:GetVoiceLength("story_v_out_324171", "324171025", "story_v_out_324171.awb") / 1000

					if var_103_6 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_6 + var_103_0
					end

					if var_103_2.prefab_name ~= "" and arg_100_1.actors_[var_103_2.prefab_name] ~= nil then
						local var_103_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_2.prefab_name].transform, "story_v_out_324171", "324171025", "story_v_out_324171.awb")

						arg_100_1:RecordAudio("324171025", var_103_7)
						arg_100_1:RecordAudio("324171025", var_103_7)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_324171", "324171025", "story_v_out_324171.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_324171", "324171025", "story_v_out_324171.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_8 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_8 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_8

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_8 and arg_100_1.time_ < var_103_0 + var_103_8 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play324171026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 324171026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play324171027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1053ui_story = arg_104_1.actors_["1053ui_story"].transform.localPosition

				local var_107_0 = GameObjectTools.GetOrAddComponent(arg_104_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_107_0 then
					var_107_0:EnableDynamicBone(false)
				end
			end

			local var_107_1 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_1 then
				arg_104_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_104_1.time_ - 0) / var_107_1)
				arg_104_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1053ui_story"].transform.position).z)
				arg_104_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1053ui_story"].transform.localEulerAngles = arg_104_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_1 and arg_104_1.time_ < 0 + var_107_1 + arg_107_0 then
				arg_104_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_104_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1053ui_story"].transform.position).z)
				arg_104_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1053ui_story"].transform.localEulerAngles = arg_104_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_107_2 = GameObjectTools.GetOrAddComponent(arg_104_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_107_2 then
					var_107_2:EnableDynamicBone(true)
				end
			end

			local var_107_3 = arg_104_1.actors_["1170ui_story"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1170ui_story = var_107_3.localPosition

				local var_107_4 = GameObjectTools.GetOrAddComponent(var_107_3.gameObject, typeof(DynamicBoneHelper))

				if var_107_4 then
					var_107_4:EnableDynamicBone(false)
				end
			end

			local var_107_5 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_5 then
				var_107_3.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1170ui_story, Vector3.New(0, 100, 0), (arg_104_1.time_ - 0) / var_107_5)
				var_107_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_3.position).x, (manager.ui.mainCamera.transform.position - var_107_3.position).y, (manager.ui.mainCamera.transform.position - var_107_3.position).z)
				var_107_3.localEulerAngles.z = 0
				var_107_3.localEulerAngles.x = 0
				var_107_3.localEulerAngles = var_107_3.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_5 and arg_104_1.time_ < 0 + var_107_5 + arg_107_0 then
				var_107_3.localPosition = Vector3.New(0, 100, 0)
				var_107_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_3.position).x, (manager.ui.mainCamera.transform.position - var_107_3.position).y, (manager.ui.mainCamera.transform.position - var_107_3.position).z)
				var_107_3.localEulerAngles.z = 0
				var_107_3.localEulerAngles.x = 0
				var_107_3.localEulerAngles = var_107_3.localEulerAngles

				local var_107_6 = GameObjectTools.GetOrAddComponent(var_107_3.gameObject, typeof(DynamicBoneHelper))

				if var_107_6 then
					var_107_6:EnableDynamicBone(true)
				end
			end

			local var_107_7 = arg_104_1.actors_["1170ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_7) and arg_104_1.var_.characterEffect1170ui_story == nil then
				arg_104_1.var_.characterEffect1170ui_story = var_107_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_8 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_8 and not isNil(var_107_7) then
				if arg_104_1.var_.characterEffect1170ui_story and not isNil(var_107_7) then
					arg_104_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_8)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_8 and arg_104_1.time_ < 0 + var_107_8 + arg_107_0 and not isNil(var_107_7) and arg_104_1.var_.characterEffect1170ui_story then
				arg_104_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_107_9 = 0
			local var_107_10 = 1.375

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_9 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_11 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(324171026).content)

				arg_104_1.text_.text = var_107_11

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_13 = 55 <= 0 and var_107_10 or var_107_10 * (utf8.len(var_107_11) / 55)

				if (55 <= 0 and var_107_10 or var_107_10 * (utf8.len(var_107_11) / 55)) > 0 and var_107_10 < var_107_13 then
					arg_104_1.talkMaxDuration = var_107_13

					if var_107_13 + var_107_9 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_13 + var_107_9
					end
				end

				arg_104_1.text_.text = var_107_11
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_14 = math.max(var_107_10, arg_104_1.talkMaxDuration)

			if var_107_9 <= arg_104_1.time_ and arg_104_1.time_ < var_107_9 + var_107_14 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_9) / var_107_14

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_9 + var_107_14 and arg_104_1.time_ < var_107_9 + var_107_14 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play324171027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 324171027
		arg_108_1.duration_ = 7.7

		local var_108_0 = {
			zh = 4.733,
			ja = 7.7
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play324171028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1053ui_story = arg_108_1.actors_["1053ui_story"].transform.localPosition

				local var_111_0 = GameObjectTools.GetOrAddComponent(arg_108_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_111_0 then
					var_111_0:EnableDynamicBone(false)
				end
			end

			local var_111_1 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_1 then
				arg_108_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1053ui_story, Vector3.New(0.7, -1.08, -6), (arg_108_1.time_ - 0) / var_111_1)
				arg_108_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1053ui_story"].transform.position).z)
				arg_108_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1053ui_story"].transform.localEulerAngles = arg_108_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_1 and arg_108_1.time_ < 0 + var_111_1 + arg_111_0 then
				arg_108_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -6)
				arg_108_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1053ui_story"].transform.position).z)
				arg_108_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1053ui_story"].transform.localEulerAngles = arg_108_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_111_2 = GameObjectTools.GetOrAddComponent(arg_108_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_111_2 then
					var_111_2:EnableDynamicBone(true)
				end
			end

			local var_111_3 = arg_108_1.actors_["1053ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_3) and arg_108_1.var_.characterEffect1053ui_story == nil then
				arg_108_1.var_.characterEffect1053ui_story = var_111_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_4 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 and not isNil(var_111_3) then
				if arg_108_1.var_.characterEffect1053ui_story and not isNil(var_111_3) then
					arg_108_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 and not isNil(var_111_3) and arg_108_1.var_.characterEffect1053ui_story then
				arg_108_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_111_6 = 0
			local var_111_7 = 0.375

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_8 = arg_108_1:GetWordFromCfg(324171027)
				local var_111_9 = arg_108_1:FormatText(var_111_8.content)

				arg_108_1.text_.text = var_111_9

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_11 = 15 <= 0 and var_111_7 or var_111_7 * (utf8.len(var_111_9) / 15)

				if (15 <= 0 and var_111_7 or var_111_7 * (utf8.len(var_111_9) / 15)) > 0 and var_111_7 < var_111_11 then
					arg_108_1.talkMaxDuration = var_111_11

					if var_111_11 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_11 + var_111_6
					end
				end

				arg_108_1.text_.text = var_111_9
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171027", "story_v_out_324171.awb") ~= 0 then
					local var_111_12 = manager.audio:GetVoiceLength("story_v_out_324171", "324171027", "story_v_out_324171.awb") / 1000

					if var_111_12 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_12 + var_111_6
					end

					if var_111_8.prefab_name ~= "" and arg_108_1.actors_[var_111_8.prefab_name] ~= nil then
						local var_111_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_8.prefab_name].transform, "story_v_out_324171", "324171027", "story_v_out_324171.awb")

						arg_108_1:RecordAudio("324171027", var_111_13)
						arg_108_1:RecordAudio("324171027", var_111_13)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_324171", "324171027", "story_v_out_324171.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_324171", "324171027", "story_v_out_324171.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_14 = math.max(var_111_7, arg_108_1.talkMaxDuration)

			if var_111_6 <= arg_108_1.time_ and arg_108_1.time_ < var_111_6 + var_111_14 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_6) / var_111_14

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_6 + var_111_14 and arg_108_1.time_ < var_111_6 + var_111_14 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play324171028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 324171028
		arg_112_1.duration_ = 4.33

		local var_112_0 = {
			zh = 2.633,
			ja = 4.333
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play324171029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1170ui_story = arg_112_1.actors_["1170ui_story"].transform.localPosition

				local var_115_0 = GameObjectTools.GetOrAddComponent(arg_112_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_115_0 then
					var_115_0:EnableDynamicBone(false)
				end
			end

			local var_115_1 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_1 then
				arg_112_1.actors_["1170ui_story"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1170ui_story, Vector3.New(-0.68, -0.95, -6.08), (arg_112_1.time_ - 0) / var_115_1)
				arg_112_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1170ui_story"].transform.position).z)
				arg_112_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1170ui_story"].transform.localEulerAngles = arg_112_1.actors_["1170ui_story"].transform.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_1 and arg_112_1.time_ < 0 + var_115_1 + arg_115_0 then
				arg_112_1.actors_["1170ui_story"].transform.localPosition = Vector3.New(-0.68, -0.95, -6.08)
				arg_112_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1170ui_story"].transform.position).z)
				arg_112_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1170ui_story"].transform.localEulerAngles = arg_112_1.actors_["1170ui_story"].transform.localEulerAngles

				local var_115_2 = GameObjectTools.GetOrAddComponent(arg_112_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_115_2 then
					var_115_2:EnableDynamicBone(true)
				end
			end

			local var_115_3 = arg_112_1.actors_["1170ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_3) and arg_112_1.var_.characterEffect1170ui_story == nil then
				arg_112_1.var_.characterEffect1170ui_story = var_115_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_4 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 and not isNil(var_115_3) then
				if arg_112_1.var_.characterEffect1170ui_story and not isNil(var_115_3) then
					arg_112_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 and not isNil(var_115_3) and arg_112_1.var_.characterEffect1170ui_story then
				arg_112_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_115_6 = arg_112_1.actors_["1053ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_6) and arg_112_1.var_.characterEffect1053ui_story == nil then
				arg_112_1.var_.characterEffect1053ui_story = var_115_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_7 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 and not isNil(var_115_6) then
				if arg_112_1.var_.characterEffect1053ui_story and not isNil(var_115_6) then
					arg_112_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_7)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 and not isNil(var_115_6) and arg_112_1.var_.characterEffect1053ui_story then
				arg_112_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action3_2")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_115_8 = 0
			local var_115_9 = 0.2

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_8 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_10 = arg_112_1:GetWordFromCfg(324171028)
				local var_115_11 = arg_112_1:FormatText(var_115_10.content)

				arg_112_1.text_.text = var_115_11

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_13 = 8 <= 0 and var_115_9 or var_115_9 * (utf8.len(var_115_11) / 8)

				if (8 <= 0 and var_115_9 or var_115_9 * (utf8.len(var_115_11) / 8)) > 0 and var_115_9 < var_115_13 then
					arg_112_1.talkMaxDuration = var_115_13

					if var_115_13 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_13 + var_115_8
					end
				end

				arg_112_1.text_.text = var_115_11
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171028", "story_v_out_324171.awb") ~= 0 then
					local var_115_14 = manager.audio:GetVoiceLength("story_v_out_324171", "324171028", "story_v_out_324171.awb") / 1000

					if var_115_14 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_14 + var_115_8
					end

					if var_115_10.prefab_name ~= "" and arg_112_1.actors_[var_115_10.prefab_name] ~= nil then
						local var_115_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_10.prefab_name].transform, "story_v_out_324171", "324171028", "story_v_out_324171.awb")

						arg_112_1:RecordAudio("324171028", var_115_15)
						arg_112_1:RecordAudio("324171028", var_115_15)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_324171", "324171028", "story_v_out_324171.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_324171", "324171028", "story_v_out_324171.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_16 = math.max(var_115_9, arg_112_1.talkMaxDuration)

			if var_115_8 <= arg_112_1.time_ and arg_112_1.time_ < var_115_8 + var_115_16 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_8) / var_115_16

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_8 + var_115_16 and arg_112_1.time_ < var_115_8 + var_115_16 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play324171029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 324171029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play324171030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1170ui_story = arg_116_1.actors_["1170ui_story"].transform.localPosition

				local var_119_0 = GameObjectTools.GetOrAddComponent(arg_116_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_119_0 then
					var_119_0:EnableDynamicBone(false)
				end
			end

			local var_119_1 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_1 then
				arg_116_1.actors_["1170ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1170ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_1)
				arg_116_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1170ui_story"].transform.position).z)
				arg_116_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1170ui_story"].transform.localEulerAngles = arg_116_1.actors_["1170ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_1 and arg_116_1.time_ < 0 + var_119_1 + arg_119_0 then
				arg_116_1.actors_["1170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1170ui_story"].transform.position).z)
				arg_116_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1170ui_story"].transform.localEulerAngles = arg_116_1.actors_["1170ui_story"].transform.localEulerAngles

				local var_119_2 = GameObjectTools.GetOrAddComponent(arg_116_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(true)
				end
			end

			local var_119_3 = arg_116_1.actors_["1053ui_story"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1053ui_story = var_119_3.localPosition

				local var_119_4 = GameObjectTools.GetOrAddComponent(var_119_3.gameObject, typeof(DynamicBoneHelper))

				if var_119_4 then
					var_119_4:EnableDynamicBone(false)
				end
			end

			local var_119_5 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_5 then
				var_119_3.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_5)
				var_119_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_3.position).x, (manager.ui.mainCamera.transform.position - var_119_3.position).y, (manager.ui.mainCamera.transform.position - var_119_3.position).z)
				var_119_3.localEulerAngles.z = 0
				var_119_3.localEulerAngles.x = 0
				var_119_3.localEulerAngles = var_119_3.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_5 and arg_116_1.time_ < 0 + var_119_5 + arg_119_0 then
				var_119_3.localPosition = Vector3.New(0, 100, 0)
				var_119_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_3.position).x, (manager.ui.mainCamera.transform.position - var_119_3.position).y, (manager.ui.mainCamera.transform.position - var_119_3.position).z)
				var_119_3.localEulerAngles.z = 0
				var_119_3.localEulerAngles.x = 0
				var_119_3.localEulerAngles = var_119_3.localEulerAngles

				local var_119_6 = GameObjectTools.GetOrAddComponent(var_119_3.gameObject, typeof(DynamicBoneHelper))

				if var_119_6 then
					var_119_6:EnableDynamicBone(true)
				end
			end

			local var_119_7 = arg_116_1.actors_["1170ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_7) and arg_116_1.var_.characterEffect1170ui_story == nil then
				arg_116_1.var_.characterEffect1170ui_story = var_119_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_8 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_8 and not isNil(var_119_7) then
				if arg_116_1.var_.characterEffect1170ui_story and not isNil(var_119_7) then
					arg_116_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_8)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_8 and arg_116_1.time_ < 0 + var_119_8 + arg_119_0 and not isNil(var_119_7) and arg_116_1.var_.characterEffect1170ui_story then
				arg_116_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_119_9 = 0
			local var_119_10 = 0.575

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_9 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_11 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(324171029).content)

				arg_116_1.text_.text = var_119_11

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_13 = 23 <= 0 and var_119_10 or var_119_10 * (utf8.len(var_119_11) / 23)

				if (23 <= 0 and var_119_10 or var_119_10 * (utf8.len(var_119_11) / 23)) > 0 and var_119_10 < var_119_13 then
					arg_116_1.talkMaxDuration = var_119_13

					if var_119_13 + var_119_9 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_13 + var_119_9
					end
				end

				arg_116_1.text_.text = var_119_11
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_14 = math.max(var_119_10, arg_116_1.talkMaxDuration)

			if var_119_9 <= arg_116_1.time_ and arg_116_1.time_ < var_119_9 + var_119_14 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_9) / var_119_14

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_9 + var_119_14 and arg_116_1.time_ < var_119_9 + var_119_14 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play324171030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 324171030
		arg_120_1.duration_ = 6.2

		local var_120_0 = {
			zh = 4.6,
			ja = 6.2
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play324171031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1170ui_story = arg_120_1.actors_["1170ui_story"].transform.localPosition

				local var_123_0 = GameObjectTools.GetOrAddComponent(arg_120_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_123_0 then
					var_123_0:EnableDynamicBone(false)
				end
			end

			local var_123_1 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_1 then
				arg_120_1.actors_["1170ui_story"].transform.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1170ui_story, Vector3.New(-0.68, -0.95, -6.08), (arg_120_1.time_ - 0) / var_123_1)
				arg_120_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1170ui_story"].transform.position).z)
				arg_120_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["1170ui_story"].transform.localEulerAngles = arg_120_1.actors_["1170ui_story"].transform.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_1 and arg_120_1.time_ < 0 + var_123_1 + arg_123_0 then
				arg_120_1.actors_["1170ui_story"].transform.localPosition = Vector3.New(-0.68, -0.95, -6.08)
				arg_120_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1170ui_story"].transform.position).z)
				arg_120_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["1170ui_story"].transform.localEulerAngles = arg_120_1.actors_["1170ui_story"].transform.localEulerAngles

				local var_123_2 = GameObjectTools.GetOrAddComponent(arg_120_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_123_2 then
					var_123_2:EnableDynamicBone(true)
				end
			end

			local var_123_3 = arg_120_1.actors_["1170ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_3) and arg_120_1.var_.characterEffect1170ui_story == nil then
				arg_120_1.var_.characterEffect1170ui_story = var_123_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_4 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 and not isNil(var_123_3) then
				if arg_120_1.var_.characterEffect1170ui_story and not isNil(var_123_3) then
					arg_120_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 and not isNil(var_123_3) and arg_120_1.var_.characterEffect1170ui_story then
				arg_120_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action5_1")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_123_6 = 0
			local var_123_7 = 0.475

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_8 = arg_120_1:GetWordFromCfg(324171030)
				local var_123_9 = arg_120_1:FormatText(var_123_8.content)

				arg_120_1.text_.text = var_123_9

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 19 <= 0 and var_123_7 or var_123_7 * (utf8.len(var_123_9) / 19)

				if (19 <= 0 and var_123_7 or var_123_7 * (utf8.len(var_123_9) / 19)) > 0 and var_123_7 < var_123_11 then
					arg_120_1.talkMaxDuration = var_123_11

					if var_123_11 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_11 + var_123_6
					end
				end

				arg_120_1.text_.text = var_123_9
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171030", "story_v_out_324171.awb") ~= 0 then
					local var_123_12 = manager.audio:GetVoiceLength("story_v_out_324171", "324171030", "story_v_out_324171.awb") / 1000

					if var_123_12 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_12 + var_123_6
					end

					if var_123_8.prefab_name ~= "" and arg_120_1.actors_[var_123_8.prefab_name] ~= nil then
						local var_123_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_8.prefab_name].transform, "story_v_out_324171", "324171030", "story_v_out_324171.awb")

						arg_120_1:RecordAudio("324171030", var_123_13)
						arg_120_1:RecordAudio("324171030", var_123_13)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_324171", "324171030", "story_v_out_324171.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_324171", "324171030", "story_v_out_324171.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_14 = math.max(var_123_7, arg_120_1.talkMaxDuration)

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_14 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_6) / var_123_14

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_6 + var_123_14 and arg_120_1.time_ < var_123_6 + var_123_14 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play324171031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 324171031
		arg_124_1.duration_ = 5.2

		local var_124_0 = {
			zh = 3.766,
			ja = 5.2
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play324171032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1053ui_story = arg_124_1.actors_["1053ui_story"].transform.localPosition

				local var_127_0 = GameObjectTools.GetOrAddComponent(arg_124_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_127_0 then
					var_127_0:EnableDynamicBone(false)
				end
			end

			local var_127_1 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_1 then
				arg_124_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1053ui_story, Vector3.New(0.7, -1.08, -6), (arg_124_1.time_ - 0) / var_127_1)
				arg_124_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1053ui_story"].transform.position).z)
				arg_124_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1053ui_story"].transform.localEulerAngles = arg_124_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_1 and arg_124_1.time_ < 0 + var_127_1 + arg_127_0 then
				arg_124_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -6)
				arg_124_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1053ui_story"].transform.position).z)
				arg_124_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1053ui_story"].transform.localEulerAngles = arg_124_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_127_2 = GameObjectTools.GetOrAddComponent(arg_124_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_127_2 then
					var_127_2:EnableDynamicBone(true)
				end
			end

			local var_127_3 = arg_124_1.actors_["1053ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_3) and arg_124_1.var_.characterEffect1053ui_story == nil then
				arg_124_1.var_.characterEffect1053ui_story = var_127_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_4 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 and not isNil(var_127_3) then
				if arg_124_1.var_.characterEffect1053ui_story and not isNil(var_127_3) then
					arg_124_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 and not isNil(var_127_3) and arg_124_1.var_.characterEffect1053ui_story then
				arg_124_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_127_6 = arg_124_1.actors_["1170ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_6) and arg_124_1.var_.characterEffect1170ui_story == nil then
				arg_124_1.var_.characterEffect1170ui_story = var_127_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_7 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 and not isNil(var_127_6) then
				if arg_124_1.var_.characterEffect1170ui_story and not isNil(var_127_6) then
					arg_124_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_7)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 and not isNil(var_127_6) and arg_124_1.var_.characterEffect1170ui_story then
				arg_124_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_127_8 = 0
			local var_127_9 = 0.375

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_8 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_10 = arg_124_1:GetWordFromCfg(324171031)
				local var_127_11 = arg_124_1:FormatText(var_127_10.content)

				arg_124_1.text_.text = var_127_11

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_13 = 15 <= 0 and var_127_9 or var_127_9 * (utf8.len(var_127_11) / 15)

				if (15 <= 0 and var_127_9 or var_127_9 * (utf8.len(var_127_11) / 15)) > 0 and var_127_9 < var_127_13 then
					arg_124_1.talkMaxDuration = var_127_13

					if var_127_13 + var_127_8 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_13 + var_127_8
					end
				end

				arg_124_1.text_.text = var_127_11
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171031", "story_v_out_324171.awb") ~= 0 then
					local var_127_14 = manager.audio:GetVoiceLength("story_v_out_324171", "324171031", "story_v_out_324171.awb") / 1000

					if var_127_14 + var_127_8 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_14 + var_127_8
					end

					if var_127_10.prefab_name ~= "" and arg_124_1.actors_[var_127_10.prefab_name] ~= nil then
						local var_127_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_10.prefab_name].transform, "story_v_out_324171", "324171031", "story_v_out_324171.awb")

						arg_124_1:RecordAudio("324171031", var_127_15)
						arg_124_1:RecordAudio("324171031", var_127_15)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_324171", "324171031", "story_v_out_324171.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_324171", "324171031", "story_v_out_324171.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_16 = math.max(var_127_9, arg_124_1.talkMaxDuration)

			if var_127_8 <= arg_124_1.time_ and arg_124_1.time_ < var_127_8 + var_127_16 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_8) / var_127_16

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_8 + var_127_16 and arg_124_1.time_ < var_127_8 + var_127_16 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play324171032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 324171032
		arg_128_1.duration_ = 6.87

		local var_128_0 = {
			zh = 5.666,
			ja = 6.866
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play324171033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1170ui_story"]) and arg_128_1.var_.characterEffect1170ui_story == nil then
				arg_128_1.var_.characterEffect1170ui_story = arg_128_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1170ui_story"]) then
				if arg_128_1.var_.characterEffect1170ui_story and not isNil(arg_128_1.actors_["1170ui_story"]) then
					arg_128_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1170ui_story"]) and arg_128_1.var_.characterEffect1170ui_story then
				arg_128_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_131_2 = arg_128_1.actors_["1053ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect1053ui_story == nil then
				arg_128_1.var_.characterEffect1053ui_story = var_131_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_3 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_3 and not isNil(var_131_2) then
				if arg_128_1.var_.characterEffect1053ui_story and not isNil(var_131_2) then
					arg_128_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_3)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_3 and arg_128_1.time_ < 0 + var_131_3 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect1053ui_story then
				arg_128_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action5_2")
			end

			local var_131_4 = 0
			local var_131_5 = 0.45

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_6 = arg_128_1:GetWordFromCfg(324171032)
				local var_131_7 = arg_128_1:FormatText(var_131_6.content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 18 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 18)

				if (18 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 18)) > 0 and var_131_5 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171032", "story_v_out_324171.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_out_324171", "324171032", "story_v_out_324171.awb") / 1000

					if var_131_10 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_4
					end

					if var_131_6.prefab_name ~= "" and arg_128_1.actors_[var_131_6.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_6.prefab_name].transform, "story_v_out_324171", "324171032", "story_v_out_324171.awb")

						arg_128_1:RecordAudio("324171032", var_131_11)
						arg_128_1:RecordAudio("324171032", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_324171", "324171032", "story_v_out_324171.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_324171", "324171032", "story_v_out_324171.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_12 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_12 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_12

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_12 and arg_128_1.time_ < var_131_4 + var_131_12 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play324171033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 324171033
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play324171034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1053ui_story = arg_132_1.actors_["1053ui_story"].transform.localPosition

				local var_135_0 = GameObjectTools.GetOrAddComponent(arg_132_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_135_0 then
					var_135_0:EnableDynamicBone(false)
				end
			end

			local var_135_1 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_1 then
				arg_132_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_132_1.time_ - 0) / var_135_1)
				arg_132_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1053ui_story"].transform.position).z)
				arg_132_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1053ui_story"].transform.localEulerAngles = arg_132_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_1 and arg_132_1.time_ < 0 + var_135_1 + arg_135_0 then
				arg_132_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_132_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1053ui_story"].transform.position).z)
				arg_132_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1053ui_story"].transform.localEulerAngles = arg_132_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_135_2 = GameObjectTools.GetOrAddComponent(arg_132_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_135_2 then
					var_135_2:EnableDynamicBone(true)
				end
			end

			local var_135_3 = arg_132_1.actors_["1170ui_story"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1170ui_story = var_135_3.localPosition

				local var_135_4 = GameObjectTools.GetOrAddComponent(var_135_3.gameObject, typeof(DynamicBoneHelper))

				if var_135_4 then
					var_135_4:EnableDynamicBone(false)
				end
			end

			local var_135_5 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_5 then
				var_135_3.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1170ui_story, Vector3.New(0, 100, 0), (arg_132_1.time_ - 0) / var_135_5)
				var_135_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_3.position).x, (manager.ui.mainCamera.transform.position - var_135_3.position).y, (manager.ui.mainCamera.transform.position - var_135_3.position).z)
				var_135_3.localEulerAngles.z = 0
				var_135_3.localEulerAngles.x = 0
				var_135_3.localEulerAngles = var_135_3.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_5 and arg_132_1.time_ < 0 + var_135_5 + arg_135_0 then
				var_135_3.localPosition = Vector3.New(0, 100, 0)
				var_135_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_3.position).x, (manager.ui.mainCamera.transform.position - var_135_3.position).y, (manager.ui.mainCamera.transform.position - var_135_3.position).z)
				var_135_3.localEulerAngles.z = 0
				var_135_3.localEulerAngles.x = 0
				var_135_3.localEulerAngles = var_135_3.localEulerAngles

				local var_135_6 = GameObjectTools.GetOrAddComponent(var_135_3.gameObject, typeof(DynamicBoneHelper))

				if var_135_6 then
					var_135_6:EnableDynamicBone(true)
				end
			end

			local var_135_7 = arg_132_1.actors_["1170ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_7) and arg_132_1.var_.characterEffect1170ui_story == nil then
				arg_132_1.var_.characterEffect1170ui_story = var_135_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_8 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_8 and not isNil(var_135_7) then
				if arg_132_1.var_.characterEffect1170ui_story and not isNil(var_135_7) then
					arg_132_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_8)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_8 and arg_132_1.time_ < 0 + var_135_8 + arg_135_0 and not isNil(var_135_7) and arg_132_1.var_.characterEffect1170ui_story then
				arg_132_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_135_9 = 0
			local var_135_10 = 0.8

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_9 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_11 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(324171033).content)

				arg_132_1.text_.text = var_135_11

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_13 = 32 <= 0 and var_135_10 or var_135_10 * (utf8.len(var_135_11) / 32)

				if (32 <= 0 and var_135_10 or var_135_10 * (utf8.len(var_135_11) / 32)) > 0 and var_135_10 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_9 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_9
					end
				end

				arg_132_1.text_.text = var_135_11
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_14 = math.max(var_135_10, arg_132_1.talkMaxDuration)

			if var_135_9 <= arg_132_1.time_ and arg_132_1.time_ < var_135_9 + var_135_14 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_9) / var_135_14

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_9 + var_135_14 and arg_132_1.time_ < var_135_9 + var_135_14 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play324171034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 324171034
		arg_136_1.duration_ = 6.73

		local var_136_0 = {
			zh = 4.7,
			ja = 6.733
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play324171035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1053ui_story = arg_136_1.actors_["1053ui_story"].transform.localPosition

				local var_139_0 = GameObjectTools.GetOrAddComponent(arg_136_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_139_0 then
					var_139_0:EnableDynamicBone(false)
				end
			end

			local var_139_1 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_1 then
				arg_136_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1053ui_story, Vector3.New(0.7, -1.08, -6), (arg_136_1.time_ - 0) / var_139_1)
				arg_136_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1053ui_story"].transform.position).z)
				arg_136_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1053ui_story"].transform.localEulerAngles = arg_136_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_1 and arg_136_1.time_ < 0 + var_139_1 + arg_139_0 then
				arg_136_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -6)
				arg_136_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1053ui_story"].transform.position).z)
				arg_136_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1053ui_story"].transform.localEulerAngles = arg_136_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_139_2 = GameObjectTools.GetOrAddComponent(arg_136_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_139_2 then
					var_139_2:EnableDynamicBone(true)
				end
			end

			local var_139_3 = arg_136_1.actors_["1053ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_3) and arg_136_1.var_.characterEffect1053ui_story == nil then
				arg_136_1.var_.characterEffect1053ui_story = var_139_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_4 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_4 and not isNil(var_139_3) then
				if arg_136_1.var_.characterEffect1053ui_story and not isNil(var_139_3) then
					arg_136_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_4 and arg_136_1.time_ < 0 + var_139_4 + arg_139_0 and not isNil(var_139_3) and arg_136_1.var_.characterEffect1053ui_story then
				arg_136_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action4_1")
			end

			local var_139_6 = 0
			local var_139_7 = 0.4

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_8 = arg_136_1:GetWordFromCfg(324171034)
				local var_139_9 = arg_136_1:FormatText(var_139_8.content)

				arg_136_1.text_.text = var_139_9

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_11 = 16 <= 0 and var_139_7 or var_139_7 * (utf8.len(var_139_9) / 16)

				if (16 <= 0 and var_139_7 or var_139_7 * (utf8.len(var_139_9) / 16)) > 0 and var_139_7 < var_139_11 then
					arg_136_1.talkMaxDuration = var_139_11

					if var_139_11 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_11 + var_139_6
					end
				end

				arg_136_1.text_.text = var_139_9
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171034", "story_v_out_324171.awb") ~= 0 then
					local var_139_12 = manager.audio:GetVoiceLength("story_v_out_324171", "324171034", "story_v_out_324171.awb") / 1000

					if var_139_12 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_12 + var_139_6
					end

					if var_139_8.prefab_name ~= "" and arg_136_1.actors_[var_139_8.prefab_name] ~= nil then
						local var_139_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_8.prefab_name].transform, "story_v_out_324171", "324171034", "story_v_out_324171.awb")

						arg_136_1:RecordAudio("324171034", var_139_13)
						arg_136_1:RecordAudio("324171034", var_139_13)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_324171", "324171034", "story_v_out_324171.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_324171", "324171034", "story_v_out_324171.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_14 = math.max(var_139_7, arg_136_1.talkMaxDuration)

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_14 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_6) / var_139_14

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_6 + var_139_14 and arg_136_1.time_ < var_139_6 + var_139_14 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play324171035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 324171035
		arg_140_1.duration_ = 4.53

		local var_140_0 = {
			zh = 2.7,
			ja = 4.533
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play324171036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1170ui_story = arg_140_1.actors_["1170ui_story"].transform.localPosition

				local var_143_0 = GameObjectTools.GetOrAddComponent(arg_140_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_143_0 then
					var_143_0:EnableDynamicBone(false)
				end
			end

			local var_143_1 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_1 then
				arg_140_1.actors_["1170ui_story"].transform.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1170ui_story, Vector3.New(-0.68, -0.95, -6.08), (arg_140_1.time_ - 0) / var_143_1)
				arg_140_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1170ui_story"].transform.position).z)
				arg_140_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1170ui_story"].transform.localEulerAngles = arg_140_1.actors_["1170ui_story"].transform.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_1 and arg_140_1.time_ < 0 + var_143_1 + arg_143_0 then
				arg_140_1.actors_["1170ui_story"].transform.localPosition = Vector3.New(-0.68, -0.95, -6.08)
				arg_140_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1170ui_story"].transform.position).z)
				arg_140_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1170ui_story"].transform.localEulerAngles = arg_140_1.actors_["1170ui_story"].transform.localEulerAngles

				local var_143_2 = GameObjectTools.GetOrAddComponent(arg_140_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_143_2 then
					var_143_2:EnableDynamicBone(true)
				end
			end

			local var_143_3 = arg_140_1.actors_["1170ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_3) and arg_140_1.var_.characterEffect1170ui_story == nil then
				arg_140_1.var_.characterEffect1170ui_story = var_143_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_4 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 and not isNil(var_143_3) then
				if arg_140_1.var_.characterEffect1170ui_story and not isNil(var_143_3) then
					arg_140_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 and not isNil(var_143_3) and arg_140_1.var_.characterEffect1170ui_story then
				arg_140_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_143_6 = arg_140_1.actors_["1053ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_6) and arg_140_1.var_.characterEffect1053ui_story == nil then
				arg_140_1.var_.characterEffect1053ui_story = var_143_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_7 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_7 and not isNil(var_143_6) then
				if arg_140_1.var_.characterEffect1053ui_story and not isNil(var_143_6) then
					arg_140_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_7)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_7 and arg_140_1.time_ < 0 + var_143_7 + arg_143_0 and not isNil(var_143_6) and arg_140_1.var_.characterEffect1053ui_story then
				arg_140_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action4_1")
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_143_8 = 0
			local var_143_9 = 0.275

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_8 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_10 = arg_140_1:GetWordFromCfg(324171035)
				local var_143_11 = arg_140_1:FormatText(var_143_10.content)

				arg_140_1.text_.text = var_143_11

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_13 = 11 <= 0 and var_143_9 or var_143_9 * (utf8.len(var_143_11) / 11)

				if (11 <= 0 and var_143_9 or var_143_9 * (utf8.len(var_143_11) / 11)) > 0 and var_143_9 < var_143_13 then
					arg_140_1.talkMaxDuration = var_143_13

					if var_143_13 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_8
					end
				end

				arg_140_1.text_.text = var_143_11
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171035", "story_v_out_324171.awb") ~= 0 then
					local var_143_14 = manager.audio:GetVoiceLength("story_v_out_324171", "324171035", "story_v_out_324171.awb") / 1000

					if var_143_14 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_14 + var_143_8
					end

					if var_143_10.prefab_name ~= "" and arg_140_1.actors_[var_143_10.prefab_name] ~= nil then
						local var_143_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_10.prefab_name].transform, "story_v_out_324171", "324171035", "story_v_out_324171.awb")

						arg_140_1:RecordAudio("324171035", var_143_15)
						arg_140_1:RecordAudio("324171035", var_143_15)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_324171", "324171035", "story_v_out_324171.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_324171", "324171035", "story_v_out_324171.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_16 = math.max(var_143_9, arg_140_1.talkMaxDuration)

			if var_143_8 <= arg_140_1.time_ and arg_140_1.time_ < var_143_8 + var_143_16 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_8) / var_143_16

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_8 + var_143_16 and arg_140_1.time_ < var_143_8 + var_143_16 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play324171036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 324171036
		arg_144_1.duration_ = 6.3

		local var_144_0 = {
			zh = 5.366,
			ja = 6.3
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
				arg_144_0:Play324171037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.6

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_1 = arg_144_1:GetWordFromCfg(324171036)
				local var_147_2 = arg_144_1:FormatText(var_147_1.content)

				arg_144_1.text_.text = var_147_2

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 24 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 24)

				if (24 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 24)) > 0 and var_147_0 < var_147_4 then
					arg_144_1.talkMaxDuration = var_147_4

					if var_147_4 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_4 + 0
					end
				end

				arg_144_1.text_.text = var_147_2
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171036", "story_v_out_324171.awb") ~= 0 then
					local var_147_5 = manager.audio:GetVoiceLength("story_v_out_324171", "324171036", "story_v_out_324171.awb") / 1000

					if var_147_5 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + 0
					end

					if var_147_1.prefab_name ~= "" and arg_144_1.actors_[var_147_1.prefab_name] ~= nil then
						local var_147_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_1.prefab_name].transform, "story_v_out_324171", "324171036", "story_v_out_324171.awb")

						arg_144_1:RecordAudio("324171036", var_147_6)
						arg_144_1:RecordAudio("324171036", var_147_6)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_324171", "324171036", "story_v_out_324171.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_324171", "324171036", "story_v_out_324171.awb")
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
	Play324171037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 324171037
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play324171038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1170ui_story = arg_148_1.actors_["1170ui_story"].transform.localPosition

				local var_151_0 = GameObjectTools.GetOrAddComponent(arg_148_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_151_0 then
					var_151_0:EnableDynamicBone(false)
				end
			end

			local var_151_1 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_1 then
				arg_148_1.actors_["1170ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1170ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_1)
				arg_148_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1170ui_story"].transform.position).z)
				arg_148_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1170ui_story"].transform.localEulerAngles = arg_148_1.actors_["1170ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_1 and arg_148_1.time_ < 0 + var_151_1 + arg_151_0 then
				arg_148_1.actors_["1170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1170ui_story"].transform.position).z)
				arg_148_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1170ui_story"].transform.localEulerAngles = arg_148_1.actors_["1170ui_story"].transform.localEulerAngles

				local var_151_2 = GameObjectTools.GetOrAddComponent(arg_148_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_151_2 then
					var_151_2:EnableDynamicBone(true)
				end
			end

			local var_151_3 = arg_148_1.actors_["1053ui_story"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1053ui_story = var_151_3.localPosition

				local var_151_4 = GameObjectTools.GetOrAddComponent(var_151_3.gameObject, typeof(DynamicBoneHelper))

				if var_151_4 then
					var_151_4:EnableDynamicBone(false)
				end
			end

			local var_151_5 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_5 then
				var_151_3.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_5)
				var_151_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_3.position).x, (manager.ui.mainCamera.transform.position - var_151_3.position).y, (manager.ui.mainCamera.transform.position - var_151_3.position).z)
				var_151_3.localEulerAngles.z = 0
				var_151_3.localEulerAngles.x = 0
				var_151_3.localEulerAngles = var_151_3.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_5 and arg_148_1.time_ < 0 + var_151_5 + arg_151_0 then
				var_151_3.localPosition = Vector3.New(0, 100, 0)
				var_151_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_3.position).x, (manager.ui.mainCamera.transform.position - var_151_3.position).y, (manager.ui.mainCamera.transform.position - var_151_3.position).z)
				var_151_3.localEulerAngles.z = 0
				var_151_3.localEulerAngles.x = 0
				var_151_3.localEulerAngles = var_151_3.localEulerAngles

				local var_151_6 = GameObjectTools.GetOrAddComponent(var_151_3.gameObject, typeof(DynamicBoneHelper))

				if var_151_6 then
					var_151_6:EnableDynamicBone(true)
				end
			end

			local var_151_7 = arg_148_1.actors_["1170ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_7) and arg_148_1.var_.characterEffect1170ui_story == nil then
				arg_148_1.var_.characterEffect1170ui_story = var_151_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_8 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_8 and not isNil(var_151_7) then
				if arg_148_1.var_.characterEffect1170ui_story and not isNil(var_151_7) then
					arg_148_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_8)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_8 and arg_148_1.time_ < 0 + var_151_8 + arg_151_0 and not isNil(var_151_7) and arg_148_1.var_.characterEffect1170ui_story then
				arg_148_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_151_9 = 0
			local var_151_10 = 1.25

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_9 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_11 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(324171037).content)

				arg_148_1.text_.text = var_151_11

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_13 = 50 <= 0 and var_151_10 or var_151_10 * (utf8.len(var_151_11) / 50)

				if (50 <= 0 and var_151_10 or var_151_10 * (utf8.len(var_151_11) / 50)) > 0 and var_151_10 < var_151_13 then
					arg_148_1.talkMaxDuration = var_151_13

					if var_151_13 + var_151_9 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_13 + var_151_9
					end
				end

				arg_148_1.text_.text = var_151_11
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_14 = math.max(var_151_10, arg_148_1.talkMaxDuration)

			if var_151_9 <= arg_148_1.time_ and arg_148_1.time_ < var_151_9 + var_151_14 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_9) / var_151_14

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_9 + var_151_14 and arg_148_1.time_ < var_151_9 + var_151_14 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play324171038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 324171038
		arg_152_1.duration_ = 4.27

		local var_152_0 = {
			zh = 2.966,
			ja = 4.266
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
				arg_152_0:Play324171039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1053ui_story = arg_152_1.actors_["1053ui_story"].transform.localPosition

				local var_155_0 = GameObjectTools.GetOrAddComponent(arg_152_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_155_0 then
					var_155_0:EnableDynamicBone(false)
				end
			end

			local var_155_1 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_1 then
				arg_152_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_152_1.time_ - 0) / var_155_1)
				arg_152_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1053ui_story"].transform.position).z)
				arg_152_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1053ui_story"].transform.localEulerAngles = arg_152_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_1 and arg_152_1.time_ < 0 + var_155_1 + arg_155_0 then
				arg_152_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_152_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1053ui_story"].transform.position).z)
				arg_152_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1053ui_story"].transform.localEulerAngles = arg_152_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_155_2 = GameObjectTools.GetOrAddComponent(arg_152_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_155_2 then
					var_155_2:EnableDynamicBone(true)
				end
			end

			local var_155_3 = arg_152_1.actors_["1053ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_3) and arg_152_1.var_.characterEffect1053ui_story == nil then
				arg_152_1.var_.characterEffect1053ui_story = var_155_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_4 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_4 and not isNil(var_155_3) then
				if arg_152_1.var_.characterEffect1053ui_story and not isNil(var_155_3) then
					arg_152_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_4 and arg_152_1.time_ < 0 + var_155_4 + arg_155_0 and not isNil(var_155_3) and arg_152_1.var_.characterEffect1053ui_story then
				arg_152_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action4_2")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_155_6 = 0
			local var_155_7 = 0.275

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_6 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_8 = arg_152_1:GetWordFromCfg(324171038)
				local var_155_9 = arg_152_1:FormatText(var_155_8.content)

				arg_152_1.text_.text = var_155_9

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_11 = 11 <= 0 and var_155_7 or var_155_7 * (utf8.len(var_155_9) / 11)

				if (11 <= 0 and var_155_7 or var_155_7 * (utf8.len(var_155_9) / 11)) > 0 and var_155_7 < var_155_11 then
					arg_152_1.talkMaxDuration = var_155_11

					if var_155_11 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_11 + var_155_6
					end
				end

				arg_152_1.text_.text = var_155_9
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171038", "story_v_out_324171.awb") ~= 0 then
					local var_155_12 = manager.audio:GetVoiceLength("story_v_out_324171", "324171038", "story_v_out_324171.awb") / 1000

					if var_155_12 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_12 + var_155_6
					end

					if var_155_8.prefab_name ~= "" and arg_152_1.actors_[var_155_8.prefab_name] ~= nil then
						local var_155_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_8.prefab_name].transform, "story_v_out_324171", "324171038", "story_v_out_324171.awb")

						arg_152_1:RecordAudio("324171038", var_155_13)
						arg_152_1:RecordAudio("324171038", var_155_13)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_324171", "324171038", "story_v_out_324171.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_324171", "324171038", "story_v_out_324171.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_14 = math.max(var_155_7, arg_152_1.talkMaxDuration)

			if var_155_6 <= arg_152_1.time_ and arg_152_1.time_ < var_155_6 + var_155_14 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_6) / var_155_14

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_6 + var_155_14 and arg_152_1.time_ < var_155_6 + var_155_14 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play324171039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 324171039
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play324171040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1053ui_story = arg_156_1.actors_["1053ui_story"].transform.localPosition

				local var_159_0 = GameObjectTools.GetOrAddComponent(arg_156_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_159_0 then
					var_159_0:EnableDynamicBone(false)
				end
			end

			local var_159_1 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_1 then
				arg_156_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_156_1.time_ - 0) / var_159_1)
				arg_156_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1053ui_story"].transform.position).z)
				arg_156_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1053ui_story"].transform.localEulerAngles = arg_156_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_1 and arg_156_1.time_ < 0 + var_159_1 + arg_159_0 then
				arg_156_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1053ui_story"].transform.position).z)
				arg_156_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1053ui_story"].transform.localEulerAngles = arg_156_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_159_2 = GameObjectTools.GetOrAddComponent(arg_156_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_159_2 then
					var_159_2:EnableDynamicBone(true)
				end
			end

			local var_159_3 = arg_156_1.actors_["1053ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_3) and arg_156_1.var_.characterEffect1053ui_story == nil then
				arg_156_1.var_.characterEffect1053ui_story = var_159_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_4 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_4 and not isNil(var_159_3) then
				if arg_156_1.var_.characterEffect1053ui_story and not isNil(var_159_3) then
					arg_156_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_4)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_4 and arg_156_1.time_ < 0 + var_159_4 + arg_159_0 and not isNil(var_159_3) and arg_156_1.var_.characterEffect1053ui_story then
				arg_156_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_159_5 = 0
			local var_159_6 = 1.325

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_7 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(324171039).content)

				arg_156_1.text_.text = var_159_7

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_9 = 53 <= 0 and var_159_6 or var_159_6 * (utf8.len(var_159_7) / 53)

				if (53 <= 0 and var_159_6 or var_159_6 * (utf8.len(var_159_7) / 53)) > 0 and var_159_6 < var_159_9 then
					arg_156_1.talkMaxDuration = var_159_9

					if var_159_9 + var_159_5 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_5
					end
				end

				arg_156_1.text_.text = var_159_7
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_10 = math.max(var_159_6, arg_156_1.talkMaxDuration)

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_10 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_5) / var_159_10

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_5 + var_159_10 and arg_156_1.time_ < var_159_5 + var_159_10 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play324171040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 324171040
		arg_160_1.duration_ = 6.7

		local var_160_0 = {
			zh = 6.6,
			ja = 6.7
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
				arg_160_0:Play324171041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1053ui_story = arg_160_1.actors_["1053ui_story"].transform.localPosition

				local var_163_0 = GameObjectTools.GetOrAddComponent(arg_160_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_163_0 then
					var_163_0:EnableDynamicBone(false)
				end
			end

			local var_163_1 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_1 then
				arg_160_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_160_1.time_ - 0) / var_163_1)
				arg_160_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1053ui_story"].transform.position).z)
				arg_160_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1053ui_story"].transform.localEulerAngles = arg_160_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_1 and arg_160_1.time_ < 0 + var_163_1 + arg_163_0 then
				arg_160_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_160_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1053ui_story"].transform.position).z)
				arg_160_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1053ui_story"].transform.localEulerAngles = arg_160_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_163_2 = GameObjectTools.GetOrAddComponent(arg_160_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_163_2 then
					var_163_2:EnableDynamicBone(true)
				end
			end

			local var_163_3 = arg_160_1.actors_["1053ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_3) and arg_160_1.var_.characterEffect1053ui_story == nil then
				arg_160_1.var_.characterEffect1053ui_story = var_163_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_4 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_4 and not isNil(var_163_3) then
				if arg_160_1.var_.characterEffect1053ui_story and not isNil(var_163_3) then
					arg_160_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_4 and arg_160_1.time_ < 0 + var_163_4 + arg_163_0 and not isNil(var_163_3) and arg_160_1.var_.characterEffect1053ui_story then
				arg_160_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_163_6 = 0
			local var_163_7 = 0.45

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_8 = arg_160_1:GetWordFromCfg(324171040)
				local var_163_9 = arg_160_1:FormatText(var_163_8.content)

				arg_160_1.text_.text = var_163_9

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_11 = 18 <= 0 and var_163_7 or var_163_7 * (utf8.len(var_163_9) / 18)

				if (18 <= 0 and var_163_7 or var_163_7 * (utf8.len(var_163_9) / 18)) > 0 and var_163_7 < var_163_11 then
					arg_160_1.talkMaxDuration = var_163_11

					if var_163_11 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_11 + var_163_6
					end
				end

				arg_160_1.text_.text = var_163_9
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171040", "story_v_out_324171.awb") ~= 0 then
					local var_163_12 = manager.audio:GetVoiceLength("story_v_out_324171", "324171040", "story_v_out_324171.awb") / 1000

					if var_163_12 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_12 + var_163_6
					end

					if var_163_8.prefab_name ~= "" and arg_160_1.actors_[var_163_8.prefab_name] ~= nil then
						local var_163_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_8.prefab_name].transform, "story_v_out_324171", "324171040", "story_v_out_324171.awb")

						arg_160_1:RecordAudio("324171040", var_163_13)
						arg_160_1:RecordAudio("324171040", var_163_13)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_324171", "324171040", "story_v_out_324171.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_324171", "324171040", "story_v_out_324171.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_14 = math.max(var_163_7, arg_160_1.talkMaxDuration)

			if var_163_6 <= arg_160_1.time_ and arg_160_1.time_ < var_163_6 + var_163_14 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_6) / var_163_14

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_6 + var_163_14 and arg_160_1.time_ < var_163_6 + var_163_14 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play324171041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 324171041
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play324171042(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos1053ui_story = arg_164_1.actors_["1053ui_story"].transform.localPosition

				local var_167_0 = GameObjectTools.GetOrAddComponent(arg_164_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_167_0 then
					var_167_0:EnableDynamicBone(false)
				end
			end

			local var_167_1 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_1 then
				arg_164_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_164_1.time_ - 0) / var_167_1)
				arg_164_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1053ui_story"].transform.position).z)
				arg_164_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["1053ui_story"].transform.localEulerAngles = arg_164_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_1 and arg_164_1.time_ < 0 + var_167_1 + arg_167_0 then
				arg_164_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_164_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1053ui_story"].transform.position).z)
				arg_164_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["1053ui_story"].transform.localEulerAngles = arg_164_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_167_2 = GameObjectTools.GetOrAddComponent(arg_164_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_167_2 then
					var_167_2:EnableDynamicBone(true)
				end
			end

			local var_167_3 = arg_164_1.actors_["1053ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_3) and arg_164_1.var_.characterEffect1053ui_story == nil then
				arg_164_1.var_.characterEffect1053ui_story = var_167_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_4 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 and not isNil(var_167_3) then
				if arg_164_1.var_.characterEffect1053ui_story and not isNil(var_167_3) then
					arg_164_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_4)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 and not isNil(var_167_3) and arg_164_1.var_.characterEffect1053ui_story then
				arg_164_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_167_5 = 0
			local var_167_6 = 1.1

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_7 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(324171041).content)

				arg_164_1.text_.text = var_167_7

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_9 = 44 <= 0 and var_167_6 or var_167_6 * (utf8.len(var_167_7) / 44)

				if (44 <= 0 and var_167_6 or var_167_6 * (utf8.len(var_167_7) / 44)) > 0 and var_167_6 < var_167_9 then
					arg_164_1.talkMaxDuration = var_167_9

					if var_167_9 + var_167_5 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_9 + var_167_5
					end
				end

				arg_164_1.text_.text = var_167_7
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_10 = math.max(var_167_6, arg_164_1.talkMaxDuration)

			if var_167_5 <= arg_164_1.time_ and arg_164_1.time_ < var_167_5 + var_167_10 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_5) / var_167_10

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_5 + var_167_10 and arg_164_1.time_ < var_167_5 + var_167_10 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play324171042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 324171042
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play324171043(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_171_1 = 0
			local var_171_2 = 1.5

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_3 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(324171042).content)

				arg_168_1.text_.text = var_171_3

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_5 = 60 <= 0 and var_171_2 or var_171_2 * (utf8.len(var_171_3) / 60)

				if (60 <= 0 and var_171_2 or var_171_2 * (utf8.len(var_171_3) / 60)) > 0 and var_171_2 < var_171_5 then
					arg_168_1.talkMaxDuration = var_171_5

					if var_171_5 + var_171_1 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_5 + var_171_1
					end
				end

				arg_168_1.text_.text = var_171_3
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_6 = math.max(var_171_2, arg_168_1.talkMaxDuration)

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_6 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_1) / var_171_6

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_1 + var_171_6 and arg_168_1.time_ < var_171_1 + var_171_6 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play324171043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 324171043
		arg_172_1.duration_ = 8.83

		local var_172_0 = {
			zh = 6.76633333631356,
			ja = 8.83333333631357
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play324171044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if arg_172_1.bgs_.J13g == nil then
				local var_175_0 = Object.Instantiate(arg_172_1.paintGo_)

				var_175_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J13g")
				var_175_0.name = "J13g"
				var_175_0.transform.parent = arg_172_1.stage_.transform
				var_175_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_172_1.bgs_.J13g = var_175_0
			end

			if 2 < arg_172_1.time_ and arg_172_1.time_ <= 2 + arg_175_0 then
				local var_175_1 = arg_172_1.bgs_.J13g

				arg_172_1.bgs_.J13g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_175_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_175_2 = var_175_1:GetComponent("SpriteRenderer")

				if var_175_2 and var_175_2.sprite then
					local var_175_3 = 2 * (var_175_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_175_1.transform.localScale = Vector3.New(var_175_3 / var_175_2.sprite.bounds.size.y < var_175_3 * manager.ui.mainCameraCom_.aspect / var_175_2.sprite.bounds.size.x and var_175_3 * manager.ui.mainCameraCom_.aspect / var_175_2.sprite.bounds.size.x or var_175_3 / var_175_2.sprite.bounds.size.y, var_175_3 / var_175_2.sprite.bounds.size.y < var_175_3 * manager.ui.mainCameraCom_.aspect / var_175_2.sprite.bounds.size.x and var_175_3 * manager.ui.mainCameraCom_.aspect / var_175_2.sprite.bounds.size.x or var_175_3 / var_175_2.sprite.bounds.size.y, 0)
				end

				for iter_175_0, iter_175_1 in pairs(arg_172_1.bgs_) do
					if iter_175_0 ~= "J13g" then
						iter_175_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_175_4 = 0

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				arg_172_1.allBtn_.enabled = false
			end

			if arg_172_1.time_ >= var_175_4 + 0.3 and arg_172_1.time_ < var_175_4 + 0.3 + arg_175_0 then
				arg_172_1.allBtn_.enabled = true
			end

			local var_175_5 = 0

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_5 + arg_175_0 then
				arg_172_1.mask_.enabled = true
				arg_172_1.mask_.raycastTarget = true

				arg_172_1:SetGaussion(false)
			end

			local var_175_6 = 2

			if var_175_5 <= arg_172_1.time_ and arg_172_1.time_ < var_175_5 + var_175_6 then
				local var_175_7 = Color.New(0, 0, 0)

				var_175_7.a = Mathf.Lerp(0, 1, (arg_172_1.time_ - var_175_5) / var_175_6)
				arg_172_1.mask_.color = var_175_7
			end

			if arg_172_1.time_ >= var_175_5 + var_175_6 and arg_172_1.time_ < var_175_5 + var_175_6 + arg_175_0 then
				local var_175_8 = Color.New(0, 0, 0)

				var_175_8.a = 1
				arg_172_1.mask_.color = var_175_8
			end

			local var_175_9 = 2

			if 2 < arg_172_1.time_ and arg_172_1.time_ <= var_175_9 + arg_175_0 then
				arg_172_1.mask_.enabled = true
				arg_172_1.mask_.raycastTarget = true

				arg_172_1:SetGaussion(false)
			end

			local var_175_10 = 2

			if var_175_9 <= arg_172_1.time_ and arg_172_1.time_ < var_175_9 + var_175_10 then
				local var_175_11 = Color.New(0, 0, 0)

				var_175_11.a = Mathf.Lerp(1, 0, (arg_172_1.time_ - var_175_9) / var_175_10)
				arg_172_1.mask_.color = var_175_11
			end

			if arg_172_1.time_ >= var_175_9 + var_175_10 and arg_172_1.time_ < var_175_9 + var_175_10 + arg_175_0 then
				local var_175_12 = Color.New(0, 0, 0)

				arg_172_1.mask_.enabled = false
				var_175_12.a = 0
				arg_172_1.mask_.color = var_175_12
			end

			local var_175_13 = arg_172_1.actors_["1170ui_story"].transform

			if 3.53333333333333 < arg_172_1.time_ and arg_172_1.time_ <= 3.53333333333333 + arg_175_0 then
				arg_172_1.var_.moveOldPos1170ui_story = var_175_13.localPosition

				local var_175_14 = GameObjectTools.GetOrAddComponent(var_175_13.gameObject, typeof(DynamicBoneHelper))

				if var_175_14 then
					var_175_14:EnableDynamicBone(false)
				end
			end

			local var_175_15 = 0.001

			if 3.53333333333333 <= arg_172_1.time_ and arg_172_1.time_ < 3.53333333333333 + var_175_15 then
				var_175_13.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1170ui_story, Vector3.New(0.03, -0.95, -6.08), (arg_172_1.time_ - 3.53333333333333) / var_175_15)
				var_175_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_13.position).x, (manager.ui.mainCamera.transform.position - var_175_13.position).y, (manager.ui.mainCamera.transform.position - var_175_13.position).z)
				var_175_13.localEulerAngles.z = 0
				var_175_13.localEulerAngles.x = 0
				var_175_13.localEulerAngles = var_175_13.localEulerAngles
			end

			if arg_172_1.time_ >= 3.53333333333333 + var_175_15 and arg_172_1.time_ < 3.53333333333333 + var_175_15 + arg_175_0 then
				var_175_13.localPosition = Vector3.New(0.03, -0.95, -6.08)
				var_175_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_13.position).x, (manager.ui.mainCamera.transform.position - var_175_13.position).y, (manager.ui.mainCamera.transform.position - var_175_13.position).z)
				var_175_13.localEulerAngles.z = 0
				var_175_13.localEulerAngles.x = 0
				var_175_13.localEulerAngles = var_175_13.localEulerAngles

				local var_175_16 = GameObjectTools.GetOrAddComponent(var_175_13.gameObject, typeof(DynamicBoneHelper))

				if var_175_16 then
					var_175_16:EnableDynamicBone(true)
				end
			end

			local var_175_17 = arg_172_1.actors_["1170ui_story"]

			if 3.53333333333333 < arg_172_1.time_ and arg_172_1.time_ <= 3.53333333333333 + arg_175_0 and not isNil(var_175_17) and arg_172_1.var_.characterEffect1170ui_story == nil then
				arg_172_1.var_.characterEffect1170ui_story = var_175_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_18 = 0.200000002980232

			if 3.53333333333333 <= arg_172_1.time_ and arg_172_1.time_ < 3.53333333333333 + var_175_18 and not isNil(var_175_17) then
				if arg_172_1.var_.characterEffect1170ui_story and not isNil(var_175_17) then
					arg_172_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= 3.53333333333333 + var_175_18 and arg_172_1.time_ < 3.53333333333333 + var_175_18 + arg_175_0 and not isNil(var_175_17) and arg_172_1.var_.characterEffect1170ui_story then
				arg_172_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_175_20 = arg_172_1.actors_["1053ui_story"]

			if 3.53333333333333 < arg_172_1.time_ and arg_172_1.time_ <= 3.53333333333333 + arg_175_0 and not isNil(var_175_20) and arg_172_1.var_.characterEffect1053ui_story == nil then
				arg_172_1.var_.characterEffect1053ui_story = var_175_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_21 = 0.200000002980232

			if 3.53333333333333 <= arg_172_1.time_ and arg_172_1.time_ < 3.53333333333333 + var_175_21 and not isNil(var_175_20) then
				if arg_172_1.var_.characterEffect1053ui_story and not isNil(var_175_20) then
					arg_172_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 3.53333333333333) / var_175_21)
				end
			end

			if arg_172_1.time_ >= 3.53333333333333 + var_175_21 and arg_172_1.time_ < 3.53333333333333 + var_175_21 + arg_175_0 and not isNil(var_175_20) and arg_172_1.var_.characterEffect1053ui_story then
				arg_172_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 3.53333333333333 < arg_172_1.time_ and arg_172_1.time_ <= 3.53333333333333 + arg_175_0 then
				arg_172_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action1_1")
			end

			if 3.53333333333333 < arg_172_1.time_ and arg_172_1.time_ <= 3.53333333333333 + arg_175_0 then
				arg_172_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 1.2 < arg_172_1.time_ and arg_172_1.time_ <= 1.2 + arg_175_0 then
				arg_172_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_wind", "")
			end

			if 0.1 < arg_172_1.time_ and arg_172_1.time_ <= 0.1 + arg_175_0 then
				arg_172_1:AudioAction("stop", "effect", "se_story_150", "se_story_150_amb_painting", "")
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:AudioAction("play", "music", "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain.awb")

				local var_175_26 = manager.audio:GetAudioName("bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain")

				if "" ~= "" then
					if arg_172_1.bgmTxt_.text ~= var_175_26 and arg_172_1.bgmTxt_.text ~= "" then
						if arg_172_1.bgmTxt2_.text ~= "" then
							arg_172_1.bgmTxt_.text = arg_172_1.bgmTxt2_.text
						end

						arg_172_1.bgmTxt2_.text = var_175_26

						arg_172_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_172_1.bgmTxt_.text = var_175_26
						arg_172_1.bgmTxt2_.text = var_175_26
					end

					if arg_172_1.bgmTimer then
						arg_172_1.bgmTimer:Stop()

						arg_172_1.bgmTimer = nil
					end

					if arg_172_1.settingData.show_music_name == 1 then
						arg_172_1.musicController:SetSelectedState("show")
						arg_172_1.musicAnimator_:Play("open", 0, 0)

						if arg_172_1.settingData.music_time ~= 0 then
							arg_172_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_172_1.settingData.music_time), function()
								if arg_172_1 == nil or isNil(arg_172_1.bgmTxt_) then
									return
								end

								arg_172_1.musicController:SetSelectedState("hide")
								arg_172_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_172_1.frameCnt_ <= 1 then
				arg_172_1.dialog_:SetActive(false)
			end

			local var_175_27 = 3.83333333631357
			local var_175_28 = 0.325

			if 3.83333333631357 < arg_172_1.time_ and arg_172_1.time_ <= var_175_27 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0

				arg_172_1.dialog_:SetActive(true)

				arg_172_1.dialogCg_.alpha = 0

				local var_175_29 = LeanTween.value(arg_172_1.dialog_, 0, 1, 0.3)

				var_175_29:setOnUpdate(LuaHelper.FloatAction(function(arg_177_0)
					arg_172_1.dialogCg_.alpha = arg_177_0
				end))
				var_175_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_172_1.dialog_)
					var_175_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_172_1.duration_ = arg_172_1.duration_ + 0.3

				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_30 = arg_172_1:GetWordFromCfg(324171043)
				local var_175_31 = arg_172_1:FormatText(var_175_30.content)

				arg_172_1.text_.text = var_175_31

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_33 = 13 <= 0 and var_175_28 or var_175_28 * (utf8.len(var_175_31) / 13)

				if (13 <= 0 and var_175_28 or var_175_28 * (utf8.len(var_175_31) / 13)) > 0 and var_175_28 < var_175_33 then
					arg_172_1.talkMaxDuration = var_175_33
					var_175_27 = var_175_27 + 0.3

					if var_175_33 + var_175_27 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_33 + var_175_27
					end
				end

				arg_172_1.text_.text = var_175_31
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171043", "story_v_out_324171.awb") ~= 0 then
					local var_175_34 = manager.audio:GetVoiceLength("story_v_out_324171", "324171043", "story_v_out_324171.awb") / 1000

					if var_175_34 + var_175_27 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_34 + var_175_27
					end

					if var_175_30.prefab_name ~= "" and arg_172_1.actors_[var_175_30.prefab_name] ~= nil then
						local var_175_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_30.prefab_name].transform, "story_v_out_324171", "324171043", "story_v_out_324171.awb")

						arg_172_1:RecordAudio("324171043", var_175_35)
						arg_172_1:RecordAudio("324171043", var_175_35)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_324171", "324171043", "story_v_out_324171.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_324171", "324171043", "story_v_out_324171.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_36 = var_175_27 + 0.3
			local var_175_37 = math.max(var_175_28, arg_172_1.talkMaxDuration)

			if var_175_27 + 0.3 <= arg_172_1.time_ and arg_172_1.time_ < var_175_36 + var_175_37 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_36) / var_175_37

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_36 + var_175_37 and arg_172_1.time_ < var_175_36 + var_175_37 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.53333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play324171044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 324171044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play324171045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1170ui_story = arg_179_1.actors_["1170ui_story"].transform.localPosition

				local var_182_0 = GameObjectTools.GetOrAddComponent(arg_179_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_182_0 then
					var_182_0:EnableDynamicBone(false)
				end
			end

			local var_182_1 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_1 then
				arg_179_1.actors_["1170ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1170ui_story, Vector3.New(0, 100, 0), (arg_179_1.time_ - 0) / var_182_1)
				arg_179_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1170ui_story"].transform.position).z)
				arg_179_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1170ui_story"].transform.localEulerAngles = arg_179_1.actors_["1170ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_1 and arg_179_1.time_ < 0 + var_182_1 + arg_182_0 then
				arg_179_1.actors_["1170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_179_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1170ui_story"].transform.position).z)
				arg_179_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1170ui_story"].transform.localEulerAngles = arg_179_1.actors_["1170ui_story"].transform.localEulerAngles

				local var_182_2 = GameObjectTools.GetOrAddComponent(arg_179_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_182_2 then
					var_182_2:EnableDynamicBone(true)
				end
			end

			local var_182_3 = arg_179_1.actors_["1170ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_3) and arg_179_1.var_.characterEffect1170ui_story == nil then
				arg_179_1.var_.characterEffect1170ui_story = var_182_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_4 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 and not isNil(var_182_3) then
				if arg_179_1.var_.characterEffect1170ui_story and not isNil(var_182_3) then
					arg_179_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_4)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 and not isNil(var_182_3) and arg_179_1.var_.characterEffect1170ui_story then
				arg_179_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_182_5 = 0
			local var_182_6 = 0.55

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_7 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(324171044).content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 22 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_7) / 22)

				if (22 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_7) / 22)) > 0 and var_182_6 < var_182_9 then
					arg_179_1.talkMaxDuration = var_182_9

					if var_182_9 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_5
					end
				end

				arg_179_1.text_.text = var_182_7
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_6, arg_179_1.talkMaxDuration)

			if var_182_5 <= arg_179_1.time_ and arg_179_1.time_ < var_182_5 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_5) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_5 + var_182_10 and arg_179_1.time_ < var_182_5 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play324171045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 324171045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play324171046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0.1 < arg_183_1.time_ and arg_183_1.time_ <= 0.1 + arg_186_0 then
				arg_183_1:AudioAction("play", "effect", "se_story_150", "se_story_150_sword08", "")
			end

			local var_186_1 = 0
			local var_186_2 = 1.15

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_3 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(324171045).content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 46 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 46)

				if (46 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 46)) > 0 and var_186_2 < var_186_5 then
					arg_183_1.talkMaxDuration = var_186_5

					if var_186_5 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + var_186_1
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_6 = math.max(var_186_2, arg_183_1.talkMaxDuration)

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_6 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_1) / var_186_6

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_1 + var_186_6 and arg_183_1.time_ < var_186_1 + var_186_6 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play324171046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 324171046
		arg_187_1.duration_ = 5.5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play324171047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				local var_190_0 = arg_187_1.var_.effect43434

				if not arg_187_1.var_.effect43434 then
					var_190_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu2"), manager.ui.mainCamera.transform)
					var_190_0.name = "43434"
					arg_187_1.var_.effect43434 = var_190_0
				else
					var_190_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_190_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_190_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.43333333333333 < arg_187_1.time_ and arg_187_1.time_ <= 1.43333333333333 + arg_190_0 then
				if arg_187_1.var_.effect43434 then
					Object.Destroy(arg_187_1.var_.effect43434)

					arg_187_1.var_.effect43434 = nil
				end
			end

			if 0.5 < arg_187_1.time_ and arg_187_1.time_ <= 0.5 + arg_190_0 then
				arg_187_1:AudioAction("play", "effect", "se_story_148", "se_story_148_whoosh03", "")
			end

			if arg_187_1.frameCnt_ <= 1 then
				arg_187_1.dialog_:SetActive(false)
			end

			local var_190_4 = 0.5
			local var_190_5 = 0.85

			if 0.5 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0

				arg_187_1.dialog_:SetActive(true)

				arg_187_1.dialogCg_.alpha = 0

				local var_190_6 = LeanTween.value(arg_187_1.dialog_, 0, 1, 0.3)

				var_190_6:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_187_1.dialogCg_.alpha = arg_191_0
				end))
				var_190_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_187_1.dialog_)
					var_190_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_187_1.duration_ = arg_187_1.duration_ + 0.3

				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_7 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(324171046).content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 34 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 34)

				if (34 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 34)) > 0 and var_190_5 < var_190_9 then
					arg_187_1.talkMaxDuration = var_190_9
					var_190_4 = var_190_4 + 0.3

					if var_190_9 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = var_190_4 + 0.3
			local var_190_11 = math.max(var_190_5, arg_187_1.talkMaxDuration)

			if var_190_4 + 0.3 <= arg_187_1.time_ and arg_187_1.time_ < var_190_10 + var_190_11 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_10) / var_190_11

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_10 + var_190_11 and arg_187_1.time_ < var_190_10 + var_190_11 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play324171047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 324171047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play324171048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.875

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(324171047).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 35 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 35)

				if (35 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 35)) > 0 and var_196_0 < var_196_3 then
					arg_193_1.talkMaxDuration = var_196_3

					if var_196_3 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_3 + 0
					end
				end

				arg_193_1.text_.text = var_196_1
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_4 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_4

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play324171048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 324171048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play324171049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0.1 < arg_197_1.time_ and arg_197_1.time_ <= 0.1 + arg_200_0 then
				arg_197_1:AudioAction("play", "effect", "se_story_148", "se_story_148_whoosh03", "")
			end

			local var_200_1 = 0
			local var_200_2 = 0.9

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_3 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(324171048).content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 36 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 36)

				if (36 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 36)) > 0 and var_200_2 < var_200_5 then
					arg_197_1.talkMaxDuration = var_200_5

					if var_200_5 + var_200_1 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + var_200_1
					end
				end

				arg_197_1.text_.text = var_200_3
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_6 = math.max(var_200_2, arg_197_1.talkMaxDuration)

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_6 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_1) / var_200_6

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_1 + var_200_6 and arg_197_1.time_ < var_200_1 + var_200_6 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play324171049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 324171049
		arg_201_1.duration_ = 2

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play324171050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1053ui_story = arg_201_1.actors_["1053ui_story"].transform.localPosition

				local var_204_0 = GameObjectTools.GetOrAddComponent(arg_201_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_204_0 then
					var_204_0:EnableDynamicBone(false)
				end
			end

			local var_204_1 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_1 then
				arg_201_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_201_1.time_ - 0) / var_204_1)
				arg_201_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1053ui_story"].transform.position).z)
				arg_201_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1053ui_story"].transform.localEulerAngles = arg_201_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_1 and arg_201_1.time_ < 0 + var_204_1 + arg_204_0 then
				arg_201_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_201_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1053ui_story"].transform.position).z)
				arg_201_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1053ui_story"].transform.localEulerAngles = arg_201_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_204_2 = GameObjectTools.GetOrAddComponent(arg_201_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_204_2 then
					var_204_2:EnableDynamicBone(true)
				end
			end

			local var_204_3 = arg_201_1.actors_["1053ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_3) and arg_201_1.var_.characterEffect1053ui_story == nil then
				arg_201_1.var_.characterEffect1053ui_story = var_204_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_4 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 and not isNil(var_204_3) then
				if arg_201_1.var_.characterEffect1053ui_story and not isNil(var_204_3) then
					arg_201_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 and not isNil(var_204_3) and arg_201_1.var_.characterEffect1053ui_story then
				arg_201_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action6_1")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_204_6 = 0
			local var_204_7 = 0.15

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_8 = arg_201_1:GetWordFromCfg(324171049)
				local var_204_9 = arg_201_1:FormatText(var_204_8.content)

				arg_201_1.text_.text = var_204_9

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_11 = 6 <= 0 and var_204_7 or var_204_7 * (utf8.len(var_204_9) / 6)

				if (6 <= 0 and var_204_7 or var_204_7 * (utf8.len(var_204_9) / 6)) > 0 and var_204_7 < var_204_11 then
					arg_201_1.talkMaxDuration = var_204_11

					if var_204_11 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_11 + var_204_6
					end
				end

				arg_201_1.text_.text = var_204_9
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171049", "story_v_out_324171.awb") ~= 0 then
					local var_204_12 = manager.audio:GetVoiceLength("story_v_out_324171", "324171049", "story_v_out_324171.awb") / 1000

					if var_204_12 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_12 + var_204_6
					end

					if var_204_8.prefab_name ~= "" and arg_201_1.actors_[var_204_8.prefab_name] ~= nil then
						local var_204_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_8.prefab_name].transform, "story_v_out_324171", "324171049", "story_v_out_324171.awb")

						arg_201_1:RecordAudio("324171049", var_204_13)
						arg_201_1:RecordAudio("324171049", var_204_13)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_324171", "324171049", "story_v_out_324171.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_324171", "324171049", "story_v_out_324171.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_14 = math.max(var_204_7, arg_201_1.talkMaxDuration)

			if var_204_6 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_14 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_6) / var_204_14

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_6 + var_204_14 and arg_201_1.time_ < var_204_6 + var_204_14 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play324171050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 324171050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play324171051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1053ui_story"]) and arg_205_1.var_.characterEffect1053ui_story == nil then
				arg_205_1.var_.characterEffect1053ui_story = arg_205_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1053ui_story"]) then
				if arg_205_1.var_.characterEffect1053ui_story and not isNil(arg_205_1.actors_["1053ui_story"]) then
					arg_205_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_0)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1053ui_story"]) and arg_205_1.var_.characterEffect1053ui_story then
				arg_205_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_208_1 = arg_205_1.actors_["1053ui_story"].transform

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1053ui_story = var_208_1.localPosition

				local var_208_2 = GameObjectTools.GetOrAddComponent(var_208_1.gameObject, typeof(DynamicBoneHelper))

				if var_208_2 then
					var_208_2:EnableDynamicBone(false)
				end
			end

			local var_208_3 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_3 then
				var_208_1.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_205_1.time_ - 0) / var_208_3)
				var_208_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_1.position).x, (manager.ui.mainCamera.transform.position - var_208_1.position).y, (manager.ui.mainCamera.transform.position - var_208_1.position).z)
				var_208_1.localEulerAngles.z = 0
				var_208_1.localEulerAngles.x = 0
				var_208_1.localEulerAngles = var_208_1.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 then
				var_208_1.localPosition = Vector3.New(0, 100, 0)
				var_208_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_1.position).x, (manager.ui.mainCamera.transform.position - var_208_1.position).y, (manager.ui.mainCamera.transform.position - var_208_1.position).z)
				var_208_1.localEulerAngles.z = 0
				var_208_1.localEulerAngles.x = 0
				var_208_1.localEulerAngles = var_208_1.localEulerAngles

				local var_208_4 = GameObjectTools.GetOrAddComponent(var_208_1.gameObject, typeof(DynamicBoneHelper))

				if var_208_4 then
					var_208_4:EnableDynamicBone(true)
				end
			end

			local var_208_5 = 0
			local var_208_6 = 0.825

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_7 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(324171050).content)

				arg_205_1.text_.text = var_208_7

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_9 = 33 <= 0 and var_208_6 or var_208_6 * (utf8.len(var_208_7) / 33)

				if (33 <= 0 and var_208_6 or var_208_6 * (utf8.len(var_208_7) / 33)) > 0 and var_208_6 < var_208_9 then
					arg_205_1.talkMaxDuration = var_208_9

					if var_208_9 + var_208_5 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_9 + var_208_5
					end
				end

				arg_205_1.text_.text = var_208_7
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_6, arg_205_1.talkMaxDuration)

			if var_208_5 <= arg_205_1.time_ and arg_205_1.time_ < var_208_5 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_5) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_5 + var_208_10 and arg_205_1.time_ < var_208_5 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play324171051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 324171051
		arg_209_1.duration_ = 4.2

		local var_209_0 = {
			zh = 1.7,
			ja = 4.2
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play324171052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1053ui_story"]) and arg_209_1.var_.characterEffect1053ui_story == nil then
				arg_209_1.var_.characterEffect1053ui_story = arg_209_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1053ui_story"]) then
				if arg_209_1.var_.characterEffect1053ui_story and not isNil(arg_209_1.actors_["1053ui_story"]) then
					arg_209_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1053ui_story"]) and arg_209_1.var_.characterEffect1053ui_story then
				arg_209_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_212_2 = 0
			local var_212_3 = 0.15

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_2 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1053")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_4 = arg_209_1:GetWordFromCfg(324171051)
				local var_212_5 = arg_209_1:FormatText(var_212_4.content)

				arg_209_1.text_.text = var_212_5

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_7 = 6 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_5) / 6)

				if (6 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_5) / 6)) > 0 and var_212_3 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_2
					end
				end

				arg_209_1.text_.text = var_212_5
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171051", "story_v_out_324171.awb") ~= 0 then
					local var_212_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171051", "story_v_out_324171.awb") / 1000

					if var_212_8 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_2
					end

					if var_212_4.prefab_name ~= "" and arg_209_1.actors_[var_212_4.prefab_name] ~= nil then
						local var_212_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_4.prefab_name].transform, "story_v_out_324171", "324171051", "story_v_out_324171.awb")

						arg_209_1:RecordAudio("324171051", var_212_9)
						arg_209_1:RecordAudio("324171051", var_212_9)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_324171", "324171051", "story_v_out_324171.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_324171", "324171051", "story_v_out_324171.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_10 = math.max(var_212_3, arg_209_1.talkMaxDuration)

			if var_212_2 <= arg_209_1.time_ and arg_209_1.time_ < var_212_2 + var_212_10 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_2) / var_212_10

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_2 + var_212_10 and arg_209_1.time_ < var_212_2 + var_212_10 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play324171052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 324171052
		arg_213_1.duration_ = 6.85

		local var_213_0 = {
			zh = 6.01666666666667,
			ja = 6.84966666666667
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
				arg_213_0:Play324171053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if arg_213_1.bgs_.ST2009 == nil then
				local var_216_0 = Object.Instantiate(arg_213_1.paintGo_)

				var_216_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2009")
				var_216_0.name = "ST2009"
				var_216_0.transform.parent = arg_213_1.stage_.transform
				var_216_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.bgs_.ST2009 = var_216_0
			end

			if 1.46666666666667 < arg_213_1.time_ and arg_213_1.time_ <= 1.46666666666667 + arg_216_0 then
				local var_216_1 = arg_213_1.bgs_.ST2009

				arg_213_1.bgs_.ST2009.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_216_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_216_2 = var_216_1:GetComponent("SpriteRenderer")

				if var_216_2 and var_216_2.sprite then
					local var_216_3 = 2 * (var_216_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_216_1.transform.localScale = Vector3.New(var_216_3 / var_216_2.sprite.bounds.size.y < var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x and var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x or var_216_3 / var_216_2.sprite.bounds.size.y, var_216_3 / var_216_2.sprite.bounds.size.y < var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x and var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x or var_216_3 / var_216_2.sprite.bounds.size.y, 0)
				end

				for iter_216_0, iter_216_1 in pairs(arg_213_1.bgs_) do
					if iter_216_0 ~= "ST2009" then
						iter_216_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_216_4 = 1.46666666666667

			if 1.46666666666667 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.allBtn_.enabled = false
			end

			if arg_213_1.time_ >= var_216_4 + 0.3 and arg_213_1.time_ < var_216_4 + 0.3 + arg_216_0 then
				arg_213_1.allBtn_.enabled = true
			end

			local var_216_5 = 0

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_6 = 1.46666666666667

			if var_216_5 <= arg_213_1.time_ and arg_213_1.time_ < var_216_5 + var_216_6 then
				local var_216_7 = Color.New(0, 0, 0)

				var_216_7.a = Mathf.Lerp(0, 1, (arg_213_1.time_ - var_216_5) / var_216_6)
				arg_213_1.mask_.color = var_216_7
			end

			if arg_213_1.time_ >= var_216_5 + var_216_6 and arg_213_1.time_ < var_216_5 + var_216_6 + arg_216_0 then
				local var_216_8 = Color.New(0, 0, 0)

				var_216_8.a = 1
				arg_213_1.mask_.color = var_216_8
			end

			local var_216_9 = 1.46666666666667

			if 1.46666666666667 < arg_213_1.time_ and arg_213_1.time_ <= var_216_9 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_10 = 2

			if var_216_9 <= arg_213_1.time_ and arg_213_1.time_ < var_216_9 + var_216_10 then
				local var_216_11 = Color.New(0, 0, 0)

				var_216_11.a = Mathf.Lerp(1, 0, (arg_213_1.time_ - var_216_9) / var_216_10)
				arg_213_1.mask_.color = var_216_11
			end

			if arg_213_1.time_ >= var_216_9 + var_216_10 and arg_213_1.time_ < var_216_9 + var_216_10 + arg_216_0 then
				local var_216_12 = Color.New(0, 0, 0)

				arg_213_1.mask_.enabled = false
				var_216_12.a = 0
				arg_213_1.mask_.color = var_216_12
			end

			local var_216_13 = arg_213_1.actors_["1053ui_story"].transform

			if 1.46666666666667 < arg_213_1.time_ and arg_213_1.time_ <= 1.46666666666667 + arg_216_0 then
				arg_213_1.var_.moveOldPos1053ui_story = var_216_13.localPosition

				local var_216_14 = GameObjectTools.GetOrAddComponent(var_216_13.gameObject, typeof(DynamicBoneHelper))

				if var_216_14 then
					var_216_14:EnableDynamicBone(false)
				end
			end

			local var_216_15 = 0.001

			if 1.46666666666667 <= arg_213_1.time_ and arg_213_1.time_ < 1.46666666666667 + var_216_15 then
				var_216_13.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_213_1.time_ - 1.46666666666667) / var_216_15)
				var_216_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_13.position).x, (manager.ui.mainCamera.transform.position - var_216_13.position).y, (manager.ui.mainCamera.transform.position - var_216_13.position).z)
				var_216_13.localEulerAngles.z = 0
				var_216_13.localEulerAngles.x = 0
				var_216_13.localEulerAngles = var_216_13.localEulerAngles
			end

			if arg_213_1.time_ >= 1.46666666666667 + var_216_15 and arg_213_1.time_ < 1.46666666666667 + var_216_15 + arg_216_0 then
				var_216_13.localPosition = Vector3.New(0, 100, 0)
				var_216_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_13.position).x, (manager.ui.mainCamera.transform.position - var_216_13.position).y, (manager.ui.mainCamera.transform.position - var_216_13.position).z)
				var_216_13.localEulerAngles.z = 0
				var_216_13.localEulerAngles.x = 0
				var_216_13.localEulerAngles = var_216_13.localEulerAngles

				local var_216_16 = GameObjectTools.GetOrAddComponent(var_216_13.gameObject, typeof(DynamicBoneHelper))

				if var_216_16 then
					var_216_16:EnableDynamicBone(true)
				end
			end

			local var_216_17 = arg_213_1.actors_["1053ui_story"]

			if 1.46666666666667 < arg_213_1.time_ and arg_213_1.time_ <= 1.46666666666667 + arg_216_0 and not isNil(var_216_17) and arg_213_1.var_.characterEffect1053ui_story == nil then
				arg_213_1.var_.characterEffect1053ui_story = var_216_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_18 = 0.200000002980232

			if 1.46666666666667 <= arg_213_1.time_ and arg_213_1.time_ < 1.46666666666667 + var_216_18 and not isNil(var_216_17) then
				if arg_213_1.var_.characterEffect1053ui_story and not isNil(var_216_17) then
					arg_213_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 1.46666666666667) / var_216_18)
				end
			end

			if arg_213_1.time_ >= 1.46666666666667 + var_216_18 and arg_213_1.time_ < 1.46666666666667 + var_216_18 + arg_216_0 and not isNil(var_216_17) and arg_213_1.var_.characterEffect1053ui_story then
				arg_213_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 1.46666666666667 < arg_213_1.time_ and arg_213_1.time_ <= 1.46666666666667 + arg_216_0 then
				if arg_213_1.var_.effect43434 then
					Object.Destroy(arg_213_1.var_.effect43434)

					arg_213_1.var_.effect43434 = nil
				end
			end

			if 1.2 < arg_213_1.time_ and arg_213_1.time_ <= 1.2 + arg_216_0 then
				arg_213_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_bar", "")
			end

			if 0.1 < arg_213_1.time_ and arg_213_1.time_ <= 0.1 + arg_216_0 then
				arg_213_1:AudioAction("stop", "effect", "se_story_1311", "se_story_1311_wind", "")
			end

			if arg_213_1.frameCnt_ <= 1 then
				arg_213_1.dialog_:SetActive(false)
			end

			local var_216_22 = 3.21666666666667
			local var_216_23 = 0.25

			if 3.21666666666667 < arg_213_1.time_ and arg_213_1.time_ <= var_216_22 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0

				arg_213_1.dialog_:SetActive(true)

				arg_213_1.dialogCg_.alpha = 0

				local var_216_24 = LeanTween.value(arg_213_1.dialog_, 0, 1, 0.3)

				var_216_24:setOnUpdate(LuaHelper.FloatAction(function(arg_217_0)
					arg_213_1.dialogCg_.alpha = arg_217_0
				end))
				var_216_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_213_1.dialog_)
					var_216_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_213_1.duration_ = arg_213_1.duration_ + 0.3

				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1502].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_25 = arg_213_1:GetWordFromCfg(324171052)
				local var_216_26 = arg_213_1:FormatText(var_216_25.content)

				arg_213_1.text_.text = var_216_26

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_28 = 10 <= 0 and var_216_23 or var_216_23 * (utf8.len(var_216_26) / 10)

				if (10 <= 0 and var_216_23 or var_216_23 * (utf8.len(var_216_26) / 10)) > 0 and var_216_23 < var_216_28 then
					arg_213_1.talkMaxDuration = var_216_28
					var_216_22 = var_216_22 + 0.3

					if var_216_28 + var_216_22 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_28 + var_216_22
					end
				end

				arg_213_1.text_.text = var_216_26
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171052", "story_v_out_324171.awb") ~= 0 then
					local var_216_29 = manager.audio:GetVoiceLength("story_v_out_324171", "324171052", "story_v_out_324171.awb") / 1000

					if var_216_29 + var_216_22 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_29 + var_216_22
					end

					if var_216_25.prefab_name ~= "" and arg_213_1.actors_[var_216_25.prefab_name] ~= nil then
						local var_216_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_25.prefab_name].transform, "story_v_out_324171", "324171052", "story_v_out_324171.awb")

						arg_213_1:RecordAudio("324171052", var_216_30)
						arg_213_1:RecordAudio("324171052", var_216_30)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_324171", "324171052", "story_v_out_324171.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_324171", "324171052", "story_v_out_324171.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_31 = var_216_22 + 0.3
			local var_216_32 = math.max(var_216_23, arg_213_1.talkMaxDuration)

			if var_216_22 + 0.3 <= arg_213_1.time_ and arg_213_1.time_ < var_216_31 + var_216_32 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_31) / var_216_32

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_31 + var_216_32 and arg_213_1.time_ < var_216_31 + var_216_32 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.46666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play324171053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 324171053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play324171054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 1.125

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_1 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(324171053).content)

				arg_219_1.text_.text = var_222_1

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_3 = 45 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 45)

				if (45 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 45)) > 0 and var_222_0 < var_222_3 then
					arg_219_1.talkMaxDuration = var_222_3

					if var_222_3 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_3 + 0
					end
				end

				arg_219_1.text_.text = var_222_1
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_4 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_4

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play324171054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 324171054
		arg_223_1.duration_ = 2.83

		local var_223_0 = {
			zh = 1.933,
			ja = 2.833
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play324171055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.2

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1497].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_1 = arg_223_1:GetWordFromCfg(324171054)
				local var_226_2 = arg_223_1:FormatText(var_226_1.content)

				arg_223_1.text_.text = var_226_2

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 8 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 8)

				if (8 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 8)) > 0 and var_226_0 < var_226_4 then
					arg_223_1.talkMaxDuration = var_226_4

					if var_226_4 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_4 + 0
					end
				end

				arg_223_1.text_.text = var_226_2
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171054", "story_v_out_324171.awb") ~= 0 then
					local var_226_5 = manager.audio:GetVoiceLength("story_v_out_324171", "324171054", "story_v_out_324171.awb") / 1000

					if var_226_5 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + 0
					end

					if var_226_1.prefab_name ~= "" and arg_223_1.actors_[var_226_1.prefab_name] ~= nil then
						local var_226_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_1.prefab_name].transform, "story_v_out_324171", "324171054", "story_v_out_324171.awb")

						arg_223_1:RecordAudio("324171054", var_226_6)
						arg_223_1:RecordAudio("324171054", var_226_6)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_324171", "324171054", "story_v_out_324171.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_324171", "324171054", "story_v_out_324171.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_7 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_7 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_7

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_7 and arg_223_1.time_ < 0 + var_226_7 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play324171055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 324171055
		arg_227_1.duration_ = 6.37

		local var_227_0 = {
			zh = 4.9,
			ja = 6.366
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play324171056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.55

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[1502].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_1 = arg_227_1:GetWordFromCfg(324171055)
				local var_230_2 = arg_227_1:FormatText(var_230_1.content)

				arg_227_1.text_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 22 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 22)

				if (22 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 22)) > 0 and var_230_0 < var_230_4 then
					arg_227_1.talkMaxDuration = var_230_4

					if var_230_4 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_4 + 0
					end
				end

				arg_227_1.text_.text = var_230_2
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171055", "story_v_out_324171.awb") ~= 0 then
					local var_230_5 = manager.audio:GetVoiceLength("story_v_out_324171", "324171055", "story_v_out_324171.awb") / 1000

					if var_230_5 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + 0
					end

					if var_230_1.prefab_name ~= "" and arg_227_1.actors_[var_230_1.prefab_name] ~= nil then
						local var_230_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_1.prefab_name].transform, "story_v_out_324171", "324171055", "story_v_out_324171.awb")

						arg_227_1:RecordAudio("324171055", var_230_6)
						arg_227_1:RecordAudio("324171055", var_230_6)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_324171", "324171055", "story_v_out_324171.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_324171", "324171055", "story_v_out_324171.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play324171056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 324171056
		arg_231_1.duration_ = 8.43

		local var_231_0 = {
			zh = 7.333,
			ja = 8.433
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play324171057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.75

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[1497].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_1 = arg_231_1:GetWordFromCfg(324171056)
				local var_234_2 = arg_231_1:FormatText(var_234_1.content)

				arg_231_1.text_.text = var_234_2

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_4 = 30 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 30)

				if (30 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 30)) > 0 and var_234_0 < var_234_4 then
					arg_231_1.talkMaxDuration = var_234_4

					if var_234_4 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_4 + 0
					end
				end

				arg_231_1.text_.text = var_234_2
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171056", "story_v_out_324171.awb") ~= 0 then
					local var_234_5 = manager.audio:GetVoiceLength("story_v_out_324171", "324171056", "story_v_out_324171.awb") / 1000

					if var_234_5 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + 0
					end

					if var_234_1.prefab_name ~= "" and arg_231_1.actors_[var_234_1.prefab_name] ~= nil then
						local var_234_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_1.prefab_name].transform, "story_v_out_324171", "324171056", "story_v_out_324171.awb")

						arg_231_1:RecordAudio("324171056", var_234_6)
						arg_231_1:RecordAudio("324171056", var_234_6)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_324171", "324171056", "story_v_out_324171.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_324171", "324171056", "story_v_out_324171.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_7 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_7 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_7

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_7 and arg_231_1.time_ < 0 + var_234_7 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play324171057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 324171057
		arg_235_1.duration_ = 7.3

		local var_235_0 = {
			zh = 6.233333333332,
			ja = 7.299333333332
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play324171058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if arg_235_1.bgs_.MS2409 == nil then
				local var_238_0 = Object.Instantiate(arg_235_1.paintGo_)

				var_238_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2409")
				var_238_0.name = "MS2409"
				var_238_0.transform.parent = arg_235_1.stage_.transform
				var_238_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_235_1.bgs_.MS2409 = var_238_0
			end

			if 1.13333333333333 < arg_235_1.time_ and arg_235_1.time_ <= 1.13333333333333 + arg_238_0 then
				local var_238_1 = arg_235_1.bgs_.MS2409

				arg_235_1.bgs_.MS2409.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_238_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_238_2 = var_238_1:GetComponent("SpriteRenderer")

				if var_238_2 and var_238_2.sprite then
					local var_238_3 = 2 * (var_238_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_238_1.transform.localScale = Vector3.New(var_238_3 / var_238_2.sprite.bounds.size.y < var_238_3 * manager.ui.mainCameraCom_.aspect / var_238_2.sprite.bounds.size.x and var_238_3 * manager.ui.mainCameraCom_.aspect / var_238_2.sprite.bounds.size.x or var_238_3 / var_238_2.sprite.bounds.size.y, var_238_3 / var_238_2.sprite.bounds.size.y < var_238_3 * manager.ui.mainCameraCom_.aspect / var_238_2.sprite.bounds.size.x and var_238_3 * manager.ui.mainCameraCom_.aspect / var_238_2.sprite.bounds.size.x or var_238_3 / var_238_2.sprite.bounds.size.y, 0)
				end

				for iter_238_0, iter_238_1 in pairs(arg_235_1.bgs_) do
					if iter_238_0 ~= "MS2409" then
						iter_238_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_238_4 = 0

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1.allBtn_.enabled = false
			end

			if arg_235_1.time_ >= var_238_4 + 0.3 and arg_235_1.time_ < var_238_4 + 0.3 + arg_238_0 then
				arg_235_1.allBtn_.enabled = true
			end

			local var_238_5 = 0

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_5 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_6 = 1.13333333333333

			if var_238_5 <= arg_235_1.time_ and arg_235_1.time_ < var_238_5 + var_238_6 then
				local var_238_7 = Color.New(0, 0, 0)

				var_238_7.a = Mathf.Lerp(0, 1, (arg_235_1.time_ - var_238_5) / var_238_6)
				arg_235_1.mask_.color = var_238_7
			end

			if arg_235_1.time_ >= var_238_5 + var_238_6 and arg_235_1.time_ < var_238_5 + var_238_6 + arg_238_0 then
				local var_238_8 = Color.New(0, 0, 0)

				var_238_8.a = 1
				arg_235_1.mask_.color = var_238_8
			end

			local var_238_9 = 1.13333333333333

			if 1.13333333333333 < arg_235_1.time_ and arg_235_1.time_ <= var_238_9 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_10 = 1.5

			if var_238_9 <= arg_235_1.time_ and arg_235_1.time_ < var_238_9 + var_238_10 then
				local var_238_11 = Color.New(0, 0, 0)

				var_238_11.a = Mathf.Lerp(1, 0, (arg_235_1.time_ - var_238_9) / var_238_10)
				arg_235_1.mask_.color = var_238_11
			end

			if arg_235_1.time_ >= var_238_9 + var_238_10 and arg_235_1.time_ < var_238_9 + var_238_10 + arg_238_0 then
				local var_238_12 = Color.New(0, 0, 0)

				arg_235_1.mask_.enabled = false
				var_238_12.a = 0
				arg_235_1.mask_.color = var_238_12
			end

			local var_238_13 = arg_235_1.actors_["1170ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_13) and arg_235_1.var_.characterEffect1170ui_story == nil then
				arg_235_1.var_.characterEffect1170ui_story = var_238_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_14 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_14 and not isNil(var_238_13) then
				if arg_235_1.var_.characterEffect1170ui_story and not isNil(var_238_13) then
					arg_235_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_14 and arg_235_1.time_ < 0 + var_238_14 + arg_238_0 and not isNil(var_238_13) and arg_235_1.var_.characterEffect1170ui_story then
				arg_235_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_238_16 = arg_235_1.bgs_.MS2409.transform

			if 1.13333333333333 < arg_235_1.time_ and arg_235_1.time_ <= 1.13333333333333 + arg_238_0 then
				arg_235_1.var_.moveOldPosMS2409 = var_238_16.localPosition
			end

			local var_238_17 = 1.7

			if 1.13333333333333 <= arg_235_1.time_ and arg_235_1.time_ < 1.13333333333333 + var_238_17 then
				var_238_16.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPosMS2409, Vector3.New(0, 1, 4), (arg_235_1.time_ - 1.13333333333333) / var_238_17)
			end

			if arg_235_1.time_ >= 1.13333333333333 + var_238_17 and arg_235_1.time_ < 1.13333333333333 + var_238_17 + arg_238_0 then
				var_238_16.localPosition = Vector3.New(0, 1, 4)
			end

			local var_238_18 = 1.86666666666667

			if 1.86666666666667 < arg_235_1.time_ and arg_235_1.time_ <= var_238_18 + arg_238_0 then
				arg_235_1.allBtn_.enabled = false
			end

			if arg_235_1.time_ >= var_238_18 + 1.33333333333333 and arg_235_1.time_ < var_238_18 + 1.33333333333333 + arg_238_0 then
				arg_235_1.allBtn_.enabled = true
			end

			if arg_235_1.frameCnt_ <= 1 then
				arg_235_1.dialog_:SetActive(false)
			end

			local var_238_19 = 2.933333333332
			local var_238_20 = 0.4

			if 2.933333333332 < arg_235_1.time_ and arg_235_1.time_ <= var_238_19 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0

				arg_235_1.dialog_:SetActive(true)

				arg_235_1.dialogCg_.alpha = 0

				local var_238_21 = LeanTween.value(arg_235_1.dialog_, 0, 1, 0.3)

				var_238_21:setOnUpdate(LuaHelper.FloatAction(function(arg_239_0)
					arg_235_1.dialogCg_.alpha = arg_239_0
				end))
				var_238_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_235_1.dialog_)
					var_238_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_235_1.duration_ = arg_235_1.duration_ + 0.3

				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_22 = arg_235_1:GetWordFromCfg(324171057)
				local var_238_23 = arg_235_1:FormatText(var_238_22.content)

				arg_235_1.text_.text = var_238_23

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_25 = 16 <= 0 and var_238_20 or var_238_20 * (utf8.len(var_238_23) / 16)

				if (16 <= 0 and var_238_20 or var_238_20 * (utf8.len(var_238_23) / 16)) > 0 and var_238_20 < var_238_25 then
					arg_235_1.talkMaxDuration = var_238_25
					var_238_19 = var_238_19 + 0.3

					if var_238_25 + var_238_19 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_25 + var_238_19
					end
				end

				arg_235_1.text_.text = var_238_23
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171057", "story_v_out_324171.awb") ~= 0 then
					local var_238_26 = manager.audio:GetVoiceLength("story_v_out_324171", "324171057", "story_v_out_324171.awb") / 1000

					if var_238_26 + var_238_19 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_26 + var_238_19
					end

					if var_238_22.prefab_name ~= "" and arg_235_1.actors_[var_238_22.prefab_name] ~= nil then
						local var_238_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_22.prefab_name].transform, "story_v_out_324171", "324171057", "story_v_out_324171.awb")

						arg_235_1:RecordAudio("324171057", var_238_27)
						arg_235_1:RecordAudio("324171057", var_238_27)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_324171", "324171057", "story_v_out_324171.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_324171", "324171057", "story_v_out_324171.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_28 = var_238_19 + 0.3
			local var_238_29 = math.max(var_238_20, arg_235_1.talkMaxDuration)

			if var_238_19 + 0.3 <= arg_235_1.time_ and arg_235_1.time_ < var_238_28 + var_238_29 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_28) / var_238_29

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_28 + var_238_29 and arg_235_1.time_ < var_238_28 + var_238_29 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2409",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.7,
				startTime = 1.13333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 1, 4),
					easeType = LeanTweenType.easeOutCirc
				}
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play324171058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 324171058
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play324171059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1170ui_story"]) and arg_241_1.var_.characterEffect1170ui_story == nil then
				arg_241_1.var_.characterEffect1170ui_story = arg_241_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1170ui_story"]) then
				if arg_241_1.var_.characterEffect1170ui_story and not isNil(arg_241_1.actors_["1170ui_story"]) then
					arg_241_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_0)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1170ui_story"]) and arg_241_1.var_.characterEffect1170ui_story then
				arg_241_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_244_1 = 0
			local var_244_2 = 1.575

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_3 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(324171058).content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 63 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 63)

				if (63 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 63)) > 0 and var_244_2 < var_244_5 then
					arg_241_1.talkMaxDuration = var_244_5

					if var_244_5 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + var_244_1
					end
				end

				arg_241_1.text_.text = var_244_3
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_6 = math.max(var_244_2, arg_241_1.talkMaxDuration)

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_6 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_1) / var_244_6

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_1 + var_244_6 and arg_241_1.time_ < var_244_1 + var_244_6 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play324171059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 324171059
		arg_245_1.duration_ = 2

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play324171060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1170ui_story"]) and arg_245_1.var_.characterEffect1170ui_story == nil then
				arg_245_1.var_.characterEffect1170ui_story = arg_245_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1170ui_story"]) then
				if arg_245_1.var_.characterEffect1170ui_story and not isNil(arg_245_1.actors_["1170ui_story"]) then
					arg_245_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1170ui_story"]) and arg_245_1.var_.characterEffect1170ui_story then
				arg_245_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_248_2 = arg_245_1.actors_["1170ui_story"].transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1170ui_story = var_248_2.localPosition

				local var_248_3 = GameObjectTools.GetOrAddComponent(var_248_2.gameObject, typeof(DynamicBoneHelper))

				if var_248_3 then
					var_248_3:EnableDynamicBone(false)
				end
			end

			local var_248_4 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 then
				var_248_2.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1170ui_story, Vector3.New(0, 100, 0), (arg_245_1.time_ - 0) / var_248_4)
				var_248_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_2.position).x, (manager.ui.mainCamera.transform.position - var_248_2.position).y, (manager.ui.mainCamera.transform.position - var_248_2.position).z)
				var_248_2.localEulerAngles.z = 0
				var_248_2.localEulerAngles.x = 0
				var_248_2.localEulerAngles = var_248_2.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 then
				var_248_2.localPosition = Vector3.New(0, 100, 0)
				var_248_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_2.position).x, (manager.ui.mainCamera.transform.position - var_248_2.position).y, (manager.ui.mainCamera.transform.position - var_248_2.position).z)
				var_248_2.localEulerAngles.z = 0
				var_248_2.localEulerAngles.x = 0
				var_248_2.localEulerAngles = var_248_2.localEulerAngles

				local var_248_5 = GameObjectTools.GetOrAddComponent(var_248_2.gameObject, typeof(DynamicBoneHelper))

				if var_248_5 then
					var_248_5:EnableDynamicBone(true)
				end
			end

			local var_248_6 = arg_245_1.actors_["1170ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_6) and arg_245_1.var_.characterEffect1170ui_story == nil then
				arg_245_1.var_.characterEffect1170ui_story = var_248_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_7 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_7 and not isNil(var_248_6) then
				if arg_245_1.var_.characterEffect1170ui_story and not isNil(var_248_6) then
					arg_245_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_7 and arg_245_1.time_ < 0 + var_248_7 + arg_248_0 and not isNil(var_248_6) and arg_245_1.var_.characterEffect1170ui_story then
				arg_245_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action1_1")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_248_9 = 0
			local var_248_10 = 0.175

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_9 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_11 = arg_245_1:GetWordFromCfg(324171059)
				local var_248_12 = arg_245_1:FormatText(var_248_11.content)

				arg_245_1.text_.text = var_248_12

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_14 = 7 <= 0 and var_248_10 or var_248_10 * (utf8.len(var_248_12) / 7)

				if (7 <= 0 and var_248_10 or var_248_10 * (utf8.len(var_248_12) / 7)) > 0 and var_248_10 < var_248_14 then
					arg_245_1.talkMaxDuration = var_248_14

					if var_248_14 + var_248_9 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_14 + var_248_9
					end
				end

				arg_245_1.text_.text = var_248_12
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171059", "story_v_out_324171.awb") ~= 0 then
					local var_248_15 = manager.audio:GetVoiceLength("story_v_out_324171", "324171059", "story_v_out_324171.awb") / 1000

					if var_248_15 + var_248_9 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_15 + var_248_9
					end

					if var_248_11.prefab_name ~= "" and arg_245_1.actors_[var_248_11.prefab_name] ~= nil then
						local var_248_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_11.prefab_name].transform, "story_v_out_324171", "324171059", "story_v_out_324171.awb")

						arg_245_1:RecordAudio("324171059", var_248_16)
						arg_245_1:RecordAudio("324171059", var_248_16)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_324171", "324171059", "story_v_out_324171.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_324171", "324171059", "story_v_out_324171.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_17 = math.max(var_248_10, arg_245_1.talkMaxDuration)

			if var_248_9 <= arg_245_1.time_ and arg_245_1.time_ < var_248_9 + var_248_17 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_9) / var_248_17

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_9 + var_248_17 and arg_245_1.time_ < var_248_9 + var_248_17 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play324171060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 324171060
		arg_249_1.duration_ = 7.83

		local var_249_0 = {
			zh = 5.266,
			ja = 7.833
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play324171061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1170ui_story"]) and arg_249_1.var_.characterEffect1170ui_story == nil then
				arg_249_1.var_.characterEffect1170ui_story = arg_249_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1170ui_story"]) then
				if arg_249_1.var_.characterEffect1170ui_story and not isNil(arg_249_1.actors_["1170ui_story"]) then
					arg_249_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_0)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1170ui_story"]) and arg_249_1.var_.characterEffect1170ui_story then
				arg_249_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_252_1 = 0
			local var_252_2 = 0.675

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[1502].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:GetWordFromCfg(324171060)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_6 = 27 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_4) / 27)

				if (27 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_4) / 27)) > 0 and var_252_2 < var_252_6 then
					arg_249_1.talkMaxDuration = var_252_6

					if var_252_6 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_6 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171060", "story_v_out_324171.awb") ~= 0 then
					local var_252_7 = manager.audio:GetVoiceLength("story_v_out_324171", "324171060", "story_v_out_324171.awb") / 1000

					if var_252_7 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_1
					end

					if var_252_3.prefab_name ~= "" and arg_249_1.actors_[var_252_3.prefab_name] ~= nil then
						local var_252_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_3.prefab_name].transform, "story_v_out_324171", "324171060", "story_v_out_324171.awb")

						arg_249_1:RecordAudio("324171060", var_252_8)
						arg_249_1:RecordAudio("324171060", var_252_8)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_324171", "324171060", "story_v_out_324171.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_324171", "324171060", "story_v_out_324171.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_9 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_9 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_9

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_9 and arg_249_1.time_ < var_252_1 + var_252_9 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play324171061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 324171061
		arg_253_1.duration_ = 2.03

		local var_253_0 = {
			zh = 2.033,
			ja = 1.533
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
				arg_253_0:Play324171062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.2

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[1502].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_1 = arg_253_1:GetWordFromCfg(324171061)
				local var_256_2 = arg_253_1:FormatText(var_256_1.content)

				arg_253_1.text_.text = var_256_2

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 8 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 8)

				if (8 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 8)) > 0 and var_256_0 < var_256_4 then
					arg_253_1.talkMaxDuration = var_256_4

					if var_256_4 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_4 + 0
					end
				end

				arg_253_1.text_.text = var_256_2
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171061", "story_v_out_324171.awb") ~= 0 then
					local var_256_5 = manager.audio:GetVoiceLength("story_v_out_324171", "324171061", "story_v_out_324171.awb") / 1000

					if var_256_5 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + 0
					end

					if var_256_1.prefab_name ~= "" and arg_253_1.actors_[var_256_1.prefab_name] ~= nil then
						local var_256_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_1.prefab_name].transform, "story_v_out_324171", "324171061", "story_v_out_324171.awb")

						arg_253_1:RecordAudio("324171061", var_256_6)
						arg_253_1:RecordAudio("324171061", var_256_6)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_324171", "324171061", "story_v_out_324171.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_324171", "324171061", "story_v_out_324171.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play324171062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 324171062
		arg_257_1.duration_ = 4.4

		local var_257_0 = {
			zh = 4.4,
			ja = 4.1
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
				arg_257_0:Play324171063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.425

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_1 = arg_257_1:GetWordFromCfg(324171062)
				local var_260_2 = arg_257_1:FormatText(var_260_1.content)

				arg_257_1.text_.text = var_260_2

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 17 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 17)

				if (17 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 17)) > 0 and var_260_0 < var_260_4 then
					arg_257_1.talkMaxDuration = var_260_4

					if var_260_4 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_4 + 0
					end
				end

				arg_257_1.text_.text = var_260_2
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171062", "story_v_out_324171.awb") ~= 0 then
					local var_260_5 = manager.audio:GetVoiceLength("story_v_out_324171", "324171062", "story_v_out_324171.awb") / 1000

					if var_260_5 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + 0
					end

					if var_260_1.prefab_name ~= "" and arg_257_1.actors_[var_260_1.prefab_name] ~= nil then
						local var_260_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_1.prefab_name].transform, "story_v_out_324171", "324171062", "story_v_out_324171.awb")

						arg_257_1:RecordAudio("324171062", var_260_6)
						arg_257_1:RecordAudio("324171062", var_260_6)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_324171", "324171062", "story_v_out_324171.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_324171", "324171062", "story_v_out_324171.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play324171063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 324171063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play324171064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:AudioAction("play", "effect", "se_story_150", "se_story_150_bamboo01", "")
			end

			local var_264_1 = 0
			local var_264_2 = 0.9

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_3 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(324171063).content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 36 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 36)

				if (36 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 36)) > 0 and var_264_2 < var_264_5 then
					arg_261_1.talkMaxDuration = var_264_5

					if var_264_5 + var_264_1 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + var_264_1
					end
				end

				arg_261_1.text_.text = var_264_3
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_6 = math.max(var_264_2, arg_261_1.talkMaxDuration)

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_6 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_1) / var_264_6

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_1 + var_264_6 and arg_261_1.time_ < var_264_1 + var_264_6 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play324171064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 324171064
		arg_265_1.duration_ = 5.27

		local var_265_0 = {
			zh = 4.733333333332,
			ja = 5.26633333631357
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
				arg_265_0:Play324171065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 1.5 < arg_265_1.time_ and arg_265_1.time_ <= 1.5 + arg_268_0 then
				local var_268_0 = arg_265_1.bgs_.ST2009

				arg_265_1.bgs_.ST2009.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_268_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_268_1 = var_268_0:GetComponent("SpriteRenderer")

				if var_268_1 and var_268_1.sprite then
					local var_268_2 = 2 * (var_268_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_268_0.transform.localScale = Vector3.New(var_268_2 / var_268_1.sprite.bounds.size.y < var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x and var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x or var_268_2 / var_268_1.sprite.bounds.size.y, var_268_2 / var_268_1.sprite.bounds.size.y < var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x and var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x or var_268_2 / var_268_1.sprite.bounds.size.y, 0)
				end

				for iter_268_0, iter_268_1 in pairs(arg_265_1.bgs_) do
					if iter_268_0 ~= "ST2009" then
						iter_268_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_268_3 = 0

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_3 + arg_268_0 then
				arg_265_1.allBtn_.enabled = false
			end

			if arg_265_1.time_ >= var_268_3 + 0.3 and arg_265_1.time_ < var_268_3 + 0.3 + arg_268_0 then
				arg_265_1.allBtn_.enabled = true
			end

			local var_268_4 = 0

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_5 = 1.5

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_5 then
				local var_268_6 = Color.New(0, 0, 0)

				var_268_6.a = Mathf.Lerp(0, 1, (arg_265_1.time_ - var_268_4) / var_268_5)
				arg_265_1.mask_.color = var_268_6
			end

			if arg_265_1.time_ >= var_268_4 + var_268_5 and arg_265_1.time_ < var_268_4 + var_268_5 + arg_268_0 then
				local var_268_7 = Color.New(0, 0, 0)

				var_268_7.a = 1
				arg_265_1.mask_.color = var_268_7
			end

			local var_268_8 = 1.5

			if 1.5 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_9 = 1.5

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_9 then
				local var_268_10 = Color.New(0, 0, 0)

				var_268_10.a = Mathf.Lerp(1, 0, (arg_265_1.time_ - var_268_8) / var_268_9)
				arg_265_1.mask_.color = var_268_10
			end

			if arg_265_1.time_ >= var_268_8 + var_268_9 and arg_265_1.time_ < var_268_8 + var_268_9 + arg_268_0 then
				local var_268_11 = Color.New(0, 0, 0)

				arg_265_1.mask_.enabled = false
				var_268_11.a = 0
				arg_265_1.mask_.color = var_268_11
			end

			local var_268_12 = arg_265_1.actors_["1170ui_story"].transform

			if 2.73333333333333 < arg_265_1.time_ and arg_265_1.time_ <= 2.73333333333333 + arg_268_0 then
				arg_265_1.var_.moveOldPos1170ui_story = var_268_12.localPosition

				local var_268_13 = GameObjectTools.GetOrAddComponent(var_268_12.gameObject, typeof(DynamicBoneHelper))

				if var_268_13 then
					var_268_13:EnableDynamicBone(false)
				end
			end

			local var_268_14 = 0.001

			if 2.73333333333333 <= arg_265_1.time_ and arg_265_1.time_ < 2.73333333333333 + var_268_14 then
				var_268_12.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1170ui_story, Vector3.New(0.03, -0.95, -6.08), (arg_265_1.time_ - 2.73333333333333) / var_268_14)
				var_268_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_12.position).x, (manager.ui.mainCamera.transform.position - var_268_12.position).y, (manager.ui.mainCamera.transform.position - var_268_12.position).z)
				var_268_12.localEulerAngles.z = 0
				var_268_12.localEulerAngles.x = 0
				var_268_12.localEulerAngles = var_268_12.localEulerAngles
			end

			if arg_265_1.time_ >= 2.73333333333333 + var_268_14 and arg_265_1.time_ < 2.73333333333333 + var_268_14 + arg_268_0 then
				var_268_12.localPosition = Vector3.New(0.03, -0.95, -6.08)
				var_268_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_12.position).x, (manager.ui.mainCamera.transform.position - var_268_12.position).y, (manager.ui.mainCamera.transform.position - var_268_12.position).z)
				var_268_12.localEulerAngles.z = 0
				var_268_12.localEulerAngles.x = 0
				var_268_12.localEulerAngles = var_268_12.localEulerAngles

				local var_268_15 = GameObjectTools.GetOrAddComponent(var_268_12.gameObject, typeof(DynamicBoneHelper))

				if var_268_15 then
					var_268_15:EnableDynamicBone(true)
				end
			end

			local var_268_16 = arg_265_1.actors_["1170ui_story"]

			if 2.73333333333333 < arg_265_1.time_ and arg_265_1.time_ <= 2.73333333333333 + arg_268_0 and not isNil(var_268_16) and arg_265_1.var_.characterEffect1170ui_story == nil then
				arg_265_1.var_.characterEffect1170ui_story = var_268_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_17 = 0.200000002980232

			if 2.73333333333333 <= arg_265_1.time_ and arg_265_1.time_ < 2.73333333333333 + var_268_17 and not isNil(var_268_16) then
				if arg_265_1.var_.characterEffect1170ui_story and not isNil(var_268_16) then
					arg_265_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 2.73333333333333 + var_268_17 and arg_265_1.time_ < 2.73333333333333 + var_268_17 + arg_268_0 and not isNil(var_268_16) and arg_265_1.var_.characterEffect1170ui_story then
				arg_265_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			if 2.73333333333333 < arg_265_1.time_ and arg_265_1.time_ <= 2.73333333333333 + arg_268_0 then
				arg_265_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action3_1")
			end

			if 2.73333333333333 < arg_265_1.time_ and arg_265_1.time_ <= 2.73333333333333 + arg_268_0 then
				arg_265_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 1 < arg_265_1.time_ and arg_265_1.time_ <= 1 + arg_268_0 then
				arg_265_1:AudioAction("play", "music", "bgm_activity_5_0_story_dahuaishucun", "bgm_activity_5_0_story_dahuaishucun", "bgm_activity_5_0_story_dahuaishucun.awb")

				local var_268_22 = manager.audio:GetAudioName("bgm_activity_5_0_story_dahuaishucun", "bgm_activity_5_0_story_dahuaishucun")

				if "" ~= "" then
					if arg_265_1.bgmTxt_.text ~= var_268_22 and arg_265_1.bgmTxt_.text ~= "" then
						if arg_265_1.bgmTxt2_.text ~= "" then
							arg_265_1.bgmTxt_.text = arg_265_1.bgmTxt2_.text
						end

						arg_265_1.bgmTxt2_.text = var_268_22

						arg_265_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_265_1.bgmTxt_.text = var_268_22
						arg_265_1.bgmTxt2_.text = var_268_22
					end

					if arg_265_1.bgmTimer then
						arg_265_1.bgmTimer:Stop()

						arg_265_1.bgmTimer = nil
					end

					if arg_265_1.settingData.show_music_name == 1 then
						arg_265_1.musicController:SetSelectedState("show")
						arg_265_1.musicAnimator_:Play("open", 0, 0)

						if arg_265_1.settingData.music_time ~= 0 then
							arg_265_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_265_1.settingData.music_time), function()
								if arg_265_1 == nil or isNil(arg_265_1.bgmTxt_) then
									return
								end

								arg_265_1.musicController:SetSelectedState("hide")
								arg_265_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_23 = 2.93333333631357
			local var_268_24 = 0.125

			if 2.93333333631357 < arg_265_1.time_ and arg_265_1.time_ <= var_268_23 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_25 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_25:setOnUpdate(LuaHelper.FloatAction(function(arg_270_0)
					arg_265_1.dialogCg_.alpha = arg_270_0
				end))
				var_268_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_26 = arg_265_1:GetWordFromCfg(324171064)
				local var_268_27 = arg_265_1:FormatText(var_268_26.content)

				arg_265_1.text_.text = var_268_27

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_29 = 5 <= 0 and var_268_24 or var_268_24 * (utf8.len(var_268_27) / 5)

				if (5 <= 0 and var_268_24 or var_268_24 * (utf8.len(var_268_27) / 5)) > 0 and var_268_24 < var_268_29 then
					arg_265_1.talkMaxDuration = var_268_29
					var_268_23 = var_268_23 + 0.3

					if var_268_29 + var_268_23 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_29 + var_268_23
					end
				end

				arg_265_1.text_.text = var_268_27
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171064", "story_v_out_324171.awb") ~= 0 then
					local var_268_30 = manager.audio:GetVoiceLength("story_v_out_324171", "324171064", "story_v_out_324171.awb") / 1000

					if var_268_30 + var_268_23 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_30 + var_268_23
					end

					if var_268_26.prefab_name ~= "" and arg_265_1.actors_[var_268_26.prefab_name] ~= nil then
						local var_268_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_26.prefab_name].transform, "story_v_out_324171", "324171064", "story_v_out_324171.awb")

						arg_265_1:RecordAudio("324171064", var_268_31)
						arg_265_1:RecordAudio("324171064", var_268_31)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_324171", "324171064", "story_v_out_324171.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_324171", "324171064", "story_v_out_324171.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_32 = var_268_23 + 0.3
			local var_268_33 = math.max(var_268_24, arg_265_1.talkMaxDuration)

			if var_268_23 + 0.3 <= arg_265_1.time_ and arg_265_1.time_ < var_268_32 + var_268_33 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_32) / var_268_33

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_32 + var_268_33 and arg_265_1.time_ < var_268_32 + var_268_33 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play324171065 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 324171065
		arg_272_1.duration_ = 5.9

		local var_272_0 = {
			zh = 5.9,
			ja = 5.5
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play324171066(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(arg_272_1.actors_["1170ui_story"]) and arg_272_1.var_.characterEffect1170ui_story == nil then
				arg_272_1.var_.characterEffect1170ui_story = arg_272_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_0 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 and not isNil(arg_272_1.actors_["1170ui_story"]) then
				if arg_272_1.var_.characterEffect1170ui_story and not isNil(arg_272_1.actors_["1170ui_story"]) then
					arg_272_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_272_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_272_1.time_ - 0) / var_275_0)
				end
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 and not isNil(arg_272_1.actors_["1170ui_story"]) and arg_272_1.var_.characterEffect1170ui_story then
				arg_272_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_272_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_275_1 = 0
			local var_275_2 = 0.525

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_3 = arg_272_1:GetWordFromCfg(324171065)
				local var_275_4 = arg_272_1:FormatText(var_275_3.content)

				arg_272_1.text_.text = var_275_4

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_6 = 21 <= 0 and var_275_2 or var_275_2 * (utf8.len(var_275_4) / 21)

				if (21 <= 0 and var_275_2 or var_275_2 * (utf8.len(var_275_4) / 21)) > 0 and var_275_2 < var_275_6 then
					arg_272_1.talkMaxDuration = var_275_6

					if var_275_6 + var_275_1 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_6 + var_275_1
					end
				end

				arg_272_1.text_.text = var_275_4
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171065", "story_v_out_324171.awb") ~= 0 then
					local var_275_7 = manager.audio:GetVoiceLength("story_v_out_324171", "324171065", "story_v_out_324171.awb") / 1000

					if var_275_7 + var_275_1 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_1
					end

					if var_275_3.prefab_name ~= "" and arg_272_1.actors_[var_275_3.prefab_name] ~= nil then
						local var_275_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_3.prefab_name].transform, "story_v_out_324171", "324171065", "story_v_out_324171.awb")

						arg_272_1:RecordAudio("324171065", var_275_8)
						arg_272_1:RecordAudio("324171065", var_275_8)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_324171", "324171065", "story_v_out_324171.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_324171", "324171065", "story_v_out_324171.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_9 = math.max(var_275_2, arg_272_1.talkMaxDuration)

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_9 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_1) / var_275_9

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_1 + var_275_9 and arg_272_1.time_ < var_275_1 + var_275_9 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play324171066 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 324171066
		arg_276_1.duration_ = 6.73

		local var_276_0 = {
			zh = 6.733,
			ja = 6.033
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
				arg_276_0:Play324171067(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(arg_276_1.actors_["1170ui_story"]) and arg_276_1.var_.characterEffect1170ui_story == nil then
				arg_276_1.var_.characterEffect1170ui_story = arg_276_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_0 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 and not isNil(arg_276_1.actors_["1170ui_story"]) then
				if arg_276_1.var_.characterEffect1170ui_story and not isNil(arg_276_1.actors_["1170ui_story"]) then
					arg_276_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 and not isNil(arg_276_1.actors_["1170ui_story"]) and arg_276_1.var_.characterEffect1170ui_story then
				arg_276_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action3_2")
			end

			local var_279_2 = 0
			local var_279_3 = 0.775

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_2 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_4 = arg_276_1:GetWordFromCfg(324171066)
				local var_279_5 = arg_276_1:FormatText(var_279_4.content)

				arg_276_1.text_.text = var_279_5

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_7 = 31 <= 0 and var_279_3 or var_279_3 * (utf8.len(var_279_5) / 31)

				if (31 <= 0 and var_279_3 or var_279_3 * (utf8.len(var_279_5) / 31)) > 0 and var_279_3 < var_279_7 then
					arg_276_1.talkMaxDuration = var_279_7

					if var_279_7 + var_279_2 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_7 + var_279_2
					end
				end

				arg_276_1.text_.text = var_279_5
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171066", "story_v_out_324171.awb") ~= 0 then
					local var_279_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171066", "story_v_out_324171.awb") / 1000

					if var_279_8 + var_279_2 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_8 + var_279_2
					end

					if var_279_4.prefab_name ~= "" and arg_276_1.actors_[var_279_4.prefab_name] ~= nil then
						local var_279_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_4.prefab_name].transform, "story_v_out_324171", "324171066", "story_v_out_324171.awb")

						arg_276_1:RecordAudio("324171066", var_279_9)
						arg_276_1:RecordAudio("324171066", var_279_9)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_324171", "324171066", "story_v_out_324171.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_324171", "324171066", "story_v_out_324171.awb")
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
	Play324171067 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 324171067
		arg_280_1.duration_ = 2.17

		local var_280_0 = {
			zh = 2.166,
			ja = 2.066
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
				arg_280_0:Play324171068(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["1170ui_story"]) and arg_280_1.var_.characterEffect1170ui_story == nil then
				arg_280_1.var_.characterEffect1170ui_story = arg_280_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_0 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["1170ui_story"]) then
				if arg_280_1.var_.characterEffect1170ui_story and not isNil(arg_280_1.actors_["1170ui_story"]) then
					arg_280_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_280_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_280_1.time_ - 0) / var_283_0)
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["1170ui_story"]) and arg_280_1.var_.characterEffect1170ui_story then
				arg_280_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_280_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_283_1 = 0
			local var_283_2 = 0.075

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_3 = arg_280_1:GetWordFromCfg(324171067)
				local var_283_4 = arg_280_1:FormatText(var_283_3.content)

				arg_280_1.text_.text = var_283_4

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_6 = 3 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_4) / 3)

				if (3 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_4) / 3)) > 0 and var_283_2 < var_283_6 then
					arg_280_1.talkMaxDuration = var_283_6

					if var_283_6 + var_283_1 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_6 + var_283_1
					end
				end

				arg_280_1.text_.text = var_283_4
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171067", "story_v_out_324171.awb") ~= 0 then
					local var_283_7 = manager.audio:GetVoiceLength("story_v_out_324171", "324171067", "story_v_out_324171.awb") / 1000

					if var_283_7 + var_283_1 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_1
					end

					if var_283_3.prefab_name ~= "" and arg_280_1.actors_[var_283_3.prefab_name] ~= nil then
						local var_283_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_3.prefab_name].transform, "story_v_out_324171", "324171067", "story_v_out_324171.awb")

						arg_280_1:RecordAudio("324171067", var_283_8)
						arg_280_1:RecordAudio("324171067", var_283_8)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_324171", "324171067", "story_v_out_324171.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_324171", "324171067", "story_v_out_324171.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_9 = math.max(var_283_2, arg_280_1.talkMaxDuration)

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_9 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_1) / var_283_9

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_1 + var_283_9 and arg_280_1.time_ < var_283_1 + var_283_9 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play324171068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 324171068
		arg_284_1.duration_ = 12.6

		local var_284_0 = {
			zh = 10.7,
			ja = 12.6
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play324171069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(arg_284_1.actors_["1170ui_story"]) and arg_284_1.var_.characterEffect1170ui_story == nil then
				arg_284_1.var_.characterEffect1170ui_story = arg_284_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_0 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 and not isNil(arg_284_1.actors_["1170ui_story"]) then
				if arg_284_1.var_.characterEffect1170ui_story and not isNil(arg_284_1.actors_["1170ui_story"]) then
					arg_284_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 and not isNil(arg_284_1.actors_["1170ui_story"]) and arg_284_1.var_.characterEffect1170ui_story then
				arg_284_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action7_1")
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_287_2 = 0
			local var_287_3 = 1.175

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_2 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_4 = arg_284_1:GetWordFromCfg(324171068)
				local var_287_5 = arg_284_1:FormatText(var_287_4.content)

				arg_284_1.text_.text = var_287_5

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_7 = 47 <= 0 and var_287_3 or var_287_3 * (utf8.len(var_287_5) / 47)

				if (47 <= 0 and var_287_3 or var_287_3 * (utf8.len(var_287_5) / 47)) > 0 and var_287_3 < var_287_7 then
					arg_284_1.talkMaxDuration = var_287_7

					if var_287_7 + var_287_2 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_7 + var_287_2
					end
				end

				arg_284_1.text_.text = var_287_5
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171068", "story_v_out_324171.awb") ~= 0 then
					local var_287_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171068", "story_v_out_324171.awb") / 1000

					if var_287_8 + var_287_2 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_8 + var_287_2
					end

					if var_287_4.prefab_name ~= "" and arg_284_1.actors_[var_287_4.prefab_name] ~= nil then
						local var_287_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_4.prefab_name].transform, "story_v_out_324171", "324171068", "story_v_out_324171.awb")

						arg_284_1:RecordAudio("324171068", var_287_9)
						arg_284_1:RecordAudio("324171068", var_287_9)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_324171", "324171068", "story_v_out_324171.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_324171", "324171068", "story_v_out_324171.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_10 = math.max(var_287_3, arg_284_1.talkMaxDuration)

			if var_287_2 <= arg_284_1.time_ and arg_284_1.time_ < var_287_2 + var_287_10 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_2) / var_287_10

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_2 + var_287_10 and arg_284_1.time_ < var_287_2 + var_287_10 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play324171069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 324171069
		arg_288_1.duration_ = 10.4

		local var_288_0 = {
			zh = 7.633,
			ja = 10.4
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
				arg_288_0:Play324171070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["1170ui_story"]) and arg_288_1.var_.characterEffect1170ui_story == nil then
				arg_288_1.var_.characterEffect1170ui_story = arg_288_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_0 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["1170ui_story"]) then
				if arg_288_1.var_.characterEffect1170ui_story and not isNil(arg_288_1.actors_["1170ui_story"]) then
					arg_288_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_288_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_288_1.time_ - 0) / var_291_0)
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["1170ui_story"]) and arg_288_1.var_.characterEffect1170ui_story then
				arg_288_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_288_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_291_1 = 0
			local var_291_2 = 0.65

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_3 = arg_288_1:GetWordFromCfg(324171069)
				local var_291_4 = arg_288_1:FormatText(var_291_3.content)

				arg_288_1.text_.text = var_291_4

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_6 = 26 <= 0 and var_291_2 or var_291_2 * (utf8.len(var_291_4) / 26)

				if (26 <= 0 and var_291_2 or var_291_2 * (utf8.len(var_291_4) / 26)) > 0 and var_291_2 < var_291_6 then
					arg_288_1.talkMaxDuration = var_291_6

					if var_291_6 + var_291_1 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_6 + var_291_1
					end
				end

				arg_288_1.text_.text = var_291_4
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171069", "story_v_out_324171.awb") ~= 0 then
					local var_291_7 = manager.audio:GetVoiceLength("story_v_out_324171", "324171069", "story_v_out_324171.awb") / 1000

					if var_291_7 + var_291_1 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_7 + var_291_1
					end

					if var_291_3.prefab_name ~= "" and arg_288_1.actors_[var_291_3.prefab_name] ~= nil then
						local var_291_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_3.prefab_name].transform, "story_v_out_324171", "324171069", "story_v_out_324171.awb")

						arg_288_1:RecordAudio("324171069", var_291_8)
						arg_288_1:RecordAudio("324171069", var_291_8)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_324171", "324171069", "story_v_out_324171.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_324171", "324171069", "story_v_out_324171.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_9 = math.max(var_291_2, arg_288_1.talkMaxDuration)

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_9 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_1) / var_291_9

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_1 + var_291_9 and arg_288_1.time_ < var_291_1 + var_291_9 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play324171070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 324171070
		arg_292_1.duration_ = 7.73

		local var_292_0 = {
			zh = 6.3,
			ja = 7.733
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play324171071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(arg_292_1.actors_["1170ui_story"]) and arg_292_1.var_.characterEffect1170ui_story == nil then
				arg_292_1.var_.characterEffect1170ui_story = arg_292_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_0 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 and not isNil(arg_292_1.actors_["1170ui_story"]) then
				if arg_292_1.var_.characterEffect1170ui_story and not isNil(arg_292_1.actors_["1170ui_story"]) then
					arg_292_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 and not isNil(arg_292_1.actors_["1170ui_story"]) and arg_292_1.var_.characterEffect1170ui_story then
				arg_292_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_295_2 = 0
			local var_295_3 = 0.65

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_2 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_4 = arg_292_1:GetWordFromCfg(324171070)
				local var_295_5 = arg_292_1:FormatText(var_295_4.content)

				arg_292_1.text_.text = var_295_5

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_7 = 26 <= 0 and var_295_3 or var_295_3 * (utf8.len(var_295_5) / 26)

				if (26 <= 0 and var_295_3 or var_295_3 * (utf8.len(var_295_5) / 26)) > 0 and var_295_3 < var_295_7 then
					arg_292_1.talkMaxDuration = var_295_7

					if var_295_7 + var_295_2 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_7 + var_295_2
					end
				end

				arg_292_1.text_.text = var_295_5
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171070", "story_v_out_324171.awb") ~= 0 then
					local var_295_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171070", "story_v_out_324171.awb") / 1000

					if var_295_8 + var_295_2 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_8 + var_295_2
					end

					if var_295_4.prefab_name ~= "" and arg_292_1.actors_[var_295_4.prefab_name] ~= nil then
						local var_295_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_4.prefab_name].transform, "story_v_out_324171", "324171070", "story_v_out_324171.awb")

						arg_292_1:RecordAudio("324171070", var_295_9)
						arg_292_1:RecordAudio("324171070", var_295_9)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_324171", "324171070", "story_v_out_324171.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_324171", "324171070", "story_v_out_324171.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_10 = math.max(var_295_3, arg_292_1.talkMaxDuration)

			if var_295_2 <= arg_292_1.time_ and arg_292_1.time_ < var_295_2 + var_295_10 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_2) / var_295_10

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_2 + var_295_10 and arg_292_1.time_ < var_295_2 + var_295_10 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play324171071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 324171071
		arg_296_1.duration_ = 4.47

		local var_296_0 = {
			zh = 4.466,
			ja = 3.666
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play324171072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action7_2")
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_299_0 = 0
			local var_299_1 = 0.575

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_2 = arg_296_1:GetWordFromCfg(324171071)
				local var_299_3 = arg_296_1:FormatText(var_299_2.content)

				arg_296_1.text_.text = var_299_3

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_5 = 23 <= 0 and var_299_1 or var_299_1 * (utf8.len(var_299_3) / 23)

				if (23 <= 0 and var_299_1 or var_299_1 * (utf8.len(var_299_3) / 23)) > 0 and var_299_1 < var_299_5 then
					arg_296_1.talkMaxDuration = var_299_5

					if var_299_5 + var_299_0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_5 + var_299_0
					end
				end

				arg_296_1.text_.text = var_299_3
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171071", "story_v_out_324171.awb") ~= 0 then
					local var_299_6 = manager.audio:GetVoiceLength("story_v_out_324171", "324171071", "story_v_out_324171.awb") / 1000

					if var_299_6 + var_299_0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_6 + var_299_0
					end

					if var_299_2.prefab_name ~= "" and arg_296_1.actors_[var_299_2.prefab_name] ~= nil then
						local var_299_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_2.prefab_name].transform, "story_v_out_324171", "324171071", "story_v_out_324171.awb")

						arg_296_1:RecordAudio("324171071", var_299_7)
						arg_296_1:RecordAudio("324171071", var_299_7)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_324171", "324171071", "story_v_out_324171.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_324171", "324171071", "story_v_out_324171.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_8 = math.max(var_299_1, arg_296_1.talkMaxDuration)

			if var_299_0 <= arg_296_1.time_ and arg_296_1.time_ < var_299_0 + var_299_8 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_0) / var_299_8

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_0 + var_299_8 and arg_296_1.time_ < var_299_0 + var_299_8 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play324171072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 324171072
		arg_300_1.duration_ = 6.93

		local var_300_0 = {
			zh = 4.666,
			ja = 6.933
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play324171073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0.525

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_1 = arg_300_1:GetWordFromCfg(324171072)
				local var_303_2 = arg_300_1:FormatText(var_303_1.content)

				arg_300_1.text_.text = var_303_2

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_4 = 21 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_2) / 21)

				if (21 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_2) / 21)) > 0 and var_303_0 < var_303_4 then
					arg_300_1.talkMaxDuration = var_303_4

					if var_303_4 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_4 + 0
					end
				end

				arg_300_1.text_.text = var_303_2
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171072", "story_v_out_324171.awb") ~= 0 then
					local var_303_5 = manager.audio:GetVoiceLength("story_v_out_324171", "324171072", "story_v_out_324171.awb") / 1000

					if var_303_5 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_5 + 0
					end

					if var_303_1.prefab_name ~= "" and arg_300_1.actors_[var_303_1.prefab_name] ~= nil then
						local var_303_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_1.prefab_name].transform, "story_v_out_324171", "324171072", "story_v_out_324171.awb")

						arg_300_1:RecordAudio("324171072", var_303_6)
						arg_300_1:RecordAudio("324171072", var_303_6)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_324171", "324171072", "story_v_out_324171.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_324171", "324171072", "story_v_out_324171.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_7 = math.max(var_303_0, arg_300_1.talkMaxDuration)

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_7 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - 0) / var_303_7

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= 0 + var_303_7 and arg_300_1.time_ < 0 + var_303_7 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play324171073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 324171073
		arg_304_1.duration_ = 2.3

		local var_304_0 = {
			zh = 1.9,
			ja = 2.3
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play324171074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(arg_304_1.actors_["1170ui_story"]) and arg_304_1.var_.characterEffect1170ui_story == nil then
				arg_304_1.var_.characterEffect1170ui_story = arg_304_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_0 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 and not isNil(arg_304_1.actors_["1170ui_story"]) then
				if arg_304_1.var_.characterEffect1170ui_story and not isNil(arg_304_1.actors_["1170ui_story"]) then
					arg_304_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_304_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_304_1.time_ - 0) / var_307_0)
				end
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 and not isNil(arg_304_1.actors_["1170ui_story"]) and arg_304_1.var_.characterEffect1170ui_story then
				arg_304_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_304_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_307_1 = 0
			local var_307_2 = 0.15

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_3 = arg_304_1:GetWordFromCfg(324171073)
				local var_307_4 = arg_304_1:FormatText(var_307_3.content)

				arg_304_1.text_.text = var_307_4

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_6 = 6 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_4) / 6)

				if (6 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_4) / 6)) > 0 and var_307_2 < var_307_6 then
					arg_304_1.talkMaxDuration = var_307_6

					if var_307_6 + var_307_1 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_6 + var_307_1
					end
				end

				arg_304_1.text_.text = var_307_4
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171073", "story_v_out_324171.awb") ~= 0 then
					local var_307_7 = manager.audio:GetVoiceLength("story_v_out_324171", "324171073", "story_v_out_324171.awb") / 1000

					if var_307_7 + var_307_1 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_7 + var_307_1
					end

					if var_307_3.prefab_name ~= "" and arg_304_1.actors_[var_307_3.prefab_name] ~= nil then
						local var_307_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_3.prefab_name].transform, "story_v_out_324171", "324171073", "story_v_out_324171.awb")

						arg_304_1:RecordAudio("324171073", var_307_8)
						arg_304_1:RecordAudio("324171073", var_307_8)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_324171", "324171073", "story_v_out_324171.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_324171", "324171073", "story_v_out_324171.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_9 = math.max(var_307_2, arg_304_1.talkMaxDuration)

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_9 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_1) / var_307_9

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_1 + var_307_9 and arg_304_1.time_ < var_307_1 + var_307_9 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play324171074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 324171074
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play324171075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos1170ui_story = arg_308_1.actors_["1170ui_story"].transform.localPosition

				local var_311_0 = GameObjectTools.GetOrAddComponent(arg_308_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_311_0 then
					var_311_0:EnableDynamicBone(false)
				end
			end

			local var_311_1 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_1 then
				arg_308_1.actors_["1170ui_story"].transform.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1170ui_story, Vector3.New(0, 100, 0), (arg_308_1.time_ - 0) / var_311_1)
				arg_308_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1170ui_story"].transform.position).z)
				arg_308_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["1170ui_story"].transform.localEulerAngles = arg_308_1.actors_["1170ui_story"].transform.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_1 and arg_308_1.time_ < 0 + var_311_1 + arg_311_0 then
				arg_308_1.actors_["1170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_308_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1170ui_story"].transform.position).z)
				arg_308_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["1170ui_story"].transform.localEulerAngles = arg_308_1.actors_["1170ui_story"].transform.localEulerAngles

				local var_311_2 = GameObjectTools.GetOrAddComponent(arg_308_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_311_2 then
					var_311_2:EnableDynamicBone(true)
				end
			end

			local var_311_3 = 0
			local var_311_4 = 0.625

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_3 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_5 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(324171074).content)

				arg_308_1.text_.text = var_311_5

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_7 = 25 <= 0 and var_311_4 or var_311_4 * (utf8.len(var_311_5) / 25)

				if (25 <= 0 and var_311_4 or var_311_4 * (utf8.len(var_311_5) / 25)) > 0 and var_311_4 < var_311_7 then
					arg_308_1.talkMaxDuration = var_311_7

					if var_311_7 + var_311_3 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_7 + var_311_3
					end
				end

				arg_308_1.text_.text = var_311_5
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_8 = math.max(var_311_4, arg_308_1.talkMaxDuration)

			if var_311_3 <= arg_308_1.time_ and arg_308_1.time_ < var_311_3 + var_311_8 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_3) / var_311_8

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_3 + var_311_8 and arg_308_1.time_ < var_311_3 + var_311_8 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play324171075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 324171075
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play324171076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0.7

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_1 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(324171075).content)

				arg_312_1.text_.text = var_315_1

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_3 = 28 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_1) / 28)

				if (28 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_1) / 28)) > 0 and var_315_0 < var_315_3 then
					arg_312_1.talkMaxDuration = var_315_3

					if var_315_3 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_3 + 0
					end
				end

				arg_312_1.text_.text = var_315_1
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_4 = math.max(var_315_0, arg_312_1.talkMaxDuration)

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_4 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - 0) / var_315_4

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= 0 + var_315_4 and arg_312_1.time_ < 0 + var_315_4 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play324171076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 324171076
		arg_316_1.duration_ = 3.8

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play324171077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0.3

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[1495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_1 = arg_316_1:GetWordFromCfg(324171076)
				local var_319_2 = arg_316_1:FormatText(var_319_1.content)

				arg_316_1.text_.text = var_319_2

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_4 = 12 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 12)

				if (12 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 12)) > 0 and var_319_0 < var_319_4 then
					arg_316_1.talkMaxDuration = var_319_4

					if var_319_4 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_4 + 0
					end
				end

				arg_316_1.text_.text = var_319_2
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171076", "story_v_out_324171.awb") ~= 0 then
					local var_319_5 = manager.audio:GetVoiceLength("story_v_out_324171", "324171076", "story_v_out_324171.awb") / 1000

					if var_319_5 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_5 + 0
					end

					if var_319_1.prefab_name ~= "" and arg_316_1.actors_[var_319_1.prefab_name] ~= nil then
						local var_319_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_1.prefab_name].transform, "story_v_out_324171", "324171076", "story_v_out_324171.awb")

						arg_316_1:RecordAudio("324171076", var_319_6)
						arg_316_1:RecordAudio("324171076", var_319_6)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_324171", "324171076", "story_v_out_324171.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_324171", "324171076", "story_v_out_324171.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_7 = math.max(var_319_0, arg_316_1.talkMaxDuration)

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_7 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - 0) / var_319_7

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= 0 + var_319_7 and arg_316_1.time_ < 0 + var_319_7 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play324171077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 324171077
		arg_320_1.duration_ = 3.2

		local var_320_0 = {
			zh = 2.8,
			ja = 3.2
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play324171078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.3

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[1494].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_lolia")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_1 = arg_320_1:GetWordFromCfg(324171077)
				local var_323_2 = arg_320_1:FormatText(var_323_1.content)

				arg_320_1.text_.text = var_323_2

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 12 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 12)

				if (12 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 12)) > 0 and var_323_0 < var_323_4 then
					arg_320_1.talkMaxDuration = var_323_4

					if var_323_4 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_4 + 0
					end
				end

				arg_320_1.text_.text = var_323_2
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171077", "story_v_out_324171.awb") ~= 0 then
					local var_323_5 = manager.audio:GetVoiceLength("story_v_out_324171", "324171077", "story_v_out_324171.awb") / 1000

					if var_323_5 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_5 + 0
					end

					if var_323_1.prefab_name ~= "" and arg_320_1.actors_[var_323_1.prefab_name] ~= nil then
						local var_323_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_1.prefab_name].transform, "story_v_out_324171", "324171077", "story_v_out_324171.awb")

						arg_320_1:RecordAudio("324171077", var_323_6)
						arg_320_1:RecordAudio("324171077", var_323_6)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_324171", "324171077", "story_v_out_324171.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_324171", "324171077", "story_v_out_324171.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_7 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_7 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_7

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_7 and arg_320_1.time_ < 0 + var_323_7 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play324171078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 324171078
		arg_324_1.duration_ = 3.83

		local var_324_0 = {
			zh = 3.266,
			ja = 3.833
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play324171079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0.3

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[1496].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_1 = arg_324_1:GetWordFromCfg(324171078)
				local var_327_2 = arg_324_1:FormatText(var_327_1.content)

				arg_324_1.text_.text = var_327_2

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_4 = 12 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_2) / 12)

				if (12 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_2) / 12)) > 0 and var_327_0 < var_327_4 then
					arg_324_1.talkMaxDuration = var_327_4

					if var_327_4 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_4 + 0
					end
				end

				arg_324_1.text_.text = var_327_2
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171078", "story_v_out_324171.awb") ~= 0 then
					local var_327_5 = manager.audio:GetVoiceLength("story_v_out_324171", "324171078", "story_v_out_324171.awb") / 1000

					if var_327_5 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_5 + 0
					end

					if var_327_1.prefab_name ~= "" and arg_324_1.actors_[var_327_1.prefab_name] ~= nil then
						local var_327_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_1.prefab_name].transform, "story_v_out_324171", "324171078", "story_v_out_324171.awb")

						arg_324_1:RecordAudio("324171078", var_327_6)
						arg_324_1:RecordAudio("324171078", var_327_6)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_324171", "324171078", "story_v_out_324171.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_324171", "324171078", "story_v_out_324171.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_7 = math.max(var_327_0, arg_324_1.talkMaxDuration)

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_7 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - 0) / var_327_7

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= 0 + var_327_7 and arg_324_1.time_ < 0 + var_327_7 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play324171079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 324171079
		arg_328_1.duration_ = 3.7

		local var_328_0 = {
			zh = 2.966,
			ja = 3.7
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play324171080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(arg_328_1.actors_["1170ui_story"]) and arg_328_1.var_.characterEffect1170ui_story == nil then
				arg_328_1.var_.characterEffect1170ui_story = arg_328_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_0 = 0.200000002980232

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 and not isNil(arg_328_1.actors_["1170ui_story"]) then
				if arg_328_1.var_.characterEffect1170ui_story and not isNil(arg_328_1.actors_["1170ui_story"]) then
					arg_328_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 and not isNil(arg_328_1.actors_["1170ui_story"]) and arg_328_1.var_.characterEffect1170ui_story then
				arg_328_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_331_2 = 0
			local var_331_3 = 0.35

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_2 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1170")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_4 = arg_328_1:GetWordFromCfg(324171079)
				local var_331_5 = arg_328_1:FormatText(var_331_4.content)

				arg_328_1.text_.text = var_331_5

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_7 = 14 <= 0 and var_331_3 or var_331_3 * (utf8.len(var_331_5) / 14)

				if (14 <= 0 and var_331_3 or var_331_3 * (utf8.len(var_331_5) / 14)) > 0 and var_331_3 < var_331_7 then
					arg_328_1.talkMaxDuration = var_331_7

					if var_331_7 + var_331_2 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_7 + var_331_2
					end
				end

				arg_328_1.text_.text = var_331_5
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171079", "story_v_out_324171.awb") ~= 0 then
					local var_331_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171079", "story_v_out_324171.awb") / 1000

					if var_331_8 + var_331_2 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_8 + var_331_2
					end

					if var_331_4.prefab_name ~= "" and arg_328_1.actors_[var_331_4.prefab_name] ~= nil then
						local var_331_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_4.prefab_name].transform, "story_v_out_324171", "324171079", "story_v_out_324171.awb")

						arg_328_1:RecordAudio("324171079", var_331_9)
						arg_328_1:RecordAudio("324171079", var_331_9)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_324171", "324171079", "story_v_out_324171.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_324171", "324171079", "story_v_out_324171.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_10 = math.max(var_331_3, arg_328_1.talkMaxDuration)

			if var_331_2 <= arg_328_1.time_ and arg_328_1.time_ < var_331_2 + var_331_10 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_2) / var_331_10

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_2 + var_331_10 and arg_328_1.time_ < var_331_2 + var_331_10 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play324171080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 324171080
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play324171081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(arg_332_1.actors_["1170ui_story"]) and arg_332_1.var_.characterEffect1170ui_story == nil then
				arg_332_1.var_.characterEffect1170ui_story = arg_332_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_0 = 0.200000002980232

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 and not isNil(arg_332_1.actors_["1170ui_story"]) then
				if arg_332_1.var_.characterEffect1170ui_story and not isNil(arg_332_1.actors_["1170ui_story"]) then
					arg_332_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_332_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_332_1.time_ - 0) / var_335_0)
				end
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 and not isNil(arg_332_1.actors_["1170ui_story"]) and arg_332_1.var_.characterEffect1170ui_story then
				arg_332_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_332_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_335_1 = 0
			local var_335_2 = 0.8

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_3 = arg_332_1:FormatText(arg_332_1:GetWordFromCfg(324171080).content)

				arg_332_1.text_.text = var_335_3

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_5 = 32 <= 0 and var_335_2 or var_335_2 * (utf8.len(var_335_3) / 32)

				if (32 <= 0 and var_335_2 or var_335_2 * (utf8.len(var_335_3) / 32)) > 0 and var_335_2 < var_335_5 then
					arg_332_1.talkMaxDuration = var_335_5

					if var_335_5 + var_335_1 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_5 + var_335_1
					end
				end

				arg_332_1.text_.text = var_335_3
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_6 = math.max(var_335_2, arg_332_1.talkMaxDuration)

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_6 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_1) / var_335_6

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_1 + var_335_6 and arg_332_1.time_ < var_335_1 + var_335_6 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play324171081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 324171081
		arg_336_1.duration_ = 2.9

		local var_336_0 = {
			zh = 2.3,
			ja = 2.9
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play324171082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0.25

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[1494].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_lolia")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_1 = arg_336_1:GetWordFromCfg(324171081)
				local var_339_2 = arg_336_1:FormatText(var_339_1.content)

				arg_336_1.text_.text = var_339_2

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_4 = 10 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_2) / 10)

				if (10 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_2) / 10)) > 0 and var_339_0 < var_339_4 then
					arg_336_1.talkMaxDuration = var_339_4

					if var_339_4 + 0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_4 + 0
					end
				end

				arg_336_1.text_.text = var_339_2
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171081", "story_v_out_324171.awb") ~= 0 then
					local var_339_5 = manager.audio:GetVoiceLength("story_v_out_324171", "324171081", "story_v_out_324171.awb") / 1000

					if var_339_5 + 0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_5 + 0
					end

					if var_339_1.prefab_name ~= "" and arg_336_1.actors_[var_339_1.prefab_name] ~= nil then
						local var_339_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_1.prefab_name].transform, "story_v_out_324171", "324171081", "story_v_out_324171.awb")

						arg_336_1:RecordAudio("324171081", var_339_6)
						arg_336_1:RecordAudio("324171081", var_339_6)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_324171", "324171081", "story_v_out_324171.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_324171", "324171081", "story_v_out_324171.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_7 = math.max(var_339_0, arg_336_1.talkMaxDuration)

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_7 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - 0) / var_339_7

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= 0 + var_339_7 and arg_336_1.time_ < 0 + var_339_7 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play324171082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 324171082
		arg_340_1.duration_ = 3.93

		local var_340_0 = {
			zh = 3.5,
			ja = 3.933
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play324171083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.var_.moveOldPos1170ui_story = arg_340_1.actors_["1170ui_story"].transform.localPosition

				local var_343_0 = GameObjectTools.GetOrAddComponent(arg_340_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_343_0 then
					var_343_0:EnableDynamicBone(false)
				end
			end

			local var_343_1 = 0.001

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_1 then
				arg_340_1.actors_["1170ui_story"].transform.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1170ui_story, Vector3.New(0.03, -0.95, -6.08), (arg_340_1.time_ - 0) / var_343_1)
				arg_340_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_340_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1170ui_story"].transform.position).z)
				arg_340_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_340_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_340_1.actors_["1170ui_story"].transform.localEulerAngles = arg_340_1.actors_["1170ui_story"].transform.localEulerAngles
			end

			if arg_340_1.time_ >= 0 + var_343_1 and arg_340_1.time_ < 0 + var_343_1 + arg_343_0 then
				arg_340_1.actors_["1170ui_story"].transform.localPosition = Vector3.New(0.03, -0.95, -6.08)
				arg_340_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_340_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1170ui_story"].transform.position).z)
				arg_340_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_340_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_340_1.actors_["1170ui_story"].transform.localEulerAngles = arg_340_1.actors_["1170ui_story"].transform.localEulerAngles

				local var_343_2 = GameObjectTools.GetOrAddComponent(arg_340_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_343_2 then
					var_343_2:EnableDynamicBone(true)
				end
			end

			local var_343_3 = arg_340_1.actors_["1170ui_story"]

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(var_343_3) and arg_340_1.var_.characterEffect1170ui_story == nil then
				arg_340_1.var_.characterEffect1170ui_story = var_343_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_4 = 0.200000002980232

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_4 and not isNil(var_343_3) then
				if arg_340_1.var_.characterEffect1170ui_story and not isNil(var_343_3) then
					arg_340_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= 0 + var_343_4 and arg_340_1.time_ < 0 + var_343_4 + arg_343_0 and not isNil(var_343_3) and arg_340_1.var_.characterEffect1170ui_story then
				arg_340_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action5_1")
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_343_6 = 0
			local var_343_7 = 0.425

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_6 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_8 = arg_340_1:GetWordFromCfg(324171082)
				local var_343_9 = arg_340_1:FormatText(var_343_8.content)

				arg_340_1.text_.text = var_343_9

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_11 = 17 <= 0 and var_343_7 or var_343_7 * (utf8.len(var_343_9) / 17)

				if (17 <= 0 and var_343_7 or var_343_7 * (utf8.len(var_343_9) / 17)) > 0 and var_343_7 < var_343_11 then
					arg_340_1.talkMaxDuration = var_343_11

					if var_343_11 + var_343_6 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_11 + var_343_6
					end
				end

				arg_340_1.text_.text = var_343_9
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171082", "story_v_out_324171.awb") ~= 0 then
					local var_343_12 = manager.audio:GetVoiceLength("story_v_out_324171", "324171082", "story_v_out_324171.awb") / 1000

					if var_343_12 + var_343_6 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_12 + var_343_6
					end

					if var_343_8.prefab_name ~= "" and arg_340_1.actors_[var_343_8.prefab_name] ~= nil then
						local var_343_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_8.prefab_name].transform, "story_v_out_324171", "324171082", "story_v_out_324171.awb")

						arg_340_1:RecordAudio("324171082", var_343_13)
						arg_340_1:RecordAudio("324171082", var_343_13)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_324171", "324171082", "story_v_out_324171.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_324171", "324171082", "story_v_out_324171.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_14 = math.max(var_343_7, arg_340_1.talkMaxDuration)

			if var_343_6 <= arg_340_1.time_ and arg_340_1.time_ < var_343_6 + var_343_14 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_6) / var_343_14

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_6 + var_343_14 and arg_340_1.time_ < var_343_6 + var_343_14 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play324171083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 324171083
		arg_344_1.duration_ = 5.27

		local var_344_0 = {
			zh = 2.733,
			ja = 5.266
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play324171084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(arg_344_1.actors_["1170ui_story"]) and arg_344_1.var_.characterEffect1170ui_story == nil then
				arg_344_1.var_.characterEffect1170ui_story = arg_344_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_0 = 0.200000002980232

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_0 and not isNil(arg_344_1.actors_["1170ui_story"]) then
				if arg_344_1.var_.characterEffect1170ui_story and not isNil(arg_344_1.actors_["1170ui_story"]) then
					arg_344_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_344_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_344_1.time_ - 0) / var_347_0)
				end
			end

			if arg_344_1.time_ >= 0 + var_347_0 and arg_344_1.time_ < 0 + var_347_0 + arg_347_0 and not isNil(arg_344_1.actors_["1170ui_story"]) and arg_344_1.var_.characterEffect1170ui_story then
				arg_344_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_344_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_347_1 = 0
			local var_347_2 = 0.425

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[1494].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, true)
				arg_344_1.iconController_:SetSelectedState("hero")

				arg_344_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_lolia")

				arg_344_1.callingController_:SetSelectedState("normal")

				arg_344_1.keyicon_.color = Color.New(1, 1, 1)
				arg_344_1.icon_.color = Color.New(1, 1, 1)

				local var_347_3 = arg_344_1:GetWordFromCfg(324171083)
				local var_347_4 = arg_344_1:FormatText(var_347_3.content)

				arg_344_1.text_.text = var_347_4

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_6 = 17 <= 0 and var_347_2 or var_347_2 * (utf8.len(var_347_4) / 17)

				if (17 <= 0 and var_347_2 or var_347_2 * (utf8.len(var_347_4) / 17)) > 0 and var_347_2 < var_347_6 then
					arg_344_1.talkMaxDuration = var_347_6

					if var_347_6 + var_347_1 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_6 + var_347_1
					end
				end

				arg_344_1.text_.text = var_347_4
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171083", "story_v_out_324171.awb") ~= 0 then
					local var_347_7 = manager.audio:GetVoiceLength("story_v_out_324171", "324171083", "story_v_out_324171.awb") / 1000

					if var_347_7 + var_347_1 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_7 + var_347_1
					end

					if var_347_3.prefab_name ~= "" and arg_344_1.actors_[var_347_3.prefab_name] ~= nil then
						local var_347_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_3.prefab_name].transform, "story_v_out_324171", "324171083", "story_v_out_324171.awb")

						arg_344_1:RecordAudio("324171083", var_347_8)
						arg_344_1:RecordAudio("324171083", var_347_8)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_324171", "324171083", "story_v_out_324171.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_324171", "324171083", "story_v_out_324171.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_9 = math.max(var_347_2, arg_344_1.talkMaxDuration)

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_9 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_1) / var_347_9

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_1 + var_347_9 and arg_344_1.time_ < var_347_1 + var_347_9 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play324171084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 324171084
		arg_348_1.duration_ = 7.83

		local var_348_0 = {
			zh = 6.7,
			ja = 7.833
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play324171085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(arg_348_1.actors_["1170ui_story"]) and arg_348_1.var_.characterEffect1170ui_story == nil then
				arg_348_1.var_.characterEffect1170ui_story = arg_348_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_0 = 0.200000002980232

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_0 and not isNil(arg_348_1.actors_["1170ui_story"]) then
				if arg_348_1.var_.characterEffect1170ui_story and not isNil(arg_348_1.actors_["1170ui_story"]) then
					arg_348_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_348_1.time_ >= 0 + var_351_0 and arg_348_1.time_ < 0 + var_351_0 + arg_351_0 and not isNil(arg_348_1.actors_["1170ui_story"]) and arg_348_1.var_.characterEffect1170ui_story then
				arg_348_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_351_2 = 0
			local var_351_3 = 0.825

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_2 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_4 = arg_348_1:GetWordFromCfg(324171084)
				local var_351_5 = arg_348_1:FormatText(var_351_4.content)

				arg_348_1.text_.text = var_351_5

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_7 = 33 <= 0 and var_351_3 or var_351_3 * (utf8.len(var_351_5) / 33)

				if (33 <= 0 and var_351_3 or var_351_3 * (utf8.len(var_351_5) / 33)) > 0 and var_351_3 < var_351_7 then
					arg_348_1.talkMaxDuration = var_351_7

					if var_351_7 + var_351_2 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_7 + var_351_2
					end
				end

				arg_348_1.text_.text = var_351_5
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171084", "story_v_out_324171.awb") ~= 0 then
					local var_351_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171084", "story_v_out_324171.awb") / 1000

					if var_351_8 + var_351_2 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_8 + var_351_2
					end

					if var_351_4.prefab_name ~= "" and arg_348_1.actors_[var_351_4.prefab_name] ~= nil then
						local var_351_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_4.prefab_name].transform, "story_v_out_324171", "324171084", "story_v_out_324171.awb")

						arg_348_1:RecordAudio("324171084", var_351_9)
						arg_348_1:RecordAudio("324171084", var_351_9)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_324171", "324171084", "story_v_out_324171.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_324171", "324171084", "story_v_out_324171.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_10 = math.max(var_351_3, arg_348_1.talkMaxDuration)

			if var_351_2 <= arg_348_1.time_ and arg_348_1.time_ < var_351_2 + var_351_10 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_2) / var_351_10

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_2 + var_351_10 and arg_348_1.time_ < var_351_2 + var_351_10 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play324171085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 324171085
		arg_352_1.duration_ = 7.93

		local var_352_0 = {
			zh = 7.933,
			ja = 7.8
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play324171086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(arg_352_1.actors_["1170ui_story"]) and arg_352_1.var_.characterEffect1170ui_story == nil then
				arg_352_1.var_.characterEffect1170ui_story = arg_352_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_0 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 and not isNil(arg_352_1.actors_["1170ui_story"]) then
				if arg_352_1.var_.characterEffect1170ui_story and not isNil(arg_352_1.actors_["1170ui_story"]) then
					arg_352_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_352_1.time_ - 0) / var_355_0)
				end
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 and not isNil(arg_352_1.actors_["1170ui_story"]) and arg_352_1.var_.characterEffect1170ui_story then
				arg_352_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_355_1 = 0
			local var_355_2 = 0.65

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[1495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_3 = arg_352_1:GetWordFromCfg(324171085)
				local var_355_4 = arg_352_1:FormatText(var_355_3.content)

				arg_352_1.text_.text = var_355_4

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_6 = 26 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_4) / 26)

				if (26 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_4) / 26)) > 0 and var_355_2 < var_355_6 then
					arg_352_1.talkMaxDuration = var_355_6

					if var_355_6 + var_355_1 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_6 + var_355_1
					end
				end

				arg_352_1.text_.text = var_355_4
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171085", "story_v_out_324171.awb") ~= 0 then
					local var_355_7 = manager.audio:GetVoiceLength("story_v_out_324171", "324171085", "story_v_out_324171.awb") / 1000

					if var_355_7 + var_355_1 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_7 + var_355_1
					end

					if var_355_3.prefab_name ~= "" and arg_352_1.actors_[var_355_3.prefab_name] ~= nil then
						local var_355_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_3.prefab_name].transform, "story_v_out_324171", "324171085", "story_v_out_324171.awb")

						arg_352_1:RecordAudio("324171085", var_355_8)
						arg_352_1:RecordAudio("324171085", var_355_8)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_324171", "324171085", "story_v_out_324171.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_324171", "324171085", "story_v_out_324171.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_9 = math.max(var_355_2, arg_352_1.talkMaxDuration)

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_9 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_1) / var_355_9

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_1 + var_355_9 and arg_352_1.time_ < var_355_1 + var_355_9 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play324171086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 324171086
		arg_356_1.duration_ = 6.6

		local var_356_0 = {
			zh = 5.2,
			ja = 6.6
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play324171087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0.45

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[1496].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_1 = arg_356_1:GetWordFromCfg(324171086)
				local var_359_2 = arg_356_1:FormatText(var_359_1.content)

				arg_356_1.text_.text = var_359_2

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_4 = 18 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_2) / 18)

				if (18 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_2) / 18)) > 0 and var_359_0 < var_359_4 then
					arg_356_1.talkMaxDuration = var_359_4

					if var_359_4 + 0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_4 + 0
					end
				end

				arg_356_1.text_.text = var_359_2
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171086", "story_v_out_324171.awb") ~= 0 then
					local var_359_5 = manager.audio:GetVoiceLength("story_v_out_324171", "324171086", "story_v_out_324171.awb") / 1000

					if var_359_5 + 0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_5 + 0
					end

					if var_359_1.prefab_name ~= "" and arg_356_1.actors_[var_359_1.prefab_name] ~= nil then
						local var_359_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_1.prefab_name].transform, "story_v_out_324171", "324171086", "story_v_out_324171.awb")

						arg_356_1:RecordAudio("324171086", var_359_6)
						arg_356_1:RecordAudio("324171086", var_359_6)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_324171", "324171086", "story_v_out_324171.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_324171", "324171086", "story_v_out_324171.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_7 = math.max(var_359_0, arg_356_1.talkMaxDuration)

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_7 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - 0) / var_359_7

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= 0 + var_359_7 and arg_356_1.time_ < 0 + var_359_7 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play324171087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 324171087
		arg_360_1.duration_ = 4.67

		local var_360_0 = {
			zh = 4.333,
			ja = 4.666
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play324171088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(arg_360_1.actors_["1170ui_story"]) and arg_360_1.var_.characterEffect1170ui_story == nil then
				arg_360_1.var_.characterEffect1170ui_story = arg_360_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_0 = 0.200000002980232

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_0 and not isNil(arg_360_1.actors_["1170ui_story"]) then
				if arg_360_1.var_.characterEffect1170ui_story and not isNil(arg_360_1.actors_["1170ui_story"]) then
					arg_360_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= 0 + var_363_0 and arg_360_1.time_ < 0 + var_363_0 + arg_363_0 and not isNil(arg_360_1.actors_["1170ui_story"]) and arg_360_1.var_.characterEffect1170ui_story then
				arg_360_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170actionlink/1170action459")
			end

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_363_2 = 0
			local var_363_3 = 0.425

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_2 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_4 = arg_360_1:GetWordFromCfg(324171087)
				local var_363_5 = arg_360_1:FormatText(var_363_4.content)

				arg_360_1.text_.text = var_363_5

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_7 = 17 <= 0 and var_363_3 or var_363_3 * (utf8.len(var_363_5) / 17)

				if (17 <= 0 and var_363_3 or var_363_3 * (utf8.len(var_363_5) / 17)) > 0 and var_363_3 < var_363_7 then
					arg_360_1.talkMaxDuration = var_363_7

					if var_363_7 + var_363_2 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_7 + var_363_2
					end
				end

				arg_360_1.text_.text = var_363_5
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171087", "story_v_out_324171.awb") ~= 0 then
					local var_363_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171087", "story_v_out_324171.awb") / 1000

					if var_363_8 + var_363_2 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_8 + var_363_2
					end

					if var_363_4.prefab_name ~= "" and arg_360_1.actors_[var_363_4.prefab_name] ~= nil then
						local var_363_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_4.prefab_name].transform, "story_v_out_324171", "324171087", "story_v_out_324171.awb")

						arg_360_1:RecordAudio("324171087", var_363_9)
						arg_360_1:RecordAudio("324171087", var_363_9)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_324171", "324171087", "story_v_out_324171.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_324171", "324171087", "story_v_out_324171.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_10 = math.max(var_363_3, arg_360_1.talkMaxDuration)

			if var_363_2 <= arg_360_1.time_ and arg_360_1.time_ < var_363_2 + var_363_10 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_2) / var_363_10

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_2 + var_363_10 and arg_360_1.time_ < var_363_2 + var_363_10 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play324171088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 324171088
		arg_364_1.duration_ = 4.03

		local var_364_0 = {
			zh = 3.6,
			ja = 4.033
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play324171089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 and not isNil(arg_364_1.actors_["1170ui_story"]) and arg_364_1.var_.characterEffect1170ui_story == nil then
				arg_364_1.var_.characterEffect1170ui_story = arg_364_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_0 = 0.200000002980232

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_0 and not isNil(arg_364_1.actors_["1170ui_story"]) then
				if arg_364_1.var_.characterEffect1170ui_story and not isNil(arg_364_1.actors_["1170ui_story"]) then
					arg_364_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_364_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_364_1.time_ - 0) / var_367_0)
				end
			end

			if arg_364_1.time_ >= 0 + var_367_0 and arg_364_1.time_ < 0 + var_367_0 + arg_367_0 and not isNil(arg_364_1.actors_["1170ui_story"]) and arg_364_1.var_.characterEffect1170ui_story then
				arg_364_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_364_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_367_1 = 0
			local var_367_2 = 0.4

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[1494].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_lolia")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_3 = arg_364_1:GetWordFromCfg(324171088)
				local var_367_4 = arg_364_1:FormatText(var_367_3.content)

				arg_364_1.text_.text = var_367_4

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_6 = 16 <= 0 and var_367_2 or var_367_2 * (utf8.len(var_367_4) / 16)

				if (16 <= 0 and var_367_2 or var_367_2 * (utf8.len(var_367_4) / 16)) > 0 and var_367_2 < var_367_6 then
					arg_364_1.talkMaxDuration = var_367_6

					if var_367_6 + var_367_1 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_6 + var_367_1
					end
				end

				arg_364_1.text_.text = var_367_4
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171088", "story_v_out_324171.awb") ~= 0 then
					local var_367_7 = manager.audio:GetVoiceLength("story_v_out_324171", "324171088", "story_v_out_324171.awb") / 1000

					if var_367_7 + var_367_1 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_7 + var_367_1
					end

					if var_367_3.prefab_name ~= "" and arg_364_1.actors_[var_367_3.prefab_name] ~= nil then
						local var_367_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_3.prefab_name].transform, "story_v_out_324171", "324171088", "story_v_out_324171.awb")

						arg_364_1:RecordAudio("324171088", var_367_8)
						arg_364_1:RecordAudio("324171088", var_367_8)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_324171", "324171088", "story_v_out_324171.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_324171", "324171088", "story_v_out_324171.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_9 = math.max(var_367_2, arg_364_1.talkMaxDuration)

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_9 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_1) / var_367_9

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_1 + var_367_9 and arg_364_1.time_ < var_367_1 + var_367_9 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play324171089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 324171089
		arg_368_1.duration_ = 3.8

		local var_368_0 = {
			zh = 2.966,
			ja = 3.8
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play324171090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(arg_368_1.actors_["1170ui_story"]) and arg_368_1.var_.characterEffect1170ui_story == nil then
				arg_368_1.var_.characterEffect1170ui_story = arg_368_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_0 = 0.200000002980232

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_0 and not isNil(arg_368_1.actors_["1170ui_story"]) then
				if arg_368_1.var_.characterEffect1170ui_story and not isNil(arg_368_1.actors_["1170ui_story"]) then
					arg_368_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_368_1.time_ >= 0 + var_371_0 and arg_368_1.time_ < 0 + var_371_0 + arg_371_0 and not isNil(arg_368_1.actors_["1170ui_story"]) and arg_368_1.var_.characterEffect1170ui_story then
				arg_368_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action9_2")
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_371_2 = 0
			local var_371_3 = 0.3

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_2 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_4 = arg_368_1:GetWordFromCfg(324171089)
				local var_371_5 = arg_368_1:FormatText(var_371_4.content)

				arg_368_1.text_.text = var_371_5

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_7 = 12 <= 0 and var_371_3 or var_371_3 * (utf8.len(var_371_5) / 12)

				if (12 <= 0 and var_371_3 or var_371_3 * (utf8.len(var_371_5) / 12)) > 0 and var_371_3 < var_371_7 then
					arg_368_1.talkMaxDuration = var_371_7

					if var_371_7 + var_371_2 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_7 + var_371_2
					end
				end

				arg_368_1.text_.text = var_371_5
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171089", "story_v_out_324171.awb") ~= 0 then
					local var_371_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171089", "story_v_out_324171.awb") / 1000

					if var_371_8 + var_371_2 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_8 + var_371_2
					end

					if var_371_4.prefab_name ~= "" and arg_368_1.actors_[var_371_4.prefab_name] ~= nil then
						local var_371_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_4.prefab_name].transform, "story_v_out_324171", "324171089", "story_v_out_324171.awb")

						arg_368_1:RecordAudio("324171089", var_371_9)
						arg_368_1:RecordAudio("324171089", var_371_9)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_324171", "324171089", "story_v_out_324171.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_324171", "324171089", "story_v_out_324171.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_10 = math.max(var_371_3, arg_368_1.talkMaxDuration)

			if var_371_2 <= arg_368_1.time_ and arg_368_1.time_ < var_371_2 + var_371_10 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_2) / var_371_10

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_2 + var_371_10 and arg_368_1.time_ < var_371_2 + var_371_10 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play324171090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 324171090
		arg_372_1.duration_ = 4.03

		local var_372_0 = {
			zh = 4.033,
			ja = 3
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play324171091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(arg_372_1.actors_["1170ui_story"]) and arg_372_1.var_.characterEffect1170ui_story == nil then
				arg_372_1.var_.characterEffect1170ui_story = arg_372_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_0 = 0.200000002980232

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 and not isNil(arg_372_1.actors_["1170ui_story"]) then
				if arg_372_1.var_.characterEffect1170ui_story and not isNil(arg_372_1.actors_["1170ui_story"]) then
					arg_372_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_372_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_372_1.time_ - 0) / var_375_0)
				end
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 and not isNil(arg_372_1.actors_["1170ui_story"]) and arg_372_1.var_.characterEffect1170ui_story then
				arg_372_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_372_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_375_1 = 0
			local var_375_2 = 0.35

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[1494].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_lolia")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_3 = arg_372_1:GetWordFromCfg(324171090)
				local var_375_4 = arg_372_1:FormatText(var_375_3.content)

				arg_372_1.text_.text = var_375_4

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_6 = 14 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_4) / 14)

				if (14 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_4) / 14)) > 0 and var_375_2 < var_375_6 then
					arg_372_1.talkMaxDuration = var_375_6

					if var_375_6 + var_375_1 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_6 + var_375_1
					end
				end

				arg_372_1.text_.text = var_375_4
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171090", "story_v_out_324171.awb") ~= 0 then
					local var_375_7 = manager.audio:GetVoiceLength("story_v_out_324171", "324171090", "story_v_out_324171.awb") / 1000

					if var_375_7 + var_375_1 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_7 + var_375_1
					end

					if var_375_3.prefab_name ~= "" and arg_372_1.actors_[var_375_3.prefab_name] ~= nil then
						local var_375_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_3.prefab_name].transform, "story_v_out_324171", "324171090", "story_v_out_324171.awb")

						arg_372_1:RecordAudio("324171090", var_375_8)
						arg_372_1:RecordAudio("324171090", var_375_8)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_324171", "324171090", "story_v_out_324171.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_324171", "324171090", "story_v_out_324171.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_9 = math.max(var_375_2, arg_372_1.talkMaxDuration)

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_9 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_1) / var_375_9

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_1 + var_375_9 and arg_372_1.time_ < var_375_1 + var_375_9 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play324171091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 324171091
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play324171092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.var_.moveOldPos1170ui_story = arg_376_1.actors_["1170ui_story"].transform.localPosition

				local var_379_0 = GameObjectTools.GetOrAddComponent(arg_376_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_379_0 then
					var_379_0:EnableDynamicBone(false)
				end
			end

			local var_379_1 = 0.001

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_1 then
				arg_376_1.actors_["1170ui_story"].transform.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1170ui_story, Vector3.New(0, 100, 0), (arg_376_1.time_ - 0) / var_379_1)
				arg_376_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_376_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1170ui_story"].transform.position).z)
				arg_376_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_376_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_376_1.actors_["1170ui_story"].transform.localEulerAngles = arg_376_1.actors_["1170ui_story"].transform.localEulerAngles
			end

			if arg_376_1.time_ >= 0 + var_379_1 and arg_376_1.time_ < 0 + var_379_1 + arg_379_0 then
				arg_376_1.actors_["1170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_376_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_376_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1170ui_story"].transform.position).z)
				arg_376_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_376_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_376_1.actors_["1170ui_story"].transform.localEulerAngles = arg_376_1.actors_["1170ui_story"].transform.localEulerAngles

				local var_379_2 = GameObjectTools.GetOrAddComponent(arg_376_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_379_2 then
					var_379_2:EnableDynamicBone(true)
				end
			end

			local var_379_3 = 0
			local var_379_4 = 0.8

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_3 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_5 = arg_376_1:FormatText(arg_376_1:GetWordFromCfg(324171091).content)

				arg_376_1.text_.text = var_379_5

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_7 = 32 <= 0 and var_379_4 or var_379_4 * (utf8.len(var_379_5) / 32)

				if (32 <= 0 and var_379_4 or var_379_4 * (utf8.len(var_379_5) / 32)) > 0 and var_379_4 < var_379_7 then
					arg_376_1.talkMaxDuration = var_379_7

					if var_379_7 + var_379_3 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_7 + var_379_3
					end
				end

				arg_376_1.text_.text = var_379_5
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_8 = math.max(var_379_4, arg_376_1.talkMaxDuration)

			if var_379_3 <= arg_376_1.time_ and arg_376_1.time_ < var_379_3 + var_379_8 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_3) / var_379_8

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_3 + var_379_8 and arg_376_1.time_ < var_379_3 + var_379_8 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_376_1:InitPlayNodeList()
	end,
	Play324171092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 324171092
		arg_380_1.duration_ = 4.63

		local var_380_0 = {
			zh = 3.4,
			ja = 4.633
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play324171093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0.425

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[1494].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_lolia")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_1 = arg_380_1:GetWordFromCfg(324171092)
				local var_383_2 = arg_380_1:FormatText(var_383_1.content)

				arg_380_1.text_.text = var_383_2

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_4 = 17 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_2) / 17)

				if (17 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_2) / 17)) > 0 and var_383_0 < var_383_4 then
					arg_380_1.talkMaxDuration = var_383_4

					if var_383_4 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_4 + 0
					end
				end

				arg_380_1.text_.text = var_383_2
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171092", "story_v_out_324171.awb") ~= 0 then
					local var_383_5 = manager.audio:GetVoiceLength("story_v_out_324171", "324171092", "story_v_out_324171.awb") / 1000

					if var_383_5 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_5 + 0
					end

					if var_383_1.prefab_name ~= "" and arg_380_1.actors_[var_383_1.prefab_name] ~= nil then
						local var_383_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_1.prefab_name].transform, "story_v_out_324171", "324171092", "story_v_out_324171.awb")

						arg_380_1:RecordAudio("324171092", var_383_6)
						arg_380_1:RecordAudio("324171092", var_383_6)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_324171", "324171092", "story_v_out_324171.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_324171", "324171092", "story_v_out_324171.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_7 = math.max(var_383_0, arg_380_1.talkMaxDuration)

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_7 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - 0) / var_383_7

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= 0 + var_383_7 and arg_380_1.time_ < 0 + var_383_7 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play324171093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 324171093
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play324171094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0.2 < arg_384_1.time_ and arg_384_1.time_ <= 0.2 + arg_387_0 then
				arg_384_1:AudioAction("play", "effect", "se_story_150", "se_story_150_bamboo02", "")
			end

			local var_387_1 = 0
			local var_387_2 = 1.2

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, false)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_3 = arg_384_1:FormatText(arg_384_1:GetWordFromCfg(324171093).content)

				arg_384_1.text_.text = var_387_3

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_5 = 48 <= 0 and var_387_2 or var_387_2 * (utf8.len(var_387_3) / 48)

				if (48 <= 0 and var_387_2 or var_387_2 * (utf8.len(var_387_3) / 48)) > 0 and var_387_2 < var_387_5 then
					arg_384_1.talkMaxDuration = var_387_5

					if var_387_5 + var_387_1 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_5 + var_387_1
					end
				end

				arg_384_1.text_.text = var_387_3
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_6 = math.max(var_387_2, arg_384_1.talkMaxDuration)

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_6 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_1) / var_387_6

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_1 + var_387_6 and arg_384_1.time_ < var_387_1 + var_387_6 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play324171094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 324171094
		arg_388_1.duration_ = 2.27

		local var_388_0 = {
			zh = 2.266,
			ja = 1.466
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play324171095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 0.125

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_1 = arg_388_1:GetWordFromCfg(324171094)
				local var_391_2 = arg_388_1:FormatText(var_391_1.content)

				arg_388_1.text_.text = var_391_2

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_4 = 5 <= 0 and var_391_0 or var_391_0 * (utf8.len(var_391_2) / 5)

				if (5 <= 0 and var_391_0 or var_391_0 * (utf8.len(var_391_2) / 5)) > 0 and var_391_0 < var_391_4 then
					arg_388_1.talkMaxDuration = var_391_4

					if var_391_4 + 0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_4 + 0
					end
				end

				arg_388_1.text_.text = var_391_2
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171094", "story_v_out_324171.awb") ~= 0 then
					local var_391_5 = manager.audio:GetVoiceLength("story_v_out_324171", "324171094", "story_v_out_324171.awb") / 1000

					if var_391_5 + 0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_5 + 0
					end

					if var_391_1.prefab_name ~= "" and arg_388_1.actors_[var_391_1.prefab_name] ~= nil then
						local var_391_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_1.prefab_name].transform, "story_v_out_324171", "324171094", "story_v_out_324171.awb")

						arg_388_1:RecordAudio("324171094", var_391_6)
						arg_388_1:RecordAudio("324171094", var_391_6)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_324171", "324171094", "story_v_out_324171.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_324171", "324171094", "story_v_out_324171.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_7 = math.max(var_391_0, arg_388_1.talkMaxDuration)

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_7 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - 0) / var_391_7

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= 0 + var_391_7 and arg_388_1.time_ < 0 + var_391_7 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play324171095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 324171095
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play324171096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 1.025

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, false)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_1 = arg_392_1:FormatText(arg_392_1:GetWordFromCfg(324171095).content)

				arg_392_1.text_.text = var_395_1

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_3 = 41 <= 0 and var_395_0 or var_395_0 * (utf8.len(var_395_1) / 41)

				if (41 <= 0 and var_395_0 or var_395_0 * (utf8.len(var_395_1) / 41)) > 0 and var_395_0 < var_395_3 then
					arg_392_1.talkMaxDuration = var_395_3

					if var_395_3 + 0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_3 + 0
					end
				end

				arg_392_1.text_.text = var_395_1
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_4 = math.max(var_395_0, arg_392_1.talkMaxDuration)

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_4 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - 0) / var_395_4

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= 0 + var_395_4 and arg_392_1.time_ < 0 + var_395_4 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play324171096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 324171096
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play324171097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0.9

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, false)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_1 = arg_396_1:FormatText(arg_396_1:GetWordFromCfg(324171096).content)

				arg_396_1.text_.text = var_399_1

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_3 = 36 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_1) / 36)

				if (36 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_1) / 36)) > 0 and var_399_0 < var_399_3 then
					arg_396_1.talkMaxDuration = var_399_3

					if var_399_3 + 0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_3 + 0
					end
				end

				arg_396_1.text_.text = var_399_1
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_4 = math.max(var_399_0, arg_396_1.talkMaxDuration)

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_4 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - 0) / var_399_4

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= 0 + var_399_4 and arg_396_1.time_ < 0 + var_399_4 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play324171097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 324171097
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play324171098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0.6 < arg_400_1.time_ and arg_400_1.time_ <= 0.6 + arg_403_0 then
				arg_400_1:AudioAction("play", "effect", "se_story_150", "se_story_150_bamboo01", "")
			end

			local var_403_1 = 0
			local var_403_2 = 1.775

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, false)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_3 = arg_400_1:FormatText(arg_400_1:GetWordFromCfg(324171097).content)

				arg_400_1.text_.text = var_403_3

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_5 = 71 <= 0 and var_403_2 or var_403_2 * (utf8.len(var_403_3) / 71)

				if (71 <= 0 and var_403_2 or var_403_2 * (utf8.len(var_403_3) / 71)) > 0 and var_403_2 < var_403_5 then
					arg_400_1.talkMaxDuration = var_403_5

					if var_403_5 + var_403_1 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_5 + var_403_1
					end
				end

				arg_400_1.text_.text = var_403_3
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_6 = math.max(var_403_2, arg_400_1.talkMaxDuration)

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_6 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_1) / var_403_6

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_1 + var_403_6 and arg_400_1.time_ < var_403_1 + var_403_6 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play324171098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 324171098
		arg_404_1.duration_ = 2.13

		local var_404_0 = {
			zh = 2.066,
			ja = 2.133
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
			arg_404_1.auto_ = false
		end

		function arg_404_1.playNext_(arg_406_0)
			arg_404_1.onStoryFinished_()
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0.125

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_1 = arg_404_1:GetWordFromCfg(324171098)
				local var_407_2 = arg_404_1:FormatText(var_407_1.content)

				arg_404_1.text_.text = var_407_2

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_4 = 5 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_2) / 5)

				if (5 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_2) / 5)) > 0 and var_407_0 < var_407_4 then
					arg_404_1.talkMaxDuration = var_407_4

					if var_407_4 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_4 + 0
					end
				end

				arg_404_1.text_.text = var_407_2
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171098", "story_v_out_324171.awb") ~= 0 then
					local var_407_5 = manager.audio:GetVoiceLength("story_v_out_324171", "324171098", "story_v_out_324171.awb") / 1000

					if var_407_5 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_5 + 0
					end

					if var_407_1.prefab_name ~= "" and arg_404_1.actors_[var_407_1.prefab_name] ~= nil then
						local var_407_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_1.prefab_name].transform, "story_v_out_324171", "324171098", "story_v_out_324171.awb")

						arg_404_1:RecordAudio("324171098", var_407_6)
						arg_404_1:RecordAudio("324171098", var_407_6)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_324171", "324171098", "story_v_out_324171.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_324171", "324171098", "story_v_out_324171.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_7 = math.max(var_407_0, arg_404_1.talkMaxDuration)

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_7 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - 0) / var_407_7

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= 0 + var_407_7 and arg_404_1.time_ < 0 + var_407_7 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J15",
		"TextureConfig/Background/J13g",
		"TextureConfig/Background/ST2009"
	},
	voices = {
		"story_v_out_324171.awb"
	}
}
