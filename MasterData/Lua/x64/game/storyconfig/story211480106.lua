return {
	Play1104806001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1104806001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1104806002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B13 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13")
				var_4_0.name = "B13"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B13 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B13

				arg_1_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B13" then
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

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

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

			local var_4_14 = 1.999999999999
			local var_4_15 = 0.475

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1104806001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 19 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 19)

				if (19 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 19)) > 0 and var_4_15 < var_4_19 then
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
	Play1104806002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1104806002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1104806003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.3

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1104806002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 12 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 12)

				if (12 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 12)) > 0 and var_12_0 < var_12_3 then
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
	Play1104806003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1104806003
		arg_13_1.duration_ = 2

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1104806004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["114801ui_story"] == nil and not isNil((Asset.Load("Char/" .. "114801ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "114801ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "114801ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["114801ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["114801ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["114801ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["114801ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["114801ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos114801ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos114801ui_story, Vector3.New(0, -0.8, -6.2), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -0.8, -6.2)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["114801ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect114801ui_story == nil then
				arg_13_1.var_.characterEffect114801ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect114801ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect114801ui_story then
				arg_13_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_16_8 = 0
			local var_16_9 = 0.125

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(1104806003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 5 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 5)

				if (5 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 5)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806003", "story_v_side_new_1104806.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806003", "story_v_side_new_1104806.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_side_new_1104806", "1104806003", "story_v_side_new_1104806.awb")

						arg_13_1:RecordAudio("1104806003", var_16_15)
						arg_13_1:RecordAudio("1104806003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806003", "story_v_side_new_1104806.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806003", "story_v_side_new_1104806.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
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
	Play1104806004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1104806004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1104806005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos114801ui_story = arg_17_1.actors_["114801ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["114801ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos114801ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["114801ui_story"].transform.position).z)
				arg_17_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["114801ui_story"].transform.localEulerAngles = arg_17_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["114801ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["114801ui_story"].transform.position).z)
				arg_17_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["114801ui_story"].transform.localEulerAngles = arg_17_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["114801ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect114801ui_story == nil then
				arg_17_1.var_.characterEffect114801ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect114801ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_17_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_2)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect114801ui_story then
				arg_17_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_17_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			local var_20_3 = 0
			local var_20_4 = 0.925

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_3 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_5 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1104806004).content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 37 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 37)

				if (37 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 37)) > 0 and var_20_4 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_3 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_3
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_8 = math.max(var_20_4, arg_17_1.talkMaxDuration)

			if var_20_3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_3 + var_20_8 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_3) / var_20_8

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_3 + var_20_8 and arg_17_1.time_ < var_20_3 + var_20_8 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
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
	Play1104806005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1104806005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1104806006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.1

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1104806005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 44 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 44)

				if (44 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 44)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1104806006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1104806006
		arg_25_1.duration_ = 9

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1104806007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.bgs_.ST01 == nil then
				local var_28_0 = Object.Instantiate(arg_25_1.paintGo_)

				var_28_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01")
				var_28_0.name = "ST01"
				var_28_0.transform.parent = arg_25_1.stage_.transform
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.bgs_.ST01 = var_28_0
			end

			if 1.999999999999 < arg_25_1.time_ and arg_25_1.time_ <= 1.999999999999 + arg_28_0 then
				local var_28_1 = arg_25_1.bgs_.ST01

				arg_25_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_28_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_2 = var_28_1:GetComponent("SpriteRenderer")

				if var_28_2 and var_28_2.sprite then
					local var_28_3 = 2 * (var_28_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_28_1.transform.localScale = Vector3.New(var_28_3 / var_28_2.sprite.bounds.size.y < var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x and var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x or var_28_3 / var_28_2.sprite.bounds.size.y, var_28_3 / var_28_2.sprite.bounds.size.y < var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x and var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x or var_28_3 / var_28_2.sprite.bounds.size.y, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "ST01" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_4 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_5 = 2

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_5 then
				local var_28_6 = Color.New(0, 0, 0)

				var_28_6.a = Mathf.Lerp(0, 1, (arg_25_1.time_ - var_28_4) / var_28_5)
				arg_25_1.mask_.color = var_28_6
			end

			if arg_25_1.time_ >= var_28_4 + var_28_5 and arg_25_1.time_ < var_28_4 + var_28_5 + arg_28_0 then
				local var_28_7 = Color.New(0, 0, 0)

				var_28_7.a = 1
				arg_25_1.mask_.color = var_28_7
			end

			local var_28_8 = 2

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_9 = 2

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 then
				local var_28_10 = Color.New(0, 0, 0)

				var_28_10.a = Mathf.Lerp(1, 0, (arg_25_1.time_ - var_28_8) / var_28_9)
				arg_25_1.mask_.color = var_28_10
			end

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 then
				local var_28_11 = Color.New(0, 0, 0)

				arg_25_1.mask_.enabled = false
				var_28_11.a = 0
				arg_25_1.mask_.color = var_28_11
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_12 = 3.999999999999
			local var_28_13 = 0.225

			if 3.999999999999 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_14 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_14:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_15 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(1104806006).content)

				arg_25_1.text_.text = var_28_15

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_17 = 9 <= 0 and var_28_13 or var_28_13 * (utf8.len(var_28_15) / 9)

				if (9 <= 0 and var_28_13 or var_28_13 * (utf8.len(var_28_15) / 9)) > 0 and var_28_13 < var_28_17 then
					arg_25_1.talkMaxDuration = var_28_17
					var_28_12 = var_28_12 + 0.3

					if var_28_17 + var_28_12 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_17 + var_28_12
					end
				end

				arg_25_1.text_.text = var_28_15
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_18 = var_28_12 + 0.3
			local var_28_19 = math.max(var_28_13, arg_25_1.talkMaxDuration)

			if var_28_12 + 0.3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_18 + var_28_19 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_18) / var_28_19

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_18 + var_28_19 and arg_25_1.time_ < var_28_18 + var_28_19 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1104806007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 1104806007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play1104806008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.35

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_1 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(1104806007).content)

				arg_31_1.text_.text = var_34_1

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_3 = 14 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 14)

				if (14 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 14)) > 0 and var_34_0 < var_34_3 then
					arg_31_1.talkMaxDuration = var_34_3

					if var_34_3 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_3 + 0
					end
				end

				arg_31_1.text_.text = var_34_1
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_4 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_4

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play1104806008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 1104806008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play1104806009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.475

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_1 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(1104806008).content)

				arg_35_1.text_.text = var_38_1

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_3 = 19 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 19)

				if (19 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 19)) > 0 and var_38_0 < var_38_3 then
					arg_35_1.talkMaxDuration = var_38_3

					if var_38_3 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_3 + 0
					end
				end

				arg_35_1.text_.text = var_38_1
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_4 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_4

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play1104806009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 1104806009
		arg_39_1.duration_ = 7.37

		local var_39_0 = {
			zh = 6.566,
			ja = 7.366
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
				arg_39_0:Play1104806010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 2 < arg_39_1.time_ and arg_39_1.time_ <= 2 + arg_42_0 then
				local var_42_0 = arg_39_1.bgs_.B13

				arg_39_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_42_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_42_1 = var_42_0:GetComponent("SpriteRenderer")

				if var_42_1 and var_42_1.sprite then
					local var_42_2 = 2 * (var_42_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_42_0.transform.localScale = Vector3.New(var_42_2 / var_42_1.sprite.bounds.size.y < var_42_2 * manager.ui.mainCameraCom_.aspect / var_42_1.sprite.bounds.size.x and var_42_2 * manager.ui.mainCameraCom_.aspect / var_42_1.sprite.bounds.size.x or var_42_2 / var_42_1.sprite.bounds.size.y, var_42_2 / var_42_1.sprite.bounds.size.y < var_42_2 * manager.ui.mainCameraCom_.aspect / var_42_1.sprite.bounds.size.x and var_42_2 * manager.ui.mainCameraCom_.aspect / var_42_1.sprite.bounds.size.x or var_42_2 / var_42_1.sprite.bounds.size.y, 0)
				end

				for iter_42_0, iter_42_1 in pairs(arg_39_1.bgs_) do
					if iter_42_0 ~= "B13" then
						iter_42_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_42_3 = 0

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_3 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_4 = 2

			if var_42_3 <= arg_39_1.time_ and arg_39_1.time_ < var_42_3 + var_42_4 then
				local var_42_5 = Color.New(0, 0, 0)

				var_42_5.a = Mathf.Lerp(0, 1, (arg_39_1.time_ - var_42_3) / var_42_4)
				arg_39_1.mask_.color = var_42_5
			end

			if arg_39_1.time_ >= var_42_3 + var_42_4 and arg_39_1.time_ < var_42_3 + var_42_4 + arg_42_0 then
				local var_42_6 = Color.New(0, 0, 0)

				var_42_6.a = 1
				arg_39_1.mask_.color = var_42_6
			end

			local var_42_7 = 2

			if 2 < arg_39_1.time_ and arg_39_1.time_ <= var_42_7 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_8 = 2

			if var_42_7 <= arg_39_1.time_ and arg_39_1.time_ < var_42_7 + var_42_8 then
				local var_42_9 = Color.New(0, 0, 0)

				var_42_9.a = Mathf.Lerp(1, 0, (arg_39_1.time_ - var_42_7) / var_42_8)
				arg_39_1.mask_.color = var_42_9
			end

			if arg_39_1.time_ >= var_42_7 + var_42_8 and arg_39_1.time_ < var_42_7 + var_42_8 + arg_42_0 then
				local var_42_10 = Color.New(0, 0, 0)

				arg_39_1.mask_.enabled = false
				var_42_10.a = 0
				arg_39_1.mask_.color = var_42_10
			end

			local var_42_11 = arg_39_1.actors_["114801ui_story"].transform

			if 3.8 < arg_39_1.time_ and arg_39_1.time_ <= 3.8 + arg_42_0 then
				arg_39_1.var_.moveOldPos114801ui_story = var_42_11.localPosition
			end

			local var_42_12 = 0.001

			if 3.8 <= arg_39_1.time_ and arg_39_1.time_ < 3.8 + var_42_12 then
				var_42_11.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos114801ui_story, Vector3.New(0, -0.8, -6.2), (arg_39_1.time_ - 3.8) / var_42_12)
				var_42_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_11.position).x, (manager.ui.mainCamera.transform.position - var_42_11.position).y, (manager.ui.mainCamera.transform.position - var_42_11.position).z)
				var_42_11.localEulerAngles.z = 0
				var_42_11.localEulerAngles.x = 0
				var_42_11.localEulerAngles = var_42_11.localEulerAngles
			end

			if arg_39_1.time_ >= 3.8 + var_42_12 and arg_39_1.time_ < 3.8 + var_42_12 + arg_42_0 then
				var_42_11.localPosition = Vector3.New(0, -0.8, -6.2)
				var_42_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_11.position).x, (manager.ui.mainCamera.transform.position - var_42_11.position).y, (manager.ui.mainCamera.transform.position - var_42_11.position).z)
				var_42_11.localEulerAngles.z = 0
				var_42_11.localEulerAngles.x = 0
				var_42_11.localEulerAngles = var_42_11.localEulerAngles
			end

			local var_42_13 = arg_39_1.actors_["114801ui_story"]

			if 3.8 < arg_39_1.time_ and arg_39_1.time_ <= 3.8 + arg_42_0 and not isNil(var_42_13) and arg_39_1.var_.characterEffect114801ui_story == nil then
				arg_39_1.var_.characterEffect114801ui_story = var_42_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_14 = 0.200000002980232

			if 3.8 <= arg_39_1.time_ and arg_39_1.time_ < 3.8 + var_42_14 and not isNil(var_42_13) then
				if arg_39_1.var_.characterEffect114801ui_story and not isNil(var_42_13) then
					arg_39_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 3.8 + var_42_14 and arg_39_1.time_ < 3.8 + var_42_14 + arg_42_0 and not isNil(var_42_13) and arg_39_1.var_.characterEffect114801ui_story then
				arg_39_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 3.8 < arg_39_1.time_ and arg_39_1.time_ <= 3.8 + arg_42_0 then
				arg_39_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action1_1")
			end

			if 3.8 < arg_39_1.time_ and arg_39_1.time_ <= 3.8 + arg_42_0 then
				arg_39_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_39_1.frameCnt_ <= 1 then
				arg_39_1.dialog_:SetActive(false)
			end

			local var_42_16 = 4
			local var_42_17 = 0.275

			if 4 < arg_39_1.time_ and arg_39_1.time_ <= var_42_16 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				arg_39_1.dialog_:SetActive(true)

				arg_39_1.dialogCg_.alpha = 0

				local var_42_18 = LeanTween.value(arg_39_1.dialog_, 0, 1, 0.3)

				var_42_18:setOnUpdate(LuaHelper.FloatAction(function(arg_43_0)
					arg_39_1.dialogCg_.alpha = arg_43_0
				end))
				var_42_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_39_1.dialog_)
					var_42_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_39_1.duration_ = arg_39_1.duration_ + 0.3

				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_19 = arg_39_1:GetWordFromCfg(1104806009)
				local var_42_20 = arg_39_1:FormatText(var_42_19.content)

				arg_39_1.text_.text = var_42_20

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_22 = 11 <= 0 and var_42_17 or var_42_17 * (utf8.len(var_42_20) / 11)

				if (11 <= 0 and var_42_17 or var_42_17 * (utf8.len(var_42_20) / 11)) > 0 and var_42_17 < var_42_22 then
					arg_39_1.talkMaxDuration = var_42_22
					var_42_16 = var_42_16 + 0.3

					if var_42_22 + var_42_16 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_22 + var_42_16
					end
				end

				arg_39_1.text_.text = var_42_20
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806009", "story_v_side_new_1104806.awb") ~= 0 then
					local var_42_23 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806009", "story_v_side_new_1104806.awb") / 1000

					if var_42_23 + var_42_16 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_23 + var_42_16
					end

					if var_42_19.prefab_name ~= "" and arg_39_1.actors_[var_42_19.prefab_name] ~= nil then
						local var_42_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_19.prefab_name].transform, "story_v_side_new_1104806", "1104806009", "story_v_side_new_1104806.awb")

						arg_39_1:RecordAudio("1104806009", var_42_24)
						arg_39_1:RecordAudio("1104806009", var_42_24)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806009", "story_v_side_new_1104806.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806009", "story_v_side_new_1104806.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_25 = var_42_16 + 0.3
			local var_42_26 = math.max(var_42_17, arg_39_1.talkMaxDuration)

			if var_42_16 + 0.3 <= arg_39_1.time_ and arg_39_1.time_ < var_42_25 + var_42_26 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_25) / var_42_26

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_25 + var_42_26 and arg_39_1.time_ < var_42_25 + var_42_26 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play1104806010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1104806010
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1104806011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["114801ui_story"]) and arg_45_1.var_.characterEffect114801ui_story == nil then
				arg_45_1.var_.characterEffect114801ui_story = arg_45_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["114801ui_story"]) then
				if arg_45_1.var_.characterEffect114801ui_story and not isNil(arg_45_1.actors_["114801ui_story"]) then
					arg_45_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_45_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["114801ui_story"]) and arg_45_1.var_.characterEffect114801ui_story then
				arg_45_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_45_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.975

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(1104806010).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 39 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 39)

				if (39 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 39)) > 0 and var_48_2 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_6 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_6 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_6

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_6 and arg_45_1.time_ < var_48_1 + var_48_6 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1104806011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1104806011
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1104806012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.5

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
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

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(1104806011).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 20 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 20)

				if (20 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 20)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1104806012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1104806012
		arg_53_1.duration_ = 5.77

		local var_53_0 = {
			zh = 4.166,
			ja = 5.766
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
				arg_53_0:Play1104806013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos114801ui_story = arg_53_1.actors_["114801ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["114801ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos114801ui_story, Vector3.New(0, -0.8, -6.2), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["114801ui_story"].transform.position).z)
				arg_53_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["114801ui_story"].transform.localEulerAngles = arg_53_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["114801ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_53_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["114801ui_story"].transform.position).z)
				arg_53_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["114801ui_story"].transform.localEulerAngles = arg_53_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["114801ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect114801ui_story == nil then
				arg_53_1.var_.characterEffect114801ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect114801ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect114801ui_story then
				arg_53_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_56_4 = 0
			local var_56_5 = 0.525

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(1104806012)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 21 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 21)

				if (21 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 21)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806012", "story_v_side_new_1104806.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806012", "story_v_side_new_1104806.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_side_new_1104806", "1104806012", "story_v_side_new_1104806.awb")

						arg_53_1:RecordAudio("1104806012", var_56_11)
						arg_53_1:RecordAudio("1104806012", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806012", "story_v_side_new_1104806.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806012", "story_v_side_new_1104806.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_12 and arg_53_1.time_ < var_56_4 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play1104806013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1104806013
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1104806014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["114801ui_story"]) and arg_57_1.var_.characterEffect114801ui_story == nil then
				arg_57_1.var_.characterEffect114801ui_story = arg_57_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["114801ui_story"]) then
				if arg_57_1.var_.characterEffect114801ui_story and not isNil(arg_57_1.actors_["114801ui_story"]) then
					arg_57_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_57_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["114801ui_story"]) and arg_57_1.var_.characterEffect114801ui_story then
				arg_57_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_57_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			local var_60_1 = 0
			local var_60_2 = 0.425

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(1104806013).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 17 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 17)

				if (17 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 17)) > 0 and var_60_2 < var_60_5 then
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

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1104806014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1104806014
		arg_61_1.duration_ = 6.8

		local var_61_0 = {
			zh = 3.266,
			ja = 6.8
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1104806015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["114801ui_story"]) and arg_61_1.var_.characterEffect114801ui_story == nil then
				arg_61_1.var_.characterEffect114801ui_story = arg_61_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["114801ui_story"]) then
				if arg_61_1.var_.characterEffect114801ui_story and not isNil(arg_61_1.actors_["114801ui_story"]) then
					arg_61_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["114801ui_story"]) and arg_61_1.var_.characterEffect114801ui_story then
				arg_61_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_64_2 = 0
			local var_64_3 = 0.6

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:GetWordFromCfg(1104806014)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 24 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 24)

				if (24 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 24)) > 0 and var_64_3 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806014", "story_v_side_new_1104806.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806014", "story_v_side_new_1104806.awb") / 1000

					if var_64_8 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_2
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_side_new_1104806", "1104806014", "story_v_side_new_1104806.awb")

						arg_61_1:RecordAudio("1104806014", var_64_9)
						arg_61_1:RecordAudio("1104806014", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806014", "story_v_side_new_1104806.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806014", "story_v_side_new_1104806.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_10 and arg_61_1.time_ < var_64_2 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1104806015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1104806015
		arg_65_1.duration_ = 9.33

		local var_65_0 = {
			zh = 7.533,
			ja = 9.333
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
				arg_65_0:Play1104806016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if arg_65_1.bgs_.ST02 == nil then
				local var_68_0 = Object.Instantiate(arg_65_1.paintGo_)

				var_68_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST02")
				var_68_0.name = "ST02"
				var_68_0.transform.parent = arg_65_1.stage_.transform
				var_68_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.bgs_.ST02 = var_68_0
			end

			if 2 < arg_65_1.time_ and arg_65_1.time_ <= 2 + arg_68_0 then
				local var_68_1 = arg_65_1.bgs_.ST02

				arg_65_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_68_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_2 = var_68_1:GetComponent("SpriteRenderer")

				if var_68_2 and var_68_2.sprite then
					local var_68_3 = 2 * (var_68_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_68_1.transform.localScale = Vector3.New(var_68_3 / var_68_2.sprite.bounds.size.y < var_68_3 * manager.ui.mainCameraCom_.aspect / var_68_2.sprite.bounds.size.x and var_68_3 * manager.ui.mainCameraCom_.aspect / var_68_2.sprite.bounds.size.x or var_68_3 / var_68_2.sprite.bounds.size.y, var_68_3 / var_68_2.sprite.bounds.size.y < var_68_3 * manager.ui.mainCameraCom_.aspect / var_68_2.sprite.bounds.size.x and var_68_3 * manager.ui.mainCameraCom_.aspect / var_68_2.sprite.bounds.size.x or var_68_3 / var_68_2.sprite.bounds.size.y, 0)
				end

				for iter_68_0, iter_68_1 in pairs(arg_65_1.bgs_) do
					if iter_68_0 ~= "ST02" then
						iter_68_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_68_4 = 0

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_5 = 2

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_5 then
				local var_68_6 = Color.New(0, 0, 0)

				var_68_6.a = Mathf.Lerp(0, 1, (arg_65_1.time_ - var_68_4) / var_68_5)
				arg_65_1.mask_.color = var_68_6
			end

			if arg_65_1.time_ >= var_68_4 + var_68_5 and arg_65_1.time_ < var_68_4 + var_68_5 + arg_68_0 then
				local var_68_7 = Color.New(0, 0, 0)

				var_68_7.a = 1
				arg_65_1.mask_.color = var_68_7
			end

			local var_68_8 = 2

			if 2 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_9 = 2

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_9 then
				local var_68_10 = Color.New(0, 0, 0)

				var_68_10.a = Mathf.Lerp(1, 0, (arg_65_1.time_ - var_68_8) / var_68_9)
				arg_65_1.mask_.color = var_68_10
			end

			if arg_65_1.time_ >= var_68_8 + var_68_9 and arg_65_1.time_ < var_68_8 + var_68_9 + arg_68_0 then
				local var_68_11 = Color.New(0, 0, 0)

				arg_65_1.mask_.enabled = false
				var_68_11.a = 0
				arg_65_1.mask_.color = var_68_11
			end

			local var_68_12 = arg_65_1.actors_["114801ui_story"].transform

			if 3.8 < arg_65_1.time_ and arg_65_1.time_ <= 3.8 + arg_68_0 then
				arg_65_1.var_.moveOldPos114801ui_story = var_68_12.localPosition
			end

			local var_68_13 = 0.001

			if 3.8 <= arg_65_1.time_ and arg_65_1.time_ < 3.8 + var_68_13 then
				var_68_12.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos114801ui_story, Vector3.New(0, -0.8, -6.2), (arg_65_1.time_ - 3.8) / var_68_13)
				var_68_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_12.position).x, (manager.ui.mainCamera.transform.position - var_68_12.position).y, (manager.ui.mainCamera.transform.position - var_68_12.position).z)
				var_68_12.localEulerAngles.z = 0
				var_68_12.localEulerAngles.x = 0
				var_68_12.localEulerAngles = var_68_12.localEulerAngles
			end

			if arg_65_1.time_ >= 3.8 + var_68_13 and arg_65_1.time_ < 3.8 + var_68_13 + arg_68_0 then
				var_68_12.localPosition = Vector3.New(0, -0.8, -6.2)
				var_68_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_12.position).x, (manager.ui.mainCamera.transform.position - var_68_12.position).y, (manager.ui.mainCamera.transform.position - var_68_12.position).z)
				var_68_12.localEulerAngles.z = 0
				var_68_12.localEulerAngles.x = 0
				var_68_12.localEulerAngles = var_68_12.localEulerAngles
			end

			local var_68_14 = arg_65_1.actors_["114801ui_story"]

			if 3.8 < arg_65_1.time_ and arg_65_1.time_ <= 3.8 + arg_68_0 and not isNil(var_68_14) and arg_65_1.var_.characterEffect114801ui_story == nil then
				arg_65_1.var_.characterEffect114801ui_story = var_68_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_15 = 0.200000002980232

			if 3.8 <= arg_65_1.time_ and arg_65_1.time_ < 3.8 + var_68_15 and not isNil(var_68_14) then
				if arg_65_1.var_.characterEffect114801ui_story and not isNil(var_68_14) then
					arg_65_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 3.8 + var_68_15 and arg_65_1.time_ < 3.8 + var_68_15 + arg_68_0 and not isNil(var_68_14) and arg_65_1.var_.characterEffect114801ui_story then
				arg_65_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 3.8 < arg_65_1.time_ and arg_65_1.time_ <= 3.8 + arg_68_0 then
				arg_65_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 3.8 < arg_65_1.time_ and arg_65_1.time_ <= 3.8 + arg_68_0 then
				arg_65_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_17 = arg_65_1.actors_["114801ui_story"].transform

			if 1.96599999815226 < arg_65_1.time_ and arg_65_1.time_ <= 1.96599999815226 + arg_68_0 then
				arg_65_1.var_.moveOldPos114801ui_story = var_68_17.localPosition
			end

			local var_68_18 = 0.001

			if 1.96599999815226 <= arg_65_1.time_ and arg_65_1.time_ < 1.96599999815226 + var_68_18 then
				var_68_17.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos114801ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 1.96599999815226) / var_68_18)
				var_68_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_17.position).x, (manager.ui.mainCamera.transform.position - var_68_17.position).y, (manager.ui.mainCamera.transform.position - var_68_17.position).z)
				var_68_17.localEulerAngles.z = 0
				var_68_17.localEulerAngles.x = 0
				var_68_17.localEulerAngles = var_68_17.localEulerAngles
			end

			if arg_65_1.time_ >= 1.96599999815226 + var_68_18 and arg_65_1.time_ < 1.96599999815226 + var_68_18 + arg_68_0 then
				var_68_17.localPosition = Vector3.New(0, 100, 0)
				var_68_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_17.position).x, (manager.ui.mainCamera.transform.position - var_68_17.position).y, (manager.ui.mainCamera.transform.position - var_68_17.position).z)
				var_68_17.localEulerAngles.z = 0
				var_68_17.localEulerAngles.x = 0
				var_68_17.localEulerAngles = var_68_17.localEulerAngles
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_19 = 4
			local var_68_20 = 0.4

			if 4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_19 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_21 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_21:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_22 = arg_65_1:GetWordFromCfg(1104806015)
				local var_68_23 = arg_65_1:FormatText(var_68_22.content)

				arg_65_1.text_.text = var_68_23

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_25 = 16 <= 0 and var_68_20 or var_68_20 * (utf8.len(var_68_23) / 16)

				if (16 <= 0 and var_68_20 or var_68_20 * (utf8.len(var_68_23) / 16)) > 0 and var_68_20 < var_68_25 then
					arg_65_1.talkMaxDuration = var_68_25
					var_68_19 = var_68_19 + 0.3

					if var_68_25 + var_68_19 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_25 + var_68_19
					end
				end

				arg_65_1.text_.text = var_68_23
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806015", "story_v_side_new_1104806.awb") ~= 0 then
					local var_68_26 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806015", "story_v_side_new_1104806.awb") / 1000

					if var_68_26 + var_68_19 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_26 + var_68_19
					end

					if var_68_22.prefab_name ~= "" and arg_65_1.actors_[var_68_22.prefab_name] ~= nil then
						local var_68_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_22.prefab_name].transform, "story_v_side_new_1104806", "1104806015", "story_v_side_new_1104806.awb")

						arg_65_1:RecordAudio("1104806015", var_68_27)
						arg_65_1:RecordAudio("1104806015", var_68_27)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806015", "story_v_side_new_1104806.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806015", "story_v_side_new_1104806.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_28 = var_68_19 + 0.3
			local var_68_29 = math.max(var_68_20, arg_65_1.talkMaxDuration)

			if var_68_19 + 0.3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_28 + var_68_29 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_28) / var_68_29

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_28 + var_68_29 and arg_65_1.time_ < var_68_28 + var_68_29 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play1104806016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1104806016
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play1104806017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["114801ui_story"]) and arg_71_1.var_.characterEffect114801ui_story == nil then
				arg_71_1.var_.characterEffect114801ui_story = arg_71_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["114801ui_story"]) then
				if arg_71_1.var_.characterEffect114801ui_story and not isNil(arg_71_1.actors_["114801ui_story"]) then
					arg_71_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_71_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_0)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["114801ui_story"]) and arg_71_1.var_.characterEffect114801ui_story then
				arg_71_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_71_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			local var_74_1 = 0
			local var_74_2 = 0.45

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(1104806016).content)

				arg_71_1.text_.text = var_74_3

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 18 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 18)

				if (18 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 18)) > 0 and var_74_2 < var_74_5 then
					arg_71_1.talkMaxDuration = var_74_5

					if var_74_5 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + var_74_1
					end
				end

				arg_71_1.text_.text = var_74_3
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_6 = math.max(var_74_2, arg_71_1.talkMaxDuration)

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_6 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_1) / var_74_6

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_1 + var_74_6 and arg_71_1.time_ < var_74_1 + var_74_6 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play1104806017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1104806017
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1104806018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.5

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(1104806017).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 20 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 20)

				if (20 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 20)) > 0 and var_78_0 < var_78_3 then
					arg_75_1.talkMaxDuration = var_78_3

					if var_78_3 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_3 + 0
					end
				end

				arg_75_1.text_.text = var_78_1
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_4 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_4

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play1104806018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1104806018
		arg_79_1.duration_ = 5.2

		local var_79_0 = {
			zh = 3.866,
			ja = 5.2
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
				arg_79_0:Play1104806019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_2")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_82_0 = arg_79_1.actors_["114801ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect114801ui_story == nil then
				arg_79_1.var_.characterEffect114801ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_1 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_1 and not isNil(var_82_0) then
				if arg_79_1.var_.characterEffect114801ui_story and not isNil(var_82_0) then
					arg_79_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_1 and arg_79_1.time_ < 0 + var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect114801ui_story then
				arg_79_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			local var_82_3 = 0
			local var_82_4 = 0.7

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_3 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_5 = arg_79_1:GetWordFromCfg(1104806018)
				local var_82_6 = arg_79_1:FormatText(var_82_5.content)

				arg_79_1.text_.text = var_82_6

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_8 = 28 <= 0 and var_82_4 or var_82_4 * (utf8.len(var_82_6) / 28)

				if (28 <= 0 and var_82_4 or var_82_4 * (utf8.len(var_82_6) / 28)) > 0 and var_82_4 < var_82_8 then
					arg_79_1.talkMaxDuration = var_82_8

					if var_82_8 + var_82_3 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_3
					end
				end

				arg_79_1.text_.text = var_82_6
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806018", "story_v_side_new_1104806.awb") ~= 0 then
					local var_82_9 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806018", "story_v_side_new_1104806.awb") / 1000

					if var_82_9 + var_82_3 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_3
					end

					if var_82_5.prefab_name ~= "" and arg_79_1.actors_[var_82_5.prefab_name] ~= nil then
						local var_82_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_5.prefab_name].transform, "story_v_side_new_1104806", "1104806018", "story_v_side_new_1104806.awb")

						arg_79_1:RecordAudio("1104806018", var_82_10)
						arg_79_1:RecordAudio("1104806018", var_82_10)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806018", "story_v_side_new_1104806.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806018", "story_v_side_new_1104806.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_11 = math.max(var_82_4, arg_79_1.talkMaxDuration)

			if var_82_3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_3 + var_82_11 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_3) / var_82_11

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_3 + var_82_11 and arg_79_1.time_ < var_82_3 + var_82_11 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1104806019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1104806019
		arg_83_1.duration_ = 3.87

		local var_83_0 = {
			zh = 3.866,
			ja = 2.9
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
				arg_83_0:Play1104806020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos114801ui_story = arg_83_1.actors_["114801ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["114801ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos114801ui_story, Vector3.New(0, -0.8, -6.2), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["114801ui_story"].transform.position).z)
				arg_83_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["114801ui_story"].transform.localEulerAngles = arg_83_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["114801ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_83_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["114801ui_story"].transform.position).z)
				arg_83_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["114801ui_story"].transform.localEulerAngles = arg_83_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			local var_86_1 = arg_83_1.actors_["114801ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect114801ui_story == nil then
				arg_83_1.var_.characterEffect114801ui_story = var_86_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 and not isNil(var_86_1) then
				if arg_83_1.var_.characterEffect114801ui_story and not isNil(var_86_1) then
					arg_83_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect114801ui_story then
				arg_83_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_86_4 = 0
			local var_86_5 = 0.35

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_6 = arg_83_1:GetWordFromCfg(1104806019)
				local var_86_7 = arg_83_1:FormatText(var_86_6.content)

				arg_83_1.text_.text = var_86_7

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_9 = 14 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_7) / 14)

				if (14 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_7) / 14)) > 0 and var_86_5 < var_86_9 then
					arg_83_1.talkMaxDuration = var_86_9

					if var_86_9 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_4
					end
				end

				arg_83_1.text_.text = var_86_7
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806019", "story_v_side_new_1104806.awb") ~= 0 then
					local var_86_10 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806019", "story_v_side_new_1104806.awb") / 1000

					if var_86_10 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_4
					end

					if var_86_6.prefab_name ~= "" and arg_83_1.actors_[var_86_6.prefab_name] ~= nil then
						local var_86_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_6.prefab_name].transform, "story_v_side_new_1104806", "1104806019", "story_v_side_new_1104806.awb")

						arg_83_1:RecordAudio("1104806019", var_86_11)
						arg_83_1:RecordAudio("1104806019", var_86_11)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806019", "story_v_side_new_1104806.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806019", "story_v_side_new_1104806.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_12 = math.max(var_86_5, arg_83_1.talkMaxDuration)

			if var_86_4 <= arg_83_1.time_ and arg_83_1.time_ < var_86_4 + var_86_12 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_4) / var_86_12

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_4 + var_86_12 and arg_83_1.time_ < var_86_4 + var_86_12 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
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
	Play1104806020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1104806020
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1104806021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos114801ui_story = arg_87_1.actors_["114801ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["114801ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos114801ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["114801ui_story"].transform.position).z)
				arg_87_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["114801ui_story"].transform.localEulerAngles = arg_87_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["114801ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["114801ui_story"].transform.position).z)
				arg_87_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["114801ui_story"].transform.localEulerAngles = arg_87_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			local var_90_1 = 0
			local var_90_2 = 0.725

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(1104806020).content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 29 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 29)

				if (29 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 29)) > 0 and var_90_2 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_1
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_6 = math.max(var_90_2, arg_87_1.talkMaxDuration)

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_6 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_1) / var_90_6

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_1 + var_90_6 and arg_87_1.time_ < var_90_1 + var_90_6 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
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
	Play1104806021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1104806021
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play1104806022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.925

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_1 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(1104806021).content)

				arg_91_1.text_.text = var_94_1

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_3 = 37 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 37)

				if (37 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 37)) > 0 and var_94_0 < var_94_3 then
					arg_91_1.talkMaxDuration = var_94_3

					if var_94_3 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_3 + 0
					end
				end

				arg_91_1.text_.text = var_94_1
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_4 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_4

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play1104806022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1104806022
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1104806023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_98_0 = 0.6

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				local var_98_1, var_98_2 = math.modf((arg_95_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_98_2 * 0.13, var_98_2 * 0.13, var_98_2 * 0.13) + arg_95_1.var_.shakeOldPos
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				manager.ui.mainCamera.transform.localPosition = arg_95_1.var_.shakeOldPos
			end

			local var_98_3 = 0

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_3 + arg_98_0 then
				arg_95_1.allBtn_.enabled = false
			end

			if arg_95_1.time_ >= var_98_3 + 0.6 and arg_95_1.time_ < var_98_3 + 0.6 + arg_98_0 then
				arg_95_1.allBtn_.enabled = true
			end

			local var_98_4 = 0
			local var_98_5 = 0.55

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_6 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(1104806022).content)

				arg_95_1.text_.text = var_98_6

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_8 = 22 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_6) / 22)

				if (22 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_6) / 22)) > 0 and var_98_5 < var_98_8 then
					arg_95_1.talkMaxDuration = var_98_8

					if var_98_8 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_6
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_9 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_9 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_9

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_9 and arg_95_1.time_ < var_98_4 + var_98_9 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play1104806023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1104806023
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1104806024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 1.1

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(1104806023).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 44 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 44)

				if (44 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 44)) > 0 and var_102_0 < var_102_3 then
					arg_99_1.talkMaxDuration = var_102_3

					if var_102_3 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_3 + 0
					end
				end

				arg_99_1.text_.text = var_102_1
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_4 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_4

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1104806024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1104806024
		arg_103_1.duration_ = 2

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1104806025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos114801ui_story = arg_103_1.actors_["114801ui_story"].transform.localPosition
			end

			local var_106_0 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				arg_103_1.actors_["114801ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos114801ui_story, Vector3.New(0, -0.8, -6.2), (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["114801ui_story"].transform.position).z)
				arg_103_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["114801ui_story"].transform.localEulerAngles = arg_103_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				arg_103_1.actors_["114801ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_103_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["114801ui_story"].transform.position).z)
				arg_103_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["114801ui_story"].transform.localEulerAngles = arg_103_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			local var_106_1 = arg_103_1.actors_["114801ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect114801ui_story == nil then
				arg_103_1.var_.characterEffect114801ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and not isNil(var_106_1) then
				if arg_103_1.var_.characterEffect114801ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect114801ui_story then
				arg_103_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_106_4 = 0
			local var_106_5 = 0.175

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_6 = arg_103_1:GetWordFromCfg(1104806024)
				local var_106_7 = arg_103_1:FormatText(var_106_6.content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 7 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 7)

				if (7 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 7)) > 0 and var_106_5 < var_106_9 then
					arg_103_1.talkMaxDuration = var_106_9

					if var_106_9 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806024", "story_v_side_new_1104806.awb") ~= 0 then
					local var_106_10 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806024", "story_v_side_new_1104806.awb") / 1000

					if var_106_10 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_4
					end

					if var_106_6.prefab_name ~= "" and arg_103_1.actors_[var_106_6.prefab_name] ~= nil then
						local var_106_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_6.prefab_name].transform, "story_v_side_new_1104806", "1104806024", "story_v_side_new_1104806.awb")

						arg_103_1:RecordAudio("1104806024", var_106_11)
						arg_103_1:RecordAudio("1104806024", var_106_11)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806024", "story_v_side_new_1104806.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806024", "story_v_side_new_1104806.awb")
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
				actorName = "114801ui_story",
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
	Play1104806025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1104806025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1104806026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos114801ui_story = arg_107_1.actors_["114801ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["114801ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos114801ui_story, Vector3.New(0, 100, 0), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["114801ui_story"].transform.position).z)
				arg_107_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["114801ui_story"].transform.localEulerAngles = arg_107_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["114801ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_107_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["114801ui_story"].transform.position).z)
				arg_107_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["114801ui_story"].transform.localEulerAngles = arg_107_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			local var_110_1 = arg_107_1.actors_["114801ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect114801ui_story == nil then
				arg_107_1.var_.characterEffect114801ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect114801ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_107_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_2)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect114801ui_story then
				arg_107_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_107_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			local var_110_3 = 0
			local var_110_4 = 0.275

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_3 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_5 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(1104806025).content)

				arg_107_1.text_.text = var_110_5

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_7 = 11 <= 0 and var_110_4 or var_110_4 * (utf8.len(var_110_5) / 11)

				if (11 <= 0 and var_110_4 or var_110_4 * (utf8.len(var_110_5) / 11)) > 0 and var_110_4 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_3 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_3
					end
				end

				arg_107_1.text_.text = var_110_5
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_8 = math.max(var_110_4, arg_107_1.talkMaxDuration)

			if var_110_3 <= arg_107_1.time_ and arg_107_1.time_ < var_110_3 + var_110_8 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_3) / var_110_8

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_3 + var_110_8 and arg_107_1.time_ < var_110_3 + var_110_8 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play1104806026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1104806026
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1104806027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				local var_114_0 = arg_111_1.var_.effecthuola1

				if not arg_111_1.var_.effecthuola1 then
					var_114_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), manager.ui.mainCamera.transform)
					var_114_0.name = "huola1"
					arg_111_1.var_.effecthuola1 = var_114_0
				else
					var_114_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_114_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_114_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_114_2 = 0
			local var_114_3 = 1.1

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_4 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(1104806026).content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_6 = 44 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_4) / 44)

				if (44 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_4) / 44)) > 0 and var_114_3 < var_114_6 then
					arg_111_1.talkMaxDuration = var_114_6

					if var_114_6 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_2
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_3, arg_111_1.talkMaxDuration)

			if var_114_2 <= arg_111_1.time_ and arg_111_1.time_ < var_114_2 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_2) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_2 + var_114_7 and arg_111_1.time_ < var_114_2 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play1104806027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1104806027
		arg_115_1.duration_ = 5.93

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play1104806028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_118_0 = 0.6

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				local var_118_1, var_118_2 = math.modf((arg_115_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_118_2 * 0.13, var_118_2 * 0.13, var_118_2 * 0.13) + arg_115_1.var_.shakeOldPos
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				manager.ui.mainCamera.transform.localPosition = arg_115_1.var_.shakeOldPos
			end

			local var_118_3 = 0

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_3 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_4 = 2

			if var_118_3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_3 + var_118_4 then
				local var_118_5 = Color.New(1, 1, 1)

				var_118_5.a = Mathf.Lerp(1, 0, (arg_115_1.time_ - var_118_3) / var_118_4)
				arg_115_1.mask_.color = var_118_5
			end

			if arg_115_1.time_ >= var_118_3 + var_118_4 and arg_115_1.time_ < var_118_3 + var_118_4 + arg_118_0 then
				local var_118_6 = Color.New(1, 1, 1)

				arg_115_1.mask_.enabled = false
				var_118_6.a = 0
				arg_115_1.mask_.color = var_118_6
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				if arg_115_1.var_.effecthuola1 then
					Object.Destroy(arg_115_1.var_.effecthuola1)

					arg_115_1.var_.effecthuola1 = nil
				end
			end

			if arg_115_1.frameCnt_ <= 1 then
				arg_115_1.dialog_:SetActive(false)
			end

			local var_118_8 = 0.933333333333333
			local var_118_9 = 0.075

			if 0.933333333333333 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				arg_115_1.dialog_:SetActive(true)

				arg_115_1.dialogCg_.alpha = 0

				local var_118_10 = LeanTween.value(arg_115_1.dialog_, 0, 1, 0.3)

				var_118_10:setOnUpdate(LuaHelper.FloatAction(function(arg_119_0)
					arg_115_1.dialogCg_.alpha = arg_119_0
				end))
				var_118_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_115_1.dialog_)
					var_118_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_115_1.duration_ = arg_115_1.duration_ + 0.3

				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_11 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(1104806027).content)

				arg_115_1.text_.text = var_118_11

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_13 = 3 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 3)

				if (3 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 3)) > 0 and var_118_9 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13
					var_118_8 = var_118_8 + 0.3

					if var_118_13 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_8
					end
				end

				arg_115_1.text_.text = var_118_11
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_14 = var_118_8 + 0.3
			local var_118_15 = math.max(var_118_9, arg_115_1.talkMaxDuration)

			if var_118_8 + 0.3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_14 + var_118_15 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_14) / var_118_15

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_14 + var_118_15 and arg_115_1.time_ < var_118_14 + var_118_15 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play1104806028 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1104806028
		arg_121_1.duration_ = 4.17

		local var_121_0 = {
			zh = 2.833,
			ja = 4.166
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
				arg_121_0:Play1104806029(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos114801ui_story = arg_121_1.actors_["114801ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["114801ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos114801ui_story, Vector3.New(0, -0.8, -6.2), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["114801ui_story"].transform.position).z)
				arg_121_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["114801ui_story"].transform.localEulerAngles = arg_121_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["114801ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_121_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["114801ui_story"].transform.position).z)
				arg_121_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["114801ui_story"].transform.localEulerAngles = arg_121_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["114801ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect114801ui_story == nil then
				arg_121_1.var_.characterEffect114801ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect114801ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect114801ui_story then
				arg_121_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action2_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_124_4 = 0
			local var_124_5 = 0.325

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(1104806028)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 13 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 13)

				if (13 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 13)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806028", "story_v_side_new_1104806.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806028", "story_v_side_new_1104806.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_side_new_1104806", "1104806028", "story_v_side_new_1104806.awb")

						arg_121_1:RecordAudio("1104806028", var_124_11)
						arg_121_1:RecordAudio("1104806028", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806028", "story_v_side_new_1104806.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806028", "story_v_side_new_1104806.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play1104806029 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1104806029
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1104806030(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos114801ui_story = arg_125_1.actors_["114801ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["114801ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos114801ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["114801ui_story"].transform.position).z)
				arg_125_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["114801ui_story"].transform.localEulerAngles = arg_125_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["114801ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["114801ui_story"].transform.position).z)
				arg_125_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["114801ui_story"].transform.localEulerAngles = arg_125_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			local var_128_1 = "1081ui_story"

			if arg_125_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_128_2 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_125_1.stage_.transform)

				var_128_2.name = var_128_1
				var_128_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.actors_[var_128_1] = var_128_2

				local var_128_3 = var_128_2:GetComponentInChildren(typeof(CharacterEffect))

				var_128_3.enabled = true

				local var_128_4 = GameObjectTools.GetOrAddComponent(var_128_2, typeof(DynamicBoneHelper))

				if var_128_4 then
					var_128_4:EnableDynamicBone(false)
				end

				arg_125_1:ShowWeapon(var_128_3.transform, false)

				arg_125_1.var_[var_128_1 .. "Animator"] = var_128_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_125_1.var_[var_128_1 .. "Animator"].applyRootMotion = true
				arg_125_1.var_[var_128_1 .. "LipSync"] = var_128_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_128_5 = arg_125_1.actors_["1081ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1081ui_story = var_128_5.localPosition

				arg_125_1:ShowWeapon(arg_125_1.var_["1081ui_story" .. "Animator"].transform, false)
			end

			local var_128_6 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_6 then
				var_128_5.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1081ui_story, Vector3.New(0.7, -0.92, -5.8), (arg_125_1.time_ - 0) / var_128_6)
				var_128_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_5.position).x, (manager.ui.mainCamera.transform.position - var_128_5.position).y, (manager.ui.mainCamera.transform.position - var_128_5.position).z)
				var_128_5.localEulerAngles.z = 0
				var_128_5.localEulerAngles.x = 0
				var_128_5.localEulerAngles = var_128_5.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_6 and arg_125_1.time_ < 0 + var_128_6 + arg_128_0 then
				var_128_5.localPosition = Vector3.New(0.7, -0.92, -5.8)
				var_128_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_5.position).x, (manager.ui.mainCamera.transform.position - var_128_5.position).y, (manager.ui.mainCamera.transform.position - var_128_5.position).z)
				var_128_5.localEulerAngles.z = 0
				var_128_5.localEulerAngles.x = 0
				var_128_5.localEulerAngles = var_128_5.localEulerAngles
			end

			local var_128_7 = "1011ui_story"

			if arg_125_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_128_8 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_125_1.stage_.transform)

				var_128_8.name = var_128_7
				var_128_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.actors_[var_128_7] = var_128_8

				local var_128_9 = var_128_8:GetComponentInChildren(typeof(CharacterEffect))

				var_128_9.enabled = true

				local var_128_10 = GameObjectTools.GetOrAddComponent(var_128_8, typeof(DynamicBoneHelper))

				if var_128_10 then
					var_128_10:EnableDynamicBone(false)
				end

				arg_125_1:ShowWeapon(var_128_9.transform, false)

				arg_125_1.var_[var_128_7 .. "Animator"] = var_128_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_125_1.var_[var_128_7 .. "Animator"].applyRootMotion = true
				arg_125_1.var_[var_128_7 .. "LipSync"] = var_128_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_128_11 = arg_125_1.actors_["1011ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1011ui_story = var_128_11.localPosition
			end

			local var_128_12 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_12 then
				var_128_11.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_125_1.time_ - 0) / var_128_12)
				var_128_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_11.position).x, (manager.ui.mainCamera.transform.position - var_128_11.position).y, (manager.ui.mainCamera.transform.position - var_128_11.position).z)
				var_128_11.localEulerAngles.z = 0
				var_128_11.localEulerAngles.x = 0
				var_128_11.localEulerAngles = var_128_11.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_12 and arg_125_1.time_ < 0 + var_128_12 + arg_128_0 then
				var_128_11.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_128_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_11.position).x, (manager.ui.mainCamera.transform.position - var_128_11.position).y, (manager.ui.mainCamera.transform.position - var_128_11.position).z)
				var_128_11.localEulerAngles.z = 0
				var_128_11.localEulerAngles.x = 0
				var_128_11.localEulerAngles = var_128_11.localEulerAngles
			end

			local var_128_13 = "1027ui_story"

			if arg_125_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_128_14 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_125_1.stage_.transform)

				var_128_14.name = var_128_13
				var_128_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.actors_[var_128_13] = var_128_14

				local var_128_15 = var_128_14:GetComponentInChildren(typeof(CharacterEffect))

				var_128_15.enabled = true

				local var_128_16 = GameObjectTools.GetOrAddComponent(var_128_14, typeof(DynamicBoneHelper))

				if var_128_16 then
					var_128_16:EnableDynamicBone(false)
				end

				arg_125_1:ShowWeapon(var_128_15.transform, false)

				arg_125_1.var_[var_128_13 .. "Animator"] = var_128_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_125_1.var_[var_128_13 .. "Animator"].applyRootMotion = true
				arg_125_1.var_[var_128_13 .. "LipSync"] = var_128_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_128_17 = arg_125_1.actors_["1027ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1027ui_story = var_128_17.localPosition

				arg_125_1:ShowWeapon(arg_125_1.var_["1027ui_story" .. "Animator"].transform, false)
			end

			local var_128_18 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_18 then
				var_128_17.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_125_1.time_ - 0) / var_128_18)
				var_128_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_17.position).x, (manager.ui.mainCamera.transform.position - var_128_17.position).y, (manager.ui.mainCamera.transform.position - var_128_17.position).z)
				var_128_17.localEulerAngles.z = 0
				var_128_17.localEulerAngles.x = 0
				var_128_17.localEulerAngles = var_128_17.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_18 and arg_125_1.time_ < 0 + var_128_18 + arg_128_0 then
				var_128_17.localPosition = Vector3.New(0, -0.81, -5.8)
				var_128_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_17.position).x, (manager.ui.mainCamera.transform.position - var_128_17.position).y, (manager.ui.mainCamera.transform.position - var_128_17.position).z)
				var_128_17.localEulerAngles.z = 0
				var_128_17.localEulerAngles.x = 0
				var_128_17.localEulerAngles = var_128_17.localEulerAngles
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action5_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_128_19 = 0
			local var_128_20 = 1.175

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_19 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_21 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(1104806029).content)

				arg_125_1.text_.text = var_128_21

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_23 = 47 <= 0 and var_128_20 or var_128_20 * (utf8.len(var_128_21) / 47)

				if (47 <= 0 and var_128_20 or var_128_20 * (utf8.len(var_128_21) / 47)) > 0 and var_128_20 < var_128_23 then
					arg_125_1.talkMaxDuration = var_128_23

					if var_128_23 + var_128_19 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_23 + var_128_19
					end
				end

				arg_125_1.text_.text = var_128_21
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_24 = math.max(var_128_20, arg_125_1.talkMaxDuration)

			if var_128_19 <= arg_125_1.time_ and arg_125_1.time_ < var_128_19 + var_128_24 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_19) / var_128_24

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_19 + var_128_24 and arg_125_1.time_ < var_128_19 + var_128_24 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play1104806030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1104806030
		arg_129_1.duration_ = 11.08

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1104806031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 3.03400000369549 < arg_129_1.time_ and arg_129_1.time_ <= 3.03400000369549 + arg_132_0 then
				local var_132_0 = arg_129_1.bgs_.ST01

				arg_129_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_132_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_132_1 = var_132_0:GetComponent("SpriteRenderer")

				if var_132_1 and var_132_1.sprite then
					local var_132_2 = 2 * (var_132_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_132_0.transform.localScale = Vector3.New(var_132_2 / var_132_1.sprite.bounds.size.y < var_132_2 * manager.ui.mainCameraCom_.aspect / var_132_1.sprite.bounds.size.x and var_132_2 * manager.ui.mainCameraCom_.aspect / var_132_1.sprite.bounds.size.x or var_132_2 / var_132_1.sprite.bounds.size.y, var_132_2 / var_132_1.sprite.bounds.size.y < var_132_2 * manager.ui.mainCameraCom_.aspect / var_132_1.sprite.bounds.size.x and var_132_2 * manager.ui.mainCameraCom_.aspect / var_132_1.sprite.bounds.size.x or var_132_2 / var_132_1.sprite.bounds.size.y, 0)
				end

				for iter_132_0, iter_132_1 in pairs(arg_129_1.bgs_) do
					if iter_132_0 ~= "ST01" then
						iter_132_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_132_3 = 0

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_3 + arg_132_0 then
				arg_129_1.mask_.enabled = true
				arg_129_1.mask_.raycastTarget = true

				arg_129_1:SetGaussion(false)
			end

			local var_132_4 = 3.03400000369549

			if var_132_3 <= arg_129_1.time_ and arg_129_1.time_ < var_132_3 + var_132_4 then
				local var_132_5 = Color.New(0, 0, 0)

				var_132_5.a = Mathf.Lerp(0, 1, (arg_129_1.time_ - var_132_3) / var_132_4)
				arg_129_1.mask_.color = var_132_5
			end

			if arg_129_1.time_ >= var_132_3 + var_132_4 and arg_129_1.time_ < var_132_3 + var_132_4 + arg_132_0 then
				local var_132_6 = Color.New(0, 0, 0)

				var_132_6.a = 1
				arg_129_1.mask_.color = var_132_6
			end

			local var_132_7 = 3.03400000369549

			if 3.03400000369549 < arg_129_1.time_ and arg_129_1.time_ <= var_132_7 + arg_132_0 then
				arg_129_1.mask_.enabled = true
				arg_129_1.mask_.raycastTarget = true

				arg_129_1:SetGaussion(false)
			end

			local var_132_8 = 3.04999999815151

			if var_132_7 <= arg_129_1.time_ and arg_129_1.time_ < var_132_7 + var_132_8 then
				local var_132_9 = Color.New(0, 0, 0)

				var_132_9.a = Mathf.Lerp(1, 0, (arg_129_1.time_ - var_132_7) / var_132_8)
				arg_129_1.mask_.color = var_132_9
			end

			if arg_129_1.time_ >= var_132_7 + var_132_8 and arg_129_1.time_ < var_132_7 + var_132_8 + arg_132_0 then
				local var_132_10 = Color.New(0, 0, 0)

				arg_129_1.mask_.enabled = false
				var_132_10.a = 0
				arg_129_1.mask_.color = var_132_10
			end

			local var_132_11 = arg_129_1.actors_["114801ui_story"].transform

			if 3 < arg_129_1.time_ and arg_129_1.time_ <= 3 + arg_132_0 then
				arg_129_1.var_.moveOldPos114801ui_story = var_132_11.localPosition
			end

			local var_132_12 = 0.001

			if 3 <= arg_129_1.time_ and arg_129_1.time_ < 3 + var_132_12 then
				var_132_11.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos114801ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 3) / var_132_12)
				var_132_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_11.position).x, (manager.ui.mainCamera.transform.position - var_132_11.position).y, (manager.ui.mainCamera.transform.position - var_132_11.position).z)
				var_132_11.localEulerAngles.z = 0
				var_132_11.localEulerAngles.x = 0
				var_132_11.localEulerAngles = var_132_11.localEulerAngles
			end

			if arg_129_1.time_ >= 3 + var_132_12 and arg_129_1.time_ < 3 + var_132_12 + arg_132_0 then
				var_132_11.localPosition = Vector3.New(0, 100, 0)
				var_132_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_11.position).x, (manager.ui.mainCamera.transform.position - var_132_11.position).y, (manager.ui.mainCamera.transform.position - var_132_11.position).z)
				var_132_11.localEulerAngles.z = 0
				var_132_11.localEulerAngles.x = 0
				var_132_11.localEulerAngles = var_132_11.localEulerAngles
			end

			local var_132_13 = arg_129_1.actors_["114801ui_story"]

			if 3 < arg_129_1.time_ and arg_129_1.time_ <= 3 + arg_132_0 and not isNil(var_132_13) and arg_129_1.var_.characterEffect114801ui_story == nil then
				arg_129_1.var_.characterEffect114801ui_story = var_132_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_14 = 0.034000001847744

			if 3 <= arg_129_1.time_ and arg_129_1.time_ < 3 + var_132_14 and not isNil(var_132_13) then
				if arg_129_1.var_.characterEffect114801ui_story and not isNil(var_132_13) then
					arg_129_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_129_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 3) / var_132_14)
				end
			end

			if arg_129_1.time_ >= 3 + var_132_14 and arg_129_1.time_ < 3 + var_132_14 + arg_132_0 and not isNil(var_132_13) and arg_129_1.var_.characterEffect114801ui_story then
				arg_129_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_129_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			local var_132_15 = arg_129_1.actors_["1081ui_story"].transform

			if 3.00000000184774 < arg_129_1.time_ and arg_129_1.time_ <= 3.00000000184774 + arg_132_0 then
				arg_129_1.var_.moveOldPos1081ui_story = var_132_15.localPosition

				arg_129_1:ShowWeapon(arg_129_1.var_["1081ui_story" .. "Animator"].transform, false)
			end

			local var_132_16 = 0.001

			if 3.00000000184774 <= arg_129_1.time_ and arg_129_1.time_ < 3.00000000184774 + var_132_16 then
				var_132_15.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 3.00000000184774) / var_132_16)
				var_132_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_15.position).x, (manager.ui.mainCamera.transform.position - var_132_15.position).y, (manager.ui.mainCamera.transform.position - var_132_15.position).z)
				var_132_15.localEulerAngles.z = 0
				var_132_15.localEulerAngles.x = 0
				var_132_15.localEulerAngles = var_132_15.localEulerAngles
			end

			if arg_129_1.time_ >= 3.00000000184774 + var_132_16 and arg_129_1.time_ < 3.00000000184774 + var_132_16 + arg_132_0 then
				var_132_15.localPosition = Vector3.New(0, 100, 0)
				var_132_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_15.position).x, (manager.ui.mainCamera.transform.position - var_132_15.position).y, (manager.ui.mainCamera.transform.position - var_132_15.position).z)
				var_132_15.localEulerAngles.z = 0
				var_132_15.localEulerAngles.x = 0
				var_132_15.localEulerAngles = var_132_15.localEulerAngles
			end

			local var_132_17 = arg_129_1.actors_["1011ui_story"].transform

			if 3.00000000184774 < arg_129_1.time_ and arg_129_1.time_ <= 3.00000000184774 + arg_132_0 then
				arg_129_1.var_.moveOldPos1011ui_story = var_132_17.localPosition
			end

			local var_132_18 = 0.001

			if 3.00000000184774 <= arg_129_1.time_ and arg_129_1.time_ < 3.00000000184774 + var_132_18 then
				var_132_17.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 3.00000000184774) / var_132_18)
				var_132_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_17.position).x, (manager.ui.mainCamera.transform.position - var_132_17.position).y, (manager.ui.mainCamera.transform.position - var_132_17.position).z)
				var_132_17.localEulerAngles.z = 0
				var_132_17.localEulerAngles.x = 0
				var_132_17.localEulerAngles = var_132_17.localEulerAngles
			end

			if arg_129_1.time_ >= 3.00000000184774 + var_132_18 and arg_129_1.time_ < 3.00000000184774 + var_132_18 + arg_132_0 then
				var_132_17.localPosition = Vector3.New(0, 100, 0)
				var_132_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_17.position).x, (manager.ui.mainCamera.transform.position - var_132_17.position).y, (manager.ui.mainCamera.transform.position - var_132_17.position).z)
				var_132_17.localEulerAngles.z = 0
				var_132_17.localEulerAngles.x = 0
				var_132_17.localEulerAngles = var_132_17.localEulerAngles
			end

			local var_132_19 = arg_129_1.actors_["1027ui_story"].transform

			if 3.00000000184774 < arg_129_1.time_ and arg_129_1.time_ <= 3.00000000184774 + arg_132_0 then
				arg_129_1.var_.moveOldPos1027ui_story = var_132_19.localPosition

				arg_129_1:ShowWeapon(arg_129_1.var_["1027ui_story" .. "Animator"].transform, false)
			end

			local var_132_20 = 0.001

			if 3.00000000184774 <= arg_129_1.time_ and arg_129_1.time_ < 3.00000000184774 + var_132_20 then
				var_132_19.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 3.00000000184774) / var_132_20)
				var_132_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_19.position).x, (manager.ui.mainCamera.transform.position - var_132_19.position).y, (manager.ui.mainCamera.transform.position - var_132_19.position).z)
				var_132_19.localEulerAngles.z = 0
				var_132_19.localEulerAngles.x = 0
				var_132_19.localEulerAngles = var_132_19.localEulerAngles
			end

			if arg_129_1.time_ >= 3.00000000184774 + var_132_20 and arg_129_1.time_ < 3.00000000184774 + var_132_20 + arg_132_0 then
				var_132_19.localPosition = Vector3.New(0, 100, 0)
				var_132_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_19.position).x, (manager.ui.mainCamera.transform.position - var_132_19.position).y, (manager.ui.mainCamera.transform.position - var_132_19.position).z)
				var_132_19.localEulerAngles.z = 0
				var_132_19.localEulerAngles.x = 0
				var_132_19.localEulerAngles = var_132_19.localEulerAngles
			end

			if arg_129_1.frameCnt_ <= 1 then
				arg_129_1.dialog_:SetActive(false)
			end

			local var_132_21 = 6.084000001847
			local var_132_22 = 1.05

			if 6.084000001847 < arg_129_1.time_ and arg_129_1.time_ <= var_132_21 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0

				arg_129_1.dialog_:SetActive(true)

				arg_129_1.dialogCg_.alpha = 0

				local var_132_23 = LeanTween.value(arg_129_1.dialog_, 0, 1, 0.3)

				var_132_23:setOnUpdate(LuaHelper.FloatAction(function(arg_133_0)
					arg_129_1.dialogCg_.alpha = arg_133_0
				end))
				var_132_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_129_1.dialog_)
					var_132_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_129_1.duration_ = arg_129_1.duration_ + 0.3

				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_24 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(1104806030).content)

				arg_129_1.text_.text = var_132_24

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_26 = 42 <= 0 and var_132_22 or var_132_22 * (utf8.len(var_132_24) / 42)

				if (42 <= 0 and var_132_22 or var_132_22 * (utf8.len(var_132_24) / 42)) > 0 and var_132_22 < var_132_26 then
					arg_129_1.talkMaxDuration = var_132_26
					var_132_21 = var_132_21 + 0.3

					if var_132_26 + var_132_21 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_26 + var_132_21
					end
				end

				arg_129_1.text_.text = var_132_24
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_27 = var_132_21 + 0.3
			local var_132_28 = math.max(var_132_22, arg_129_1.talkMaxDuration)

			if var_132_21 + 0.3 <= arg_129_1.time_ and arg_129_1.time_ < var_132_27 + var_132_28 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_27) / var_132_28

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_27 + var_132_28 and arg_129_1.time_ < var_132_27 + var_132_28 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.00000000184774,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.00000000184774,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.00000000184774,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play1104806031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1104806031
		arg_135_1.duration_ = 5.27

		local var_135_0 = {
			zh = 5.266,
			ja = 3.833
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
				arg_135_0:Play1104806032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos114801ui_story = arg_135_1.actors_["114801ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["114801ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos114801ui_story, Vector3.New(0, -0.8, -6.2), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["114801ui_story"].transform.position).z)
				arg_135_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["114801ui_story"].transform.localEulerAngles = arg_135_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["114801ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_135_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["114801ui_story"].transform.position).z)
				arg_135_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["114801ui_story"].transform.localEulerAngles = arg_135_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			local var_138_1 = arg_135_1.actors_["114801ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect114801ui_story == nil then
				arg_135_1.var_.characterEffect114801ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect114801ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect114801ui_story then
				arg_135_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_138_4 = 0
			local var_138_5 = 0.4

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_6 = arg_135_1:GetWordFromCfg(1104806031)
				local var_138_7 = arg_135_1:FormatText(var_138_6.content)

				arg_135_1.text_.text = var_138_7

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_9 = 16 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 16)

				if (16 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 16)) > 0 and var_138_5 < var_138_9 then
					arg_135_1.talkMaxDuration = var_138_9

					if var_138_9 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_7
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806031", "story_v_side_new_1104806.awb") ~= 0 then
					local var_138_10 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806031", "story_v_side_new_1104806.awb") / 1000

					if var_138_10 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_4
					end

					if var_138_6.prefab_name ~= "" and arg_135_1.actors_[var_138_6.prefab_name] ~= nil then
						local var_138_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_6.prefab_name].transform, "story_v_side_new_1104806", "1104806031", "story_v_side_new_1104806.awb")

						arg_135_1:RecordAudio("1104806031", var_138_11)
						arg_135_1:RecordAudio("1104806031", var_138_11)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806031", "story_v_side_new_1104806.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806031", "story_v_side_new_1104806.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_12 = math.max(var_138_5, arg_135_1.talkMaxDuration)

			if var_138_4 <= arg_135_1.time_ and arg_135_1.time_ < var_138_4 + var_138_12 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_4) / var_138_12

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_4 + var_138_12 and arg_135_1.time_ < var_138_4 + var_138_12 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play1104806032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1104806032
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1104806033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["114801ui_story"]) and arg_139_1.var_.characterEffect114801ui_story == nil then
				arg_139_1.var_.characterEffect114801ui_story = arg_139_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["114801ui_story"]) then
				if arg_139_1.var_.characterEffect114801ui_story and not isNil(arg_139_1.actors_["114801ui_story"]) then
					arg_139_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_139_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_0)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["114801ui_story"]) and arg_139_1.var_.characterEffect114801ui_story then
				arg_139_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_139_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			local var_142_1 = 0
			local var_142_2 = 0.8

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_3 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(1104806032).content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 32 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 32)

				if (32 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 32)) > 0 and var_142_2 < var_142_5 then
					arg_139_1.talkMaxDuration = var_142_5

					if var_142_5 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + var_142_1
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_6 = math.max(var_142_2, arg_139_1.talkMaxDuration)

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_6 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_1) / var_142_6

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_1 + var_142_6 and arg_139_1.time_ < var_142_1 + var_142_6 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play1104806033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1104806033
		arg_143_1.duration_ = 3.77

		local var_143_0 = {
			zh = 2.633,
			ja = 3.766
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1104806034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["114801ui_story"]) and arg_143_1.var_.characterEffect114801ui_story == nil then
				arg_143_1.var_.characterEffect114801ui_story = arg_143_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["114801ui_story"]) then
				if arg_143_1.var_.characterEffect114801ui_story and not isNil(arg_143_1.actors_["114801ui_story"]) then
					arg_143_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["114801ui_story"]) and arg_143_1.var_.characterEffect114801ui_story then
				arg_143_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action435")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_146_2 = 0
			local var_146_3 = 0.275

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_2 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_4 = arg_143_1:GetWordFromCfg(1104806033)
				local var_146_5 = arg_143_1:FormatText(var_146_4.content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 11 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 11)

				if (11 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 11)) > 0 and var_146_3 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_2
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806033", "story_v_side_new_1104806.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806033", "story_v_side_new_1104806.awb") / 1000

					if var_146_8 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_2
					end

					if var_146_4.prefab_name ~= "" and arg_143_1.actors_[var_146_4.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_4.prefab_name].transform, "story_v_side_new_1104806", "1104806033", "story_v_side_new_1104806.awb")

						arg_143_1:RecordAudio("1104806033", var_146_9)
						arg_143_1:RecordAudio("1104806033", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806033", "story_v_side_new_1104806.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806033", "story_v_side_new_1104806.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_3, arg_143_1.talkMaxDuration)

			if var_146_2 <= arg_143_1.time_ and arg_143_1.time_ < var_146_2 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_2) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_2 + var_146_10 and arg_143_1.time_ < var_146_2 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play1104806034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1104806034
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1104806035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["114801ui_story"]) and arg_147_1.var_.characterEffect114801ui_story == nil then
				arg_147_1.var_.characterEffect114801ui_story = arg_147_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["114801ui_story"]) then
				if arg_147_1.var_.characterEffect114801ui_story and not isNil(arg_147_1.actors_["114801ui_story"]) then
					arg_147_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_147_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["114801ui_story"]) and arg_147_1.var_.characterEffect114801ui_story then
				arg_147_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_147_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			local var_150_1 = arg_147_1.actors_["114801ui_story"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos114801ui_story = var_150_1.localPosition
			end

			local var_150_2 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 then
				var_150_1.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos114801ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 0) / var_150_2)
				var_150_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_1.position).x, (manager.ui.mainCamera.transform.position - var_150_1.position).y, (manager.ui.mainCamera.transform.position - var_150_1.position).z)
				var_150_1.localEulerAngles.z = 0
				var_150_1.localEulerAngles.x = 0
				var_150_1.localEulerAngles = var_150_1.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 then
				var_150_1.localPosition = Vector3.New(0, 100, 0)
				var_150_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_1.position).x, (manager.ui.mainCamera.transform.position - var_150_1.position).y, (manager.ui.mainCamera.transform.position - var_150_1.position).z)
				var_150_1.localEulerAngles.z = 0
				var_150_1.localEulerAngles.x = 0
				var_150_1.localEulerAngles = var_150_1.localEulerAngles
			end

			local var_150_3 = 0
			local var_150_4 = 1.05

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_3 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_5 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(1104806034).content)

				arg_147_1.text_.text = var_150_5

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_7 = 42 <= 0 and var_150_4 or var_150_4 * (utf8.len(var_150_5) / 42)

				if (42 <= 0 and var_150_4 or var_150_4 * (utf8.len(var_150_5) / 42)) > 0 and var_150_4 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_3 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_3
					end
				end

				arg_147_1.text_.text = var_150_5
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_8 = math.max(var_150_4, arg_147_1.talkMaxDuration)

			if var_150_3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_3 + var_150_8 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_3) / var_150_8

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_3 + var_150_8 and arg_147_1.time_ < var_150_3 + var_150_8 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play1104806035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1104806035
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1104806036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.7

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(1104806035).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 28 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 28)

				if (28 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 28)) > 0 and var_154_0 < var_154_3 then
					arg_151_1.talkMaxDuration = var_154_3

					if var_154_3 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_3 + 0
					end
				end

				arg_151_1.text_.text = var_154_1
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_4 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_4

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play1104806036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1104806036
		arg_155_1.duration_ = 4.37

		local var_155_0 = {
			zh = 4.333,
			ja = 4.366
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1104806037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos114801ui_story = arg_155_1.actors_["114801ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["114801ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos114801ui_story, Vector3.New(0, -0.8, -6.2), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["114801ui_story"].transform.position).z)
				arg_155_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["114801ui_story"].transform.localEulerAngles = arg_155_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["114801ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_155_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["114801ui_story"].transform.position).z)
				arg_155_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["114801ui_story"].transform.localEulerAngles = arg_155_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			local var_158_1 = arg_155_1.actors_["114801ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect114801ui_story == nil then
				arg_155_1.var_.characterEffect114801ui_story = var_158_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 and not isNil(var_158_1) then
				if arg_155_1.var_.characterEffect114801ui_story and not isNil(var_158_1) then
					arg_155_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect114801ui_story then
				arg_155_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_2")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_158_4 = 0
			local var_158_5 = 0.55

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_6 = arg_155_1:GetWordFromCfg(1104806036)
				local var_158_7 = arg_155_1:FormatText(var_158_6.content)

				arg_155_1.text_.text = var_158_7

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_9 = 22 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 22)

				if (22 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 22)) > 0 and var_158_5 < var_158_9 then
					arg_155_1.talkMaxDuration = var_158_9

					if var_158_9 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_9 + var_158_4
					end
				end

				arg_155_1.text_.text = var_158_7
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806036", "story_v_side_new_1104806.awb") ~= 0 then
					local var_158_10 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806036", "story_v_side_new_1104806.awb") / 1000

					if var_158_10 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_4
					end

					if var_158_6.prefab_name ~= "" and arg_155_1.actors_[var_158_6.prefab_name] ~= nil then
						local var_158_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_6.prefab_name].transform, "story_v_side_new_1104806", "1104806036", "story_v_side_new_1104806.awb")

						arg_155_1:RecordAudio("1104806036", var_158_11)
						arg_155_1:RecordAudio("1104806036", var_158_11)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806036", "story_v_side_new_1104806.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806036", "story_v_side_new_1104806.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_12 = math.max(var_158_5, arg_155_1.talkMaxDuration)

			if var_158_4 <= arg_155_1.time_ and arg_155_1.time_ < var_158_4 + var_158_12 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_4) / var_158_12

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_4 + var_158_12 and arg_155_1.time_ < var_158_4 + var_158_12 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
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
	Play1104806037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1104806037
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1104806038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["114801ui_story"]) and arg_159_1.var_.characterEffect114801ui_story == nil then
				arg_159_1.var_.characterEffect114801ui_story = arg_159_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["114801ui_story"]) then
				if arg_159_1.var_.characterEffect114801ui_story and not isNil(arg_159_1.actors_["114801ui_story"]) then
					arg_159_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_159_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_0)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["114801ui_story"]) and arg_159_1.var_.characterEffect114801ui_story then
				arg_159_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_159_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			local var_162_1 = 0
			local var_162_2 = 0.5

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(1104806037).content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 20 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 20)

				if (20 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 20)) > 0 and var_162_2 < var_162_5 then
					arg_159_1.talkMaxDuration = var_162_5

					if var_162_5 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + var_162_1
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_6 = math.max(var_162_2, arg_159_1.talkMaxDuration)

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_6 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_1) / var_162_6

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_1 + var_162_6 and arg_159_1.time_ < var_162_1 + var_162_6 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1104806038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1104806038
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1104806039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.45

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(1104806038).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 18 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 18)

				if (18 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 18)) > 0 and var_166_0 < var_166_3 then
					arg_163_1.talkMaxDuration = var_166_3

					if var_166_3 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_3 + 0
					end
				end

				arg_163_1.text_.text = var_166_1
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_4 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_4

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1104806039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1104806039
		arg_167_1.duration_ = 8.47

		local var_167_0 = {
			zh = 8.466,
			ja = 7.866
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1104806040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["114801ui_story"]) and arg_167_1.var_.characterEffect114801ui_story == nil then
				arg_167_1.var_.characterEffect114801ui_story = arg_167_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["114801ui_story"]) then
				if arg_167_1.var_.characterEffect114801ui_story and not isNil(arg_167_1.actors_["114801ui_story"]) then
					arg_167_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["114801ui_story"]) and arg_167_1.var_.characterEffect114801ui_story then
				arg_167_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_170_2 = 0
			local var_170_3 = 0.925

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_2 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_4 = arg_167_1:GetWordFromCfg(1104806039)
				local var_170_5 = arg_167_1:FormatText(var_170_4.content)

				arg_167_1.text_.text = var_170_5

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_7 = 37 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_5) / 37)

				if (37 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_5) / 37)) > 0 and var_170_3 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_2
					end
				end

				arg_167_1.text_.text = var_170_5
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806039", "story_v_side_new_1104806.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806039", "story_v_side_new_1104806.awb") / 1000

					if var_170_8 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_2
					end

					if var_170_4.prefab_name ~= "" and arg_167_1.actors_[var_170_4.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_4.prefab_name].transform, "story_v_side_new_1104806", "1104806039", "story_v_side_new_1104806.awb")

						arg_167_1:RecordAudio("1104806039", var_170_9)
						arg_167_1:RecordAudio("1104806039", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806039", "story_v_side_new_1104806.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806039", "story_v_side_new_1104806.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_3, arg_167_1.talkMaxDuration)

			if var_170_2 <= arg_167_1.time_ and arg_167_1.time_ < var_170_2 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_2) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_2 + var_170_10 and arg_167_1.time_ < var_170_2 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play1104806040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1104806040
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1104806041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["114801ui_story"]) and arg_171_1.var_.characterEffect114801ui_story == nil then
				arg_171_1.var_.characterEffect114801ui_story = arg_171_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["114801ui_story"]) then
				if arg_171_1.var_.characterEffect114801ui_story and not isNil(arg_171_1.actors_["114801ui_story"]) then
					arg_171_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_171_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_0)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["114801ui_story"]) and arg_171_1.var_.characterEffect114801ui_story then
				arg_171_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_171_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			local var_174_1 = 0
			local var_174_2 = 0.5

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(1104806040).content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 20 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 20)

				if (20 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 20)) > 0 and var_174_2 < var_174_5 then
					arg_171_1.talkMaxDuration = var_174_5

					if var_174_5 + var_174_1 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + var_174_1
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_6 = math.max(var_174_2, arg_171_1.talkMaxDuration)

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_6 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_1) / var_174_6

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_1 + var_174_6 and arg_171_1.time_ < var_174_1 + var_174_6 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1104806041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1104806041
		arg_175_1.duration_ = 7.23

		local var_175_0 = {
			zh = 7.233,
			ja = 6.966
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1104806042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["114801ui_story"]) and arg_175_1.var_.characterEffect114801ui_story == nil then
				arg_175_1.var_.characterEffect114801ui_story = arg_175_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["114801ui_story"]) then
				if arg_175_1.var_.characterEffect114801ui_story and not isNil(arg_175_1.actors_["114801ui_story"]) then
					arg_175_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["114801ui_story"]) and arg_175_1.var_.characterEffect114801ui_story then
				arg_175_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_178_2 = 0
			local var_178_3 = 0.875

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_2 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_4 = arg_175_1:GetWordFromCfg(1104806041)
				local var_178_5 = arg_175_1:FormatText(var_178_4.content)

				arg_175_1.text_.text = var_178_5

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_7 = 35 <= 0 and var_178_3 or var_178_3 * (utf8.len(var_178_5) / 35)

				if (35 <= 0 and var_178_3 or var_178_3 * (utf8.len(var_178_5) / 35)) > 0 and var_178_3 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_2 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_2
					end
				end

				arg_175_1.text_.text = var_178_5
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806041", "story_v_side_new_1104806.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806041", "story_v_side_new_1104806.awb") / 1000

					if var_178_8 + var_178_2 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_2
					end

					if var_178_4.prefab_name ~= "" and arg_175_1.actors_[var_178_4.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_4.prefab_name].transform, "story_v_side_new_1104806", "1104806041", "story_v_side_new_1104806.awb")

						arg_175_1:RecordAudio("1104806041", var_178_9)
						arg_175_1:RecordAudio("1104806041", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806041", "story_v_side_new_1104806.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806041", "story_v_side_new_1104806.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_10 = math.max(var_178_3, arg_175_1.talkMaxDuration)

			if var_178_2 <= arg_175_1.time_ and arg_175_1.time_ < var_178_2 + var_178_10 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_2) / var_178_10

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_2 + var_178_10 and arg_175_1.time_ < var_178_2 + var_178_10 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1104806042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1104806042
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1104806043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["114801ui_story"]) and arg_179_1.var_.characterEffect114801ui_story == nil then
				arg_179_1.var_.characterEffect114801ui_story = arg_179_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["114801ui_story"]) then
				if arg_179_1.var_.characterEffect114801ui_story and not isNil(arg_179_1.actors_["114801ui_story"]) then
					arg_179_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_179_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_0)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["114801ui_story"]) and arg_179_1.var_.characterEffect114801ui_story then
				arg_179_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_179_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			local var_182_1 = arg_179_1.actors_["114801ui_story"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos114801ui_story = var_182_1.localPosition
			end

			local var_182_2 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 then
				var_182_1.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos114801ui_story, Vector3.New(0, 100, 0), (arg_179_1.time_ - 0) / var_182_2)
				var_182_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_1.position).x, (manager.ui.mainCamera.transform.position - var_182_1.position).y, (manager.ui.mainCamera.transform.position - var_182_1.position).z)
				var_182_1.localEulerAngles.z = 0
				var_182_1.localEulerAngles.x = 0
				var_182_1.localEulerAngles = var_182_1.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 then
				var_182_1.localPosition = Vector3.New(0, 100, 0)
				var_182_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_1.position).x, (manager.ui.mainCamera.transform.position - var_182_1.position).y, (manager.ui.mainCamera.transform.position - var_182_1.position).z)
				var_182_1.localEulerAngles.z = 0
				var_182_1.localEulerAngles.x = 0
				var_182_1.localEulerAngles = var_182_1.localEulerAngles
			end

			local var_182_3 = 0
			local var_182_4 = 0.95

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_3 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_5 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(1104806042).content)

				arg_179_1.text_.text = var_182_5

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_7 = 38 <= 0 and var_182_4 or var_182_4 * (utf8.len(var_182_5) / 38)

				if (38 <= 0 and var_182_4 or var_182_4 * (utf8.len(var_182_5) / 38)) > 0 and var_182_4 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_3 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_3
					end
				end

				arg_179_1.text_.text = var_182_5
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_8 = math.max(var_182_4, arg_179_1.talkMaxDuration)

			if var_182_3 <= arg_179_1.time_ and arg_179_1.time_ < var_182_3 + var_182_8 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_3) / var_182_8

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_3 + var_182_8 and arg_179_1.time_ < var_182_3 + var_182_8 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play1104806043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1104806043
		arg_183_1.duration_ = 11.57

		local var_183_0 = {
			zh = 7.7,
			ja = 11.566
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1104806044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos114801ui_story = arg_183_1.actors_["114801ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["114801ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos114801ui_story, Vector3.New(0, -0.8, -6.2), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["114801ui_story"].transform.position).z)
				arg_183_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["114801ui_story"].transform.localEulerAngles = arg_183_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["114801ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_183_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["114801ui_story"].transform.position).z)
				arg_183_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["114801ui_story"].transform.localEulerAngles = arg_183_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["114801ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect114801ui_story == nil then
				arg_183_1.var_.characterEffect114801ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect114801ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect114801ui_story then
				arg_183_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_186_4 = 0
			local var_186_5 = 0.7

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(1104806043)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 28 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 28)

				if (28 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 28)) > 0 and var_186_5 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806043", "story_v_side_new_1104806.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806043", "story_v_side_new_1104806.awb") / 1000

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end

					if var_186_6.prefab_name ~= "" and arg_183_1.actors_[var_186_6.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_6.prefab_name].transform, "story_v_side_new_1104806", "1104806043", "story_v_side_new_1104806.awb")

						arg_183_1:RecordAudio("1104806043", var_186_11)
						arg_183_1:RecordAudio("1104806043", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806043", "story_v_side_new_1104806.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806043", "story_v_side_new_1104806.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_12 = math.max(var_186_5, arg_183_1.talkMaxDuration)

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_12 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_4) / var_186_12

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_4 + var_186_12 and arg_183_1.time_ < var_186_4 + var_186_12 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play1104806044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1104806044
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1104806045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["114801ui_story"]) and arg_187_1.var_.characterEffect114801ui_story == nil then
				arg_187_1.var_.characterEffect114801ui_story = arg_187_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["114801ui_story"]) then
				if arg_187_1.var_.characterEffect114801ui_story and not isNil(arg_187_1.actors_["114801ui_story"]) then
					arg_187_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_187_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["114801ui_story"]) and arg_187_1.var_.characterEffect114801ui_story then
				arg_187_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_187_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			local var_190_1 = 0
			local var_190_2 = 0.575

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_3 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(1104806044).content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 23 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 23)

				if (23 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 23)) > 0 and var_190_2 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_6 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_6 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_6

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_6 and arg_187_1.time_ < var_190_1 + var_190_6 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1104806045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1104806045
		arg_191_1.duration_ = 11

		local var_191_0 = {
			zh = 9.733,
			ja = 11
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
				arg_191_0:Play1104806046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos114801ui_story = arg_191_1.actors_["114801ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["114801ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos114801ui_story, Vector3.New(0, -0.8, -6.2), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["114801ui_story"].transform.position).z)
				arg_191_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["114801ui_story"].transform.localEulerAngles = arg_191_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["114801ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_191_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["114801ui_story"].transform.position).z)
				arg_191_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["114801ui_story"].transform.localEulerAngles = arg_191_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["114801ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect114801ui_story == nil then
				arg_191_1.var_.characterEffect114801ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect114801ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect114801ui_story then
				arg_191_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_2")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_194_4 = 0
			local var_194_5 = 1.05

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_6 = arg_191_1:GetWordFromCfg(1104806045)
				local var_194_7 = arg_191_1:FormatText(var_194_6.content)

				arg_191_1.text_.text = var_194_7

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 42 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 42)

				if (42 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 42)) > 0 and var_194_5 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_4
					end
				end

				arg_191_1.text_.text = var_194_7
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806045", "story_v_side_new_1104806.awb") ~= 0 then
					local var_194_10 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806045", "story_v_side_new_1104806.awb") / 1000

					if var_194_10 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_4
					end

					if var_194_6.prefab_name ~= "" and arg_191_1.actors_[var_194_6.prefab_name] ~= nil then
						local var_194_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_6.prefab_name].transform, "story_v_side_new_1104806", "1104806045", "story_v_side_new_1104806.awb")

						arg_191_1:RecordAudio("1104806045", var_194_11)
						arg_191_1:RecordAudio("1104806045", var_194_11)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806045", "story_v_side_new_1104806.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806045", "story_v_side_new_1104806.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_12 = math.max(var_194_5, arg_191_1.talkMaxDuration)

			if var_194_4 <= arg_191_1.time_ and arg_191_1.time_ < var_194_4 + var_194_12 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_4) / var_194_12

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_4 + var_194_12 and arg_191_1.time_ < var_194_4 + var_194_12 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
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
	Play1104806046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1104806046
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1104806047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["114801ui_story"]) and arg_195_1.var_.characterEffect114801ui_story == nil then
				arg_195_1.var_.characterEffect114801ui_story = arg_195_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["114801ui_story"]) then
				if arg_195_1.var_.characterEffect114801ui_story and not isNil(arg_195_1.actors_["114801ui_story"]) then
					arg_195_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_195_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["114801ui_story"]) and arg_195_1.var_.characterEffect114801ui_story then
				arg_195_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_195_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			local var_198_1 = arg_195_1.actors_["114801ui_story"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos114801ui_story = var_198_1.localPosition
			end

			local var_198_2 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 then
				var_198_1.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos114801ui_story, Vector3.New(0, 100, 0), (arg_195_1.time_ - 0) / var_198_2)
				var_198_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_1.position).x, (manager.ui.mainCamera.transform.position - var_198_1.position).y, (manager.ui.mainCamera.transform.position - var_198_1.position).z)
				var_198_1.localEulerAngles.z = 0
				var_198_1.localEulerAngles.x = 0
				var_198_1.localEulerAngles = var_198_1.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 then
				var_198_1.localPosition = Vector3.New(0, 100, 0)
				var_198_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_1.position).x, (manager.ui.mainCamera.transform.position - var_198_1.position).y, (manager.ui.mainCamera.transform.position - var_198_1.position).z)
				var_198_1.localEulerAngles.z = 0
				var_198_1.localEulerAngles.x = 0
				var_198_1.localEulerAngles = var_198_1.localEulerAngles
			end

			local var_198_3 = 0
			local var_198_4 = 1.125

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_3 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_5 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(1104806046).content)

				arg_195_1.text_.text = var_198_5

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_7 = 45 <= 0 and var_198_4 or var_198_4 * (utf8.len(var_198_5) / 45)

				if (45 <= 0 and var_198_4 or var_198_4 * (utf8.len(var_198_5) / 45)) > 0 and var_198_4 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_3 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_3
					end
				end

				arg_195_1.text_.text = var_198_5
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_8 = math.max(var_198_4, arg_195_1.talkMaxDuration)

			if var_198_3 <= arg_195_1.time_ and arg_195_1.time_ < var_198_3 + var_198_8 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_3) / var_198_8

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_3 + var_198_8 and arg_195_1.time_ < var_198_3 + var_198_8 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play1104806047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1104806047
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1104806048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.225

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(1104806047).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 9 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 9)

				if (9 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 9)) > 0 and var_202_0 < var_202_3 then
					arg_199_1.talkMaxDuration = var_202_3

					if var_202_3 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_3 + 0
					end
				end

				arg_199_1.text_.text = var_202_1
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_4 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_4

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play1104806048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1104806048
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1104806049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.975

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_1 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(1104806048).content)

				arg_203_1.text_.text = var_206_1

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_3 = 39 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 39)

				if (39 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 39)) > 0 and var_206_0 < var_206_3 then
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
	Play1104806049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1104806049
		arg_207_1.duration_ = 5.5

		local var_207_0 = {
			zh = 2.1,
			ja = 5.5
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1104806050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.175

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_1 = arg_207_1:GetWordFromCfg(1104806049)
				local var_210_2 = arg_207_1:FormatText(var_210_1.content)

				arg_207_1.text_.text = var_210_2

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 7 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 7)

				if (7 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 7)) > 0 and var_210_0 < var_210_4 then
					arg_207_1.talkMaxDuration = var_210_4

					if var_210_4 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_4 + 0
					end
				end

				arg_207_1.text_.text = var_210_2
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806049", "story_v_side_new_1104806.awb") ~= 0 then
					local var_210_5 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806049", "story_v_side_new_1104806.awb") / 1000

					if var_210_5 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + 0
					end

					if var_210_1.prefab_name ~= "" and arg_207_1.actors_[var_210_1.prefab_name] ~= nil then
						local var_210_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_1.prefab_name].transform, "story_v_side_new_1104806", "1104806049", "story_v_side_new_1104806.awb")

						arg_207_1:RecordAudio("1104806049", var_210_6)
						arg_207_1:RecordAudio("1104806049", var_210_6)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806049", "story_v_side_new_1104806.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806049", "story_v_side_new_1104806.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play1104806050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1104806050
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1104806051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos114801ui_story = arg_211_1.actors_["114801ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["114801ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos114801ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["114801ui_story"].transform.position).z)
				arg_211_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["114801ui_story"].transform.localEulerAngles = arg_211_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["114801ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["114801ui_story"].transform.position).z)
				arg_211_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["114801ui_story"].transform.localEulerAngles = arg_211_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["114801ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect114801ui_story == nil then
				arg_211_1.var_.characterEffect114801ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect114801ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_211_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_2)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect114801ui_story then
				arg_211_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_211_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			local var_214_3 = 0
			local var_214_4 = 0.7

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_3 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_5 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(1104806050).content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 28 <= 0 and var_214_4 or var_214_4 * (utf8.len(var_214_5) / 28)

				if (28 <= 0 and var_214_4 or var_214_4 * (utf8.len(var_214_5) / 28)) > 0 and var_214_4 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_3 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_3
					end
				end

				arg_211_1.text_.text = var_214_5
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_8 = math.max(var_214_4, arg_211_1.talkMaxDuration)

			if var_214_3 <= arg_211_1.time_ and arg_211_1.time_ < var_214_3 + var_214_8 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_3) / var_214_8

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_3 + var_214_8 and arg_211_1.time_ < var_214_3 + var_214_8 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play1104806051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1104806051
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1104806052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:AudioAction("play", "effect", "se_story_side_1148", "se_story_1148_vibrate", "")
			end

			local var_218_1 = 0
			local var_218_2 = 1.075

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_3 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(1104806051).content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 43 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 43)

				if (43 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 43)) > 0 and var_218_2 < var_218_5 then
					arg_215_1.talkMaxDuration = var_218_5

					if var_218_5 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + var_218_1
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_6 = math.max(var_218_2, arg_215_1.talkMaxDuration)

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_6 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_1) / var_218_6

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_1 + var_218_6 and arg_215_1.time_ < var_218_1 + var_218_6 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play1104806052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1104806052
		arg_219_1.duration_ = 9

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1104806053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if arg_219_1.bgs_.ST10 == nil then
				local var_222_0 = Object.Instantiate(arg_219_1.paintGo_)

				var_222_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST10")
				var_222_0.name = "ST10"
				var_222_0.transform.parent = arg_219_1.stage_.transform
				var_222_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.bgs_.ST10 = var_222_0
			end

			if 1.999999999999 < arg_219_1.time_ and arg_219_1.time_ <= 1.999999999999 + arg_222_0 then
				local var_222_1 = arg_219_1.bgs_.ST10

				arg_219_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_222_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_222_2 = var_222_1:GetComponent("SpriteRenderer")

				if var_222_2 and var_222_2.sprite then
					local var_222_3 = 2 * (var_222_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_222_1.transform.localScale = Vector3.New(var_222_3 / var_222_2.sprite.bounds.size.y < var_222_3 * manager.ui.mainCameraCom_.aspect / var_222_2.sprite.bounds.size.x and var_222_3 * manager.ui.mainCameraCom_.aspect / var_222_2.sprite.bounds.size.x or var_222_3 / var_222_2.sprite.bounds.size.y, var_222_3 / var_222_2.sprite.bounds.size.y < var_222_3 * manager.ui.mainCameraCom_.aspect / var_222_2.sprite.bounds.size.x and var_222_3 * manager.ui.mainCameraCom_.aspect / var_222_2.sprite.bounds.size.x or var_222_3 / var_222_2.sprite.bounds.size.y, 0)
				end

				for iter_222_0, iter_222_1 in pairs(arg_219_1.bgs_) do
					if iter_222_0 ~= "ST10" then
						iter_222_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_222_4 = 0

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_5 = 2

			if var_222_4 <= arg_219_1.time_ and arg_219_1.time_ < var_222_4 + var_222_5 then
				local var_222_6 = Color.New(0, 0, 0)

				var_222_6.a = Mathf.Lerp(0, 1, (arg_219_1.time_ - var_222_4) / var_222_5)
				arg_219_1.mask_.color = var_222_6
			end

			if arg_219_1.time_ >= var_222_4 + var_222_5 and arg_219_1.time_ < var_222_4 + var_222_5 + arg_222_0 then
				local var_222_7 = Color.New(0, 0, 0)

				var_222_7.a = 1
				arg_219_1.mask_.color = var_222_7
			end

			local var_222_8 = 2

			if 2 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_9 = 2

			if var_222_8 <= arg_219_1.time_ and arg_219_1.time_ < var_222_8 + var_222_9 then
				local var_222_10 = Color.New(0, 0, 0)

				var_222_10.a = Mathf.Lerp(1, 0, (arg_219_1.time_ - var_222_8) / var_222_9)
				arg_219_1.mask_.color = var_222_10
			end

			if arg_219_1.time_ >= var_222_8 + var_222_9 and arg_219_1.time_ < var_222_8 + var_222_9 + arg_222_0 then
				local var_222_11 = Color.New(0, 0, 0)

				arg_219_1.mask_.enabled = false
				var_222_11.a = 0
				arg_219_1.mask_.color = var_222_11
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_12 = 3.999999999999
			local var_222_13 = 0.75

			if 3.999999999999 < arg_219_1.time_ and arg_219_1.time_ <= var_222_12 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_14 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_14:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_15 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(1104806052).content)

				arg_219_1.text_.text = var_222_15

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_17 = 30 <= 0 and var_222_13 or var_222_13 * (utf8.len(var_222_15) / 30)

				if (30 <= 0 and var_222_13 or var_222_13 * (utf8.len(var_222_15) / 30)) > 0 and var_222_13 < var_222_17 then
					arg_219_1.talkMaxDuration = var_222_17
					var_222_12 = var_222_12 + 0.3

					if var_222_17 + var_222_12 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_17 + var_222_12
					end
				end

				arg_219_1.text_.text = var_222_15
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_18 = var_222_12 + 0.3
			local var_222_19 = math.max(var_222_13, arg_219_1.talkMaxDuration)

			if var_222_12 + 0.3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_18 + var_222_19 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_18) / var_222_19

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_18 + var_222_19 and arg_219_1.time_ < var_222_18 + var_222_19 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play1104806053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1104806053
		arg_225_1.duration_ = 4.6

		local var_225_0 = {
			zh = 4.6,
			ja = 3.666
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1104806054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if arg_225_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_228_0 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_225_1.stage_.transform)

				var_228_0.name = "1066ui_story"
				var_228_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_225_1.actors_["1066ui_story"] = var_228_0

				local var_228_1 = var_228_0:GetComponentInChildren(typeof(CharacterEffect))

				var_228_1.enabled = true

				local var_228_2 = GameObjectTools.GetOrAddComponent(var_228_0, typeof(DynamicBoneHelper))

				if var_228_2 then
					var_228_2:EnableDynamicBone(false)
				end

				arg_225_1:ShowWeapon(var_228_1.transform, false)

				arg_225_1.var_["1066ui_story" .. "Animator"] = var_228_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_225_1.var_["1066ui_story" .. "Animator"].applyRootMotion = true
				arg_225_1.var_["1066ui_story" .. "LipSync"] = var_228_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_228_3 = arg_225_1.actors_["1066ui_story"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1066ui_story = var_228_3.localPosition
			end

			local var_228_4 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				var_228_3.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_225_1.time_ - 0) / var_228_4)
				var_228_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_3.position).x, (manager.ui.mainCamera.transform.position - var_228_3.position).y, (manager.ui.mainCamera.transform.position - var_228_3.position).z)
				var_228_3.localEulerAngles.z = 0
				var_228_3.localEulerAngles.x = 0
				var_228_3.localEulerAngles = var_228_3.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				var_228_3.localPosition = Vector3.New(0, -0.77, -6.1)
				var_228_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_3.position).x, (manager.ui.mainCamera.transform.position - var_228_3.position).y, (manager.ui.mainCamera.transform.position - var_228_3.position).z)
				var_228_3.localEulerAngles.z = 0
				var_228_3.localEulerAngles.x = 0
				var_228_3.localEulerAngles = var_228_3.localEulerAngles
			end

			local var_228_5 = arg_225_1.actors_["1066ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_5) and arg_225_1.var_.characterEffect1066ui_story == nil then
				arg_225_1.var_.characterEffect1066ui_story = var_228_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_6 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_6 and not isNil(var_228_5) then
				if arg_225_1.var_.characterEffect1066ui_story and not isNil(var_228_5) then
					arg_225_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_6 and arg_225_1.time_ < 0 + var_228_6 + arg_228_0 and not isNil(var_228_5) and arg_225_1.var_.characterEffect1066ui_story then
				arg_225_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_228_8 = 0
			local var_228_9 = 0.425

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_10 = arg_225_1:GetWordFromCfg(1104806053)
				local var_228_11 = arg_225_1:FormatText(var_228_10.content)

				arg_225_1.text_.text = var_228_11

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_13 = 17 <= 0 and var_228_9 or var_228_9 * (utf8.len(var_228_11) / 17)

				if (17 <= 0 and var_228_9 or var_228_9 * (utf8.len(var_228_11) / 17)) > 0 and var_228_9 < var_228_13 then
					arg_225_1.talkMaxDuration = var_228_13

					if var_228_13 + var_228_8 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_13 + var_228_8
					end
				end

				arg_225_1.text_.text = var_228_11
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806053", "story_v_side_new_1104806.awb") ~= 0 then
					local var_228_14 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806053", "story_v_side_new_1104806.awb") / 1000

					if var_228_14 + var_228_8 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_14 + var_228_8
					end

					if var_228_10.prefab_name ~= "" and arg_225_1.actors_[var_228_10.prefab_name] ~= nil then
						local var_228_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_10.prefab_name].transform, "story_v_side_new_1104806", "1104806053", "story_v_side_new_1104806.awb")

						arg_225_1:RecordAudio("1104806053", var_228_15)
						arg_225_1:RecordAudio("1104806053", var_228_15)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806053", "story_v_side_new_1104806.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806053", "story_v_side_new_1104806.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_16 = math.max(var_228_9, arg_225_1.talkMaxDuration)

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_16 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_8) / var_228_16

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_8 + var_228_16 and arg_225_1.time_ < var_228_8 + var_228_16 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
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

		arg_225_1:InitPlayNodeList()
	end,
	Play1104806054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1104806054
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1104806055(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1066ui_story"]) and arg_229_1.var_.characterEffect1066ui_story == nil then
				arg_229_1.var_.characterEffect1066ui_story = arg_229_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1066ui_story"]) then
				if arg_229_1.var_.characterEffect1066ui_story and not isNil(arg_229_1.actors_["1066ui_story"]) then
					arg_229_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_0)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1066ui_story"]) and arg_229_1.var_.characterEffect1066ui_story then
				arg_229_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_232_1 = 0
			local var_232_2 = 0.2

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(1104806054).content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 8 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 8)

				if (8 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 8)) > 0 and var_232_2 < var_232_5 then
					arg_229_1.talkMaxDuration = var_232_5

					if var_232_5 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + var_232_1
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_6 = math.max(var_232_2, arg_229_1.talkMaxDuration)

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_6 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_1) / var_232_6

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_1 + var_232_6 and arg_229_1.time_ < var_232_1 + var_232_6 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1104806055 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1104806055
		arg_233_1.duration_ = 10.97

		local var_233_0 = {
			zh = 4.066,
			ja = 10.966
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1104806056(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1066ui_story = arg_233_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1066ui_story"].transform.position).z)
				arg_233_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1066ui_story"].transform.localEulerAngles = arg_233_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				arg_233_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1066ui_story"].transform.position).z)
				arg_233_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1066ui_story"].transform.localEulerAngles = arg_233_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["1066ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1066ui_story == nil then
				arg_233_1.var_.characterEffect1066ui_story = var_236_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 and not isNil(var_236_1) then
				if arg_233_1.var_.characterEffect1066ui_story and not isNil(var_236_1) then
					arg_233_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_2)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1066ui_story then
				arg_233_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_236_3 = "1033ui_story"

			if arg_233_1.actors_["1033ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1033ui_story"))) then
				local var_236_4 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_233_1.stage_.transform)

				var_236_4.name = var_236_3
				var_236_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.actors_[var_236_3] = var_236_4

				local var_236_5 = var_236_4:GetComponentInChildren(typeof(CharacterEffect))

				var_236_5.enabled = true

				local var_236_6 = GameObjectTools.GetOrAddComponent(var_236_4, typeof(DynamicBoneHelper))

				if var_236_6 then
					var_236_6:EnableDynamicBone(false)
				end

				arg_233_1:ShowWeapon(var_236_5.transform, false)

				arg_233_1.var_[var_236_3 .. "Animator"] = var_236_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_233_1.var_[var_236_3 .. "Animator"].applyRootMotion = true
				arg_233_1.var_[var_236_3 .. "LipSync"] = var_236_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_236_7 = arg_233_1.actors_["1033ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1033ui_story = var_236_7.localPosition
			end

			local var_236_8 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_8 then
				var_236_7.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_233_1.time_ - 0) / var_236_8)
				var_236_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_7.position).x, (manager.ui.mainCamera.transform.position - var_236_7.position).y, (manager.ui.mainCamera.transform.position - var_236_7.position).z)
				var_236_7.localEulerAngles.z = 0
				var_236_7.localEulerAngles.x = 0
				var_236_7.localEulerAngles = var_236_7.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_8 and arg_233_1.time_ < 0 + var_236_8 + arg_236_0 then
				var_236_7.localPosition = Vector3.New(0.7, -1.01, -6.13)
				var_236_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_7.position).x, (manager.ui.mainCamera.transform.position - var_236_7.position).y, (manager.ui.mainCamera.transform.position - var_236_7.position).z)
				var_236_7.localEulerAngles.z = 0
				var_236_7.localEulerAngles.x = 0
				var_236_7.localEulerAngles = var_236_7.localEulerAngles
			end

			local var_236_9 = arg_233_1.actors_["1033ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_9) and arg_233_1.var_.characterEffect1033ui_story == nil then
				arg_233_1.var_.characterEffect1033ui_story = var_236_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_10 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_10 and not isNil(var_236_9) then
				if arg_233_1.var_.characterEffect1033ui_story and not isNil(var_236_9) then
					arg_233_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_10 and arg_233_1.time_ < 0 + var_236_10 + arg_236_0 and not isNil(var_236_9) and arg_233_1.var_.characterEffect1033ui_story then
				arg_233_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_236_12 = 0
			local var_236_13 = 0.45

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_12 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_14 = arg_233_1:GetWordFromCfg(1104806055)
				local var_236_15 = arg_233_1:FormatText(var_236_14.content)

				arg_233_1.text_.text = var_236_15

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_17 = 18 <= 0 and var_236_13 or var_236_13 * (utf8.len(var_236_15) / 18)

				if (18 <= 0 and var_236_13 or var_236_13 * (utf8.len(var_236_15) / 18)) > 0 and var_236_13 < var_236_17 then
					arg_233_1.talkMaxDuration = var_236_17

					if var_236_17 + var_236_12 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_17 + var_236_12
					end
				end

				arg_233_1.text_.text = var_236_15
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806055", "story_v_side_new_1104806.awb") ~= 0 then
					local var_236_18 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806055", "story_v_side_new_1104806.awb") / 1000

					if var_236_18 + var_236_12 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_18 + var_236_12
					end

					if var_236_14.prefab_name ~= "" and arg_233_1.actors_[var_236_14.prefab_name] ~= nil then
						local var_236_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_14.prefab_name].transform, "story_v_side_new_1104806", "1104806055", "story_v_side_new_1104806.awb")

						arg_233_1:RecordAudio("1104806055", var_236_19)
						arg_233_1:RecordAudio("1104806055", var_236_19)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806055", "story_v_side_new_1104806.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806055", "story_v_side_new_1104806.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_20 = math.max(var_236_13, arg_233_1.talkMaxDuration)

			if var_236_12 <= arg_233_1.time_ and arg_233_1.time_ < var_236_12 + var_236_20 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_12) / var_236_20

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_12 + var_236_20 and arg_233_1.time_ < var_236_12 + var_236_20 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
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

		arg_233_1:InitPlayNodeList()
	end,
	Play1104806056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1104806056
		arg_237_1.duration_ = 9.33

		local var_237_0 = {
			zh = 7.566,
			ja = 9.333
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1104806057(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_240_0 = 0
			local var_240_1 = 0.875

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_2 = arg_237_1:GetWordFromCfg(1104806056)
				local var_240_3 = arg_237_1:FormatText(var_240_2.content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 35 <= 0 and var_240_1 or var_240_1 * (utf8.len(var_240_3) / 35)

				if (35 <= 0 and var_240_1 or var_240_1 * (utf8.len(var_240_3) / 35)) > 0 and var_240_1 < var_240_5 then
					arg_237_1.talkMaxDuration = var_240_5

					if var_240_5 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806056", "story_v_side_new_1104806.awb") ~= 0 then
					local var_240_6 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806056", "story_v_side_new_1104806.awb") / 1000

					if var_240_6 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_6 + var_240_0
					end

					if var_240_2.prefab_name ~= "" and arg_237_1.actors_[var_240_2.prefab_name] ~= nil then
						local var_240_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_2.prefab_name].transform, "story_v_side_new_1104806", "1104806056", "story_v_side_new_1104806.awb")

						arg_237_1:RecordAudio("1104806056", var_240_7)
						arg_237_1:RecordAudio("1104806056", var_240_7)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806056", "story_v_side_new_1104806.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806056", "story_v_side_new_1104806.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_8 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_8 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_8

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_8 and arg_237_1.time_ < var_240_0 + var_240_8 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play1104806057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1104806057
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1104806058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1033ui_story"]) and arg_241_1.var_.characterEffect1033ui_story == nil then
				arg_241_1.var_.characterEffect1033ui_story = arg_241_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1033ui_story"]) then
				if arg_241_1.var_.characterEffect1033ui_story and not isNil(arg_241_1.actors_["1033ui_story"]) then
					arg_241_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_0)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1033ui_story"]) and arg_241_1.var_.characterEffect1033ui_story then
				arg_241_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_244_1 = 0
			local var_244_2 = 0.75

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_3 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(1104806057).content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 30 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 30)

				if (30 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 30)) > 0 and var_244_2 < var_244_5 then
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
	Play1104806058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1104806058
		arg_245_1.duration_ = 9.6

		local var_245_0 = {
			zh = 9.6,
			ja = 9.366
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1104806059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1066ui_story"]) and arg_245_1.var_.characterEffect1066ui_story == nil then
				arg_245_1.var_.characterEffect1066ui_story = arg_245_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1066ui_story"]) then
				if arg_245_1.var_.characterEffect1066ui_story and not isNil(arg_245_1.actors_["1066ui_story"]) then
					arg_245_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1066ui_story"]) and arg_245_1.var_.characterEffect1066ui_story then
				arg_245_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_248_2 = 0
			local var_248_3 = 1.15

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_2 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_4 = arg_245_1:GetWordFromCfg(1104806058)
				local var_248_5 = arg_245_1:FormatText(var_248_4.content)

				arg_245_1.text_.text = var_248_5

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_7 = 46 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_5) / 46)

				if (46 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_5) / 46)) > 0 and var_248_3 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_2
					end
				end

				arg_245_1.text_.text = var_248_5
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806058", "story_v_side_new_1104806.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806058", "story_v_side_new_1104806.awb") / 1000

					if var_248_8 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_2
					end

					if var_248_4.prefab_name ~= "" and arg_245_1.actors_[var_248_4.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_4.prefab_name].transform, "story_v_side_new_1104806", "1104806058", "story_v_side_new_1104806.awb")

						arg_245_1:RecordAudio("1104806058", var_248_9)
						arg_245_1:RecordAudio("1104806058", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806058", "story_v_side_new_1104806.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806058", "story_v_side_new_1104806.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_10 = math.max(var_248_3, arg_245_1.talkMaxDuration)

			if var_248_2 <= arg_245_1.time_ and arg_245_1.time_ < var_248_2 + var_248_10 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_2) / var_248_10

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_2 + var_248_10 and arg_245_1.time_ < var_248_2 + var_248_10 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play1104806059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1104806059
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1104806060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1066ui_story"]) and arg_249_1.var_.characterEffect1066ui_story == nil then
				arg_249_1.var_.characterEffect1066ui_story = arg_249_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1066ui_story"]) then
				if arg_249_1.var_.characterEffect1066ui_story and not isNil(arg_249_1.actors_["1066ui_story"]) then
					arg_249_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_0)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1066ui_story"]) and arg_249_1.var_.characterEffect1066ui_story then
				arg_249_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_252_1 = 0
			local var_252_2 = 0.6

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(1104806059).content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 24 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 24)

				if (24 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 24)) > 0 and var_252_2 < var_252_5 then
					arg_249_1.talkMaxDuration = var_252_5

					if var_252_5 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_6 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_6 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_6

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_6 and arg_249_1.time_ < var_252_1 + var_252_6 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1104806060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1104806060
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1104806061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.3

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_1 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(1104806060).content)

				arg_253_1.text_.text = var_256_1

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_3 = 12 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 12)

				if (12 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 12)) > 0 and var_256_0 < var_256_3 then
					arg_253_1.talkMaxDuration = var_256_3

					if var_256_3 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_3 + 0
					end
				end

				arg_253_1.text_.text = var_256_1
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_4 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_4

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play1104806061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1104806061
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1104806062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.85

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(1104806061).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 34 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 34)

				if (34 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 34)) > 0 and var_260_0 < var_260_3 then
					arg_257_1.talkMaxDuration = var_260_3

					if var_260_3 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_3 + 0
					end
				end

				arg_257_1.text_.text = var_260_1
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_4 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_4

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play1104806062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1104806062
		arg_261_1.duration_ = 9.83

		local var_261_0 = {
			zh = 7.4,
			ja = 9.833
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
				arg_261_0:Play1104806063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1033ui_story"]) and arg_261_1.var_.characterEffect1033ui_story == nil then
				arg_261_1.var_.characterEffect1033ui_story = arg_261_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1033ui_story"]) then
				if arg_261_1.var_.characterEffect1033ui_story and not isNil(arg_261_1.actors_["1033ui_story"]) then
					arg_261_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1033ui_story"]) and arg_261_1.var_.characterEffect1033ui_story then
				arg_261_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_2")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_264_2 = 0
			local var_264_3 = 0.95

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_2 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_4 = arg_261_1:GetWordFromCfg(1104806062)
				local var_264_5 = arg_261_1:FormatText(var_264_4.content)

				arg_261_1.text_.text = var_264_5

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_7 = 38 <= 0 and var_264_3 or var_264_3 * (utf8.len(var_264_5) / 38)

				if (38 <= 0 and var_264_3 or var_264_3 * (utf8.len(var_264_5) / 38)) > 0 and var_264_3 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_2 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_2
					end
				end

				arg_261_1.text_.text = var_264_5
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806062", "story_v_side_new_1104806.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806062", "story_v_side_new_1104806.awb") / 1000

					if var_264_8 + var_264_2 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_2
					end

					if var_264_4.prefab_name ~= "" and arg_261_1.actors_[var_264_4.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_4.prefab_name].transform, "story_v_side_new_1104806", "1104806062", "story_v_side_new_1104806.awb")

						arg_261_1:RecordAudio("1104806062", var_264_9)
						arg_261_1:RecordAudio("1104806062", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806062", "story_v_side_new_1104806.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806062", "story_v_side_new_1104806.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_3, arg_261_1.talkMaxDuration)

			if var_264_2 <= arg_261_1.time_ and arg_261_1.time_ < var_264_2 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_2) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_2 + var_264_10 and arg_261_1.time_ < var_264_2 + var_264_10 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play1104806063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1104806063
		arg_265_1.duration_ = 6.2

		local var_265_0 = {
			zh = 6.2,
			ja = 4.466
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
				arg_265_0:Play1104806064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1066ui_story"]) and arg_265_1.var_.characterEffect1066ui_story == nil then
				arg_265_1.var_.characterEffect1066ui_story = arg_265_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1066ui_story"]) then
				if arg_265_1.var_.characterEffect1066ui_story and not isNil(arg_265_1.actors_["1066ui_story"]) then
					arg_265_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1066ui_story"]) and arg_265_1.var_.characterEffect1066ui_story then
				arg_265_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action436")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_268_2 = arg_265_1.actors_["1033ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.characterEffect1033ui_story == nil then
				arg_265_1.var_.characterEffect1033ui_story = var_268_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_3 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_3 and not isNil(var_268_2) then
				if arg_265_1.var_.characterEffect1033ui_story and not isNil(var_268_2) then
					arg_265_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_3)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_3 and arg_265_1.time_ < 0 + var_268_3 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.characterEffect1033ui_story then
				arg_265_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_268_4 = 0
			local var_268_5 = 0.875

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_6 = arg_265_1:GetWordFromCfg(1104806063)
				local var_268_7 = arg_265_1:FormatText(var_268_6.content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 35 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 35)

				if (35 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 35)) > 0 and var_268_5 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_4
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806063", "story_v_side_new_1104806.awb") ~= 0 then
					local var_268_10 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806063", "story_v_side_new_1104806.awb") / 1000

					if var_268_10 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_4
					end

					if var_268_6.prefab_name ~= "" and arg_265_1.actors_[var_268_6.prefab_name] ~= nil then
						local var_268_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_6.prefab_name].transform, "story_v_side_new_1104806", "1104806063", "story_v_side_new_1104806.awb")

						arg_265_1:RecordAudio("1104806063", var_268_11)
						arg_265_1:RecordAudio("1104806063", var_268_11)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806063", "story_v_side_new_1104806.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806063", "story_v_side_new_1104806.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_12 = math.max(var_268_5, arg_265_1.talkMaxDuration)

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_12 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_4) / var_268_12

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_4 + var_268_12 and arg_265_1.time_ < var_268_4 + var_268_12 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play1104806064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1104806064
		arg_269_1.duration_ = 5.7

		local var_269_0 = {
			zh = 3.8,
			ja = 5.7
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
				arg_269_0:Play1104806065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action6_2")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_272_0 = 0
			local var_272_1 = 0.45

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_2 = arg_269_1:GetWordFromCfg(1104806064)
				local var_272_3 = arg_269_1:FormatText(var_272_2.content)

				arg_269_1.text_.text = var_272_3

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 18 <= 0 and var_272_1 or var_272_1 * (utf8.len(var_272_3) / 18)

				if (18 <= 0 and var_272_1 or var_272_1 * (utf8.len(var_272_3) / 18)) > 0 and var_272_1 < var_272_5 then
					arg_269_1.talkMaxDuration = var_272_5

					if var_272_5 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_3
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806064", "story_v_side_new_1104806.awb") ~= 0 then
					local var_272_6 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806064", "story_v_side_new_1104806.awb") / 1000

					if var_272_6 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_6 + var_272_0
					end

					if var_272_2.prefab_name ~= "" and arg_269_1.actors_[var_272_2.prefab_name] ~= nil then
						local var_272_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_2.prefab_name].transform, "story_v_side_new_1104806", "1104806064", "story_v_side_new_1104806.awb")

						arg_269_1:RecordAudio("1104806064", var_272_7)
						arg_269_1:RecordAudio("1104806064", var_272_7)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806064", "story_v_side_new_1104806.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806064", "story_v_side_new_1104806.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_8 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_8 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_8

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_8 and arg_269_1.time_ < var_272_0 + var_272_8 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play1104806065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1104806065
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1104806066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1066ui_story"]) and arg_273_1.var_.characterEffect1066ui_story == nil then
				arg_273_1.var_.characterEffect1066ui_story = arg_273_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1066ui_story"]) then
				if arg_273_1.var_.characterEffect1066ui_story and not isNil(arg_273_1.actors_["1066ui_story"]) then
					arg_273_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_0)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1066ui_story"]) and arg_273_1.var_.characterEffect1066ui_story then
				arg_273_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_276_1 = 0
			local var_276_2 = 0.425

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_3 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(1104806065).content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 17 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 17)

				if (17 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 17)) > 0 and var_276_2 < var_276_5 then
					arg_273_1.talkMaxDuration = var_276_5

					if var_276_5 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_3
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_6 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_6 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_6

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_6 and arg_273_1.time_ < var_276_1 + var_276_6 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play1104806066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1104806066
		arg_277_1.duration_ = 9.8

		local var_277_0 = {
			zh = 6.5,
			ja = 9.8
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
				arg_277_0:Play1104806067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["1066ui_story"]) and arg_277_1.var_.characterEffect1066ui_story == nil then
				arg_277_1.var_.characterEffect1066ui_story = arg_277_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["1066ui_story"]) then
				if arg_277_1.var_.characterEffect1066ui_story and not isNil(arg_277_1.actors_["1066ui_story"]) then
					arg_277_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["1066ui_story"]) and arg_277_1.var_.characterEffect1066ui_story then
				arg_277_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_280_2 = 0
			local var_280_3 = 0.925

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_2 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0

				arg_277_1.dialog_:SetActive(true)

				arg_277_1.dialogCg_.alpha = 0

				local var_280_4 = LeanTween.value(arg_277_1.dialog_, 0, 1, 0.3)

				var_280_4:setOnUpdate(LuaHelper.FloatAction(function(arg_281_0)
					arg_277_1.dialogCg_.alpha = arg_281_0
				end))
				var_280_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_277_1.dialog_)
					var_280_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_277_1.duration_ = arg_277_1.duration_ + 0.3

				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_5 = arg_277_1:GetWordFromCfg(1104806066)
				local var_280_6 = arg_277_1:FormatText(var_280_5.content)

				arg_277_1.text_.text = var_280_6

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_8 = 37 <= 0 and var_280_3 or var_280_3 * (utf8.len(var_280_6) / 37)

				if (37 <= 0 and var_280_3 or var_280_3 * (utf8.len(var_280_6) / 37)) > 0 and var_280_3 < var_280_8 then
					arg_277_1.talkMaxDuration = var_280_8
					var_280_2 = var_280_2 + 0.3

					if var_280_8 + var_280_2 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_2
					end
				end

				arg_277_1.text_.text = var_280_6
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806066", "story_v_side_new_1104806.awb") ~= 0 then
					local var_280_9 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806066", "story_v_side_new_1104806.awb") / 1000

					if var_280_9 + var_280_2 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_2
					end

					if var_280_5.prefab_name ~= "" and arg_277_1.actors_[var_280_5.prefab_name] ~= nil then
						local var_280_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_5.prefab_name].transform, "story_v_side_new_1104806", "1104806066", "story_v_side_new_1104806.awb")

						arg_277_1:RecordAudio("1104806066", var_280_10)
						arg_277_1:RecordAudio("1104806066", var_280_10)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806066", "story_v_side_new_1104806.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806066", "story_v_side_new_1104806.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_11 = var_280_2 + 0.3
			local var_280_12 = math.max(var_280_3, arg_277_1.talkMaxDuration)

			if var_280_2 + 0.3 <= arg_277_1.time_ and arg_277_1.time_ < var_280_11 + var_280_12 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_11) / var_280_12

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_11 + var_280_12 and arg_277_1.time_ < var_280_11 + var_280_12 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1104806067 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1104806067
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1104806068(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1066ui_story"]) and arg_283_1.var_.characterEffect1066ui_story == nil then
				arg_283_1.var_.characterEffect1066ui_story = arg_283_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1066ui_story"]) then
				if arg_283_1.var_.characterEffect1066ui_story and not isNil(arg_283_1.actors_["1066ui_story"]) then
					arg_283_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_0)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1066ui_story"]) and arg_283_1.var_.characterEffect1066ui_story then
				arg_283_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_286_1 = 0
			local var_286_2 = 0.725

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_3 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(1104806067).content)

				arg_283_1.text_.text = var_286_3

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 29 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 29)

				if (29 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 29)) > 0 and var_286_2 < var_286_5 then
					arg_283_1.talkMaxDuration = var_286_5

					if var_286_5 + var_286_1 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + var_286_1
					end
				end

				arg_283_1.text_.text = var_286_3
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_6 = math.max(var_286_2, arg_283_1.talkMaxDuration)

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_6 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_1) / var_286_6

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_1 + var_286_6 and arg_283_1.time_ < var_286_1 + var_286_6 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play1104806068 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1104806068
		arg_287_1.duration_ = 7.2

		local var_287_0 = {
			zh = 5.933,
			ja = 7.2
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1104806069(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1066ui_story"]) and arg_287_1.var_.characterEffect1066ui_story == nil then
				arg_287_1.var_.characterEffect1066ui_story = arg_287_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1066ui_story"]) then
				if arg_287_1.var_.characterEffect1066ui_story and not isNil(arg_287_1.actors_["1066ui_story"]) then
					arg_287_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1066ui_story"]) and arg_287_1.var_.characterEffect1066ui_story then
				arg_287_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_290_2 = 0
			local var_290_3 = 0.675

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_2 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_4 = arg_287_1:GetWordFromCfg(1104806068)
				local var_290_5 = arg_287_1:FormatText(var_290_4.content)

				arg_287_1.text_.text = var_290_5

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_7 = 27 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 27)

				if (27 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 27)) > 0 and var_290_3 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_2
					end
				end

				arg_287_1.text_.text = var_290_5
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806068", "story_v_side_new_1104806.awb") ~= 0 then
					local var_290_8 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806068", "story_v_side_new_1104806.awb") / 1000

					if var_290_8 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_2
					end

					if var_290_4.prefab_name ~= "" and arg_287_1.actors_[var_290_4.prefab_name] ~= nil then
						local var_290_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_4.prefab_name].transform, "story_v_side_new_1104806", "1104806068", "story_v_side_new_1104806.awb")

						arg_287_1:RecordAudio("1104806068", var_290_9)
						arg_287_1:RecordAudio("1104806068", var_290_9)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806068", "story_v_side_new_1104806.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806068", "story_v_side_new_1104806.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_3, arg_287_1.talkMaxDuration)

			if var_290_2 <= arg_287_1.time_ and arg_287_1.time_ < var_290_2 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_2) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_2 + var_290_10 and arg_287_1.time_ < var_290_2 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1104806069 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1104806069
		arg_291_1.duration_ = 11.8

		local var_291_0 = {
			zh = 11.8,
			ja = 7.9
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1104806070(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1033ui_story"]) and arg_291_1.var_.characterEffect1033ui_story == nil then
				arg_291_1.var_.characterEffect1033ui_story = arg_291_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1033ui_story"]) then
				if arg_291_1.var_.characterEffect1033ui_story and not isNil(arg_291_1.actors_["1033ui_story"]) then
					arg_291_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1033ui_story"]) and arg_291_1.var_.characterEffect1033ui_story then
				arg_291_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action4_1")
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_294_2 = arg_291_1.actors_["1066ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_2) and arg_291_1.var_.characterEffect1066ui_story == nil then
				arg_291_1.var_.characterEffect1066ui_story = var_294_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_3 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_3 and not isNil(var_294_2) then
				if arg_291_1.var_.characterEffect1066ui_story and not isNil(var_294_2) then
					arg_291_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_3)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_3 and arg_291_1.time_ < 0 + var_294_3 + arg_294_0 and not isNil(var_294_2) and arg_291_1.var_.characterEffect1066ui_story then
				arg_291_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_294_4 = 0
			local var_294_5 = 1.3

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_4 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_6 = arg_291_1:GetWordFromCfg(1104806069)
				local var_294_7 = arg_291_1:FormatText(var_294_6.content)

				arg_291_1.text_.text = var_294_7

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_9 = 52 <= 0 and var_294_5 or var_294_5 * (utf8.len(var_294_7) / 52)

				if (52 <= 0 and var_294_5 or var_294_5 * (utf8.len(var_294_7) / 52)) > 0 and var_294_5 < var_294_9 then
					arg_291_1.talkMaxDuration = var_294_9

					if var_294_9 + var_294_4 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_9 + var_294_4
					end
				end

				arg_291_1.text_.text = var_294_7
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806069", "story_v_side_new_1104806.awb") ~= 0 then
					local var_294_10 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806069", "story_v_side_new_1104806.awb") / 1000

					if var_294_10 + var_294_4 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_10 + var_294_4
					end

					if var_294_6.prefab_name ~= "" and arg_291_1.actors_[var_294_6.prefab_name] ~= nil then
						local var_294_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_6.prefab_name].transform, "story_v_side_new_1104806", "1104806069", "story_v_side_new_1104806.awb")

						arg_291_1:RecordAudio("1104806069", var_294_11)
						arg_291_1:RecordAudio("1104806069", var_294_11)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806069", "story_v_side_new_1104806.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806069", "story_v_side_new_1104806.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_12 = math.max(var_294_5, arg_291_1.talkMaxDuration)

			if var_294_4 <= arg_291_1.time_ and arg_291_1.time_ < var_294_4 + var_294_12 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_4) / var_294_12

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_4 + var_294_12 and arg_291_1.time_ < var_294_4 + var_294_12 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play1104806070 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1104806070
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1104806071(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["1033ui_story"]) and arg_295_1.var_.characterEffect1033ui_story == nil then
				arg_295_1.var_.characterEffect1033ui_story = arg_295_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_0 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["1033ui_story"]) then
				if arg_295_1.var_.characterEffect1033ui_story and not isNil(arg_295_1.actors_["1033ui_story"]) then
					arg_295_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_0)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["1033ui_story"]) and arg_295_1.var_.characterEffect1033ui_story then
				arg_295_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_298_1 = 0
			local var_298_2 = 0.3

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_3 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(1104806070).content)

				arg_295_1.text_.text = var_298_3

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 12 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 12)

				if (12 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 12)) > 0 and var_298_2 < var_298_5 then
					arg_295_1.talkMaxDuration = var_298_5

					if var_298_5 + var_298_1 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + var_298_1
					end
				end

				arg_295_1.text_.text = var_298_3
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_6 = math.max(var_298_2, arg_295_1.talkMaxDuration)

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_6 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_1) / var_298_6

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_1 + var_298_6 and arg_295_1.time_ < var_298_1 + var_298_6 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play1104806071 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1104806071
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1104806072(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 1.25

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_1 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(1104806071).content)

				arg_299_1.text_.text = var_302_1

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_3 = 50 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 50)

				if (50 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 50)) > 0 and var_302_0 < var_302_3 then
					arg_299_1.talkMaxDuration = var_302_3

					if var_302_3 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_3 + 0
					end
				end

				arg_299_1.text_.text = var_302_1
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_4 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_4

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play1104806072 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1104806072
		arg_303_1.duration_ = 5.2

		local var_303_0 = {
			zh = 5.2,
			ja = 4.866
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1104806073(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1066ui_story"]) and arg_303_1.var_.characterEffect1066ui_story == nil then
				arg_303_1.var_.characterEffect1066ui_story = arg_303_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1066ui_story"]) then
				if arg_303_1.var_.characterEffect1066ui_story and not isNil(arg_303_1.actors_["1066ui_story"]) then
					arg_303_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1066ui_story"]) and arg_303_1.var_.characterEffect1066ui_story then
				arg_303_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_306_2 = 0
			local var_306_3 = 0.675

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_2 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_4 = arg_303_1:GetWordFromCfg(1104806072)
				local var_306_5 = arg_303_1:FormatText(var_306_4.content)

				arg_303_1.text_.text = var_306_5

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_7 = 27 <= 0 and var_306_3 or var_306_3 * (utf8.len(var_306_5) / 27)

				if (27 <= 0 and var_306_3 or var_306_3 * (utf8.len(var_306_5) / 27)) > 0 and var_306_3 < var_306_7 then
					arg_303_1.talkMaxDuration = var_306_7

					if var_306_7 + var_306_2 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_2
					end
				end

				arg_303_1.text_.text = var_306_5
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806072", "story_v_side_new_1104806.awb") ~= 0 then
					local var_306_8 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806072", "story_v_side_new_1104806.awb") / 1000

					if var_306_8 + var_306_2 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_8 + var_306_2
					end

					if var_306_4.prefab_name ~= "" and arg_303_1.actors_[var_306_4.prefab_name] ~= nil then
						local var_306_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_4.prefab_name].transform, "story_v_side_new_1104806", "1104806072", "story_v_side_new_1104806.awb")

						arg_303_1:RecordAudio("1104806072", var_306_9)
						arg_303_1:RecordAudio("1104806072", var_306_9)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806072", "story_v_side_new_1104806.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806072", "story_v_side_new_1104806.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_10 = math.max(var_306_3, arg_303_1.talkMaxDuration)

			if var_306_2 <= arg_303_1.time_ and arg_303_1.time_ < var_306_2 + var_306_10 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_2) / var_306_10

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_2 + var_306_10 and arg_303_1.time_ < var_306_2 + var_306_10 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play1104806073 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1104806073
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1104806074(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["1066ui_story"]) and arg_307_1.var_.characterEffect1066ui_story == nil then
				arg_307_1.var_.characterEffect1066ui_story = arg_307_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["1066ui_story"]) then
				if arg_307_1.var_.characterEffect1066ui_story and not isNil(arg_307_1.actors_["1066ui_story"]) then
					arg_307_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_307_1.time_ - 0) / var_310_0)
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["1066ui_story"]) and arg_307_1.var_.characterEffect1066ui_story then
				arg_307_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_310_1 = 0
			local var_310_2 = 0.175

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_3 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(1104806073).content)

				arg_307_1.text_.text = var_310_3

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 7 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_3) / 7)

				if (7 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_3) / 7)) > 0 and var_310_2 < var_310_5 then
					arg_307_1.talkMaxDuration = var_310_5

					if var_310_5 + var_310_1 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + var_310_1
					end
				end

				arg_307_1.text_.text = var_310_3
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_6 = math.max(var_310_2, arg_307_1.talkMaxDuration)

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_6 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_1) / var_310_6

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_1 + var_310_6 and arg_307_1.time_ < var_310_1 + var_310_6 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play1104806074 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1104806074
		arg_311_1.duration_ = 7.6

		local var_311_0 = {
			zh = 7.5,
			ja = 7.6
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1104806075(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if arg_311_1.bgs_.STblack == nil then
				local var_314_0 = Object.Instantiate(arg_311_1.paintGo_)

				var_314_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_314_0.name = "STblack"
				var_314_0.transform.parent = arg_311_1.stage_.transform
				var_314_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_311_1.bgs_.STblack = var_314_0
			end

			if 2 < arg_311_1.time_ and arg_311_1.time_ <= 2 + arg_314_0 then
				local var_314_1 = arg_311_1.bgs_.STblack

				arg_311_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_314_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_314_2 = var_314_1:GetComponent("SpriteRenderer")

				if var_314_2 and var_314_2.sprite then
					local var_314_3 = 2 * (var_314_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_314_1.transform.localScale = Vector3.New(var_314_3 / var_314_2.sprite.bounds.size.y < var_314_3 * manager.ui.mainCameraCom_.aspect / var_314_2.sprite.bounds.size.x and var_314_3 * manager.ui.mainCameraCom_.aspect / var_314_2.sprite.bounds.size.x or var_314_3 / var_314_2.sprite.bounds.size.y, var_314_3 / var_314_2.sprite.bounds.size.y < var_314_3 * manager.ui.mainCameraCom_.aspect / var_314_2.sprite.bounds.size.x and var_314_3 * manager.ui.mainCameraCom_.aspect / var_314_2.sprite.bounds.size.x or var_314_3 / var_314_2.sprite.bounds.size.y, 0)
				end

				for iter_314_0, iter_314_1 in pairs(arg_311_1.bgs_) do
					if iter_314_0 ~= "STblack" then
						iter_314_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_314_4 = 0

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_4 + arg_314_0 then
				arg_311_1.mask_.enabled = true
				arg_311_1.mask_.raycastTarget = true

				arg_311_1:SetGaussion(false)
			end

			local var_314_5 = 2

			if var_314_4 <= arg_311_1.time_ and arg_311_1.time_ < var_314_4 + var_314_5 then
				local var_314_6 = Color.New(0, 0, 0)

				var_314_6.a = Mathf.Lerp(0, 1, (arg_311_1.time_ - var_314_4) / var_314_5)
				arg_311_1.mask_.color = var_314_6
			end

			if arg_311_1.time_ >= var_314_4 + var_314_5 and arg_311_1.time_ < var_314_4 + var_314_5 + arg_314_0 then
				local var_314_7 = Color.New(0, 0, 0)

				var_314_7.a = 1
				arg_311_1.mask_.color = var_314_7
			end

			local var_314_8 = 2

			if 2 < arg_311_1.time_ and arg_311_1.time_ <= var_314_8 + arg_314_0 then
				arg_311_1.mask_.enabled = true
				arg_311_1.mask_.raycastTarget = true

				arg_311_1:SetGaussion(false)
			end

			local var_314_9 = 2

			if var_314_8 <= arg_311_1.time_ and arg_311_1.time_ < var_314_8 + var_314_9 then
				local var_314_10 = Color.New(0, 0, 0)

				var_314_10.a = Mathf.Lerp(1, 0, (arg_311_1.time_ - var_314_8) / var_314_9)
				arg_311_1.mask_.color = var_314_10
			end

			if arg_311_1.time_ >= var_314_8 + var_314_9 and arg_311_1.time_ < var_314_8 + var_314_9 + arg_314_0 then
				local var_314_11 = Color.New(0, 0, 0)

				arg_311_1.mask_.enabled = false
				var_314_11.a = 0
				arg_311_1.mask_.color = var_314_11
			end

			local var_314_12 = arg_311_1.actors_["1033ui_story"].transform

			if 1.96599999815226 < arg_311_1.time_ and arg_311_1.time_ <= 1.96599999815226 + arg_314_0 then
				arg_311_1.var_.moveOldPos1033ui_story = var_314_12.localPosition
			end

			local var_314_13 = 0.001

			if 1.96599999815226 <= arg_311_1.time_ and arg_311_1.time_ < 1.96599999815226 + var_314_13 then
				var_314_12.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_311_1.time_ - 1.96599999815226) / var_314_13)
				var_314_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_314_12.position).x, (manager.ui.mainCamera.transform.position - var_314_12.position).y, (manager.ui.mainCamera.transform.position - var_314_12.position).z)
				var_314_12.localEulerAngles.z = 0
				var_314_12.localEulerAngles.x = 0
				var_314_12.localEulerAngles = var_314_12.localEulerAngles
			end

			if arg_311_1.time_ >= 1.96599999815226 + var_314_13 and arg_311_1.time_ < 1.96599999815226 + var_314_13 + arg_314_0 then
				var_314_12.localPosition = Vector3.New(0, 100, 0)
				var_314_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_314_12.position).x, (manager.ui.mainCamera.transform.position - var_314_12.position).y, (manager.ui.mainCamera.transform.position - var_314_12.position).z)
				var_314_12.localEulerAngles.z = 0
				var_314_12.localEulerAngles.x = 0
				var_314_12.localEulerAngles = var_314_12.localEulerAngles
			end

			local var_314_14 = arg_311_1.actors_["1066ui_story"].transform

			if 1.96599999815226 < arg_311_1.time_ and arg_311_1.time_ <= 1.96599999815226 + arg_314_0 then
				arg_311_1.var_.moveOldPos1066ui_story = var_314_14.localPosition
			end

			local var_314_15 = 0.001

			if 1.96599999815226 <= arg_311_1.time_ and arg_311_1.time_ < 1.96599999815226 + var_314_15 then
				var_314_14.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_311_1.time_ - 1.96599999815226) / var_314_15)
				var_314_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_314_14.position).x, (manager.ui.mainCamera.transform.position - var_314_14.position).y, (manager.ui.mainCamera.transform.position - var_314_14.position).z)
				var_314_14.localEulerAngles.z = 0
				var_314_14.localEulerAngles.x = 0
				var_314_14.localEulerAngles = var_314_14.localEulerAngles
			end

			if arg_311_1.time_ >= 1.96599999815226 + var_314_15 and arg_311_1.time_ < 1.96599999815226 + var_314_15 + arg_314_0 then
				var_314_14.localPosition = Vector3.New(0, 100, 0)
				var_314_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_314_14.position).x, (manager.ui.mainCamera.transform.position - var_314_14.position).y, (manager.ui.mainCamera.transform.position - var_314_14.position).z)
				var_314_14.localEulerAngles.z = 0
				var_314_14.localEulerAngles.x = 0
				var_314_14.localEulerAngles = var_314_14.localEulerAngles
			end

			if arg_311_1.frameCnt_ <= 1 then
				arg_311_1.dialog_:SetActive(false)
			end

			local var_314_16 = 4
			local var_314_17 = 0.4

			if 4 < arg_311_1.time_ and arg_311_1.time_ <= var_314_16 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0

				arg_311_1.dialog_:SetActive(true)

				arg_311_1.dialogCg_.alpha = 0

				local var_314_18 = LeanTween.value(arg_311_1.dialog_, 0, 1, 0.3)

				var_314_18:setOnUpdate(LuaHelper.FloatAction(function(arg_315_0)
					arg_311_1.dialogCg_.alpha = arg_315_0
				end))
				var_314_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_311_1.dialog_)
					var_314_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_311_1.duration_ = arg_311_1.duration_ + 0.3

				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033_split_1")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_19 = arg_311_1:GetWordFromCfg(1104806074)
				local var_314_20 = arg_311_1:FormatText(var_314_19.content)

				arg_311_1.text_.text = var_314_20

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_22 = 16 <= 0 and var_314_17 or var_314_17 * (utf8.len(var_314_20) / 16)

				if (16 <= 0 and var_314_17 or var_314_17 * (utf8.len(var_314_20) / 16)) > 0 and var_314_17 < var_314_22 then
					arg_311_1.talkMaxDuration = var_314_22
					var_314_16 = var_314_16 + 0.3

					if var_314_22 + var_314_16 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_22 + var_314_16
					end
				end

				arg_311_1.text_.text = var_314_20
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806074", "story_v_side_new_1104806.awb") ~= 0 then
					local var_314_23 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806074", "story_v_side_new_1104806.awb") / 1000

					if var_314_23 + var_314_16 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_23 + var_314_16
					end

					if var_314_19.prefab_name ~= "" and arg_311_1.actors_[var_314_19.prefab_name] ~= nil then
						local var_314_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_19.prefab_name].transform, "story_v_side_new_1104806", "1104806074", "story_v_side_new_1104806.awb")

						arg_311_1:RecordAudio("1104806074", var_314_24)
						arg_311_1:RecordAudio("1104806074", var_314_24)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806074", "story_v_side_new_1104806.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806074", "story_v_side_new_1104806.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_25 = var_314_16 + 0.3
			local var_314_26 = math.max(var_314_17, arg_311_1.talkMaxDuration)

			if var_314_16 + 0.3 <= arg_311_1.time_ and arg_311_1.time_ < var_314_25 + var_314_26 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_25) / var_314_26

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_25 + var_314_26 and arg_311_1.time_ < var_314_25 + var_314_26 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play1104806075 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1104806075
		arg_317_1.duration_ = 9

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1104806076(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				local var_320_0 = arg_317_1.bgs_.STblack

				arg_317_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_320_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_320_1 = var_320_0:GetComponent("SpriteRenderer")

				if var_320_1 and var_320_1.sprite then
					local var_320_2 = 2 * (var_320_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_320_0.transform.localScale = Vector3.New(var_320_2 / var_320_1.sprite.bounds.size.y < var_320_2 * manager.ui.mainCameraCom_.aspect / var_320_1.sprite.bounds.size.x and var_320_2 * manager.ui.mainCameraCom_.aspect / var_320_1.sprite.bounds.size.x or var_320_2 / var_320_1.sprite.bounds.size.y, var_320_2 / var_320_1.sprite.bounds.size.y < var_320_2 * manager.ui.mainCameraCom_.aspect / var_320_1.sprite.bounds.size.x and var_320_2 * manager.ui.mainCameraCom_.aspect / var_320_1.sprite.bounds.size.x or var_320_2 / var_320_1.sprite.bounds.size.y, 0)
				end

				for iter_320_0, iter_320_1 in pairs(arg_317_1.bgs_) do
					if iter_320_0 ~= "STblack" then
						iter_320_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_320_3 = 0

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_3 + arg_320_0 then
				arg_317_1.mask_.enabled = true
				arg_317_1.mask_.raycastTarget = true

				arg_317_1:SetGaussion(false)
			end

			local var_320_4 = 4

			if var_320_3 <= arg_317_1.time_ and arg_317_1.time_ < var_320_3 + var_320_4 then
				local var_320_5 = Color.New(0, 0, 0)

				var_320_5.a = Mathf.Lerp(1, 0, (arg_317_1.time_ - var_320_3) / var_320_4)
				arg_317_1.mask_.color = var_320_5
			end

			if arg_317_1.time_ >= var_320_3 + var_320_4 and arg_317_1.time_ < var_320_3 + var_320_4 + arg_320_0 then
				local var_320_6 = Color.New(0, 0, 0)

				arg_317_1.mask_.enabled = false
				var_320_6.a = 0
				arg_317_1.mask_.color = var_320_6
			end

			local var_320_7 = arg_317_1.actors_["1033ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_7) and arg_317_1.var_.characterEffect1033ui_story == nil then
				arg_317_1.var_.characterEffect1033ui_story = var_320_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_8 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_8 and not isNil(var_320_7) then
				if arg_317_1.var_.characterEffect1033ui_story and not isNil(var_320_7) then
					arg_317_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_8)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_8 and arg_317_1.time_ < 0 + var_320_8 + arg_320_0 and not isNil(var_320_7) and arg_317_1.var_.characterEffect1033ui_story then
				arg_317_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if arg_317_1.frameCnt_ <= 1 then
				arg_317_1.dialog_:SetActive(false)
			end

			local var_320_9 = 4
			local var_320_10 = 0.75

			if 4 < arg_317_1.time_ and arg_317_1.time_ <= var_320_9 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0

				arg_317_1.dialog_:SetActive(true)

				arg_317_1.dialogCg_.alpha = 0

				local var_320_11 = LeanTween.value(arg_317_1.dialog_, 0, 1, 0.3)

				var_320_11:setOnUpdate(LuaHelper.FloatAction(function(arg_321_0)
					arg_317_1.dialogCg_.alpha = arg_321_0
				end))
				var_320_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_317_1.dialog_)
					var_320_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_317_1.duration_ = arg_317_1.duration_ + 0.3

				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_12 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(1104806075).content)

				arg_317_1.text_.text = var_320_12

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_14 = 30 <= 0 and var_320_10 or var_320_10 * (utf8.len(var_320_12) / 30)

				if (30 <= 0 and var_320_10 or var_320_10 * (utf8.len(var_320_12) / 30)) > 0 and var_320_10 < var_320_14 then
					arg_317_1.talkMaxDuration = var_320_14
					var_320_9 = var_320_9 + 0.3

					if var_320_14 + var_320_9 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_14 + var_320_9
					end
				end

				arg_317_1.text_.text = var_320_12
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_15 = var_320_9 + 0.3
			local var_320_16 = math.max(var_320_10, arg_317_1.talkMaxDuration)

			if var_320_9 + 0.3 <= arg_317_1.time_ and arg_317_1.time_ < var_320_15 + var_320_16 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_15) / var_320_16

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_15 + var_320_16 and arg_317_1.time_ < var_320_15 + var_320_16 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play1104806076 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1104806076
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1104806077(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_326_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_323_1.bgmTxt_.text ~= var_326_2 and arg_323_1.bgmTxt_.text ~= "" then
						if arg_323_1.bgmTxt2_.text ~= "" then
							arg_323_1.bgmTxt_.text = arg_323_1.bgmTxt2_.text
						end

						arg_323_1.bgmTxt2_.text = var_326_2

						arg_323_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_323_1.bgmTxt_.text = var_326_2
						arg_323_1.bgmTxt2_.text = var_326_2
					end

					if arg_323_1.bgmTimer then
						arg_323_1.bgmTimer:Stop()

						arg_323_1.bgmTimer = nil
					end

					if arg_323_1.settingData.show_music_name == 1 then
						arg_323_1.musicController:SetSelectedState("show")
						arg_323_1.musicAnimator_:Play("open", 0, 0)

						if arg_323_1.settingData.music_time ~= 0 then
							arg_323_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_323_1.settingData.music_time), function()
								if arg_323_1 == nil or isNil(arg_323_1.bgmTxt_) then
									return
								end

								arg_323_1.musicController:SetSelectedState("hide")
								arg_323_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_326_3 = 0
			local var_326_4 = 0.775

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_3 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_5 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(1104806076).content)

				arg_323_1.text_.text = var_326_5

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_7 = 31 <= 0 and var_326_4 or var_326_4 * (utf8.len(var_326_5) / 31)

				if (31 <= 0 and var_326_4 or var_326_4 * (utf8.len(var_326_5) / 31)) > 0 and var_326_4 < var_326_7 then
					arg_323_1.talkMaxDuration = var_326_7

					if var_326_7 + var_326_3 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_7 + var_326_3
					end
				end

				arg_323_1.text_.text = var_326_5
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_8 = math.max(var_326_4, arg_323_1.talkMaxDuration)

			if var_326_3 <= arg_323_1.time_ and arg_323_1.time_ < var_326_3 + var_326_8 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_3) / var_326_8

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_3 + var_326_8 and arg_323_1.time_ < var_326_3 + var_326_8 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play1104806077 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 1104806077
		arg_328_1.duration_ = 9.13

		local var_328_0 = {
			zh = 8.3,
			ja = 9.133
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
				arg_328_0:Play1104806078(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 2 < arg_328_1.time_ and arg_328_1.time_ <= 2 + arg_331_0 then
				arg_328_1.var_.moveOldPos114801ui_story = arg_328_1.actors_["114801ui_story"].transform.localPosition
			end

			local var_331_0 = 0.001

			if 2 <= arg_328_1.time_ and arg_328_1.time_ < 2 + var_331_0 then
				arg_328_1.actors_["114801ui_story"].transform.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos114801ui_story, Vector3.New(0, -0.8, -6.2), (arg_328_1.time_ - 2) / var_331_0)
				arg_328_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_328_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["114801ui_story"].transform.position).z)
				arg_328_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_328_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_328_1.actors_["114801ui_story"].transform.localEulerAngles = arg_328_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			if arg_328_1.time_ >= 2 + var_331_0 and arg_328_1.time_ < 2 + var_331_0 + arg_331_0 then
				arg_328_1.actors_["114801ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_328_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_328_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["114801ui_story"].transform.position).z)
				arg_328_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_328_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_328_1.actors_["114801ui_story"].transform.localEulerAngles = arg_328_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			local var_331_1 = arg_328_1.actors_["114801ui_story"]

			if 2 < arg_328_1.time_ and arg_328_1.time_ <= 2 + arg_331_0 and not isNil(var_331_1) and arg_328_1.var_.characterEffect114801ui_story == nil then
				arg_328_1.var_.characterEffect114801ui_story = var_331_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_2 = 0.200000002980232

			if 2 <= arg_328_1.time_ and arg_328_1.time_ < 2 + var_331_2 and not isNil(var_331_1) then
				if arg_328_1.var_.characterEffect114801ui_story and not isNil(var_331_1) then
					arg_328_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= 2 + var_331_2 and arg_328_1.time_ < 2 + var_331_2 + arg_331_0 and not isNil(var_331_1) and arg_328_1.var_.characterEffect114801ui_story then
				arg_328_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 2 < arg_328_1.time_ and arg_328_1.time_ <= 2 + arg_331_0 then
				arg_328_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 2 < arg_328_1.time_ and arg_328_1.time_ <= 2 + arg_331_0 then
				arg_328_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_331_4 = "ST01a"

			if arg_328_1.bgs_.ST01a == nil then
				local var_331_5 = Object.Instantiate(arg_328_1.paintGo_)

				var_331_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_331_4)
				var_331_5.name = var_331_4
				var_331_5.transform.parent = arg_328_1.stage_.transform
				var_331_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_328_1.bgs_[var_331_4] = var_331_5
			end

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				local var_331_6 = arg_328_1.bgs_.ST01a

				arg_328_1.bgs_.ST01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_331_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_331_7 = var_331_6:GetComponent("SpriteRenderer")

				if var_331_7 and var_331_7.sprite then
					local var_331_8 = 2 * (var_331_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_331_6.transform.localScale = Vector3.New(var_331_8 / var_331_7.sprite.bounds.size.y < var_331_8 * manager.ui.mainCameraCom_.aspect / var_331_7.sprite.bounds.size.x and var_331_8 * manager.ui.mainCameraCom_.aspect / var_331_7.sprite.bounds.size.x or var_331_8 / var_331_7.sprite.bounds.size.y, var_331_8 / var_331_7.sprite.bounds.size.y < var_331_8 * manager.ui.mainCameraCom_.aspect / var_331_7.sprite.bounds.size.x and var_331_8 * manager.ui.mainCameraCom_.aspect / var_331_7.sprite.bounds.size.x or var_331_8 / var_331_7.sprite.bounds.size.y, 0)
				end

				for iter_331_0, iter_331_1 in pairs(arg_328_1.bgs_) do
					if iter_331_0 ~= "ST01a" then
						iter_331_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_331_9 = 0

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_9 + arg_331_0 then
				arg_328_1.mask_.enabled = true
				arg_328_1.mask_.raycastTarget = true

				arg_328_1:SetGaussion(false)
			end

			local var_331_10 = 2

			if var_331_9 <= arg_328_1.time_ and arg_328_1.time_ < var_331_9 + var_331_10 then
				local var_331_11 = Color.New(0, 0, 0)

				var_331_11.a = Mathf.Lerp(1, 0, (arg_328_1.time_ - var_331_9) / var_331_10)
				arg_328_1.mask_.color = var_331_11
			end

			if arg_328_1.time_ >= var_331_9 + var_331_10 and arg_328_1.time_ < var_331_9 + var_331_10 + arg_331_0 then
				local var_331_12 = Color.New(0, 0, 0)

				arg_328_1.mask_.enabled = false
				var_331_12.a = 0
				arg_328_1.mask_.color = var_331_12
			end

			if arg_328_1.frameCnt_ <= 1 then
				arg_328_1.dialog_:SetActive(false)
			end

			local var_331_13 = 2
			local var_331_14 = 0.725

			if 2 < arg_328_1.time_ and arg_328_1.time_ <= var_331_13 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0

				arg_328_1.dialog_:SetActive(true)

				arg_328_1.dialogCg_.alpha = 0

				local var_331_15 = LeanTween.value(arg_328_1.dialog_, 0, 1, 0.3)

				var_331_15:setOnUpdate(LuaHelper.FloatAction(function(arg_332_0)
					arg_328_1.dialogCg_.alpha = arg_332_0
				end))
				var_331_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_328_1.dialog_)
					var_331_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_328_1.duration_ = arg_328_1.duration_ + 0.3

				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_16 = arg_328_1:GetWordFromCfg(1104806077)
				local var_331_17 = arg_328_1:FormatText(var_331_16.content)

				arg_328_1.text_.text = var_331_17

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_19 = 30 <= 0 and var_331_14 or var_331_14 * (utf8.len(var_331_17) / 30)

				if (30 <= 0 and var_331_14 or var_331_14 * (utf8.len(var_331_17) / 30)) > 0 and var_331_14 < var_331_19 then
					arg_328_1.talkMaxDuration = var_331_19
					var_331_13 = var_331_13 + 0.3

					if var_331_19 + var_331_13 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_19 + var_331_13
					end
				end

				arg_328_1.text_.text = var_331_17
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806077", "story_v_side_new_1104806.awb") ~= 0 then
					local var_331_20 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806077", "story_v_side_new_1104806.awb") / 1000

					if var_331_20 + var_331_13 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_20 + var_331_13
					end

					if var_331_16.prefab_name ~= "" and arg_328_1.actors_[var_331_16.prefab_name] ~= nil then
						local var_331_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_16.prefab_name].transform, "story_v_side_new_1104806", "1104806077", "story_v_side_new_1104806.awb")

						arg_328_1:RecordAudio("1104806077", var_331_21)
						arg_328_1:RecordAudio("1104806077", var_331_21)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806077", "story_v_side_new_1104806.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806077", "story_v_side_new_1104806.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_22 = var_331_13 + 0.3
			local var_331_23 = math.max(var_331_14, arg_328_1.talkMaxDuration)

			if var_331_13 + 0.3 <= arg_328_1.time_ and arg_328_1.time_ < var_331_22 + var_331_23 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_22) / var_331_23

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_22 + var_331_23 and arg_328_1.time_ < var_331_22 + var_331_23 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_328_1:InitPlayNodeList()
	end,
	Play1104806078 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1104806078
		arg_334_1.duration_ = 8.07

		local var_334_0 = {
			zh = 4.633,
			ja = 8.066
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1104806079(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action445")
			end

			local var_337_0 = 0
			local var_337_1 = 0.6

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_2 = arg_334_1:GetWordFromCfg(1104806078)
				local var_337_3 = arg_334_1:FormatText(var_337_2.content)

				arg_334_1.text_.text = var_337_3

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 24 <= 0 and var_337_1 or var_337_1 * (utf8.len(var_337_3) / 24)

				if (24 <= 0 and var_337_1 or var_337_1 * (utf8.len(var_337_3) / 24)) > 0 and var_337_1 < var_337_5 then
					arg_334_1.talkMaxDuration = var_337_5

					if var_337_5 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_5 + var_337_0
					end
				end

				arg_334_1.text_.text = var_337_3
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806078", "story_v_side_new_1104806.awb") ~= 0 then
					local var_337_6 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806078", "story_v_side_new_1104806.awb") / 1000

					if var_337_6 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_6 + var_337_0
					end

					if var_337_2.prefab_name ~= "" and arg_334_1.actors_[var_337_2.prefab_name] ~= nil then
						local var_337_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_2.prefab_name].transform, "story_v_side_new_1104806", "1104806078", "story_v_side_new_1104806.awb")

						arg_334_1:RecordAudio("1104806078", var_337_7)
						arg_334_1:RecordAudio("1104806078", var_337_7)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806078", "story_v_side_new_1104806.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806078", "story_v_side_new_1104806.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_8 = math.max(var_337_1, arg_334_1.talkMaxDuration)

			if var_337_0 <= arg_334_1.time_ and arg_334_1.time_ < var_337_0 + var_337_8 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_0) / var_337_8

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_0 + var_337_8 and arg_334_1.time_ < var_337_0 + var_337_8 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play1104806079 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1104806079
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play1104806080(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["114801ui_story"]) and arg_338_1.var_.characterEffect114801ui_story == nil then
				arg_338_1.var_.characterEffect114801ui_story = arg_338_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_0 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["114801ui_story"]) then
				if arg_338_1.var_.characterEffect114801ui_story and not isNil(arg_338_1.actors_["114801ui_story"]) then
					arg_338_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_338_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_338_1.time_ - 0) / var_341_0)
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["114801ui_story"]) and arg_338_1.var_.characterEffect114801ui_story then
				arg_338_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_338_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			local var_341_1 = 0
			local var_341_2 = 0.975

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_3 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(1104806079).content)

				arg_338_1.text_.text = var_341_3

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_5 = 39 <= 0 and var_341_2 or var_341_2 * (utf8.len(var_341_3) / 39)

				if (39 <= 0 and var_341_2 or var_341_2 * (utf8.len(var_341_3) / 39)) > 0 and var_341_2 < var_341_5 then
					arg_338_1.talkMaxDuration = var_341_5

					if var_341_5 + var_341_1 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_5 + var_341_1
					end
				end

				arg_338_1.text_.text = var_341_3
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_6 = math.max(var_341_2, arg_338_1.talkMaxDuration)

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_6 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_1) / var_341_6

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_1 + var_341_6 and arg_338_1.time_ < var_341_1 + var_341_6 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play1104806080 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 1104806080
		arg_342_1.duration_ = 4.6

		local var_342_0 = {
			zh = 4.6,
			ja = 4.366
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
				arg_342_0:Play1104806081(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["114801ui_story"]) and arg_342_1.var_.characterEffect114801ui_story == nil then
				arg_342_1.var_.characterEffect114801ui_story = arg_342_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_0 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["114801ui_story"]) then
				if arg_342_1.var_.characterEffect114801ui_story and not isNil(arg_342_1.actors_["114801ui_story"]) then
					arg_342_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["114801ui_story"]) and arg_342_1.var_.characterEffect114801ui_story then
				arg_342_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_345_4 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_342_1.bgmTxt_.text ~= var_345_4 and arg_342_1.bgmTxt_.text ~= "" then
						if arg_342_1.bgmTxt2_.text ~= "" then
							arg_342_1.bgmTxt_.text = arg_342_1.bgmTxt2_.text
						end

						arg_342_1.bgmTxt2_.text = var_345_4

						arg_342_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_342_1.bgmTxt_.text = var_345_4
						arg_342_1.bgmTxt2_.text = var_345_4
					end

					if arg_342_1.bgmTimer then
						arg_342_1.bgmTimer:Stop()

						arg_342_1.bgmTimer = nil
					end

					if arg_342_1.settingData.show_music_name == 1 then
						arg_342_1.musicController:SetSelectedState("show")
						arg_342_1.musicAnimator_:Play("open", 0, 0)

						if arg_342_1.settingData.music_time ~= 0 then
							arg_342_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_342_1.settingData.music_time), function()
								if arg_342_1 == nil or isNil(arg_342_1.bgmTxt_) then
									return
								end

								arg_342_1.musicController:SetSelectedState("hide")
								arg_342_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.366666666666667 < arg_342_1.time_ and arg_342_1.time_ <= 0.366666666666667 + arg_345_0 then
				arg_342_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_345_7 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_342_1.bgmTxt_.text ~= var_345_7 and arg_342_1.bgmTxt_.text ~= "" then
						if arg_342_1.bgmTxt2_.text ~= "" then
							arg_342_1.bgmTxt_.text = arg_342_1.bgmTxt2_.text
						end

						arg_342_1.bgmTxt2_.text = var_345_7

						arg_342_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_342_1.bgmTxt_.text = var_345_7
						arg_342_1.bgmTxt2_.text = var_345_7
					end

					if arg_342_1.bgmTimer then
						arg_342_1.bgmTimer:Stop()

						arg_342_1.bgmTimer = nil
					end

					if arg_342_1.settingData.show_music_name == 1 then
						arg_342_1.musicController:SetSelectedState("show")
						arg_342_1.musicAnimator_:Play("open", 0, 0)

						if arg_342_1.settingData.music_time ~= 0 then
							arg_342_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_342_1.settingData.music_time), function()
								if arg_342_1 == nil or isNil(arg_342_1.bgmTxt_) then
									return
								end

								arg_342_1.musicController:SetSelectedState("hide")
								arg_342_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_345_8 = 0
			local var_345_9 = 0.775

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_8 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_10 = arg_342_1:GetWordFromCfg(1104806080)
				local var_345_11 = arg_342_1:FormatText(var_345_10.content)

				arg_342_1.text_.text = var_345_11

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_13 = 31 <= 0 and var_345_9 or var_345_9 * (utf8.len(var_345_11) / 31)

				if (31 <= 0 and var_345_9 or var_345_9 * (utf8.len(var_345_11) / 31)) > 0 and var_345_9 < var_345_13 then
					arg_342_1.talkMaxDuration = var_345_13

					if var_345_13 + var_345_8 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_13 + var_345_8
					end
				end

				arg_342_1.text_.text = var_345_11
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806080", "story_v_side_new_1104806.awb") ~= 0 then
					local var_345_14 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806080", "story_v_side_new_1104806.awb") / 1000

					if var_345_14 + var_345_8 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_14 + var_345_8
					end

					if var_345_10.prefab_name ~= "" and arg_342_1.actors_[var_345_10.prefab_name] ~= nil then
						local var_345_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_10.prefab_name].transform, "story_v_side_new_1104806", "1104806080", "story_v_side_new_1104806.awb")

						arg_342_1:RecordAudio("1104806080", var_345_15)
						arg_342_1:RecordAudio("1104806080", var_345_15)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806080", "story_v_side_new_1104806.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806080", "story_v_side_new_1104806.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_16 = math.max(var_345_9, arg_342_1.talkMaxDuration)

			if var_345_8 <= arg_342_1.time_ and arg_342_1.time_ < var_345_8 + var_345_16 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_8) / var_345_16

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_8 + var_345_16 and arg_342_1.time_ < var_345_8 + var_345_16 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play1104806081 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1104806081
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play1104806082(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(arg_348_1.actors_["114801ui_story"]) and arg_348_1.var_.characterEffect114801ui_story == nil then
				arg_348_1.var_.characterEffect114801ui_story = arg_348_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_0 = 0.200000002980232

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_0 and not isNil(arg_348_1.actors_["114801ui_story"]) then
				if arg_348_1.var_.characterEffect114801ui_story and not isNil(arg_348_1.actors_["114801ui_story"]) then
					arg_348_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_348_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_348_1.time_ - 0) / var_351_0)
				end
			end

			if arg_348_1.time_ >= 0 + var_351_0 and arg_348_1.time_ < 0 + var_351_0 + arg_351_0 and not isNil(arg_348_1.actors_["114801ui_story"]) and arg_348_1.var_.characterEffect114801ui_story then
				arg_348_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_348_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			local var_351_1 = 0
			local var_351_2 = 1.075

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_3 = arg_348_1:FormatText(arg_348_1:GetWordFromCfg(1104806081).content)

				arg_348_1.text_.text = var_351_3

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 43 <= 0 and var_351_2 or var_351_2 * (utf8.len(var_351_3) / 43)

				if (43 <= 0 and var_351_2 or var_351_2 * (utf8.len(var_351_3) / 43)) > 0 and var_351_2 < var_351_5 then
					arg_348_1.talkMaxDuration = var_351_5

					if var_351_5 + var_351_1 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_5 + var_351_1
					end
				end

				arg_348_1.text_.text = var_351_3
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_6 = math.max(var_351_2, arg_348_1.talkMaxDuration)

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_6 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_1) / var_351_6

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_1 + var_351_6 and arg_348_1.time_ < var_351_1 + var_351_6 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play1104806082 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 1104806082
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play1104806083(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0.8

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_1 = arg_352_1:FormatText(arg_352_1:GetWordFromCfg(1104806082).content)

				arg_352_1.text_.text = var_355_1

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_3 = 32 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_1) / 32)

				if (32 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_1) / 32)) > 0 and var_355_0 < var_355_3 then
					arg_352_1.talkMaxDuration = var_355_3

					if var_355_3 + 0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_3 + 0
					end
				end

				arg_352_1.text_.text = var_355_1
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_4 = math.max(var_355_0, arg_352_1.talkMaxDuration)

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_4 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - 0) / var_355_4

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= 0 + var_355_4 and arg_352_1.time_ < 0 + var_355_4 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play1104806083 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 1104806083
		arg_356_1.duration_ = 4.8

		local var_356_0 = {
			zh = 4.8,
			ja = 4.133
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
				arg_356_0:Play1104806084(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(arg_356_1.actors_["114801ui_story"]) and arg_356_1.var_.characterEffect114801ui_story == nil then
				arg_356_1.var_.characterEffect114801ui_story = arg_356_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_0 = 0.200000002980232

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 and not isNil(arg_356_1.actors_["114801ui_story"]) then
				if arg_356_1.var_.characterEffect114801ui_story and not isNil(arg_356_1.actors_["114801ui_story"]) then
					arg_356_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 and not isNil(arg_356_1.actors_["114801ui_story"]) and arg_356_1.var_.characterEffect114801ui_story then
				arg_356_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_2")
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_359_2 = 0
			local var_359_3 = 0.475

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_2 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_4 = arg_356_1:GetWordFromCfg(1104806083)
				local var_359_5 = arg_356_1:FormatText(var_359_4.content)

				arg_356_1.text_.text = var_359_5

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_7 = 19 <= 0 and var_359_3 or var_359_3 * (utf8.len(var_359_5) / 19)

				if (19 <= 0 and var_359_3 or var_359_3 * (utf8.len(var_359_5) / 19)) > 0 and var_359_3 < var_359_7 then
					arg_356_1.talkMaxDuration = var_359_7

					if var_359_7 + var_359_2 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_2
					end
				end

				arg_356_1.text_.text = var_359_5
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806083", "story_v_side_new_1104806.awb") ~= 0 then
					local var_359_8 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806083", "story_v_side_new_1104806.awb") / 1000

					if var_359_8 + var_359_2 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_8 + var_359_2
					end

					if var_359_4.prefab_name ~= "" and arg_356_1.actors_[var_359_4.prefab_name] ~= nil then
						local var_359_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_4.prefab_name].transform, "story_v_side_new_1104806", "1104806083", "story_v_side_new_1104806.awb")

						arg_356_1:RecordAudio("1104806083", var_359_9)
						arg_356_1:RecordAudio("1104806083", var_359_9)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806083", "story_v_side_new_1104806.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806083", "story_v_side_new_1104806.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_10 = math.max(var_359_3, arg_356_1.talkMaxDuration)

			if var_359_2 <= arg_356_1.time_ and arg_356_1.time_ < var_359_2 + var_359_10 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_2) / var_359_10

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_2 + var_359_10 and arg_356_1.time_ < var_359_2 + var_359_10 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play1104806084 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 1104806084
		arg_360_1.duration_ = 6.43

		local var_360_0 = {
			zh = 4.4,
			ja = 6.433
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
				arg_360_0:Play1104806085(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(arg_360_1.actors_["114801ui_story"]) and arg_360_1.var_.characterEffect114801ui_story == nil then
				arg_360_1.var_.characterEffect114801ui_story = arg_360_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_0 = 0.200000002980232

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_0 and not isNil(arg_360_1.actors_["114801ui_story"]) then
				if arg_360_1.var_.characterEffect114801ui_story and not isNil(arg_360_1.actors_["114801ui_story"]) then
					arg_360_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= 0 + var_363_0 and arg_360_1.time_ < 0 + var_363_0 + arg_363_0 and not isNil(arg_360_1.actors_["114801ui_story"]) and arg_360_1.var_.characterEffect114801ui_story then
				arg_360_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_363_2 = 0
			local var_363_3 = 0.75

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_2 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_4 = arg_360_1:GetWordFromCfg(1104806084)
				local var_363_5 = arg_360_1:FormatText(var_363_4.content)

				arg_360_1.text_.text = var_363_5

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_7 = 30 <= 0 and var_363_3 or var_363_3 * (utf8.len(var_363_5) / 30)

				if (30 <= 0 and var_363_3 or var_363_3 * (utf8.len(var_363_5) / 30)) > 0 and var_363_3 < var_363_7 then
					arg_360_1.talkMaxDuration = var_363_7

					if var_363_7 + var_363_2 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_7 + var_363_2
					end
				end

				arg_360_1.text_.text = var_363_5
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806084", "story_v_side_new_1104806.awb") ~= 0 then
					local var_363_8 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806084", "story_v_side_new_1104806.awb") / 1000

					if var_363_8 + var_363_2 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_8 + var_363_2
					end

					if var_363_4.prefab_name ~= "" and arg_360_1.actors_[var_363_4.prefab_name] ~= nil then
						local var_363_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_4.prefab_name].transform, "story_v_side_new_1104806", "1104806084", "story_v_side_new_1104806.awb")

						arg_360_1:RecordAudio("1104806084", var_363_9)
						arg_360_1:RecordAudio("1104806084", var_363_9)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806084", "story_v_side_new_1104806.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806084", "story_v_side_new_1104806.awb")
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
	Play1104806085 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 1104806085
		arg_364_1.duration_ = 4.3

		local var_364_0 = {
			zh = 4.3,
			ja = 4.233
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
				arg_364_0:Play1104806086(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_2")
			end

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_367_0 = 0
			local var_367_1 = 0.8

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_2 = arg_364_1:GetWordFromCfg(1104806085)
				local var_367_3 = arg_364_1:FormatText(var_367_2.content)

				arg_364_1.text_.text = var_367_3

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 32 <= 0 and var_367_1 or var_367_1 * (utf8.len(var_367_3) / 32)

				if (32 <= 0 and var_367_1 or var_367_1 * (utf8.len(var_367_3) / 32)) > 0 and var_367_1 < var_367_5 then
					arg_364_1.talkMaxDuration = var_367_5

					if var_367_5 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_5 + var_367_0
					end
				end

				arg_364_1.text_.text = var_367_3
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806085", "story_v_side_new_1104806.awb") ~= 0 then
					local var_367_6 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806085", "story_v_side_new_1104806.awb") / 1000

					if var_367_6 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_6 + var_367_0
					end

					if var_367_2.prefab_name ~= "" and arg_364_1.actors_[var_367_2.prefab_name] ~= nil then
						local var_367_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_2.prefab_name].transform, "story_v_side_new_1104806", "1104806085", "story_v_side_new_1104806.awb")

						arg_364_1:RecordAudio("1104806085", var_367_7)
						arg_364_1:RecordAudio("1104806085", var_367_7)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806085", "story_v_side_new_1104806.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806085", "story_v_side_new_1104806.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_8 = math.max(var_367_1, arg_364_1.talkMaxDuration)

			if var_367_0 <= arg_364_1.time_ and arg_364_1.time_ < var_367_0 + var_367_8 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_0) / var_367_8

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_0 + var_367_8 and arg_364_1.time_ < var_367_0 + var_367_8 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play1104806086 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 1104806086
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play1104806087(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.var_.moveOldPos114801ui_story = arg_368_1.actors_["114801ui_story"].transform.localPosition
			end

			local var_371_0 = 0.001

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_0 then
				arg_368_1.actors_["114801ui_story"].transform.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos114801ui_story, Vector3.New(0, 100, 0), (arg_368_1.time_ - 0) / var_371_0)
				arg_368_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_368_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["114801ui_story"].transform.position).z)
				arg_368_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_368_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_368_1.actors_["114801ui_story"].transform.localEulerAngles = arg_368_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			if arg_368_1.time_ >= 0 + var_371_0 and arg_368_1.time_ < 0 + var_371_0 + arg_371_0 then
				arg_368_1.actors_["114801ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_368_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_368_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["114801ui_story"].transform.position).z)
				arg_368_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_368_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_368_1.actors_["114801ui_story"].transform.localEulerAngles = arg_368_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			local var_371_1 = arg_368_1.actors_["114801ui_story"]

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(var_371_1) and arg_368_1.var_.characterEffect114801ui_story == nil then
				arg_368_1.var_.characterEffect114801ui_story = var_371_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_2 = 0.200000002980232

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_2 and not isNil(var_371_1) then
				if arg_368_1.var_.characterEffect114801ui_story and not isNil(var_371_1) then
					arg_368_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_368_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_368_1.time_ - 0) / var_371_2)
				end
			end

			if arg_368_1.time_ >= 0 + var_371_2 and arg_368_1.time_ < 0 + var_371_2 + arg_371_0 and not isNil(var_371_1) and arg_368_1.var_.characterEffect114801ui_story then
				arg_368_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_368_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			local var_371_3 = 0
			local var_371_4 = 0.45

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_3 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_5 = arg_368_1:FormatText(arg_368_1:GetWordFromCfg(1104806086).content)

				arg_368_1.text_.text = var_371_5

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_7 = 18 <= 0 and var_371_4 or var_371_4 * (utf8.len(var_371_5) / 18)

				if (18 <= 0 and var_371_4 or var_371_4 * (utf8.len(var_371_5) / 18)) > 0 and var_371_4 < var_371_7 then
					arg_368_1.talkMaxDuration = var_371_7

					if var_371_7 + var_371_3 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_7 + var_371_3
					end
				end

				arg_368_1.text_.text = var_371_5
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_8 = math.max(var_371_4, arg_368_1.talkMaxDuration)

			if var_371_3 <= arg_368_1.time_ and arg_368_1.time_ < var_371_3 + var_371_8 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_3) / var_371_8

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_3 + var_371_8 and arg_368_1.time_ < var_371_3 + var_371_8 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play1104806087 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 1104806087
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play1104806088(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0.725

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_1 = arg_372_1:FormatText(arg_372_1:GetWordFromCfg(1104806087).content)

				arg_372_1.text_.text = var_375_1

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_3 = 29 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_1) / 29)

				if (29 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_1) / 29)) > 0 and var_375_0 < var_375_3 then
					arg_372_1.talkMaxDuration = var_375_3

					if var_375_3 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_3 + 0
					end
				end

				arg_372_1.text_.text = var_375_1
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_4 = math.max(var_375_0, arg_372_1.talkMaxDuration)

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_4 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - 0) / var_375_4

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= 0 + var_375_4 and arg_372_1.time_ < 0 + var_375_4 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play1104806088 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1104806088
		arg_376_1.duration_ = 7.87

		local var_376_0 = {
			zh = 6.333,
			ja = 7.866
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1104806089(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0.45

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[520].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, true)
				arg_376_1.iconController_:SetSelectedState("hero")

				arg_376_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_376_1.callingController_:SetSelectedState("normal")

				arg_376_1.keyicon_.color = Color.New(1, 1, 1)
				arg_376_1.icon_.color = Color.New(1, 1, 1)

				local var_379_1 = arg_376_1:GetWordFromCfg(1104806088)
				local var_379_2 = arg_376_1:FormatText(var_379_1.content)

				arg_376_1.text_.text = var_379_2

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_4 = 18 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_2) / 18)

				if (18 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_2) / 18)) > 0 and var_379_0 < var_379_4 then
					arg_376_1.talkMaxDuration = var_379_4

					if var_379_4 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_4 + 0
					end
				end

				arg_376_1.text_.text = var_379_2
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806088", "story_v_side_new_1104806.awb") ~= 0 then
					local var_379_5 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806088", "story_v_side_new_1104806.awb") / 1000

					if var_379_5 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_5 + 0
					end

					if var_379_1.prefab_name ~= "" and arg_376_1.actors_[var_379_1.prefab_name] ~= nil then
						local var_379_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_1.prefab_name].transform, "story_v_side_new_1104806", "1104806088", "story_v_side_new_1104806.awb")

						arg_376_1:RecordAudio("1104806088", var_379_6)
						arg_376_1:RecordAudio("1104806088", var_379_6)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806088", "story_v_side_new_1104806.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806088", "story_v_side_new_1104806.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_7 = math.max(var_379_0, arg_376_1.talkMaxDuration)

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_7 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - 0) / var_379_7

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= 0 + var_379_7 and arg_376_1.time_ < 0 + var_379_7 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play1104806089 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1104806089
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1104806090(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0.675

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_1 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(1104806089).content)

				arg_380_1.text_.text = var_383_1

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_3 = 27 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_1) / 27)

				if (27 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_1) / 27)) > 0 and var_383_0 < var_383_3 then
					arg_380_1.talkMaxDuration = var_383_3

					if var_383_3 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_3 + 0
					end
				end

				arg_380_1.text_.text = var_383_1
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_4 = math.max(var_383_0, arg_380_1.talkMaxDuration)

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_4 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - 0) / var_383_4

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= 0 + var_383_4 and arg_380_1.time_ < 0 + var_383_4 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play1104806090 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 1104806090
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play1104806091(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0.8

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_1 = arg_384_1:FormatText(arg_384_1:GetWordFromCfg(1104806090).content)

				arg_384_1.text_.text = var_387_1

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_3 = 32 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_1) / 32)

				if (32 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_1) / 32)) > 0 and var_387_0 < var_387_3 then
					arg_384_1.talkMaxDuration = var_387_3

					if var_387_3 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_3 + 0
					end
				end

				arg_384_1.text_.text = var_387_1
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_4 = math.max(var_387_0, arg_384_1.talkMaxDuration)

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_4 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - 0) / var_387_4

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= 0 + var_387_4 and arg_384_1.time_ < 0 + var_387_4 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play1104806091 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1104806091
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1104806092(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 0.7

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_1 = arg_388_1:FormatText(arg_388_1:GetWordFromCfg(1104806091).content)

				arg_388_1.text_.text = var_391_1

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_3 = 28 <= 0 and var_391_0 or var_391_0 * (utf8.len(var_391_1) / 28)

				if (28 <= 0 and var_391_0 or var_391_0 * (utf8.len(var_391_1) / 28)) > 0 and var_391_0 < var_391_3 then
					arg_388_1.talkMaxDuration = var_391_3

					if var_391_3 + 0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_3 + 0
					end
				end

				arg_388_1.text_.text = var_391_1
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_4 = math.max(var_391_0, arg_388_1.talkMaxDuration)

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_4 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - 0) / var_391_4

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= 0 + var_391_4 and arg_388_1.time_ < 0 + var_391_4 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play1104806092 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 1104806092
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play1104806093(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 1.1

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, true)
				arg_392_1.iconController_:SetSelectedState("hero")

				arg_392_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_392_1.callingController_:SetSelectedState("normal")

				arg_392_1.keyicon_.color = Color.New(1, 1, 1)
				arg_392_1.icon_.color = Color.New(1, 1, 1)

				local var_395_1 = arg_392_1:FormatText(arg_392_1:GetWordFromCfg(1104806092).content)

				arg_392_1.text_.text = var_395_1

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_3 = 44 <= 0 and var_395_0 or var_395_0 * (utf8.len(var_395_1) / 44)

				if (44 <= 0 and var_395_0 or var_395_0 * (utf8.len(var_395_1) / 44)) > 0 and var_395_0 < var_395_3 then
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
	Play1104806093 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 1104806093
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play1104806094(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0.6

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_1 = arg_396_1:FormatText(arg_396_1:GetWordFromCfg(1104806093).content)

				arg_396_1.text_.text = var_399_1

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_3 = 24 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_1) / 24)

				if (24 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_1) / 24)) > 0 and var_399_0 < var_399_3 then
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
	Play1104806094 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 1104806094
		arg_400_1.duration_ = 6

		local var_400_0 = {
			zh = 4.166,
			ja = 6
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play1104806095(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.var_.moveOldPos114801ui_story = arg_400_1.actors_["114801ui_story"].transform.localPosition
			end

			local var_403_0 = 0.001

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_0 then
				arg_400_1.actors_["114801ui_story"].transform.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos114801ui_story, Vector3.New(0, -0.8, -6.2), (arg_400_1.time_ - 0) / var_403_0)
				arg_400_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_400_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["114801ui_story"].transform.position).z)
				arg_400_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_400_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_400_1.actors_["114801ui_story"].transform.localEulerAngles = arg_400_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			if arg_400_1.time_ >= 0 + var_403_0 and arg_400_1.time_ < 0 + var_403_0 + arg_403_0 then
				arg_400_1.actors_["114801ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_400_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_400_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["114801ui_story"].transform.position).z)
				arg_400_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_400_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_400_1.actors_["114801ui_story"].transform.localEulerAngles = arg_400_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			local var_403_1 = arg_400_1.actors_["114801ui_story"]

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(var_403_1) and arg_400_1.var_.characterEffect114801ui_story == nil then
				arg_400_1.var_.characterEffect114801ui_story = var_403_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_2 = 0.200000002980232

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_2 and not isNil(var_403_1) then
				if arg_400_1.var_.characterEffect114801ui_story and not isNil(var_403_1) then
					arg_400_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= 0 + var_403_2 and arg_400_1.time_ < 0 + var_403_2 + arg_403_0 and not isNil(var_403_1) and arg_400_1.var_.characterEffect114801ui_story then
				arg_400_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action1_1")
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_403_4 = 0
			local var_403_5 = 0.625

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_4 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_6 = arg_400_1:GetWordFromCfg(1104806094)
				local var_403_7 = arg_400_1:FormatText(var_403_6.content)

				arg_400_1.text_.text = var_403_7

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_9 = 25 <= 0 and var_403_5 or var_403_5 * (utf8.len(var_403_7) / 25)

				if (25 <= 0 and var_403_5 or var_403_5 * (utf8.len(var_403_7) / 25)) > 0 and var_403_5 < var_403_9 then
					arg_400_1.talkMaxDuration = var_403_9

					if var_403_9 + var_403_4 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_9 + var_403_4
					end
				end

				arg_400_1.text_.text = var_403_7
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806094", "story_v_side_new_1104806.awb") ~= 0 then
					local var_403_10 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806094", "story_v_side_new_1104806.awb") / 1000

					if var_403_10 + var_403_4 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_10 + var_403_4
					end

					if var_403_6.prefab_name ~= "" and arg_400_1.actors_[var_403_6.prefab_name] ~= nil then
						local var_403_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_6.prefab_name].transform, "story_v_side_new_1104806", "1104806094", "story_v_side_new_1104806.awb")

						arg_400_1:RecordAudio("1104806094", var_403_11)
						arg_400_1:RecordAudio("1104806094", var_403_11)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806094", "story_v_side_new_1104806.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806094", "story_v_side_new_1104806.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_12 = math.max(var_403_5, arg_400_1.talkMaxDuration)

			if var_403_4 <= arg_400_1.time_ and arg_400_1.time_ < var_403_4 + var_403_12 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_4) / var_403_12

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_4 + var_403_12 and arg_400_1.time_ < var_403_4 + var_403_12 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play1104806095 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 1104806095
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play1104806096(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.var_.moveOldPos114801ui_story = arg_404_1.actors_["114801ui_story"].transform.localPosition
			end

			local var_407_0 = 0.001

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 then
				arg_404_1.actors_["114801ui_story"].transform.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos114801ui_story, Vector3.New(0, 100, 0), (arg_404_1.time_ - 0) / var_407_0)
				arg_404_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["114801ui_story"].transform.position).z)
				arg_404_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["114801ui_story"].transform.localEulerAngles = arg_404_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 then
				arg_404_1.actors_["114801ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_404_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["114801ui_story"].transform.position).z)
				arg_404_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["114801ui_story"].transform.localEulerAngles = arg_404_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			local var_407_1 = arg_404_1.actors_["114801ui_story"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_1) and arg_404_1.var_.characterEffect114801ui_story == nil then
				arg_404_1.var_.characterEffect114801ui_story = var_407_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_2 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_2 and not isNil(var_407_1) then
				if arg_404_1.var_.characterEffect114801ui_story and not isNil(var_407_1) then
					arg_404_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_404_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_404_1.time_ - 0) / var_407_2)
				end
			end

			if arg_404_1.time_ >= 0 + var_407_2 and arg_404_1.time_ < 0 + var_407_2 + arg_407_0 and not isNil(var_407_1) and arg_404_1.var_.characterEffect114801ui_story then
				arg_404_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_404_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			local var_407_3 = 0
			local var_407_4 = 0.925

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_3 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, false)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_5 = arg_404_1:FormatText(arg_404_1:GetWordFromCfg(1104806095).content)

				arg_404_1.text_.text = var_407_5

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_7 = 37 <= 0 and var_407_4 or var_407_4 * (utf8.len(var_407_5) / 37)

				if (37 <= 0 and var_407_4 or var_407_4 * (utf8.len(var_407_5) / 37)) > 0 and var_407_4 < var_407_7 then
					arg_404_1.talkMaxDuration = var_407_7

					if var_407_7 + var_407_3 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_7 + var_407_3
					end
				end

				arg_404_1.text_.text = var_407_5
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_8 = math.max(var_407_4, arg_404_1.talkMaxDuration)

			if var_407_3 <= arg_404_1.time_ and arg_404_1.time_ < var_407_3 + var_407_8 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_3) / var_407_8

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_3 + var_407_8 and arg_404_1.time_ < var_407_3 + var_407_8 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_404_1:InitPlayNodeList()
	end,
	Play1104806096 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 1104806096
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play1104806097(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 1.15

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_1 = arg_408_1:FormatText(arg_408_1:GetWordFromCfg(1104806096).content)

				arg_408_1.text_.text = var_411_1

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_3 = 46 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_1) / 46)

				if (46 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_1) / 46)) > 0 and var_411_0 < var_411_3 then
					arg_408_1.talkMaxDuration = var_411_3

					if var_411_3 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_3 + 0
					end
				end

				arg_408_1.text_.text = var_411_1
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_4 = math.max(var_411_0, arg_408_1.talkMaxDuration)

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_4 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - 0) / var_411_4

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= 0 + var_411_4 and arg_408_1.time_ < 0 + var_411_4 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play1104806097 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1104806097
		arg_412_1.duration_ = 6.5

		local var_412_0 = {
			zh = 5.233,
			ja = 6.5
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1104806098(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.var_.moveOldPos114801ui_story = arg_412_1.actors_["114801ui_story"].transform.localPosition
			end

			local var_415_0 = 0.001

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 then
				arg_412_1.actors_["114801ui_story"].transform.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos114801ui_story, Vector3.New(0, -0.8, -6.2), (arg_412_1.time_ - 0) / var_415_0)
				arg_412_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_412_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["114801ui_story"].transform.position).z)
				arg_412_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_412_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_412_1.actors_["114801ui_story"].transform.localEulerAngles = arg_412_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 then
				arg_412_1.actors_["114801ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_412_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_412_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["114801ui_story"].transform.position).z)
				arg_412_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_412_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_412_1.actors_["114801ui_story"].transform.localEulerAngles = arg_412_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			local var_415_1 = arg_412_1.actors_["114801ui_story"]

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(var_415_1) and arg_412_1.var_.characterEffect114801ui_story == nil then
				arg_412_1.var_.characterEffect114801ui_story = var_415_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_2 = 0.200000002980232

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_2 and not isNil(var_415_1) then
				if arg_412_1.var_.characterEffect114801ui_story and not isNil(var_415_1) then
					arg_412_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_412_1.time_ >= 0 + var_415_2 and arg_412_1.time_ < 0 + var_415_2 + arg_415_0 and not isNil(var_415_1) and arg_412_1.var_.characterEffect114801ui_story then
				arg_412_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_415_4 = 0
			local var_415_5 = 0.8

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_4 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_6 = arg_412_1:GetWordFromCfg(1104806097)
				local var_415_7 = arg_412_1:FormatText(var_415_6.content)

				arg_412_1.text_.text = var_415_7

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_9 = 32 <= 0 and var_415_5 or var_415_5 * (utf8.len(var_415_7) / 32)

				if (32 <= 0 and var_415_5 or var_415_5 * (utf8.len(var_415_7) / 32)) > 0 and var_415_5 < var_415_9 then
					arg_412_1.talkMaxDuration = var_415_9

					if var_415_9 + var_415_4 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_9 + var_415_4
					end
				end

				arg_412_1.text_.text = var_415_7
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806097", "story_v_side_new_1104806.awb") ~= 0 then
					local var_415_10 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806097", "story_v_side_new_1104806.awb") / 1000

					if var_415_10 + var_415_4 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_10 + var_415_4
					end

					if var_415_6.prefab_name ~= "" and arg_412_1.actors_[var_415_6.prefab_name] ~= nil then
						local var_415_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_6.prefab_name].transform, "story_v_side_new_1104806", "1104806097", "story_v_side_new_1104806.awb")

						arg_412_1:RecordAudio("1104806097", var_415_11)
						arg_412_1:RecordAudio("1104806097", var_415_11)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806097", "story_v_side_new_1104806.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806097", "story_v_side_new_1104806.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_12 = math.max(var_415_5, arg_412_1.talkMaxDuration)

			if var_415_4 <= arg_412_1.time_ and arg_412_1.time_ < var_415_4 + var_415_12 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_4) / var_415_12

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_4 + var_415_12 and arg_412_1.time_ < var_415_4 + var_415_12 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_412_1:InitPlayNodeList()
	end,
	Play1104806098 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1104806098
		arg_416_1.duration_ = 6.43

		local var_416_0 = {
			zh = 4.8,
			ja = 6.433
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1104806099(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_419_0 = 0
			local var_419_1 = 1

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_2 = arg_416_1:GetWordFromCfg(1104806098)
				local var_419_3 = arg_416_1:FormatText(var_419_2.content)

				arg_416_1.text_.text = var_419_3

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_5 = 37 <= 0 and var_419_1 or var_419_1 * (utf8.len(var_419_3) / 37)

				if (37 <= 0 and var_419_1 or var_419_1 * (utf8.len(var_419_3) / 37)) > 0 and var_419_1 < var_419_5 then
					arg_416_1.talkMaxDuration = var_419_5

					if var_419_5 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_5 + var_419_0
					end
				end

				arg_416_1.text_.text = var_419_3
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806098", "story_v_side_new_1104806.awb") ~= 0 then
					local var_419_6 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806098", "story_v_side_new_1104806.awb") / 1000

					if var_419_6 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_6 + var_419_0
					end

					if var_419_2.prefab_name ~= "" and arg_416_1.actors_[var_419_2.prefab_name] ~= nil then
						local var_419_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_2.prefab_name].transform, "story_v_side_new_1104806", "1104806098", "story_v_side_new_1104806.awb")

						arg_416_1:RecordAudio("1104806098", var_419_7)
						arg_416_1:RecordAudio("1104806098", var_419_7)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806098", "story_v_side_new_1104806.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806098", "story_v_side_new_1104806.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_8 = math.max(var_419_1, arg_416_1.talkMaxDuration)

			if var_419_0 <= arg_416_1.time_ and arg_416_1.time_ < var_419_0 + var_419_8 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_0) / var_419_8

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_0 + var_419_8 and arg_416_1.time_ < var_419_0 + var_419_8 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play1104806099 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1104806099
		arg_420_1.duration_ = 5.27

		local var_420_0 = {
			zh = 5.266,
			ja = 4.6
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1104806100(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 0.575

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_1 = arg_420_1:GetWordFromCfg(1104806099)
				local var_423_2 = arg_420_1:FormatText(var_423_1.content)

				arg_420_1.text_.text = var_423_2

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_4 = 22 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_2) / 22)

				if (22 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_2) / 22)) > 0 and var_423_0 < var_423_4 then
					arg_420_1.talkMaxDuration = var_423_4

					if var_423_4 + 0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_4 + 0
					end
				end

				arg_420_1.text_.text = var_423_2
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806099", "story_v_side_new_1104806.awb") ~= 0 then
					local var_423_5 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806099", "story_v_side_new_1104806.awb") / 1000

					if var_423_5 + 0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_5 + 0
					end

					if var_423_1.prefab_name ~= "" and arg_420_1.actors_[var_423_1.prefab_name] ~= nil then
						local var_423_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_1.prefab_name].transform, "story_v_side_new_1104806", "1104806099", "story_v_side_new_1104806.awb")

						arg_420_1:RecordAudio("1104806099", var_423_6)
						arg_420_1:RecordAudio("1104806099", var_423_6)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806099", "story_v_side_new_1104806.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806099", "story_v_side_new_1104806.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_7 = math.max(var_423_0, arg_420_1.talkMaxDuration)

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_7 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - 0) / var_423_7

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= 0 + var_423_7 and arg_420_1.time_ < 0 + var_423_7 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play1104806100 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1104806100
		arg_424_1.duration_ = 7

		local var_424_0 = {
			zh = 5.633,
			ja = 7
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1104806101(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_2")
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_427_0 = 0
			local var_427_1 = 0.65

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_0 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_2 = arg_424_1:GetWordFromCfg(1104806100)
				local var_427_3 = arg_424_1:FormatText(var_427_2.content)

				arg_424_1.text_.text = var_427_3

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_5 = 25 <= 0 and var_427_1 or var_427_1 * (utf8.len(var_427_3) / 25)

				if (25 <= 0 and var_427_1 or var_427_1 * (utf8.len(var_427_3) / 25)) > 0 and var_427_1 < var_427_5 then
					arg_424_1.talkMaxDuration = var_427_5

					if var_427_5 + var_427_0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_5 + var_427_0
					end
				end

				arg_424_1.text_.text = var_427_3
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806100", "story_v_side_new_1104806.awb") ~= 0 then
					local var_427_6 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806100", "story_v_side_new_1104806.awb") / 1000

					if var_427_6 + var_427_0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_6 + var_427_0
					end

					if var_427_2.prefab_name ~= "" and arg_424_1.actors_[var_427_2.prefab_name] ~= nil then
						local var_427_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_2.prefab_name].transform, "story_v_side_new_1104806", "1104806100", "story_v_side_new_1104806.awb")

						arg_424_1:RecordAudio("1104806100", var_427_7)
						arg_424_1:RecordAudio("1104806100", var_427_7)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806100", "story_v_side_new_1104806.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806100", "story_v_side_new_1104806.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_8 = math.max(var_427_1, arg_424_1.talkMaxDuration)

			if var_427_0 <= arg_424_1.time_ and arg_424_1.time_ < var_427_0 + var_427_8 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_0) / var_427_8

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_0 + var_427_8 and arg_424_1.time_ < var_427_0 + var_427_8 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play1104806101 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 1104806101
		arg_428_1.duration_ = 6.17

		local var_428_0 = {
			zh = 5.333,
			ja = 6.166
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play1104806102(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_431_0 = 0
			local var_431_1 = 0.55

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_0 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_2 = arg_428_1:GetWordFromCfg(1104806101)
				local var_431_3 = arg_428_1:FormatText(var_431_2.content)

				arg_428_1.text_.text = var_431_3

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_5 = 22 <= 0 and var_431_1 or var_431_1 * (utf8.len(var_431_3) / 22)

				if (22 <= 0 and var_431_1 or var_431_1 * (utf8.len(var_431_3) / 22)) > 0 and var_431_1 < var_431_5 then
					arg_428_1.talkMaxDuration = var_431_5

					if var_431_5 + var_431_0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_5 + var_431_0
					end
				end

				arg_428_1.text_.text = var_431_3
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806101", "story_v_side_new_1104806.awb") ~= 0 then
					local var_431_6 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806101", "story_v_side_new_1104806.awb") / 1000

					if var_431_6 + var_431_0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_6 + var_431_0
					end

					if var_431_2.prefab_name ~= "" and arg_428_1.actors_[var_431_2.prefab_name] ~= nil then
						local var_431_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_2.prefab_name].transform, "story_v_side_new_1104806", "1104806101", "story_v_side_new_1104806.awb")

						arg_428_1:RecordAudio("1104806101", var_431_7)
						arg_428_1:RecordAudio("1104806101", var_431_7)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806101", "story_v_side_new_1104806.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806101", "story_v_side_new_1104806.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_8 = math.max(var_431_1, arg_428_1.talkMaxDuration)

			if var_431_0 <= arg_428_1.time_ and arg_428_1.time_ < var_431_0 + var_431_8 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_0) / var_431_8

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_0 + var_431_8 and arg_428_1.time_ < var_431_0 + var_431_8 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play1104806102 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1104806102
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1104806103(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(arg_432_1.actors_["114801ui_story"]) and arg_432_1.var_.characterEffect114801ui_story == nil then
				arg_432_1.var_.characterEffect114801ui_story = arg_432_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_0 = 0.200000002980232

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_0 and not isNil(arg_432_1.actors_["114801ui_story"]) then
				if arg_432_1.var_.characterEffect114801ui_story and not isNil(arg_432_1.actors_["114801ui_story"]) then
					arg_432_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_432_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_432_1.time_ - 0) / var_435_0)
				end
			end

			if arg_432_1.time_ >= 0 + var_435_0 and arg_432_1.time_ < 0 + var_435_0 + arg_435_0 and not isNil(arg_432_1.actors_["114801ui_story"]) and arg_432_1.var_.characterEffect114801ui_story then
				arg_432_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_432_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			local var_435_1 = 0
			local var_435_2 = 0.05

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, true)
				arg_432_1.iconController_:SetSelectedState("hero")

				arg_432_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_432_1.callingController_:SetSelectedState("normal")

				arg_432_1.keyicon_.color = Color.New(1, 1, 1)
				arg_432_1.icon_.color = Color.New(1, 1, 1)

				local var_435_3 = arg_432_1:FormatText(arg_432_1:GetWordFromCfg(1104806102).content)

				arg_432_1.text_.text = var_435_3

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_5 = 2 <= 0 and var_435_2 or var_435_2 * (utf8.len(var_435_3) / 2)

				if (2 <= 0 and var_435_2 or var_435_2 * (utf8.len(var_435_3) / 2)) > 0 and var_435_2 < var_435_5 then
					arg_432_1.talkMaxDuration = var_435_5

					if var_435_5 + var_435_1 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_5 + var_435_1
					end
				end

				arg_432_1.text_.text = var_435_3
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_6 = math.max(var_435_2, arg_432_1.talkMaxDuration)

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_6 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_1) / var_435_6

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_1 + var_435_6 and arg_432_1.time_ < var_435_1 + var_435_6 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play1104806103 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1104806103
		arg_436_1.duration_ = 6.03

		local var_436_0 = {
			zh = 4.7,
			ja = 6.033
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1104806104(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(arg_436_1.actors_["114801ui_story"]) and arg_436_1.var_.characterEffect114801ui_story == nil then
				arg_436_1.var_.characterEffect114801ui_story = arg_436_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_0 = 0.200000002980232

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_0 and not isNil(arg_436_1.actors_["114801ui_story"]) then
				if arg_436_1.var_.characterEffect114801ui_story and not isNil(arg_436_1.actors_["114801ui_story"]) then
					arg_436_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_436_1.time_ >= 0 + var_439_0 and arg_436_1.time_ < 0 + var_439_0 + arg_439_0 and not isNil(arg_436_1.actors_["114801ui_story"]) and arg_436_1.var_.characterEffect114801ui_story then
				arg_436_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_439_2 = 0
			local var_439_3 = 0.425

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_2 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_4 = arg_436_1:GetWordFromCfg(1104806103)
				local var_439_5 = arg_436_1:FormatText(var_439_4.content)

				arg_436_1.text_.text = var_439_5

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_7 = 17 <= 0 and var_439_3 or var_439_3 * (utf8.len(var_439_5) / 17)

				if (17 <= 0 and var_439_3 or var_439_3 * (utf8.len(var_439_5) / 17)) > 0 and var_439_3 < var_439_7 then
					arg_436_1.talkMaxDuration = var_439_7

					if var_439_7 + var_439_2 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_7 + var_439_2
					end
				end

				arg_436_1.text_.text = var_439_5
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806103", "story_v_side_new_1104806.awb") ~= 0 then
					local var_439_8 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806103", "story_v_side_new_1104806.awb") / 1000

					if var_439_8 + var_439_2 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_8 + var_439_2
					end

					if var_439_4.prefab_name ~= "" and arg_436_1.actors_[var_439_4.prefab_name] ~= nil then
						local var_439_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_4.prefab_name].transform, "story_v_side_new_1104806", "1104806103", "story_v_side_new_1104806.awb")

						arg_436_1:RecordAudio("1104806103", var_439_9)
						arg_436_1:RecordAudio("1104806103", var_439_9)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806103", "story_v_side_new_1104806.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806103", "story_v_side_new_1104806.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_10 = math.max(var_439_3, arg_436_1.talkMaxDuration)

			if var_439_2 <= arg_436_1.time_ and arg_436_1.time_ < var_439_2 + var_439_10 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_2) / var_439_10

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_2 + var_439_10 and arg_436_1.time_ < var_439_2 + var_439_10 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play1104806104 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 1104806104
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play1104806105(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(arg_440_1.actors_["114801ui_story"]) and arg_440_1.var_.characterEffect114801ui_story == nil then
				arg_440_1.var_.characterEffect114801ui_story = arg_440_1.actors_["114801ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_0 = 0.200000002980232

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_0 and not isNil(arg_440_1.actors_["114801ui_story"]) then
				if arg_440_1.var_.characterEffect114801ui_story and not isNil(arg_440_1.actors_["114801ui_story"]) then
					arg_440_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_440_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_440_1.time_ - 0) / var_443_0)
				end
			end

			if arg_440_1.time_ >= 0 + var_443_0 and arg_440_1.time_ < 0 + var_443_0 + arg_443_0 and not isNil(arg_440_1.actors_["114801ui_story"]) and arg_440_1.var_.characterEffect114801ui_story then
				arg_440_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_440_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			local var_443_1 = 0
			local var_443_2 = 0.525

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, true)
				arg_440_1.iconController_:SetSelectedState("hero")

				arg_440_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_440_1.callingController_:SetSelectedState("normal")

				arg_440_1.keyicon_.color = Color.New(1, 1, 1)
				arg_440_1.icon_.color = Color.New(1, 1, 1)

				local var_443_3 = arg_440_1:FormatText(arg_440_1:GetWordFromCfg(1104806104).content)

				arg_440_1.text_.text = var_443_3

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_5 = 21 <= 0 and var_443_2 or var_443_2 * (utf8.len(var_443_3) / 21)

				if (21 <= 0 and var_443_2 or var_443_2 * (utf8.len(var_443_3) / 21)) > 0 and var_443_2 < var_443_5 then
					arg_440_1.talkMaxDuration = var_443_5

					if var_443_5 + var_443_1 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_5 + var_443_1
					end
				end

				arg_440_1.text_.text = var_443_3
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_6 = math.max(var_443_2, arg_440_1.talkMaxDuration)

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_6 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_1) / var_443_6

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_1 + var_443_6 and arg_440_1.time_ < var_443_1 + var_443_6 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play1104806105 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 1104806105
		arg_444_1.duration_ = 4.63

		local var_444_0 = {
			zh = 4.633,
			ja = 4.166
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play1104806106(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.var_.moveOldPos114801ui_story = arg_444_1.actors_["114801ui_story"].transform.localPosition
			end

			local var_447_0 = 0.001

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_0 then
				arg_444_1.actors_["114801ui_story"].transform.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos114801ui_story, Vector3.New(0, -0.8, -6.2), (arg_444_1.time_ - 0) / var_447_0)
				arg_444_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_444_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["114801ui_story"].transform.position).z)
				arg_444_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_444_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_444_1.actors_["114801ui_story"].transform.localEulerAngles = arg_444_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			if arg_444_1.time_ >= 0 + var_447_0 and arg_444_1.time_ < 0 + var_447_0 + arg_447_0 then
				arg_444_1.actors_["114801ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_444_1.actors_["114801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_444_1.actors_["114801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["114801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["114801ui_story"].transform.position).z)
				arg_444_1.actors_["114801ui_story"].transform.localEulerAngles.z = 0
				arg_444_1.actors_["114801ui_story"].transform.localEulerAngles.x = 0
				arg_444_1.actors_["114801ui_story"].transform.localEulerAngles = arg_444_1.actors_["114801ui_story"].transform.localEulerAngles
			end

			local var_447_1 = arg_444_1.actors_["114801ui_story"]

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(var_447_1) and arg_444_1.var_.characterEffect114801ui_story == nil then
				arg_444_1.var_.characterEffect114801ui_story = var_447_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_2 = 0.200000002980232

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_2 and not isNil(var_447_1) then
				if arg_444_1.var_.characterEffect114801ui_story and not isNil(var_447_1) then
					arg_444_1.var_.characterEffect114801ui_story.fillFlat = false
				end
			end

			if arg_444_1.time_ >= 0 + var_447_2 and arg_444_1.time_ < 0 + var_447_2 + arg_447_0 and not isNil(var_447_1) and arg_444_1.var_.characterEffect114801ui_story then
				arg_444_1.var_.characterEffect114801ui_story.fillFlat = false
			end

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action453")
			end

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1:PlayTimeline("114801ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_447_4 = 0
			local var_447_5 = 0.4

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_4 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_6 = arg_444_1:GetWordFromCfg(1104806105)
				local var_447_7 = arg_444_1:FormatText(var_447_6.content)

				arg_444_1.text_.text = var_447_7

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_9 = 16 <= 0 and var_447_5 or var_447_5 * (utf8.len(var_447_7) / 16)

				if (16 <= 0 and var_447_5 or var_447_5 * (utf8.len(var_447_7) / 16)) > 0 and var_447_5 < var_447_9 then
					arg_444_1.talkMaxDuration = var_447_9

					if var_447_9 + var_447_4 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_9 + var_447_4
					end
				end

				arg_444_1.text_.text = var_447_7
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806105", "story_v_side_new_1104806.awb") ~= 0 then
					local var_447_10 = manager.audio:GetVoiceLength("story_v_side_new_1104806", "1104806105", "story_v_side_new_1104806.awb") / 1000

					if var_447_10 + var_447_4 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_10 + var_447_4
					end

					if var_447_6.prefab_name ~= "" and arg_444_1.actors_[var_447_6.prefab_name] ~= nil then
						local var_447_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_6.prefab_name].transform, "story_v_side_new_1104806", "1104806105", "story_v_side_new_1104806.awb")

						arg_444_1:RecordAudio("1104806105", var_447_11)
						arg_444_1:RecordAudio("1104806105", var_447_11)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_side_new_1104806", "1104806105", "story_v_side_new_1104806.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_side_new_1104806", "1104806105", "story_v_side_new_1104806.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_12 = math.max(var_447_5, arg_444_1.talkMaxDuration)

			if var_447_4 <= arg_444_1.time_ and arg_444_1.time_ < var_447_4 + var_447_12 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_4) / var_447_12

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_4 + var_447_12 and arg_444_1.time_ < var_447_4 + var_447_12 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_444_1:InitPlayNodeList()
	end,
	Play1104806106 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 1104806106
		arg_448_1.duration_ = 4.63

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play1104806107(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if arg_448_1.bgs_.R4802 == nil then
				local var_451_0 = Object.Instantiate(arg_448_1.paintGo_)

				var_451_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R4802")
				var_451_0.name = "R4802"
				var_451_0.transform.parent = arg_448_1.stage_.transform
				var_451_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_448_1.bgs_.R4802 = var_451_0
			end

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				local var_451_1 = arg_448_1.bgs_.R4802

				arg_448_1.bgs_.R4802.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_451_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_451_2 = var_451_1:GetComponent("SpriteRenderer")

				if var_451_2 and var_451_2.sprite then
					local var_451_3 = 2 * (var_451_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_451_1.transform.localScale = Vector3.New(var_451_3 / var_451_2.sprite.bounds.size.y < var_451_3 * manager.ui.mainCameraCom_.aspect / var_451_2.sprite.bounds.size.x and var_451_3 * manager.ui.mainCameraCom_.aspect / var_451_2.sprite.bounds.size.x or var_451_3 / var_451_2.sprite.bounds.size.y, var_451_3 / var_451_2.sprite.bounds.size.y < var_451_3 * manager.ui.mainCameraCom_.aspect / var_451_2.sprite.bounds.size.x and var_451_3 * manager.ui.mainCameraCom_.aspect / var_451_2.sprite.bounds.size.x or var_451_3 / var_451_2.sprite.bounds.size.y, 0)
				end

				for iter_451_0, iter_451_1 in pairs(arg_448_1.bgs_) do
					if iter_451_0 ~= "R4802" then
						iter_451_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_451_4 = 0

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_4 + arg_451_0 then
				arg_448_1.mask_.enabled = true
				arg_448_1.mask_.raycastTarget = true

				arg_448_1:SetGaussion(false)
			end

			local var_451_5 = 3.5

			if var_451_4 <= arg_448_1.time_ and arg_448_1.time_ < var_451_4 + var_451_5 then
				local var_451_6 = Color.New(1, 1, 1)

				var_451_6.a = Mathf.Lerp(1, 0, (arg_448_1.time_ - var_451_4) / var_451_5)
				arg_448_1.mask_.color = var_451_6
			end

			if arg_448_1.time_ >= var_451_4 + var_451_5 and arg_448_1.time_ < var_451_4 + var_451_5 + arg_451_0 then
				local var_451_7 = Color.New(1, 1, 1)

				arg_448_1.mask_.enabled = false
				var_451_7.a = 0
				arg_448_1.mask_.color = var_451_7
			end

			local var_451_8 = arg_448_1.actors_["114801ui_story"].transform

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.var_.moveOldPos114801ui_story = var_451_8.localPosition
			end

			local var_451_9 = 0.001

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_9 then
				var_451_8.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos114801ui_story, Vector3.New(0, 100, 0), (arg_448_1.time_ - 0) / var_451_9)
				var_451_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_451_8.position).x, (manager.ui.mainCamera.transform.position - var_451_8.position).y, (manager.ui.mainCamera.transform.position - var_451_8.position).z)
				var_451_8.localEulerAngles.z = 0
				var_451_8.localEulerAngles.x = 0
				var_451_8.localEulerAngles = var_451_8.localEulerAngles
			end

			if arg_448_1.time_ >= 0 + var_451_9 and arg_448_1.time_ < 0 + var_451_9 + arg_451_0 then
				var_451_8.localPosition = Vector3.New(0, 100, 0)
				var_451_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_451_8.position).x, (manager.ui.mainCamera.transform.position - var_451_8.position).y, (manager.ui.mainCamera.transform.position - var_451_8.position).z)
				var_451_8.localEulerAngles.z = 0
				var_451_8.localEulerAngles.x = 0
				var_451_8.localEulerAngles = var_451_8.localEulerAngles
			end

			local var_451_10 = arg_448_1.actors_["114801ui_story"]

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(var_451_10) and arg_448_1.var_.characterEffect114801ui_story == nil then
				arg_448_1.var_.characterEffect114801ui_story = var_451_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_11 = 0.200000002980232

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_11 and not isNil(var_451_10) then
				if arg_448_1.var_.characterEffect114801ui_story and not isNil(var_451_10) then
					arg_448_1.var_.characterEffect114801ui_story.fillFlat = true
					arg_448_1.var_.characterEffect114801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_448_1.time_ - 0) / var_451_11)
				end
			end

			if arg_448_1.time_ >= 0 + var_451_11 and arg_448_1.time_ < 0 + var_451_11 + arg_451_0 and not isNil(var_451_10) and arg_448_1.var_.characterEffect114801ui_story then
				arg_448_1.var_.characterEffect114801ui_story.fillFlat = true
				arg_448_1.var_.characterEffect114801ui_story.fillRatio = 0.5
			end

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.fswbg_:SetActive(true)
				arg_448_1.dialog_:SetActive(false)

				arg_448_1.fswtw_.percent = 0
				arg_448_1.fswt_.text = arg_448_1:FormatText(arg_448_1:GetWordFromCfg(1104806106).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.fswt_)

				arg_448_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_448_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_448_1.fswtw_:SetDirty()

				arg_448_1.typewritterCharCountI18N = 0

				SetActive(arg_448_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_448_1:ShowNextGo(false)
			end

			local var_451_12 = 2.5

			if 2.5 < arg_448_1.time_ and arg_448_1.time_ <= var_451_12 + arg_451_0 then
				arg_448_1.var_.oldValueTypewriter = arg_448_1.fswtw_.percent

				SetActive(arg_448_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_448_1:ShowNextGo(false)
			end

			local var_451_13 = 24
			local var_451_14 = 1.6
			local var_451_15, var_451_16 = arg_448_1:GetPercentByPara(arg_448_1:FormatText(arg_448_1:GetWordFromCfg(1104806106).content), 1)

			if var_451_12 < arg_448_1.time_ and arg_448_1.time_ <= var_451_12 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0

				local var_451_17 = var_451_13 <= 0 and var_451_14 or var_451_14 * ((var_451_16 - arg_448_1.typewritterCharCountI18N) / var_451_13)

				if (var_451_13 <= 0 and var_451_14 or var_451_14 * ((var_451_16 - arg_448_1.typewritterCharCountI18N) / var_451_13)) > 0 and var_451_14 < var_451_17 then
					arg_448_1.talkMaxDuration = var_451_17

					if var_451_17 + var_451_12 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_17 + var_451_12
					end
				end
			end

			local var_451_18 = math.max(1.6, arg_448_1.talkMaxDuration)

			if var_451_12 <= arg_448_1.time_ and arg_448_1.time_ < var_451_12 + var_451_18 then
				arg_448_1.fswtw_.percent = Mathf.Lerp(arg_448_1.var_.oldValueTypewriter, var_451_15, (arg_448_1.time_ - var_451_12) / var_451_18)
				arg_448_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_448_1.fswtw_:SetDirty()
			end

			if arg_448_1.time_ >= var_451_12 + var_451_18 and arg_448_1.time_ < var_451_12 + var_451_18 + arg_451_0 then
				arg_448_1.fswtw_.percent = var_451_15

				arg_448_1.fswtw_:SetDirty()
				arg_448_1:ShowNextGo(true)

				arg_448_1.typewritterCharCountI18N = var_451_16
			end

			if 2.5 < arg_448_1.time_ and arg_448_1.time_ <= 2.5 + arg_451_0 then
				local var_451_19 = arg_448_1.fswbg_.transform:Find("textbox/adapt/content") or arg_448_1.fswbg_.transform:Find("textbox/content")
				local var_451_20 = arg_448_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_451_21 = var_451_19:GetComponent("RectTransform")

				var_451_19:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_451_21.offsetMin = Vector2.New(0, 0)
				var_451_21.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_448_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "114801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_448_1:InitPlayNodeList()
	end,
	Play1104806107 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 1104806107
		arg_452_1.duration_ = 2.27

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play1104806108(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.fswbg_:SetActive(true)
				arg_452_1.dialog_:SetActive(false)

				arg_452_1.fswtw_.percent = 0
				arg_452_1.fswt_.text = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(1104806107).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.fswt_)

				arg_452_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_452_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_452_1.fswtw_:SetDirty()

				arg_452_1.typewritterCharCountI18N = 0

				SetActive(arg_452_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_452_1:ShowNextGo(false)
			end

			local var_455_0 = 0.034000001847744

			if 0.034000001847744 < arg_452_1.time_ and arg_452_1.time_ <= var_455_0 + arg_455_0 then
				arg_452_1.var_.oldValueTypewriter = arg_452_1.fswtw_.percent

				SetActive(arg_452_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_452_1:ShowNextGo(false)
			end

			local var_455_1 = 25
			local var_455_2 = 1.66666666666667
			local var_455_3, var_455_4 = arg_452_1:GetPercentByPara(arg_452_1:FormatText(arg_452_1:GetWordFromCfg(1104806107).content), 1)

			if var_455_0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_0 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0

				local var_455_5 = var_455_1 <= 0 and var_455_2 or var_455_2 * ((var_455_4 - arg_452_1.typewritterCharCountI18N) / var_455_1)

				if (var_455_1 <= 0 and var_455_2 or var_455_2 * ((var_455_4 - arg_452_1.typewritterCharCountI18N) / var_455_1)) > 0 and var_455_2 < var_455_5 then
					arg_452_1.talkMaxDuration = var_455_5

					if var_455_5 + var_455_0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_5 + var_455_0
					end
				end
			end

			local var_455_6 = math.max(1.66666666666667, arg_452_1.talkMaxDuration)

			if var_455_0 <= arg_452_1.time_ and arg_452_1.time_ < var_455_0 + var_455_6 then
				arg_452_1.fswtw_.percent = Mathf.Lerp(arg_452_1.var_.oldValueTypewriter, var_455_3, (arg_452_1.time_ - var_455_0) / var_455_6)
				arg_452_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_452_1.fswtw_:SetDirty()
			end

			if arg_452_1.time_ >= var_455_0 + var_455_6 and arg_452_1.time_ < var_455_0 + var_455_6 + arg_455_0 then
				arg_452_1.fswtw_.percent = var_455_3

				arg_452_1.fswtw_:SetDirty()
				arg_452_1:ShowNextGo(true)

				arg_452_1.typewritterCharCountI18N = var_455_4
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play1104806108 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1104806108
		arg_456_1.duration_ = 1.03

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play1104806109(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.fswbg_:SetActive(true)
				arg_456_1.dialog_:SetActive(false)

				arg_456_1.fswtw_.percent = 0
				arg_456_1.fswt_.text = arg_456_1:FormatText(arg_456_1:GetWordFromCfg(1104806108).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.fswt_)

				arg_456_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_456_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_456_1.fswtw_:SetDirty()

				arg_456_1.typewritterCharCountI18N = 0

				SetActive(arg_456_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_456_1:ShowNextGo(false)
			end

			local var_459_0 = 0.034000001847744

			if 0.034000001847744 < arg_456_1.time_ and arg_456_1.time_ <= var_459_0 + arg_459_0 then
				arg_456_1.var_.oldValueTypewriter = arg_456_1.fswtw_.percent

				SetActive(arg_456_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_456_1:ShowNextGo(false)
			end

			local var_459_1 = 15
			local var_459_2 = 1
			local var_459_3, var_459_4 = arg_456_1:GetPercentByPara(arg_456_1:FormatText(arg_456_1:GetWordFromCfg(1104806108).content), 1)

			if var_459_0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0

				local var_459_5 = var_459_1 <= 0 and var_459_2 or var_459_2 * ((var_459_4 - arg_456_1.typewritterCharCountI18N) / var_459_1)

				if (var_459_1 <= 0 and var_459_2 or var_459_2 * ((var_459_4 - arg_456_1.typewritterCharCountI18N) / var_459_1)) > 0 and var_459_2 < var_459_5 then
					arg_456_1.talkMaxDuration = var_459_5

					if var_459_5 + var_459_0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_5 + var_459_0
					end
				end
			end

			local var_459_6 = math.max(1, arg_456_1.talkMaxDuration)

			if var_459_0 <= arg_456_1.time_ and arg_456_1.time_ < var_459_0 + var_459_6 then
				arg_456_1.fswtw_.percent = Mathf.Lerp(arg_456_1.var_.oldValueTypewriter, var_459_3, (arg_456_1.time_ - var_459_0) / var_459_6)
				arg_456_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_456_1.fswtw_:SetDirty()
			end

			if arg_456_1.time_ >= var_459_0 + var_459_6 and arg_456_1.time_ < var_459_0 + var_459_6 + arg_459_0 then
				arg_456_1.fswtw_.percent = var_459_3

				arg_456_1.fswtw_:SetDirty()
				arg_456_1:ShowNextGo(true)

				arg_456_1.typewritterCharCountI18N = var_459_4
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play1104806109 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1104806109
		arg_460_1.duration_ = 1.1

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
			arg_460_1.auto_ = false
		end

		function arg_460_1.playNext_(arg_462_0)
			arg_460_1.onStoryFinished_()
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.fswbg_:SetActive(true)
				arg_460_1.dialog_:SetActive(false)

				arg_460_1.fswtw_.percent = 0
				arg_460_1.fswt_.text = arg_460_1:FormatText(arg_460_1:GetWordFromCfg(1104806109).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.fswt_)

				arg_460_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_460_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_460_1.fswtw_:SetDirty()

				arg_460_1.typewritterCharCountI18N = 0

				SetActive(arg_460_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_460_1:ShowNextGo(false)
			end

			local var_463_0 = 0.034000001847744

			if 0.034000001847744 < arg_460_1.time_ and arg_460_1.time_ <= var_463_0 + arg_463_0 then
				arg_460_1.var_.oldValueTypewriter = arg_460_1.fswtw_.percent

				SetActive(arg_460_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_460_1:ShowNextGo(false)
			end

			local var_463_1 = 16
			local var_463_2 = 1.06666666666667
			local var_463_3, var_463_4 = arg_460_1:GetPercentByPara(arg_460_1:FormatText(arg_460_1:GetWordFromCfg(1104806109).content), 1)

			if var_463_0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_0 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0

				local var_463_5 = var_463_1 <= 0 and var_463_2 or var_463_2 * ((var_463_4 - arg_460_1.typewritterCharCountI18N) / var_463_1)

				if (var_463_1 <= 0 and var_463_2 or var_463_2 * ((var_463_4 - arg_460_1.typewritterCharCountI18N) / var_463_1)) > 0 and var_463_2 < var_463_5 then
					arg_460_1.talkMaxDuration = var_463_5

					if var_463_5 + var_463_0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_5 + var_463_0
					end
				end
			end

			local var_463_6 = math.max(1.06666666666667, arg_460_1.talkMaxDuration)

			if var_463_0 <= arg_460_1.time_ and arg_460_1.time_ < var_463_0 + var_463_6 then
				arg_460_1.fswtw_.percent = Mathf.Lerp(arg_460_1.var_.oldValueTypewriter, var_463_3, (arg_460_1.time_ - var_463_0) / var_463_6)
				arg_460_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_460_1.fswtw_:SetDirty()
			end

			if arg_460_1.time_ >= var_463_0 + var_463_6 and arg_460_1.time_ < var_463_0 + var_463_6 + arg_463_0 then
				arg_460_1.fswtw_.percent = var_463_3

				arg_460_1.fswtw_:SetDirty()
				arg_460_1:ShowNextGo(true)

				arg_460_1.typewritterCharCountI18N = var_463_4
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST01a",
		"TextureConfig/Background/R4802"
	},
	voices = {
		"story_v_side_new_1104806.awb"
	}
}
