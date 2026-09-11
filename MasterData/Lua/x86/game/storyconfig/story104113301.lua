return {
	Play411331001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411331001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play411331002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I07a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I07a")
				var_4_0.name = "I07a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I07a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I07a

				arg_1_1.bgs_.I07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I07a" then
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

			if 0.666666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.666666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock")

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
			local var_4_15 = 1

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

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(411331001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 40 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 40)

				if (40 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 40)) > 0 and var_4_15 < var_4_19 then
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
	Play411331002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 411331002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play411331003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.475

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(411331002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 59 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 59)

				if (59 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 59)) > 0 and var_12_0 < var_12_3 then
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
	Play411331003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 411331003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play411331004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["4040ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4040ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "4040ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["4040ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["4040ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["4040ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["4040ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["4040ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos4040ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_13_1.time_ - 0) / var_16_4)
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

			local var_16_5 = arg_13_1.actors_["4040ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect4040ui_story == nil then
				arg_13_1.var_.characterEffect4040ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect4040ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect4040ui_story then
				arg_13_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_8 = 0
			local var_16_9 = 0.125

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(411331003).content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_12 = 5 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_10) / 5)

				if (5 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_10) / 5)) > 0 and var_16_9 < var_16_12 then
					arg_13_1.talkMaxDuration = var_16_12

					if var_16_12 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_10
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_13 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_13 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_13

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_13 and arg_13_1.time_ < var_16_8 + var_16_13 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play411331004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 411331004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play411331005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["4040ui_story"]) and arg_17_1.var_.characterEffect4040ui_story == nil then
				arg_17_1.var_.characterEffect4040ui_story = arg_17_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["4040ui_story"]) then
				if arg_17_1.var_.characterEffect4040ui_story and not isNil(arg_17_1.actors_["4040ui_story"]) then
					arg_17_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_17_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["4040ui_story"]) and arg_17_1.var_.characterEffect4040ui_story then
				arg_17_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_17_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 1.075

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(411331004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 43 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 43)

				if (43 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 43)) > 0 and var_20_2 < var_20_5 then
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
	Play411331005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 411331005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play411331006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos4040ui_story = arg_21_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["4040ui_story"].transform.position).z)
				arg_21_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["4040ui_story"].transform.localEulerAngles = arg_21_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_21_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["4040ui_story"].transform.position).z)
				arg_21_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["4040ui_story"].transform.localEulerAngles = arg_21_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["4040ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect4040ui_story == nil then
				arg_21_1.var_.characterEffect4040ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect4040ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect4040ui_story then
				arg_21_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_4 = 0
			local var_24_5 = 0.15

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(411331005).content)

				arg_21_1.text_.text = var_24_6

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_8 = 6 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_6) / 6)

				if (6 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_6) / 6)) > 0 and var_24_5 < var_24_8 then
					arg_21_1.talkMaxDuration = var_24_8

					if var_24_8 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_6
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_9 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_9 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_9

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_9 and arg_21_1.time_ < var_24_4 + var_24_9 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play411331006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 411331006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play411331007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["4040ui_story"]) and arg_25_1.var_.characterEffect4040ui_story == nil then
				arg_25_1.var_.characterEffect4040ui_story = arg_25_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["4040ui_story"]) then
				if arg_25_1.var_.characterEffect4040ui_story and not isNil(arg_25_1.actors_["4040ui_story"]) then
					arg_25_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_25_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["4040ui_story"]) and arg_25_1.var_.characterEffect4040ui_story then
				arg_25_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_25_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 1.4

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(411331006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 56 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 56)

				if (56 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 56)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play411331007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 411331007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play411331008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos4040ui_story = arg_29_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["4040ui_story"].transform.position).z)
				arg_29_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["4040ui_story"].transform.localEulerAngles = arg_29_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_29_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["4040ui_story"].transform.position).z)
				arg_29_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["4040ui_story"].transform.localEulerAngles = arg_29_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["4040ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect4040ui_story == nil then
				arg_29_1.var_.characterEffect4040ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect4040ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect4040ui_story then
				arg_29_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_32_4 = 0
			local var_32_5 = 0.725

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(411331007).content)

				arg_29_1.text_.text = var_32_6

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_8 = 29 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_6) / 29)

				if (29 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_6) / 29)) > 0 and var_32_5 < var_32_8 then
					arg_29_1.talkMaxDuration = var_32_8

					if var_32_8 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_6
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_9 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_9 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_9

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_9 and arg_29_1.time_ < var_32_4 + var_32_9 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play411331008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 411331008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play411331009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["4040ui_story"]) and arg_33_1.var_.characterEffect4040ui_story == nil then
				arg_33_1.var_.characterEffect4040ui_story = arg_33_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["4040ui_story"]) then
				if arg_33_1.var_.characterEffect4040ui_story and not isNil(arg_33_1.actors_["4040ui_story"]) then
					arg_33_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_33_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["4040ui_story"]) and arg_33_1.var_.characterEffect4040ui_story then
				arg_33_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_33_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.525

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(411331008).content)

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
	Play411331009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 411331009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play411331010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos4040ui_story = arg_37_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["4040ui_story"].transform.position).z)
				arg_37_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["4040ui_story"].transform.localEulerAngles = arg_37_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_37_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["4040ui_story"].transform.position).z)
				arg_37_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["4040ui_story"].transform.localEulerAngles = arg_37_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["4040ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect4040ui_story == nil then
				arg_37_1.var_.characterEffect4040ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect4040ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect4040ui_story then
				arg_37_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_40_4 = 0
			local var_40_5 = 0.75

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(411331009).content)

				arg_37_1.text_.text = var_40_6

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_8 = 30 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_6) / 30)

				if (30 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_6) / 30)) > 0 and var_40_5 < var_40_8 then
					arg_37_1.talkMaxDuration = var_40_8

					if var_40_8 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_6
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_9 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_9 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_9

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_9 and arg_37_1.time_ < var_40_4 + var_40_9 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play411331010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 411331010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play411331011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos4040ui_story = arg_41_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["4040ui_story"].transform.position).z)
				arg_41_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["4040ui_story"].transform.localEulerAngles = arg_41_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["4040ui_story"].transform.position).z)
				arg_41_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["4040ui_story"].transform.localEulerAngles = arg_41_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["4040ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect4040ui_story == nil then
				arg_41_1.var_.characterEffect4040ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect4040ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_41_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_2)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect4040ui_story then
				arg_41_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_41_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_44_3 = 0

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_3 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = false

				arg_41_1:SetGaussion(false)
			end

			local var_44_4 = 0.366666666666667

			if var_44_3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_3 + var_44_4 then
				local var_44_5 = Color.New(0, 0, 0)

				var_44_5.a = Mathf.Lerp(1, 0, (arg_41_1.time_ - var_44_3) / var_44_4)
				arg_41_1.mask_.color = var_44_5
			end

			if arg_41_1.time_ >= var_44_3 + var_44_4 and arg_41_1.time_ < var_44_3 + var_44_4 + arg_44_0 then
				local var_44_6 = Color.New(0, 0, 0)

				arg_41_1.mask_.enabled = false
				var_44_6.a = 0
				arg_41_1.mask_.color = var_44_6
			end

			local var_44_7 = 0
			local var_44_8 = 1.475

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_9 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_9:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(411331010).content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_12 = 59 <= 0 and var_44_8 or var_44_8 * (utf8.len(var_44_10) / 59)

				if (59 <= 0 and var_44_8 or var_44_8 * (utf8.len(var_44_10) / 59)) > 0 and var_44_8 < var_44_12 then
					arg_41_1.talkMaxDuration = var_44_12
					var_44_7 = var_44_7 + 0.3

					if var_44_12 + var_44_7 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_7
					end
				end

				arg_41_1.text_.text = var_44_10
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_13 = var_44_7 + 0.3
			local var_44_14 = math.max(var_44_8, arg_41_1.talkMaxDuration)

			if var_44_7 + 0.3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_13 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_13) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_13 + var_44_14 and arg_41_1.time_ < var_44_13 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play411331011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 411331011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play411331012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.2

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_1 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(411331011).content)

				arg_47_1.text_.text = var_50_1

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_3 = 8 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 8)

				if (8 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 8)) > 0 and var_50_0 < var_50_3 then
					arg_47_1.talkMaxDuration = var_50_3

					if var_50_3 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_3 + 0
					end
				end

				arg_47_1.text_.text = var_50_1
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_4 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_4

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play411331012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 411331012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play411331013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 1.4

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(411331012).content)

				arg_51_1.text_.text = var_54_1

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_3 = 56 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 56)

				if (56 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 56)) > 0 and var_54_0 < var_54_3 then
					arg_51_1.talkMaxDuration = var_54_3

					if var_54_3 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_3 + 0
					end
				end

				arg_51_1.text_.text = var_54_1
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_4 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_4

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play411331013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 411331013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play411331014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.15

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(411331013).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 6 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 6)

				if (6 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 6)) > 0 and var_58_0 < var_58_3 then
					arg_55_1.talkMaxDuration = var_58_3

					if var_58_3 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_3 + 0
					end
				end

				arg_55_1.text_.text = var_58_1
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_4 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_4

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play411331014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 411331014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play411331015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.6

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(411331014).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 24 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 24)

				if (24 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 24)) > 0 and var_62_0 < var_62_3 then
					arg_59_1.talkMaxDuration = var_62_3

					if var_62_3 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_3 + 0
					end
				end

				arg_59_1.text_.text = var_62_1
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_4 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_4

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play411331015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 411331015
		arg_63_1.duration_ = 3.2

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play411331016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if arg_63_1.bgs_.STblack == nil then
				local var_66_0 = Object.Instantiate(arg_63_1.paintGo_)

				var_66_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_66_0.name = "STblack"
				var_66_0.transform.parent = arg_63_1.stage_.transform
				var_66_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.bgs_.STblack = var_66_0
			end

			if 2 < arg_63_1.time_ and arg_63_1.time_ <= 2 + arg_66_0 then
				local var_66_1 = arg_63_1.bgs_.STblack

				arg_63_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_66_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_66_2 = var_66_1:GetComponent("SpriteRenderer")

				if var_66_2 and var_66_2.sprite then
					local var_66_3 = 2 * (var_66_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_66_1.transform.localScale = Vector3.New(var_66_3 / var_66_2.sprite.bounds.size.y < var_66_3 * manager.ui.mainCameraCom_.aspect / var_66_2.sprite.bounds.size.x and var_66_3 * manager.ui.mainCameraCom_.aspect / var_66_2.sprite.bounds.size.x or var_66_3 / var_66_2.sprite.bounds.size.y, var_66_3 / var_66_2.sprite.bounds.size.y < var_66_3 * manager.ui.mainCameraCom_.aspect / var_66_2.sprite.bounds.size.x and var_66_3 * manager.ui.mainCameraCom_.aspect / var_66_2.sprite.bounds.size.x or var_66_3 / var_66_2.sprite.bounds.size.y, 0)
				end

				for iter_66_0, iter_66_1 in pairs(arg_63_1.bgs_) do
					if iter_66_0 ~= "STblack" then
						iter_66_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_66_4 = 0

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_5 = 2

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_5 then
				local var_66_6 = Color.New(0, 0, 0)

				var_66_6.a = Mathf.Lerp(0, 1, (arg_63_1.time_ - var_66_4) / var_66_5)
				arg_63_1.mask_.color = var_66_6
			end

			if arg_63_1.time_ >= var_66_4 + var_66_5 and arg_63_1.time_ < var_66_4 + var_66_5 + arg_66_0 then
				local var_66_7 = Color.New(0, 0, 0)

				var_66_7.a = 1
				arg_63_1.mask_.color = var_66_7
			end

			local var_66_8 = 2

			if 2 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_9 = 1.03333333333333

			if var_66_8 <= arg_63_1.time_ and arg_63_1.time_ < var_66_8 + var_66_9 then
				local var_66_10 = Color.New(0, 0, 0)

				var_66_10.a = Mathf.Lerp(1, 0, (arg_63_1.time_ - var_66_8) / var_66_9)
				arg_63_1.mask_.color = var_66_10
			end

			if arg_63_1.time_ >= var_66_8 + var_66_9 and arg_63_1.time_ < var_66_8 + var_66_9 + arg_66_0 then
				local var_66_11 = Color.New(0, 0, 0)

				arg_63_1.mask_.enabled = false
				var_66_11.a = 0
				arg_63_1.mask_.color = var_66_11
			end

			if 2 < arg_63_1.time_ and arg_63_1.time_ <= 2 + arg_66_0 then
				arg_63_1.fswbg_:SetActive(true)
				arg_63_1.dialog_:SetActive(false)

				arg_63_1.fswtw_.percent = 0
				arg_63_1.fswt_.text = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(411331015).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.fswt_)

				arg_63_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_63_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_63_1.fswtw_:SetDirty()

				arg_63_1.typewritterCharCountI18N = 0

				SetActive(arg_63_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_63_1:ShowNextGo(false)
			end

			local var_66_12 = 2.53333333333333

			if 2.53333333333333 < arg_63_1.time_ and arg_63_1.time_ <= var_66_12 + arg_66_0 then
				arg_63_1.var_.oldValueTypewriter = arg_63_1.fswtw_.percent

				SetActive(arg_63_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_63_1:ShowNextGo(false)
			end

			local var_66_13 = 10
			local var_66_14 = 0.666666666666667
			local var_66_15, var_66_16 = arg_63_1:GetPercentByPara(arg_63_1:FormatText(arg_63_1:GetWordFromCfg(411331015).content), 1)

			if var_66_12 < arg_63_1.time_ and arg_63_1.time_ <= var_66_12 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				local var_66_17 = var_66_13 <= 0 and var_66_14 or var_66_14 * ((var_66_16 - arg_63_1.typewritterCharCountI18N) / var_66_13)

				if (var_66_13 <= 0 and var_66_14 or var_66_14 * ((var_66_16 - arg_63_1.typewritterCharCountI18N) / var_66_13)) > 0 and var_66_14 < var_66_17 then
					arg_63_1.talkMaxDuration = var_66_17

					if var_66_17 + var_66_12 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_17 + var_66_12
					end
				end
			end

			local var_66_18 = math.max(0.666666666666667, arg_63_1.talkMaxDuration)

			if var_66_12 <= arg_63_1.time_ and arg_63_1.time_ < var_66_12 + var_66_18 then
				arg_63_1.fswtw_.percent = Mathf.Lerp(arg_63_1.var_.oldValueTypewriter, var_66_15, (arg_63_1.time_ - var_66_12) / var_66_18)
				arg_63_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_63_1.fswtw_:SetDirty()
			end

			if arg_63_1.time_ >= var_66_12 + var_66_18 and arg_63_1.time_ < var_66_12 + var_66_18 + arg_66_0 then
				arg_63_1.fswtw_.percent = var_66_15

				arg_63_1.fswtw_:SetDirty()
				arg_63_1:ShowNextGo(true)

				arg_63_1.typewritterCharCountI18N = var_66_16
			end

			if 2 < arg_63_1.time_ and arg_63_1.time_ <= 2 + arg_66_0 then
				local var_66_19 = arg_63_1.fswbg_.transform:Find("textbox/adapt/content") or arg_63_1.fswbg_.transform:Find("textbox/content")
				local var_66_20 = arg_63_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_66_21 = var_66_19:GetComponent("RectTransform")

				var_66_19:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_66_21.offsetMin = Vector2.New(0, 0)
				var_66_21.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play411331016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 411331016
		arg_67_1.duration_ = 2.53

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play411331017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.oldValueTypewriter = arg_67_1.fswtw_.percent

				SetActive(arg_67_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_67_1:ShowNextGo(false)
			end

			local var_70_0 = 38
			local var_70_1 = 2.53333333333333
			local var_70_2, var_70_3 = arg_67_1:GetPercentByPara(arg_67_1:FormatText(arg_67_1:GetWordFromCfg(411331015).content), 2)

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0

				local var_70_4 = var_70_0 <= 0 and var_70_1 or var_70_1 * ((var_70_3 - arg_67_1.typewritterCharCountI18N) / var_70_0)

				if (var_70_0 <= 0 and var_70_1 or var_70_1 * ((var_70_3 - arg_67_1.typewritterCharCountI18N) / var_70_0)) > 0 and var_70_1 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end
			end

			local var_70_5 = math.max(2.53333333333333, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_5 then
				arg_67_1.fswtw_.percent = Mathf.Lerp(arg_67_1.var_.oldValueTypewriter, var_70_2, (arg_67_1.time_ - 0) / var_70_5)
				arg_67_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_67_1.fswtw_:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_5 and arg_67_1.time_ < 0 + var_70_5 + arg_70_0 then
				arg_67_1.fswtw_.percent = var_70_2

				arg_67_1.fswtw_:SetDirty()
				arg_67_1:ShowNextGo(true)

				arg_67_1.typewritterCharCountI18N = var_70_3
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play411331017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 411331017
		arg_71_1.duration_ = 1.67

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play411331018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.oldValueTypewriter = arg_71_1.fswtw_.percent

				SetActive(arg_71_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_71_1:ShowNextGo(false)
			end

			local var_74_0 = 25
			local var_74_1 = 1.66666666666667
			local var_74_2, var_74_3 = arg_71_1:GetPercentByPara(arg_71_1:FormatText(arg_71_1:GetWordFromCfg(411331015).content), 3)

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				local var_74_4 = var_74_0 <= 0 and var_74_1 or var_74_1 * ((var_74_3 - arg_71_1.typewritterCharCountI18N) / var_74_0)

				if (var_74_0 <= 0 and var_74_1 or var_74_1 * ((var_74_3 - arg_71_1.typewritterCharCountI18N) / var_74_0)) > 0 and var_74_1 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end
			end

			local var_74_5 = math.max(1.66666666666667, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_5 then
				arg_71_1.fswtw_.percent = Mathf.Lerp(arg_71_1.var_.oldValueTypewriter, var_74_2, (arg_71_1.time_ - 0) / var_74_5)
				arg_71_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_71_1.fswtw_:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_5 and arg_71_1.time_ < 0 + var_74_5 + arg_74_0 then
				arg_71_1.fswtw_.percent = var_74_2

				arg_71_1.fswtw_:SetDirty()
				arg_71_1:ShowNextGo(true)

				arg_71_1.typewritterCharCountI18N = var_74_3
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play411331018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 411331018
		arg_75_1.duration_ = 1

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play411331019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.oldValueTypewriter = arg_75_1.fswtw_.percent

				SetActive(arg_75_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_75_1:ShowNextGo(false)
			end

			local var_78_0 = 4
			local var_78_1 = 0.266666666666667
			local var_78_2, var_78_3 = arg_75_1:GetPercentByPara(arg_75_1:FormatText(arg_75_1:GetWordFromCfg(411331015).content), 4)

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				local var_78_4 = var_78_0 <= 0 and var_78_1 or var_78_1 * ((var_78_3 - arg_75_1.typewritterCharCountI18N) / var_78_0)

				if (var_78_0 <= 0 and var_78_1 or var_78_1 * ((var_78_3 - arg_75_1.typewritterCharCountI18N) / var_78_0)) > 0 and var_78_1 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end
			end

			local var_78_5 = math.max(0.266666666666667, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_5 then
				arg_75_1.fswtw_.percent = Mathf.Lerp(arg_75_1.var_.oldValueTypewriter, var_78_2, (arg_75_1.time_ - 0) / var_78_5)
				arg_75_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_75_1.fswtw_:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_5 and arg_75_1.time_ < 0 + var_78_5 + arg_78_0 then
				arg_75_1.fswtw_.percent = var_78_2

				arg_75_1.fswtw_:SetDirty()
				arg_75_1:ShowNextGo(true)

				arg_75_1.typewritterCharCountI18N = var_78_3
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play411331019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 411331019
		arg_79_1.duration_ = 7.9

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play411331020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if arg_79_1.bgs_.I07 == nil then
				local var_82_0 = Object.Instantiate(arg_79_1.paintGo_)

				var_82_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I07")
				var_82_0.name = "I07"
				var_82_0.transform.parent = arg_79_1.stage_.transform
				var_82_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.bgs_.I07 = var_82_0
			end

			if 1 < arg_79_1.time_ and arg_79_1.time_ <= 1 + arg_82_0 then
				local var_82_1 = arg_79_1.bgs_.I07

				arg_79_1.bgs_.I07.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_82_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_82_2 = var_82_1:GetComponent("SpriteRenderer")

				if var_82_2 and var_82_2.sprite then
					local var_82_3 = 2 * (var_82_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_82_1.transform.localScale = Vector3.New(var_82_3 / var_82_2.sprite.bounds.size.y < var_82_3 * manager.ui.mainCameraCom_.aspect / var_82_2.sprite.bounds.size.x and var_82_3 * manager.ui.mainCameraCom_.aspect / var_82_2.sprite.bounds.size.x or var_82_3 / var_82_2.sprite.bounds.size.y, var_82_3 / var_82_2.sprite.bounds.size.y < var_82_3 * manager.ui.mainCameraCom_.aspect / var_82_2.sprite.bounds.size.x and var_82_3 * manager.ui.mainCameraCom_.aspect / var_82_2.sprite.bounds.size.x or var_82_3 / var_82_2.sprite.bounds.size.y, 0)
				end

				for iter_82_0, iter_82_1 in pairs(arg_79_1.bgs_) do
					if iter_82_0 ~= "I07" then
						iter_82_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_82_4 = 0

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_5 = 1

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_5 then
				local var_82_6 = Color.New(0, 0, 0)

				var_82_6.a = Mathf.Lerp(0, 1, (arg_79_1.time_ - var_82_4) / var_82_5)
				arg_79_1.mask_.color = var_82_6
			end

			if arg_79_1.time_ >= var_82_4 + var_82_5 and arg_79_1.time_ < var_82_4 + var_82_5 + arg_82_0 then
				local var_82_7 = Color.New(0, 0, 0)

				var_82_7.a = 1
				arg_79_1.mask_.color = var_82_7
			end

			local var_82_8 = 1

			if 1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_9 = 2

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_9 then
				local var_82_10 = Color.New(0, 0, 0)

				var_82_10.a = Mathf.Lerp(1, 0, (arg_79_1.time_ - var_82_8) / var_82_9)
				arg_79_1.mask_.color = var_82_10
			end

			if arg_79_1.time_ >= var_82_8 + var_82_9 and arg_79_1.time_ < var_82_8 + var_82_9 + arg_82_0 then
				local var_82_11 = Color.New(0, 0, 0)

				arg_79_1.mask_.enabled = false
				var_82_11.a = 0
				arg_79_1.mask_.color = var_82_11
			end

			local var_82_12 = arg_79_1.actors_["4040ui_story"].transform

			if 2.7 < arg_79_1.time_ and arg_79_1.time_ <= 2.7 + arg_82_0 then
				arg_79_1.var_.moveOldPos4040ui_story = var_82_12.localPosition
			end

			local var_82_13 = 0.001

			if 2.7 <= arg_79_1.time_ and arg_79_1.time_ < 2.7 + var_82_13 then
				var_82_12.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_79_1.time_ - 2.7) / var_82_13)
				var_82_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_12.position).x, (manager.ui.mainCamera.transform.position - var_82_12.position).y, (manager.ui.mainCamera.transform.position - var_82_12.position).z)
				var_82_12.localEulerAngles.z = 0
				var_82_12.localEulerAngles.x = 0
				var_82_12.localEulerAngles = var_82_12.localEulerAngles
			end

			if arg_79_1.time_ >= 2.7 + var_82_13 and arg_79_1.time_ < 2.7 + var_82_13 + arg_82_0 then
				var_82_12.localPosition = Vector3.New(0, -1.55, -5.5)
				var_82_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_12.position).x, (manager.ui.mainCamera.transform.position - var_82_12.position).y, (manager.ui.mainCamera.transform.position - var_82_12.position).z)
				var_82_12.localEulerAngles.z = 0
				var_82_12.localEulerAngles.x = 0
				var_82_12.localEulerAngles = var_82_12.localEulerAngles
			end

			local var_82_14 = arg_79_1.actors_["4040ui_story"]

			if 2.7 < arg_79_1.time_ and arg_79_1.time_ <= 2.7 + arg_82_0 and not isNil(var_82_14) and arg_79_1.var_.characterEffect4040ui_story == nil then
				arg_79_1.var_.characterEffect4040ui_story = var_82_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_15 = 0.200000002980232

			if 2.7 <= arg_79_1.time_ and arg_79_1.time_ < 2.7 + var_82_15 and not isNil(var_82_14) then
				if arg_79_1.var_.characterEffect4040ui_story and not isNil(var_82_14) then
					arg_79_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 2.7 + var_82_15 and arg_79_1.time_ < 2.7 + var_82_15 + arg_82_0 and not isNil(var_82_14) and arg_79_1.var_.characterEffect4040ui_story then
				arg_79_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 2.7 < arg_79_1.time_ and arg_79_1.time_ <= 2.7 + arg_82_0 then
				arg_79_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 2.7 < arg_79_1.time_ and arg_79_1.time_ <= 2.7 + arg_82_0 then
				arg_79_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 1 < arg_79_1.time_ and arg_79_1.time_ <= 1 + arg_82_0 then
				arg_79_1.fswbg_:SetActive(false)
				arg_79_1.dialog_:SetActive(false)
				SetActive(arg_79_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_79_1:ShowNextGo(false)
			end

			if 1.13333333333333 < arg_79_1.time_ and arg_79_1.time_ <= 1.13333333333333 + arg_82_0 then
				arg_79_1.fswbg_:SetActive(false)
				arg_79_1.dialog_:SetActive(false)
				SetActive(arg_79_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_79_1:ShowNextGo(false)
			end

			if 1 < arg_79_1.time_ and arg_79_1.time_ <= 1 + arg_82_0 then
				local var_82_17 = arg_79_1.fswbg_.transform:Find("textbox/adapt/content") or arg_79_1.fswbg_.transform:Find("textbox/content")
				local var_82_18 = arg_79_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_82_19 = var_82_17:GetComponent("RectTransform")

				var_82_17:GetComponent("Text").alignment = UnityEngine.TextAnchor.UpperLeft
				var_82_19.offsetMin = Vector2.New(0, 0)
				var_82_19.offsetMax = Vector2.New(0, 0)
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_20 = 2.90000000298023
			local var_82_21 = 0.625

			if 2.90000000298023 < arg_79_1.time_ and arg_79_1.time_ <= var_82_20 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_22 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_22:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_23 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(411331019).content)

				arg_79_1.text_.text = var_82_23

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_25 = 25 <= 0 and var_82_21 or var_82_21 * (utf8.len(var_82_23) / 25)

				if (25 <= 0 and var_82_21 or var_82_21 * (utf8.len(var_82_23) / 25)) > 0 and var_82_21 < var_82_25 then
					arg_79_1.talkMaxDuration = var_82_25
					var_82_20 = var_82_20 + 0.3

					if var_82_25 + var_82_20 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_25 + var_82_20
					end
				end

				arg_79_1.text_.text = var_82_23
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_26 = var_82_20 + 0.3
			local var_82_27 = math.max(var_82_21, arg_79_1.talkMaxDuration)

			if var_82_20 + 0.3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_26 + var_82_27 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_26) / var_82_27

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_26 + var_82_27 and arg_79_1.time_ < var_82_26 + var_82_27 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play411331020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 411331020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play411331021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["4040ui_story"]) and arg_85_1.var_.characterEffect4040ui_story == nil then
				arg_85_1.var_.characterEffect4040ui_story = arg_85_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["4040ui_story"]) then
				if arg_85_1.var_.characterEffect4040ui_story and not isNil(arg_85_1.actors_["4040ui_story"]) then
					arg_85_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_85_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["4040ui_story"]) and arg_85_1.var_.characterEffect4040ui_story then
				arg_85_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_85_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.625

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(411331020).content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 25 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 25)

				if (25 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 25)) > 0 and var_88_2 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_6 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_6 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_6

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_6 and arg_85_1.time_ < var_88_1 + var_88_6 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play411331021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 411331021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play411331022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos4040ui_story = arg_89_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["4040ui_story"].transform.position).z)
				arg_89_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["4040ui_story"].transform.localEulerAngles = arg_89_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_89_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["4040ui_story"].transform.position).z)
				arg_89_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["4040ui_story"].transform.localEulerAngles = arg_89_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["4040ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect4040ui_story == nil then
				arg_89_1.var_.characterEffect4040ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect4040ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect4040ui_story then
				arg_89_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_92_4 = 0
			local var_92_5 = 0.2

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(411331021).content)

				arg_89_1.text_.text = var_92_6

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_8 = 8 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_6) / 8)

				if (8 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_6) / 8)) > 0 and var_92_5 < var_92_8 then
					arg_89_1.talkMaxDuration = var_92_8

					if var_92_8 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_6
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_9 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_9 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_9

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_9 and arg_89_1.time_ < var_92_4 + var_92_9 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play411331022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 411331022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play411331023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["4040ui_story"]) and arg_93_1.var_.characterEffect4040ui_story == nil then
				arg_93_1.var_.characterEffect4040ui_story = arg_93_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["4040ui_story"]) then
				if arg_93_1.var_.characterEffect4040ui_story and not isNil(arg_93_1.actors_["4040ui_story"]) then
					arg_93_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_93_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["4040ui_story"]) and arg_93_1.var_.characterEffect4040ui_story then
				arg_93_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_93_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_96_1 = 0
			local var_96_2 = 0.55

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(411331022).content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 22 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 22)

				if (22 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 22)) > 0 and var_96_2 < var_96_5 then
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
	Play411331023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 411331023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play411331024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos4040ui_story = arg_97_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["4040ui_story"].transform.position).z)
				arg_97_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["4040ui_story"].transform.localEulerAngles = arg_97_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_97_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["4040ui_story"].transform.position).z)
				arg_97_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["4040ui_story"].transform.localEulerAngles = arg_97_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["4040ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect4040ui_story == nil then
				arg_97_1.var_.characterEffect4040ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect4040ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect4040ui_story then
				arg_97_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_4 = 0
			local var_100_5 = 1.125

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(411331023).content)

				arg_97_1.text_.text = var_100_6

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_8 = 45 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_6) / 45)

				if (45 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_6) / 45)) > 0 and var_100_5 < var_100_8 then
					arg_97_1.talkMaxDuration = var_100_8

					if var_100_8 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_6
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_9 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_9 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_9

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_9 and arg_97_1.time_ < var_100_4 + var_100_9 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play411331024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 411331024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play411331025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["4040ui_story"]) and arg_101_1.var_.characterEffect4040ui_story == nil then
				arg_101_1.var_.characterEffect4040ui_story = arg_101_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["4040ui_story"]) then
				if arg_101_1.var_.characterEffect4040ui_story and not isNil(arg_101_1.actors_["4040ui_story"]) then
					arg_101_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_101_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["4040ui_story"]) and arg_101_1.var_.characterEffect4040ui_story then
				arg_101_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_101_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.725

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(411331024).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 29 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 29)

				if (29 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 29)) > 0 and var_104_2 < var_104_5 then
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
	Play411331025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 411331025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play411331026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos4040ui_story = arg_105_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["4040ui_story"].transform.position).z)
				arg_105_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["4040ui_story"].transform.localEulerAngles = arg_105_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_105_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["4040ui_story"].transform.position).z)
				arg_105_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["4040ui_story"].transform.localEulerAngles = arg_105_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["4040ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect4040ui_story == nil then
				arg_105_1.var_.characterEffect4040ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect4040ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect4040ui_story then
				arg_105_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_108_4 = 0
			local var_108_5 = 0.15

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(411331025).content)

				arg_105_1.text_.text = var_108_6

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_8 = 6 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_6) / 6)

				if (6 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_6) / 6)) > 0 and var_108_5 < var_108_8 then
					arg_105_1.talkMaxDuration = var_108_8

					if var_108_8 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_6
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_9 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_9 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_9

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_9 and arg_105_1.time_ < var_108_4 + var_108_9 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play411331026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 411331026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play411331027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos4040ui_story = arg_109_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["4040ui_story"].transform.position).z)
				arg_109_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["4040ui_story"].transform.localEulerAngles = arg_109_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["4040ui_story"].transform.position).z)
				arg_109_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["4040ui_story"].transform.localEulerAngles = arg_109_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["4040ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect4040ui_story == nil then
				arg_109_1.var_.characterEffect4040ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect4040ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_109_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_2)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect4040ui_story then
				arg_109_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_109_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_112_3 = 0
			local var_112_4 = 1.4

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_5 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(411331026).content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 56 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 56)

				if (56 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 56)) > 0 and var_112_4 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_3
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_4, arg_109_1.talkMaxDuration)

			if var_112_3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_3 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_3) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_3 + var_112_8 and arg_109_1.time_ < var_112_3 + var_112_8 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play411331027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 411331027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play411331028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.4

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(411331027).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 16 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 16)

				if (16 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 16)) > 0 and var_116_0 < var_116_3 then
					arg_113_1.talkMaxDuration = var_116_3

					if var_116_3 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_3 + 0
					end
				end

				arg_113_1.text_.text = var_116_1
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_4 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_4

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play411331028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 411331028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play411331029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 1.05

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(411331028).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 42 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 42)

				if (42 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 42)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play411331029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 411331029
		arg_121_1.duration_ = 6

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play411331030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = false

				arg_121_1:SetGaussion(false)
			end

			local var_124_0 = 0.1

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				local var_124_1 = Color.New(1, 1, 1)

				var_124_1.a = Mathf.Lerp(1, 0, (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.mask_.color = var_124_1
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				local var_124_2 = Color.New(1, 1, 1)

				arg_121_1.mask_.enabled = false
				var_124_2.a = 0
				arg_121_1.mask_.color = var_124_2
			end

			local var_124_3 = 0.233333333333333

			if 0.233333333333333 < arg_121_1.time_ and arg_121_1.time_ <= var_124_3 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = false

				arg_121_1:SetGaussion(false)
			end

			local var_124_4 = 0.133333333333333

			if var_124_3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_3 + var_124_4 then
				local var_124_5 = Color.New(1, 1, 1)

				var_124_5.a = Mathf.Lerp(1, 0, (arg_121_1.time_ - var_124_3) / var_124_4)
				arg_121_1.mask_.color = var_124_5
			end

			if arg_121_1.time_ >= var_124_3 + var_124_4 and arg_121_1.time_ < var_124_3 + var_124_4 + arg_124_0 then
				local var_124_6 = Color.New(1, 1, 1)

				arg_121_1.mask_.enabled = false
				var_124_6.a = 0
				arg_121_1.mask_.color = var_124_6
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_7 = 1
			local var_124_8 = 0.7

			if 1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_7 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_9 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_9:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_10 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(411331029).content)

				arg_121_1.text_.text = var_124_10

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_12 = 28 <= 0 and var_124_8 or var_124_8 * (utf8.len(var_124_10) / 28)

				if (28 <= 0 and var_124_8 or var_124_8 * (utf8.len(var_124_10) / 28)) > 0 and var_124_8 < var_124_12 then
					arg_121_1.talkMaxDuration = var_124_12
					var_124_7 = var_124_7 + 0.3

					if var_124_12 + var_124_7 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_12 + var_124_7
					end
				end

				arg_121_1.text_.text = var_124_10
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_13 = var_124_7 + 0.3
			local var_124_14 = math.max(var_124_8, arg_121_1.talkMaxDuration)

			if var_124_7 + 0.3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_13 + var_124_14 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_13) / var_124_14

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_13 + var_124_14 and arg_121_1.time_ < var_124_13 + var_124_14 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play411331030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 411331030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play411331031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.25

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[906].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(411331030).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 10 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 10)

				if (10 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 10)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play411331031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 411331031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play411331032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 1.225

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(411331031).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 49 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 49)

				if (49 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 49)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play411331032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 411331032
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play411331033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.65

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(411331032).content)

				arg_135_1.text_.text = var_138_1

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_3 = 26 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 26)

				if (26 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 26)) > 0 and var_138_0 < var_138_3 then
					arg_135_1.talkMaxDuration = var_138_3

					if var_138_3 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_3 + 0
					end
				end

				arg_135_1.text_.text = var_138_1
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_4 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_4

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play411331033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 411331033
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play411331034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.325

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(411331033).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 13 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 13)

				if (13 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 13)) > 0 and var_142_0 < var_142_3 then
					arg_139_1.talkMaxDuration = var_142_3

					if var_142_3 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_3 + 0
					end
				end

				arg_139_1.text_.text = var_142_1
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_4 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_4

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play411331034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 411331034
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play411331035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.825

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(411331034).content)

				arg_143_1.text_.text = var_146_1

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_3 = 33 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 33)

				if (33 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 33)) > 0 and var_146_0 < var_146_3 then
					arg_143_1.talkMaxDuration = var_146_3

					if var_146_3 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_3 + 0
					end
				end

				arg_143_1.text_.text = var_146_1
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_4 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_4

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play411331035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 411331035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play411331036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.2

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[906].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_1 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(411331035).content)

				arg_147_1.text_.text = var_150_1

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_3 = 8 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 8)

				if (8 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 8)) > 0 and var_150_0 < var_150_3 then
					arg_147_1.talkMaxDuration = var_150_3

					if var_150_3 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_3 + 0
					end
				end

				arg_147_1.text_.text = var_150_1
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_4 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_4

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play411331036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 411331036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play411331037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.35

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[906].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(411331036).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 14 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 14)

				if (14 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 14)) > 0 and var_154_0 < var_154_3 then
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
	Play411331037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 411331037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play411331038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 1.675

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(411331037).content)

				arg_155_1.text_.text = var_158_1

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_3 = 67 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 67)

				if (67 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 67)) > 0 and var_158_0 < var_158_3 then
					arg_155_1.talkMaxDuration = var_158_3

					if var_158_3 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_3 + 0
					end
				end

				arg_155_1.text_.text = var_158_1
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_4 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_4

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play411331038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 411331038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play411331039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.2

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[906].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_1 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(411331038).content)

				arg_159_1.text_.text = var_162_1

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_3 = 8 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 8)

				if (8 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 8)) > 0 and var_162_0 < var_162_3 then
					arg_159_1.talkMaxDuration = var_162_3

					if var_162_3 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_3 + 0
					end
				end

				arg_159_1.text_.text = var_162_1
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_4 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_4

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play411331039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 411331039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play411331040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos4040ui_story = arg_163_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["4040ui_story"].transform.position).z)
				arg_163_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["4040ui_story"].transform.localEulerAngles = arg_163_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_163_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["4040ui_story"].transform.position).z)
				arg_163_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["4040ui_story"].transform.localEulerAngles = arg_163_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["4040ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect4040ui_story == nil then
				arg_163_1.var_.characterEffect4040ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect4040ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect4040ui_story then
				arg_163_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_166_4 = 0
			local var_166_5 = 0.2

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_6 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(411331039).content)

				arg_163_1.text_.text = var_166_6

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_8 = 8 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_6) / 8)

				if (8 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_6) / 8)) > 0 and var_166_5 < var_166_8 then
					arg_163_1.talkMaxDuration = var_166_8

					if var_166_8 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_4
					end
				end

				arg_163_1.text_.text = var_166_6
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_9 = math.max(var_166_5, arg_163_1.talkMaxDuration)

			if var_166_4 <= arg_163_1.time_ and arg_163_1.time_ < var_166_4 + var_166_9 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_4) / var_166_9

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_4 + var_166_9 and arg_163_1.time_ < var_166_4 + var_166_9 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play411331040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 411331040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play411331041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["4040ui_story"]) and arg_167_1.var_.characterEffect4040ui_story == nil then
				arg_167_1.var_.characterEffect4040ui_story = arg_167_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["4040ui_story"]) then
				if arg_167_1.var_.characterEffect4040ui_story and not isNil(arg_167_1.actors_["4040ui_story"]) then
					arg_167_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_167_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_0)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["4040ui_story"]) and arg_167_1.var_.characterEffect4040ui_story then
				arg_167_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_167_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_170_1 = 0
			local var_170_2 = 1.175

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(411331040).content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 47 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 47)

				if (47 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 47)) > 0 and var_170_2 < var_170_5 then
					arg_167_1.talkMaxDuration = var_170_5

					if var_170_5 + var_170_1 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + var_170_1
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_6 = math.max(var_170_2, arg_167_1.talkMaxDuration)

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_6 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_1) / var_170_6

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_1 + var_170_6 and arg_167_1.time_ < var_170_1 + var_170_6 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play411331041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 411331041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play411331042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.95

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_1 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(411331041).content)

				arg_171_1.text_.text = var_174_1

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_3 = 38 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 38)

				if (38 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 38)) > 0 and var_174_0 < var_174_3 then
					arg_171_1.talkMaxDuration = var_174_3

					if var_174_3 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_3 + 0
					end
				end

				arg_171_1.text_.text = var_174_1
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_4 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_4

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play411331042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 411331042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play411331043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos4040ui_story = arg_175_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["4040ui_story"].transform.position).z)
				arg_175_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["4040ui_story"].transform.localEulerAngles = arg_175_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["4040ui_story"].transform.position).z)
				arg_175_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["4040ui_story"].transform.localEulerAngles = arg_175_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["4040ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect4040ui_story == nil then
				arg_175_1.var_.characterEffect4040ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect4040ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_175_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_2)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect4040ui_story then
				arg_175_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_175_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_178_3 = 0
			local var_178_4 = 0.9

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_3 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_5 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(411331042).content)

				arg_175_1.text_.text = var_178_5

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_7 = 36 <= 0 and var_178_4 or var_178_4 * (utf8.len(var_178_5) / 36)

				if (36 <= 0 and var_178_4 or var_178_4 * (utf8.len(var_178_5) / 36)) > 0 and var_178_4 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_3 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_3
					end
				end

				arg_175_1.text_.text = var_178_5
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_8 = math.max(var_178_4, arg_175_1.talkMaxDuration)

			if var_178_3 <= arg_175_1.time_ and arg_175_1.time_ < var_178_3 + var_178_8 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_3) / var_178_8

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_3 + var_178_8 and arg_175_1.time_ < var_178_3 + var_178_8 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play411331043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 411331043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play411331044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 1.125

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0

				arg_179_1.dialog_:SetActive(true)

				arg_179_1.dialogCg_.alpha = 0

				local var_182_2 = LeanTween.value(arg_179_1.dialog_, 0, 1, 0.3)

				var_182_2:setOnUpdate(LuaHelper.FloatAction(function(arg_183_0)
					arg_179_1.dialogCg_.alpha = arg_183_0
				end))
				var_182_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_179_1.dialog_)
					var_182_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_179_1.duration_ = arg_179_1.duration_ + 0.3

				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_3 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(411331043).content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 45 <= 0 and var_182_1 or var_182_1 * (utf8.len(var_182_3) / 45)

				if (45 <= 0 and var_182_1 or var_182_1 * (utf8.len(var_182_3) / 45)) > 0 and var_182_1 < var_182_5 then
					arg_179_1.talkMaxDuration = var_182_5
					var_182_0 = var_182_0 + 0.3

					if var_182_5 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_6 = var_182_0 + 0.3
			local var_182_7 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 + 0.3 <= arg_179_1.time_ and arg_179_1.time_ < var_182_6 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_6) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_6 + var_182_7 and arg_179_1.time_ < var_182_6 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play411331044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 411331044
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play411331045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.4

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(411331044).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 16 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 16)

				if (16 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 16)) > 0 and var_188_0 < var_188_3 then
					arg_185_1.talkMaxDuration = var_188_3

					if var_188_3 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_3 + 0
					end
				end

				arg_185_1.text_.text = var_188_1
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_4 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_4

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play411331045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 411331045
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play411331046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.875

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(411331045).content)

				arg_189_1.text_.text = var_192_1

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_3 = 35 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 35)

				if (35 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 35)) > 0 and var_192_0 < var_192_3 then
					arg_189_1.talkMaxDuration = var_192_3

					if var_192_3 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_3 + 0
					end
				end

				arg_189_1.text_.text = var_192_1
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_4 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_4

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play411331046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 411331046
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play411331047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos4040ui_story = arg_193_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["4040ui_story"].transform.position).z)
				arg_193_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["4040ui_story"].transform.localEulerAngles = arg_193_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_193_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["4040ui_story"].transform.position).z)
				arg_193_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["4040ui_story"].transform.localEulerAngles = arg_193_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["4040ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect4040ui_story == nil then
				arg_193_1.var_.characterEffect4040ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect4040ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect4040ui_story then
				arg_193_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_196_4 = 0
			local var_196_5 = 0.575

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(411331046).content)

				arg_193_1.text_.text = var_196_6

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_8 = 23 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_6) / 23)

				if (23 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_6) / 23)) > 0 and var_196_5 < var_196_8 then
					arg_193_1.talkMaxDuration = var_196_8

					if var_196_8 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_6
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_9 = math.max(var_196_5, arg_193_1.talkMaxDuration)

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_9 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_4) / var_196_9

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_4 + var_196_9 and arg_193_1.time_ < var_196_4 + var_196_9 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play411331047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 411331047
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play411331048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["4040ui_story"]) and arg_197_1.var_.characterEffect4040ui_story == nil then
				arg_197_1.var_.characterEffect4040ui_story = arg_197_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["4040ui_story"]) then
				if arg_197_1.var_.characterEffect4040ui_story and not isNil(arg_197_1.actors_["4040ui_story"]) then
					arg_197_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_197_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_0)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["4040ui_story"]) and arg_197_1.var_.characterEffect4040ui_story then
				arg_197_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_197_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_200_1 = 0
			local var_200_2 = 0.85

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(411331047).content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 34 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 34)

				if (34 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 34)) > 0 and var_200_2 < var_200_5 then
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
	Play411331048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 411331048
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play411331049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos4040ui_story = arg_201_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["4040ui_story"].transform.position).z)
				arg_201_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["4040ui_story"].transform.localEulerAngles = arg_201_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_201_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["4040ui_story"].transform.position).z)
				arg_201_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["4040ui_story"].transform.localEulerAngles = arg_201_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["4040ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect4040ui_story == nil then
				arg_201_1.var_.characterEffect4040ui_story = var_204_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 and not isNil(var_204_1) then
				if arg_201_1.var_.characterEffect4040ui_story and not isNil(var_204_1) then
					arg_201_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect4040ui_story then
				arg_201_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action6_1")
			end

			local var_204_4 = 0
			local var_204_5 = 0.225

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_6 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(411331048).content)

				arg_201_1.text_.text = var_204_6

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_8 = 9 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_6) / 9)

				if (9 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_6) / 9)) > 0 and var_204_5 < var_204_8 then
					arg_201_1.talkMaxDuration = var_204_8

					if var_204_8 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_4
					end
				end

				arg_201_1.text_.text = var_204_6
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_9 = math.max(var_204_5, arg_201_1.talkMaxDuration)

			if var_204_4 <= arg_201_1.time_ and arg_201_1.time_ < var_204_4 + var_204_9 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_4) / var_204_9

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_4 + var_204_9 and arg_201_1.time_ < var_204_4 + var_204_9 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play411331049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 411331049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play411331050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.825

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(411331049).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 33 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 33)

				if (33 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 33)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play411331050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 411331050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play411331051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos4040ui_story = arg_209_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["4040ui_story"].transform.position).z)
				arg_209_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["4040ui_story"].transform.localEulerAngles = arg_209_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_209_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["4040ui_story"].transform.position).z)
				arg_209_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["4040ui_story"].transform.localEulerAngles = arg_209_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["4040ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect4040ui_story == nil then
				arg_209_1.var_.characterEffect4040ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect4040ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect4040ui_story then
				arg_209_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action6_2")
			end

			local var_212_4 = 0
			local var_212_5 = 0.825

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_6 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(411331050).content)

				arg_209_1.text_.text = var_212_6

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_8 = 33 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_6) / 33)

				if (33 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_6) / 33)) > 0 and var_212_5 < var_212_8 then
					arg_209_1.talkMaxDuration = var_212_8

					if var_212_8 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_6
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_9 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_9 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_9

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_9 and arg_209_1.time_ < var_212_4 + var_212_9 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play411331051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 411331051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play411331052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos4040ui_story = arg_213_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["4040ui_story"].transform.position).z)
				arg_213_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["4040ui_story"].transform.localEulerAngles = arg_213_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["4040ui_story"].transform.position).z)
				arg_213_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["4040ui_story"].transform.localEulerAngles = arg_213_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["4040ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect4040ui_story == nil then
				arg_213_1.var_.characterEffect4040ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect4040ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_213_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_2)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect4040ui_story then
				arg_213_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_213_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_216_3 = 0
			local var_216_4 = 1.175

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_3 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_5 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(411331051).content)

				arg_213_1.text_.text = var_216_5

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_7 = 47 <= 0 and var_216_4 or var_216_4 * (utf8.len(var_216_5) / 47)

				if (47 <= 0 and var_216_4 or var_216_4 * (utf8.len(var_216_5) / 47)) > 0 and var_216_4 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_3 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_3
					end
				end

				arg_213_1.text_.text = var_216_5
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_8 = math.max(var_216_4, arg_213_1.talkMaxDuration)

			if var_216_3 <= arg_213_1.time_ and arg_213_1.time_ < var_216_3 + var_216_8 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_3) / var_216_8

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_3 + var_216_8 and arg_213_1.time_ < var_216_3 + var_216_8 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play411331052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 411331052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play411331053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.525

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_1 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(411331052).content)

				arg_217_1.text_.text = var_220_1

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_3 = 21 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 21)

				if (21 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 21)) > 0 and var_220_0 < var_220_3 then
					arg_217_1.talkMaxDuration = var_220_3

					if var_220_3 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_3 + 0
					end
				end

				arg_217_1.text_.text = var_220_1
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_4 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_4

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play411331053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 411331053
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play411331054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.1

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_1 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(411331053).content)

				arg_221_1.text_.text = var_224_1

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_3 = 4 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 4)

				if (4 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 4)) > 0 and var_224_0 < var_224_3 then
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
	Play411331054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 411331054
		arg_225_1.duration_ = 3.33

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play411331055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 2 < arg_225_1.time_ and arg_225_1.time_ <= 2 + arg_228_0 then
				local var_228_0 = arg_225_1.bgs_.STblack

				arg_225_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_228_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_228_1 = var_228_0:GetComponent("SpriteRenderer")

				if var_228_1 and var_228_1.sprite then
					local var_228_2 = 2 * (var_228_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_228_0.transform.localScale = Vector3.New(var_228_2 / var_228_1.sprite.bounds.size.y < var_228_2 * manager.ui.mainCameraCom_.aspect / var_228_1.sprite.bounds.size.x and var_228_2 * manager.ui.mainCameraCom_.aspect / var_228_1.sprite.bounds.size.x or var_228_2 / var_228_1.sprite.bounds.size.y, var_228_2 / var_228_1.sprite.bounds.size.y < var_228_2 * manager.ui.mainCameraCom_.aspect / var_228_1.sprite.bounds.size.x and var_228_2 * manager.ui.mainCameraCom_.aspect / var_228_1.sprite.bounds.size.x or var_228_2 / var_228_1.sprite.bounds.size.y, 0)
				end

				for iter_228_0, iter_228_1 in pairs(arg_225_1.bgs_) do
					if iter_228_0 ~= "STblack" then
						iter_228_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_228_3 = 0

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_3 + arg_228_0 then
				arg_225_1.mask_.enabled = true
				arg_225_1.mask_.raycastTarget = true

				arg_225_1:SetGaussion(false)
			end

			local var_228_4 = 2

			if var_228_3 <= arg_225_1.time_ and arg_225_1.time_ < var_228_3 + var_228_4 then
				local var_228_5 = Color.New(0, 0, 0)

				var_228_5.a = Mathf.Lerp(0, 1, (arg_225_1.time_ - var_228_3) / var_228_4)
				arg_225_1.mask_.color = var_228_5
			end

			if arg_225_1.time_ >= var_228_3 + var_228_4 and arg_225_1.time_ < var_228_3 + var_228_4 + arg_228_0 then
				local var_228_6 = Color.New(0, 0, 0)

				var_228_6.a = 1
				arg_225_1.mask_.color = var_228_6
			end

			local var_228_7 = 2

			if 2 < arg_225_1.time_ and arg_225_1.time_ <= var_228_7 + arg_228_0 then
				arg_225_1.mask_.enabled = true
				arg_225_1.mask_.raycastTarget = true

				arg_225_1:SetGaussion(false)
			end

			local var_228_8 = 1.03333333333333

			if var_228_7 <= arg_225_1.time_ and arg_225_1.time_ < var_228_7 + var_228_8 then
				local var_228_9 = Color.New(0, 0, 0)

				var_228_9.a = Mathf.Lerp(1, 0, (arg_225_1.time_ - var_228_7) / var_228_8)
				arg_225_1.mask_.color = var_228_9
			end

			if arg_225_1.time_ >= var_228_7 + var_228_8 and arg_225_1.time_ < var_228_7 + var_228_8 + arg_228_0 then
				local var_228_10 = Color.New(0, 0, 0)

				arg_225_1.mask_.enabled = false
				var_228_10.a = 0
				arg_225_1.mask_.color = var_228_10
			end

			if 2 < arg_225_1.time_ and arg_225_1.time_ <= 2 + arg_228_0 then
				arg_225_1.fswbg_:SetActive(true)
				arg_225_1.dialog_:SetActive(false)

				arg_225_1.fswtw_.percent = 0
				arg_225_1.fswt_.text = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(411331054).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.fswt_)

				arg_225_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_225_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_225_1.fswtw_:SetDirty()

				arg_225_1.typewritterCharCountI18N = 0

				SetActive(arg_225_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_225_1:ShowNextGo(false)
			end

			local var_228_11 = 2.53333333333333

			if 2.53333333333333 < arg_225_1.time_ and arg_225_1.time_ <= var_228_11 + arg_228_0 then
				arg_225_1.var_.oldValueTypewriter = arg_225_1.fswtw_.percent

				SetActive(arg_225_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_225_1:ShowNextGo(false)
			end

			local var_228_12 = 12
			local var_228_13 = 0.8
			local var_228_14, var_228_15 = arg_225_1:GetPercentByPara(arg_225_1:FormatText(arg_225_1:GetWordFromCfg(411331054).content), 1)

			if var_228_11 < arg_225_1.time_ and arg_225_1.time_ <= var_228_11 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0

				local var_228_16 = var_228_12 <= 0 and var_228_13 or var_228_13 * ((var_228_15 - arg_225_1.typewritterCharCountI18N) / var_228_12)

				if (var_228_12 <= 0 and var_228_13 or var_228_13 * ((var_228_15 - arg_225_1.typewritterCharCountI18N) / var_228_12)) > 0 and var_228_13 < var_228_16 then
					arg_225_1.talkMaxDuration = var_228_16

					if var_228_16 + var_228_11 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_16 + var_228_11
					end
				end
			end

			local var_228_17 = math.max(0.8, arg_225_1.talkMaxDuration)

			if var_228_11 <= arg_225_1.time_ and arg_225_1.time_ < var_228_11 + var_228_17 then
				arg_225_1.fswtw_.percent = Mathf.Lerp(arg_225_1.var_.oldValueTypewriter, var_228_14, (arg_225_1.time_ - var_228_11) / var_228_17)
				arg_225_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_225_1.fswtw_:SetDirty()
			end

			if arg_225_1.time_ >= var_228_11 + var_228_17 and arg_225_1.time_ < var_228_11 + var_228_17 + arg_228_0 then
				arg_225_1.fswtw_.percent = var_228_14

				arg_225_1.fswtw_:SetDirty()
				arg_225_1:ShowNextGo(true)

				arg_225_1.typewritterCharCountI18N = var_228_15
			end

			if 2 < arg_225_1.time_ and arg_225_1.time_ <= 2 + arg_228_0 then
				local var_228_18 = arg_225_1.fswbg_.transform:Find("textbox/adapt/content") or arg_225_1.fswbg_.transform:Find("textbox/content")
				local var_228_19 = arg_225_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_228_20 = var_228_18:GetComponent("RectTransform")

				var_228_18:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_228_20.offsetMin = Vector2.New(0, 0)
				var_228_20.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play411331055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 411331055
		arg_229_1.duration_ = 2.53

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play411331056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.oldValueTypewriter = arg_229_1.fswtw_.percent

				SetActive(arg_229_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_229_1:ShowNextGo(false)
			end

			local var_232_0 = 38
			local var_232_1 = 2.53333333333333
			local var_232_2, var_232_3 = arg_229_1:GetPercentByPara(arg_229_1:FormatText(arg_229_1:GetWordFromCfg(411331054).content), 2)

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				local var_232_4 = var_232_0 <= 0 and var_232_1 or var_232_1 * ((var_232_3 - arg_229_1.typewritterCharCountI18N) / var_232_0)

				if (var_232_0 <= 0 and var_232_1 or var_232_1 * ((var_232_3 - arg_229_1.typewritterCharCountI18N) / var_232_0)) > 0 and var_232_1 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end
			end

			local var_232_5 = math.max(2.53333333333333, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_5 then
				arg_229_1.fswtw_.percent = Mathf.Lerp(arg_229_1.var_.oldValueTypewriter, var_232_2, (arg_229_1.time_ - 0) / var_232_5)
				arg_229_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_229_1.fswtw_:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_5 and arg_229_1.time_ < 0 + var_232_5 + arg_232_0 then
				arg_229_1.fswtw_.percent = var_232_2

				arg_229_1.fswtw_:SetDirty()
				arg_229_1:ShowNextGo(true)

				arg_229_1.typewritterCharCountI18N = var_232_3
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play411331056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 411331056
		arg_233_1.duration_ = 7.43

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play411331057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 1 < arg_233_1.time_ and arg_233_1.time_ <= 1 + arg_236_0 then
				local var_236_0 = arg_233_1.bgs_.STblack

				arg_233_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_236_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_236_1 = var_236_0:GetComponent("SpriteRenderer")

				if var_236_1 and var_236_1.sprite then
					local var_236_2 = 2 * (var_236_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_236_0.transform.localScale = Vector3.New(var_236_2 / var_236_1.sprite.bounds.size.y < var_236_2 * manager.ui.mainCameraCom_.aspect / var_236_1.sprite.bounds.size.x and var_236_2 * manager.ui.mainCameraCom_.aspect / var_236_1.sprite.bounds.size.x or var_236_2 / var_236_1.sprite.bounds.size.y, var_236_2 / var_236_1.sprite.bounds.size.y < var_236_2 * manager.ui.mainCameraCom_.aspect / var_236_1.sprite.bounds.size.x and var_236_2 * manager.ui.mainCameraCom_.aspect / var_236_1.sprite.bounds.size.x or var_236_2 / var_236_1.sprite.bounds.size.y, 0)
				end

				for iter_236_0, iter_236_1 in pairs(arg_233_1.bgs_) do
					if iter_236_0 ~= "STblack" then
						iter_236_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_236_3 = 0

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_3 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_4 = 1

			if var_236_3 <= arg_233_1.time_ and arg_233_1.time_ < var_236_3 + var_236_4 then
				local var_236_5 = Color.New(0, 0, 0)

				var_236_5.a = Mathf.Lerp(0, 1, (arg_233_1.time_ - var_236_3) / var_236_4)
				arg_233_1.mask_.color = var_236_5
			end

			if arg_233_1.time_ >= var_236_3 + var_236_4 and arg_233_1.time_ < var_236_3 + var_236_4 + arg_236_0 then
				local var_236_6 = Color.New(0, 0, 0)

				var_236_6.a = 1
				arg_233_1.mask_.color = var_236_6
			end

			local var_236_7 = 1

			if 1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_7 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_8 = 2

			if var_236_7 <= arg_233_1.time_ and arg_233_1.time_ < var_236_7 + var_236_8 then
				local var_236_9 = Color.New(0, 0, 0)

				var_236_9.a = Mathf.Lerp(1, 0, (arg_233_1.time_ - var_236_7) / var_236_8)
				arg_233_1.mask_.color = var_236_9
			end

			if arg_233_1.time_ >= var_236_7 + var_236_8 and arg_233_1.time_ < var_236_7 + var_236_8 + arg_236_0 then
				local var_236_10 = Color.New(0, 0, 0)

				arg_233_1.mask_.enabled = false
				var_236_10.a = 0
				arg_233_1.mask_.color = var_236_10
			end

			if 1 < arg_233_1.time_ and arg_233_1.time_ <= 1 + arg_236_0 then
				arg_233_1.fswbg_:SetActive(false)
				arg_233_1.dialog_:SetActive(false)
				SetActive(arg_233_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_233_1:ShowNextGo(false)
			end

			if 1.1 < arg_233_1.time_ and arg_233_1.time_ <= 1.1 + arg_236_0 then
				arg_233_1.fswbg_:SetActive(false)
				arg_233_1.dialog_:SetActive(false)
				SetActive(arg_233_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_233_1:ShowNextGo(false)
			end

			if arg_233_1.frameCnt_ <= 1 then
				arg_233_1.dialog_:SetActive(false)
			end

			local var_236_11 = 2.43333333333333
			local var_236_12 = 0.475

			if 2.43333333333333 < arg_233_1.time_ and arg_233_1.time_ <= var_236_11 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_13 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_13:setOnUpdate(LuaHelper.FloatAction(function(arg_237_0)
					arg_233_1.dialogCg_.alpha = arg_237_0
				end))
				var_236_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_14 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(411331056).content)

				arg_233_1.text_.text = var_236_14

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_16 = 19 <= 0 and var_236_12 or var_236_12 * (utf8.len(var_236_14) / 19)

				if (19 <= 0 and var_236_12 or var_236_12 * (utf8.len(var_236_14) / 19)) > 0 and var_236_12 < var_236_16 then
					arg_233_1.talkMaxDuration = var_236_16
					var_236_11 = var_236_11 + 0.3

					if var_236_16 + var_236_11 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_16 + var_236_11
					end
				end

				arg_233_1.text_.text = var_236_14
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_17 = var_236_11 + 0.3
			local var_236_18 = math.max(var_236_12, arg_233_1.talkMaxDuration)

			if var_236_11 + 0.3 <= arg_233_1.time_ and arg_233_1.time_ < var_236_17 + var_236_18 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_17) / var_236_18

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_17 + var_236_18 and arg_233_1.time_ < var_236_17 + var_236_18 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play411331057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 411331057
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play411331058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 1.025

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(411331057).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 41 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 41)

				if (41 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 41)) > 0 and var_242_0 < var_242_3 then
					arg_239_1.talkMaxDuration = var_242_3

					if var_242_3 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_3 + 0
					end
				end

				arg_239_1.text_.text = var_242_1
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_4 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_4

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play411331058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 411331058
		arg_243_1.duration_ = 6.83

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play411331059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				local var_246_0 = arg_243_1.bgs_.I07a

				arg_243_1.bgs_.I07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_246_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_246_1 = var_246_0:GetComponent("SpriteRenderer")

				if var_246_1 and var_246_1.sprite then
					local var_246_2 = 2 * (var_246_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_246_0.transform.localScale = Vector3.New(var_246_2 / var_246_1.sprite.bounds.size.y < var_246_2 * manager.ui.mainCameraCom_.aspect / var_246_1.sprite.bounds.size.x and var_246_2 * manager.ui.mainCameraCom_.aspect / var_246_1.sprite.bounds.size.x or var_246_2 / var_246_1.sprite.bounds.size.y, var_246_2 / var_246_1.sprite.bounds.size.y < var_246_2 * manager.ui.mainCameraCom_.aspect / var_246_1.sprite.bounds.size.x and var_246_2 * manager.ui.mainCameraCom_.aspect / var_246_1.sprite.bounds.size.x or var_246_2 / var_246_1.sprite.bounds.size.y, 0)
				end

				for iter_246_0, iter_246_1 in pairs(arg_243_1.bgs_) do
					if iter_246_0 ~= "I07a" then
						iter_246_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_246_3 = 0

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_3 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_4 = 2

			if var_246_3 <= arg_243_1.time_ and arg_243_1.time_ < var_246_3 + var_246_4 then
				local var_246_5 = Color.New(0, 0, 0)

				var_246_5.a = Mathf.Lerp(1, 0, (arg_243_1.time_ - var_246_3) / var_246_4)
				arg_243_1.mask_.color = var_246_5
			end

			if arg_243_1.time_ >= var_246_3 + var_246_4 and arg_243_1.time_ < var_246_3 + var_246_4 + arg_246_0 then
				local var_246_6 = Color.New(0, 0, 0)

				arg_243_1.mask_.enabled = false
				var_246_6.a = 0
				arg_243_1.mask_.color = var_246_6
			end

			if arg_243_1.frameCnt_ <= 1 then
				arg_243_1.dialog_:SetActive(false)
			end

			local var_246_7 = 1.83333333333333
			local var_246_8 = 0.675

			if 1.83333333333333 < arg_243_1.time_ and arg_243_1.time_ <= var_246_7 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0

				arg_243_1.dialog_:SetActive(true)

				arg_243_1.dialogCg_.alpha = 0

				local var_246_9 = LeanTween.value(arg_243_1.dialog_, 0, 1, 0.3)

				var_246_9:setOnUpdate(LuaHelper.FloatAction(function(arg_247_0)
					arg_243_1.dialogCg_.alpha = arg_247_0
				end))
				var_246_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_243_1.dialog_)
					var_246_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_243_1.duration_ = arg_243_1.duration_ + 0.3

				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_10 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(411331058).content)

				arg_243_1.text_.text = var_246_10

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_12 = 27 <= 0 and var_246_8 or var_246_8 * (utf8.len(var_246_10) / 27)

				if (27 <= 0 and var_246_8 or var_246_8 * (utf8.len(var_246_10) / 27)) > 0 and var_246_8 < var_246_12 then
					arg_243_1.talkMaxDuration = var_246_12
					var_246_7 = var_246_7 + 0.3

					if var_246_12 + var_246_7 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_12 + var_246_7
					end
				end

				arg_243_1.text_.text = var_246_10
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_13 = var_246_7 + 0.3
			local var_246_14 = math.max(var_246_8, arg_243_1.talkMaxDuration)

			if var_246_7 + 0.3 <= arg_243_1.time_ and arg_243_1.time_ < var_246_13 + var_246_14 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_13) / var_246_14

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_13 + var_246_14 and arg_243_1.time_ < var_246_13 + var_246_14 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play411331059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 411331059
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play411331060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos4040ui_story = arg_249_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["4040ui_story"].transform.position).z)
				arg_249_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["4040ui_story"].transform.localEulerAngles = arg_249_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_249_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["4040ui_story"].transform.position).z)
				arg_249_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["4040ui_story"].transform.localEulerAngles = arg_249_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["4040ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect4040ui_story == nil then
				arg_249_1.var_.characterEffect4040ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect4040ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect4040ui_story then
				arg_249_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_252_4 = 0
			local var_252_5 = 0.525

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(411331059).content)

				arg_249_1.text_.text = var_252_6

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_8 = 21 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_6) / 21)

				if (21 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_6) / 21)) > 0 and var_252_5 < var_252_8 then
					arg_249_1.talkMaxDuration = var_252_8

					if var_252_8 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_6
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_9 = math.max(var_252_5, arg_249_1.talkMaxDuration)

			if var_252_4 <= arg_249_1.time_ and arg_249_1.time_ < var_252_4 + var_252_9 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_4) / var_252_9

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_4 + var_252_9 and arg_249_1.time_ < var_252_4 + var_252_9 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play411331060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 411331060
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play411331061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["4040ui_story"]) and arg_253_1.var_.characterEffect4040ui_story == nil then
				arg_253_1.var_.characterEffect4040ui_story = arg_253_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["4040ui_story"]) then
				if arg_253_1.var_.characterEffect4040ui_story and not isNil(arg_253_1.actors_["4040ui_story"]) then
					arg_253_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_253_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["4040ui_story"]) and arg_253_1.var_.characterEffect4040ui_story then
				arg_253_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_253_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_256_1 = 0
			local var_256_2 = 0.225

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[907].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(411331060).content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 9 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 9)

				if (9 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 9)) > 0 and var_256_2 < var_256_5 then
					arg_253_1.talkMaxDuration = var_256_5

					if var_256_5 + var_256_1 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + var_256_1
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_6 = math.max(var_256_2, arg_253_1.talkMaxDuration)

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_6 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_1) / var_256_6

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_1 + var_256_6 and arg_253_1.time_ < var_256_1 + var_256_6 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play411331061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 411331061
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play411331062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos4040ui_story = arg_257_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["4040ui_story"].transform.position).z)
				arg_257_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["4040ui_story"].transform.localEulerAngles = arg_257_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_257_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["4040ui_story"].transform.position).z)
				arg_257_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["4040ui_story"].transform.localEulerAngles = arg_257_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_260_1 = arg_257_1.actors_["4040ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect4040ui_story == nil then
				arg_257_1.var_.characterEffect4040ui_story = var_260_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 and not isNil(var_260_1) then
				if arg_257_1.var_.characterEffect4040ui_story and not isNil(var_260_1) then
					arg_257_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_257_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_2)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect4040ui_story then
				arg_257_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_257_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_260_3 = 0
			local var_260_4 = 1.175

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_3 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_5 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(411331061).content)

				arg_257_1.text_.text = var_260_5

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_7 = 35 <= 0 and var_260_4 or var_260_4 * (utf8.len(var_260_5) / 35)

				if (35 <= 0 and var_260_4 or var_260_4 * (utf8.len(var_260_5) / 35)) > 0 and var_260_4 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_3 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_3
					end
				end

				arg_257_1.text_.text = var_260_5
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_8 = math.max(var_260_4, arg_257_1.talkMaxDuration)

			if var_260_3 <= arg_257_1.time_ and arg_257_1.time_ < var_260_3 + var_260_8 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_3) / var_260_8

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_3 + var_260_8 and arg_257_1.time_ < var_260_3 + var_260_8 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play411331062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 411331062
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play411331063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.325

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_1 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(411331062).content)

				arg_261_1.text_.text = var_264_1

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_3 = 25 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 25)

				if (25 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 25)) > 0 and var_264_0 < var_264_3 then
					arg_261_1.talkMaxDuration = var_264_3

					if var_264_3 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_3 + 0
					end
				end

				arg_261_1.text_.text = var_264_1
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_4 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_4

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play411331063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 411331063
		arg_265_1.duration_ = 9

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play411331064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 2 < arg_265_1.time_ and arg_265_1.time_ <= 2 + arg_268_0 then
				local var_268_0 = arg_265_1.bgs_.I07

				arg_265_1.bgs_.I07.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_268_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_268_1 = var_268_0:GetComponent("SpriteRenderer")

				if var_268_1 and var_268_1.sprite then
					local var_268_2 = 2 * (var_268_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_268_0.transform.localScale = Vector3.New(var_268_2 / var_268_1.sprite.bounds.size.y < var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x and var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x or var_268_2 / var_268_1.sprite.bounds.size.y, var_268_2 / var_268_1.sprite.bounds.size.y < var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x and var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x or var_268_2 / var_268_1.sprite.bounds.size.y, 0)
				end

				for iter_268_0, iter_268_1 in pairs(arg_265_1.bgs_) do
					if iter_268_0 ~= "I07" then
						iter_268_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_268_3 = 0

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_3 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_4 = 2

			if var_268_3 <= arg_265_1.time_ and arg_265_1.time_ < var_268_3 + var_268_4 then
				local var_268_5 = Color.New(0, 0, 0)

				var_268_5.a = Mathf.Lerp(0, 1, (arg_265_1.time_ - var_268_3) / var_268_4)
				arg_265_1.mask_.color = var_268_5
			end

			if arg_265_1.time_ >= var_268_3 + var_268_4 and arg_265_1.time_ < var_268_3 + var_268_4 + arg_268_0 then
				local var_268_6 = Color.New(0, 0, 0)

				var_268_6.a = 1
				arg_265_1.mask_.color = var_268_6
			end

			local var_268_7 = 2

			if 2 < arg_265_1.time_ and arg_265_1.time_ <= var_268_7 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_8 = 2

			if var_268_7 <= arg_265_1.time_ and arg_265_1.time_ < var_268_7 + var_268_8 then
				local var_268_9 = Color.New(0, 0, 0)

				var_268_9.a = Mathf.Lerp(1, 0, (arg_265_1.time_ - var_268_7) / var_268_8)
				arg_265_1.mask_.color = var_268_9
			end

			if arg_265_1.time_ >= var_268_7 + var_268_8 and arg_265_1.time_ < var_268_7 + var_268_8 + arg_268_0 then
				local var_268_10 = Color.New(0, 0, 0)

				arg_265_1.mask_.enabled = false
				var_268_10.a = 0
				arg_265_1.mask_.color = var_268_10
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_11 = 4
			local var_268_12 = 0.725

			if 4 < arg_265_1.time_ and arg_265_1.time_ <= var_268_11 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_13 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_13:setOnUpdate(LuaHelper.FloatAction(function(arg_269_0)
					arg_265_1.dialogCg_.alpha = arg_269_0
				end))
				var_268_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_14 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(411331063).content)

				arg_265_1.text_.text = var_268_14

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_16 = 29 <= 0 and var_268_12 or var_268_12 * (utf8.len(var_268_14) / 29)

				if (29 <= 0 and var_268_12 or var_268_12 * (utf8.len(var_268_14) / 29)) > 0 and var_268_12 < var_268_16 then
					arg_265_1.talkMaxDuration = var_268_16
					var_268_11 = var_268_11 + 0.3

					if var_268_16 + var_268_11 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_16 + var_268_11
					end
				end

				arg_265_1.text_.text = var_268_14
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_17 = var_268_11 + 0.3
			local var_268_18 = math.max(var_268_12, arg_265_1.talkMaxDuration)

			if var_268_11 + 0.3 <= arg_265_1.time_ and arg_265_1.time_ < var_268_17 + var_268_18 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_17) / var_268_18

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_17 + var_268_18 and arg_265_1.time_ < var_268_17 + var_268_18 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play411331064 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 411331064
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play411331065(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 1.375

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(411331064).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 55 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 55)

				if (55 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 55)) > 0 and var_274_0 < var_274_3 then
					arg_271_1.talkMaxDuration = var_274_3

					if var_274_3 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_3 + 0
					end
				end

				arg_271_1.text_.text = var_274_1
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_4 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_4

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play411331065 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 411331065
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play411331066(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.3

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_1 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(411331065).content)

				arg_275_1.text_.text = var_278_1

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_3 = 12 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 12)

				if (12 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 12)) > 0 and var_278_0 < var_278_3 then
					arg_275_1.talkMaxDuration = var_278_3

					if var_278_3 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_3 + 0
					end
				end

				arg_275_1.text_.text = var_278_1
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_4 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_4

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play411331066 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 411331066
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play411331067(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos4040ui_story = arg_279_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["4040ui_story"].transform.position).z)
				arg_279_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["4040ui_story"].transform.localEulerAngles = arg_279_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_279_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["4040ui_story"].transform.position).z)
				arg_279_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["4040ui_story"].transform.localEulerAngles = arg_279_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_282_1 = arg_279_1.actors_["4040ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect4040ui_story == nil then
				arg_279_1.var_.characterEffect4040ui_story = var_282_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 and not isNil(var_282_1) then
				if arg_279_1.var_.characterEffect4040ui_story and not isNil(var_282_1) then
					arg_279_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect4040ui_story then
				arg_279_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_282_4 = 0
			local var_282_5 = 0.075

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_6 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(411331066).content)

				arg_279_1.text_.text = var_282_6

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_8 = 3 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_6) / 3)

				if (3 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_6) / 3)) > 0 and var_282_5 < var_282_8 then
					arg_279_1.talkMaxDuration = var_282_8

					if var_282_8 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_8 + var_282_4
					end
				end

				arg_279_1.text_.text = var_282_6
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_9 = math.max(var_282_5, arg_279_1.talkMaxDuration)

			if var_282_4 <= arg_279_1.time_ and arg_279_1.time_ < var_282_4 + var_282_9 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_4) / var_282_9

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_4 + var_282_9 and arg_279_1.time_ < var_282_4 + var_282_9 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play411331067 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 411331067
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play411331068(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["4040ui_story"]) and arg_283_1.var_.characterEffect4040ui_story == nil then
				arg_283_1.var_.characterEffect4040ui_story = arg_283_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["4040ui_story"]) then
				if arg_283_1.var_.characterEffect4040ui_story and not isNil(arg_283_1.actors_["4040ui_story"]) then
					arg_283_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_283_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_0)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["4040ui_story"]) and arg_283_1.var_.characterEffect4040ui_story then
				arg_283_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_283_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_286_1 = 0
			local var_286_2 = 0.85

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

				local var_286_3 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(411331067).content)

				arg_283_1.text_.text = var_286_3

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 34 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 34)

				if (34 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 34)) > 0 and var_286_2 < var_286_5 then
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
	Play411331068 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 411331068
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play411331069(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos4040ui_story = arg_287_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_290_0 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 then
				arg_287_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_287_1.time_ - 0) / var_290_0)
				arg_287_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["4040ui_story"].transform.position).z)
				arg_287_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["4040ui_story"].transform.localEulerAngles = arg_287_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 then
				arg_287_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_287_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["4040ui_story"].transform.position).z)
				arg_287_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["4040ui_story"].transform.localEulerAngles = arg_287_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_290_1 = arg_287_1.actors_["4040ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect4040ui_story == nil then
				arg_287_1.var_.characterEffect4040ui_story = var_290_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_2 and not isNil(var_290_1) then
				if arg_287_1.var_.characterEffect4040ui_story and not isNil(var_290_1) then
					arg_287_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_2 and arg_287_1.time_ < 0 + var_290_2 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect4040ui_story then
				arg_287_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_290_4 = 0
			local var_290_5 = 0.375

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_4 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_6 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(411331068).content)

				arg_287_1.text_.text = var_290_6

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_8 = 15 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_6) / 15)

				if (15 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_6) / 15)) > 0 and var_290_5 < var_290_8 then
					arg_287_1.talkMaxDuration = var_290_8

					if var_290_8 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_4
					end
				end

				arg_287_1.text_.text = var_290_6
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_9 = math.max(var_290_5, arg_287_1.talkMaxDuration)

			if var_290_4 <= arg_287_1.time_ and arg_287_1.time_ < var_290_4 + var_290_9 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_4) / var_290_9

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_4 + var_290_9 and arg_287_1.time_ < var_290_4 + var_290_9 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play411331069 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 411331069
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play411331070(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["4040ui_story"]) and arg_291_1.var_.characterEffect4040ui_story == nil then
				arg_291_1.var_.characterEffect4040ui_story = arg_291_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["4040ui_story"]) then
				if arg_291_1.var_.characterEffect4040ui_story and not isNil(arg_291_1.actors_["4040ui_story"]) then
					arg_291_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_291_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_0)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["4040ui_story"]) and arg_291_1.var_.characterEffect4040ui_story then
				arg_291_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_291_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_294_1 = 0
			local var_294_2 = 0.3

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_3 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(411331069).content)

				arg_291_1.text_.text = var_294_3

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 12 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 12)

				if (12 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 12)) > 0 and var_294_2 < var_294_5 then
					arg_291_1.talkMaxDuration = var_294_5

					if var_294_5 + var_294_1 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + var_294_1
					end
				end

				arg_291_1.text_.text = var_294_3
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_6 = math.max(var_294_2, arg_291_1.talkMaxDuration)

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_6 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_1) / var_294_6

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_1 + var_294_6 and arg_291_1.time_ < var_294_1 + var_294_6 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play411331070 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 411331070
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play411331071(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 1.2

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_1 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(411331070).content)

				arg_295_1.text_.text = var_298_1

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_3 = 48 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 48)

				if (48 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 48)) > 0 and var_298_0 < var_298_3 then
					arg_295_1.talkMaxDuration = var_298_3

					if var_298_3 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_3 + 0
					end
				end

				arg_295_1.text_.text = var_298_1
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_4 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_4 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_4

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_4 and arg_295_1.time_ < 0 + var_298_4 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play411331071 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 411331071
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play411331072(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 1.275

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

				local var_302_1 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(411331071).content)

				arg_299_1.text_.text = var_302_1

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_3 = 51 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 51)

				if (51 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 51)) > 0 and var_302_0 < var_302_3 then
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
	Play411331072 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 411331072
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play411331073(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos4040ui_story = arg_303_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_306_0 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 then
				arg_303_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_303_1.time_ - 0) / var_306_0)
				arg_303_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["4040ui_story"].transform.position).z)
				arg_303_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["4040ui_story"].transform.localEulerAngles = arg_303_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 then
				arg_303_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_303_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["4040ui_story"].transform.position).z)
				arg_303_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["4040ui_story"].transform.localEulerAngles = arg_303_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_306_1 = manager.ui.mainCamera.transform

			if 0.3 < arg_303_1.time_ and arg_303_1.time_ <= 0.3 + arg_306_0 then
				arg_303_1.var_.shakeOldPos = var_306_1.localPosition
			end

			local var_306_2 = 0.466666666666667

			if 0.3 <= arg_303_1.time_ and arg_303_1.time_ < 0.3 + var_306_2 then
				local var_306_3, var_306_4 = math.modf((arg_303_1.time_ - 0.3) / 0.066)

				var_306_1.localPosition = Vector3.New(var_306_4 * 0.13, var_306_4 * 0.13, var_306_4 * 0.13) + arg_303_1.var_.shakeOldPos
			end

			if arg_303_1.time_ >= 0.3 + var_306_2 and arg_303_1.time_ < 0.3 + var_306_2 + arg_306_0 then
				var_306_1.localPosition = arg_303_1.var_.shakeOldPos
			end

			local var_306_5 = 0

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_5 + arg_306_0 then
				arg_303_1.mask_.enabled = true
				arg_303_1.mask_.raycastTarget = false

				arg_303_1:SetGaussion(false)
			end

			local var_306_6 = 0.3

			if var_306_5 <= arg_303_1.time_ and arg_303_1.time_ < var_306_5 + var_306_6 then
				local var_306_7 = Color.New(1, 1, 1)

				var_306_7.a = Mathf.Lerp(1, 0, (arg_303_1.time_ - var_306_5) / var_306_6)
				arg_303_1.mask_.color = var_306_7
			end

			if arg_303_1.time_ >= var_306_5 + var_306_6 and arg_303_1.time_ < var_306_5 + var_306_6 + arg_306_0 then
				local var_306_8 = Color.New(1, 1, 1)

				arg_303_1.mask_.enabled = false
				var_306_8.a = 0
				arg_303_1.mask_.color = var_306_8
			end

			local var_306_9 = 0

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_9 + arg_306_0 then
				arg_303_1.allBtn_.enabled = false
			end

			if arg_303_1.time_ >= var_306_9 + 0.766666666666667 and arg_303_1.time_ < var_306_9 + 0.766666666666667 + arg_306_0 then
				arg_303_1.allBtn_.enabled = true
			end

			local var_306_10 = 0
			local var_306_11 = 0.725

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_10 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_12 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(411331072).content)

				arg_303_1.text_.text = var_306_12

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_14 = 29 <= 0 and var_306_11 or var_306_11 * (utf8.len(var_306_12) / 29)

				if (29 <= 0 and var_306_11 or var_306_11 * (utf8.len(var_306_12) / 29)) > 0 and var_306_11 < var_306_14 then
					arg_303_1.talkMaxDuration = var_306_14

					if var_306_14 + var_306_10 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_14 + var_306_10
					end
				end

				arg_303_1.text_.text = var_306_12
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_15 = math.max(var_306_11, arg_303_1.talkMaxDuration)

			if var_306_10 <= arg_303_1.time_ and arg_303_1.time_ < var_306_10 + var_306_15 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_10) / var_306_15

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_10 + var_306_15 and arg_303_1.time_ < var_306_10 + var_306_15 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play411331073 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 411331073
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play411331074(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0.125

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_1 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(411331073).content)

				arg_307_1.text_.text = var_310_1

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_3 = 5 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 5)

				if (5 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 5)) > 0 and var_310_0 < var_310_3 then
					arg_307_1.talkMaxDuration = var_310_3

					if var_310_3 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_3 + 0
					end
				end

				arg_307_1.text_.text = var_310_1
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_4 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_4 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_4

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_4 and arg_307_1.time_ < 0 + var_310_4 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play411331074 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 411331074
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play411331075(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.2

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_1 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(411331074).content)

				arg_311_1.text_.text = var_314_1

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_3 = 8 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 8)

				if (8 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 8)) > 0 and var_314_0 < var_314_3 then
					arg_311_1.talkMaxDuration = var_314_3

					if var_314_3 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_3 + 0
					end
				end

				arg_311_1.text_.text = var_314_1
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_4 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_4 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_4

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_4 and arg_311_1.time_ < 0 + var_314_4 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play411331075 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 411331075
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play411331076(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos4040ui_story = arg_315_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_318_0 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 then
				arg_315_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_315_1.time_ - 0) / var_318_0)
				arg_315_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["4040ui_story"].transform.position).z)
				arg_315_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["4040ui_story"].transform.localEulerAngles = arg_315_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 then
				arg_315_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_315_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["4040ui_story"].transform.position).z)
				arg_315_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["4040ui_story"].transform.localEulerAngles = arg_315_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_318_1 = arg_315_1.actors_["4040ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect4040ui_story == nil then
				arg_315_1.var_.characterEffect4040ui_story = var_318_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_2 and not isNil(var_318_1) then
				if arg_315_1.var_.characterEffect4040ui_story and not isNil(var_318_1) then
					arg_315_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_315_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_2)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_2 and arg_315_1.time_ < 0 + var_318_2 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect4040ui_story then
				arg_315_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_315_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			if 0.175 < arg_315_1.time_ and arg_315_1.time_ <= 0.175 + arg_318_0 then
				arg_315_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_door02", "")
			end

			local var_318_4 = 0
			local var_318_5 = 0.575

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_4 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_6 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(411331075).content)

				arg_315_1.text_.text = var_318_6

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_8 = 23 <= 0 and var_318_5 or var_318_5 * (utf8.len(var_318_6) / 23)

				if (23 <= 0 and var_318_5 or var_318_5 * (utf8.len(var_318_6) / 23)) > 0 and var_318_5 < var_318_8 then
					arg_315_1.talkMaxDuration = var_318_8

					if var_318_8 + var_318_4 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_4
					end
				end

				arg_315_1.text_.text = var_318_6
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_9 = math.max(var_318_5, arg_315_1.talkMaxDuration)

			if var_318_4 <= arg_315_1.time_ and arg_315_1.time_ < var_318_4 + var_318_9 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_4) / var_318_9

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_4 + var_318_9 and arg_315_1.time_ < var_318_4 + var_318_9 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play411331076 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 411331076
		arg_319_1.duration_ = 9

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play411331077(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 2 < arg_319_1.time_ and arg_319_1.time_ <= 2 + arg_322_0 then
				local var_322_0 = arg_319_1.bgs_.STblack

				arg_319_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_322_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_322_1 = var_322_0:GetComponent("SpriteRenderer")

				if var_322_1 and var_322_1.sprite then
					local var_322_2 = 2 * (var_322_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_322_0.transform.localScale = Vector3.New(var_322_2 / var_322_1.sprite.bounds.size.y < var_322_2 * manager.ui.mainCameraCom_.aspect / var_322_1.sprite.bounds.size.x and var_322_2 * manager.ui.mainCameraCom_.aspect / var_322_1.sprite.bounds.size.x or var_322_2 / var_322_1.sprite.bounds.size.y, var_322_2 / var_322_1.sprite.bounds.size.y < var_322_2 * manager.ui.mainCameraCom_.aspect / var_322_1.sprite.bounds.size.x and var_322_2 * manager.ui.mainCameraCom_.aspect / var_322_1.sprite.bounds.size.x or var_322_2 / var_322_1.sprite.bounds.size.y, 0)
				end

				for iter_322_0, iter_322_1 in pairs(arg_319_1.bgs_) do
					if iter_322_0 ~= "STblack" then
						iter_322_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_322_3 = 0

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_3 + arg_322_0 then
				arg_319_1.mask_.enabled = true
				arg_319_1.mask_.raycastTarget = true

				arg_319_1:SetGaussion(false)
			end

			local var_322_4 = 2

			if var_322_3 <= arg_319_1.time_ and arg_319_1.time_ < var_322_3 + var_322_4 then
				local var_322_5 = Color.New(0, 0, 0)

				var_322_5.a = Mathf.Lerp(0, 1, (arg_319_1.time_ - var_322_3) / var_322_4)
				arg_319_1.mask_.color = var_322_5
			end

			if arg_319_1.time_ >= var_322_3 + var_322_4 and arg_319_1.time_ < var_322_3 + var_322_4 + arg_322_0 then
				local var_322_6 = Color.New(0, 0, 0)

				var_322_6.a = 1
				arg_319_1.mask_.color = var_322_6
			end

			local var_322_7 = 2

			if 2 < arg_319_1.time_ and arg_319_1.time_ <= var_322_7 + arg_322_0 then
				arg_319_1.mask_.enabled = true
				arg_319_1.mask_.raycastTarget = true

				arg_319_1:SetGaussion(false)
			end

			local var_322_8 = 2

			if var_322_7 <= arg_319_1.time_ and arg_319_1.time_ < var_322_7 + var_322_8 then
				local var_322_9 = Color.New(0, 0, 0)

				var_322_9.a = Mathf.Lerp(1, 0, (arg_319_1.time_ - var_322_7) / var_322_8)
				arg_319_1.mask_.color = var_322_9
			end

			if arg_319_1.time_ >= var_322_7 + var_322_8 and arg_319_1.time_ < var_322_7 + var_322_8 + arg_322_0 then
				local var_322_10 = Color.New(0, 0, 0)

				arg_319_1.mask_.enabled = false
				var_322_10.a = 0
				arg_319_1.mask_.color = var_322_10
			end

			if arg_319_1.frameCnt_ <= 1 then
				arg_319_1.dialog_:SetActive(false)
			end

			local var_322_11 = 4
			local var_322_12 = 0.475

			if 4 < arg_319_1.time_ and arg_319_1.time_ <= var_322_11 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0

				arg_319_1.dialog_:SetActive(true)

				arg_319_1.dialogCg_.alpha = 0

				local var_322_13 = LeanTween.value(arg_319_1.dialog_, 0, 1, 0.3)

				var_322_13:setOnUpdate(LuaHelper.FloatAction(function(arg_323_0)
					arg_319_1.dialogCg_.alpha = arg_323_0
				end))
				var_322_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_319_1.dialog_)
					var_322_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_319_1.duration_ = arg_319_1.duration_ + 0.3

				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_14 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(411331076).content)

				arg_319_1.text_.text = var_322_14

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_16 = 19 <= 0 and var_322_12 or var_322_12 * (utf8.len(var_322_14) / 19)

				if (19 <= 0 and var_322_12 or var_322_12 * (utf8.len(var_322_14) / 19)) > 0 and var_322_12 < var_322_16 then
					arg_319_1.talkMaxDuration = var_322_16
					var_322_11 = var_322_11 + 0.3

					if var_322_16 + var_322_11 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_16 + var_322_11
					end
				end

				arg_319_1.text_.text = var_322_14
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_17 = var_322_11 + 0.3
			local var_322_18 = math.max(var_322_12, arg_319_1.talkMaxDuration)

			if var_322_11 + 0.3 <= arg_319_1.time_ and arg_319_1.time_ < var_322_17 + var_322_18 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_17) / var_322_18

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_17 + var_322_18 and arg_319_1.time_ < var_322_17 + var_322_18 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play411331077 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 411331077
		arg_325_1.duration_ = 7

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play411331078(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				local var_328_0 = arg_325_1.bgs_.I07a

				arg_325_1.bgs_.I07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_328_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_328_1 = var_328_0:GetComponent("SpriteRenderer")

				if var_328_1 and var_328_1.sprite then
					local var_328_2 = 2 * (var_328_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_328_0.transform.localScale = Vector3.New(var_328_2 / var_328_1.sprite.bounds.size.y < var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x and var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x or var_328_2 / var_328_1.sprite.bounds.size.y, var_328_2 / var_328_1.sprite.bounds.size.y < var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x and var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x or var_328_2 / var_328_1.sprite.bounds.size.y, 0)
				end

				for iter_328_0, iter_328_1 in pairs(arg_325_1.bgs_) do
					if iter_328_0 ~= "I07a" then
						iter_328_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_328_3 = 0

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_3 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_4 = 2

			if var_328_3 <= arg_325_1.time_ and arg_325_1.time_ < var_328_3 + var_328_4 then
				local var_328_5 = Color.New(0, 0, 0)

				var_328_5.a = Mathf.Lerp(1, 0, (arg_325_1.time_ - var_328_3) / var_328_4)
				arg_325_1.mask_.color = var_328_5
			end

			if arg_325_1.time_ >= var_328_3 + var_328_4 and arg_325_1.time_ < var_328_3 + var_328_4 + arg_328_0 then
				local var_328_6 = Color.New(0, 0, 0)

				arg_325_1.mask_.enabled = false
				var_328_6.a = 0
				arg_325_1.mask_.color = var_328_6
			end

			if arg_325_1.frameCnt_ <= 1 then
				arg_325_1.dialog_:SetActive(false)
			end

			local var_328_7 = 2
			local var_328_8 = 1

			if 2 < arg_325_1.time_ and arg_325_1.time_ <= var_328_7 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				arg_325_1.dialog_:SetActive(true)

				arg_325_1.dialogCg_.alpha = 0

				local var_328_9 = LeanTween.value(arg_325_1.dialog_, 0, 1, 0.3)

				var_328_9:setOnUpdate(LuaHelper.FloatAction(function(arg_329_0)
					arg_325_1.dialogCg_.alpha = arg_329_0
				end))
				var_328_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_325_1.dialog_)
					var_328_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_325_1.duration_ = arg_325_1.duration_ + 0.3

				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_10 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(411331077).content)

				arg_325_1.text_.text = var_328_10

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_12 = 40 <= 0 and var_328_8 or var_328_8 * (utf8.len(var_328_10) / 40)

				if (40 <= 0 and var_328_8 or var_328_8 * (utf8.len(var_328_10) / 40)) > 0 and var_328_8 < var_328_12 then
					arg_325_1.talkMaxDuration = var_328_12
					var_328_7 = var_328_7 + 0.3

					if var_328_12 + var_328_7 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_12 + var_328_7
					end
				end

				arg_325_1.text_.text = var_328_10
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_13 = var_328_7 + 0.3
			local var_328_14 = math.max(var_328_8, arg_325_1.talkMaxDuration)

			if var_328_7 + 0.3 <= arg_325_1.time_ and arg_325_1.time_ < var_328_13 + var_328_14 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_13) / var_328_14

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_13 + var_328_14 and arg_325_1.time_ < var_328_13 + var_328_14 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play411331078 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 411331078
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play411331079(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0.65

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_1 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(411331078).content)

				arg_331_1.text_.text = var_334_1

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_3 = 26 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 26)

				if (26 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 26)) > 0 and var_334_0 < var_334_3 then
					arg_331_1.talkMaxDuration = var_334_3

					if var_334_3 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_3 + 0
					end
				end

				arg_331_1.text_.text = var_334_1
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_4 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_4

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play411331079 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 411331079
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play411331080(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos4040ui_story = arg_335_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_338_0 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 then
				arg_335_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_335_1.time_ - 0) / var_338_0)
				arg_335_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["4040ui_story"].transform.position).z)
				arg_335_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["4040ui_story"].transform.localEulerAngles = arg_335_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 then
				arg_335_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_335_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["4040ui_story"].transform.position).z)
				arg_335_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["4040ui_story"].transform.localEulerAngles = arg_335_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_338_1 = arg_335_1.actors_["4040ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_1) and arg_335_1.var_.characterEffect4040ui_story == nil then
				arg_335_1.var_.characterEffect4040ui_story = var_338_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_2 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_2 and not isNil(var_338_1) then
				if arg_335_1.var_.characterEffect4040ui_story and not isNil(var_338_1) then
					arg_335_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= 0 + var_338_2 and arg_335_1.time_ < 0 + var_338_2 + arg_338_0 and not isNil(var_338_1) and arg_335_1.var_.characterEffect4040ui_story then
				arg_335_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_338_4 = 0
			local var_338_5 = 0.1

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_4 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_6 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(411331079).content)

				arg_335_1.text_.text = var_338_6

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_8 = 4 <= 0 and var_338_5 or var_338_5 * (utf8.len(var_338_6) / 4)

				if (4 <= 0 and var_338_5 or var_338_5 * (utf8.len(var_338_6) / 4)) > 0 and var_338_5 < var_338_8 then
					arg_335_1.talkMaxDuration = var_338_8

					if var_338_8 + var_338_4 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_8 + var_338_4
					end
				end

				arg_335_1.text_.text = var_338_6
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_9 = math.max(var_338_5, arg_335_1.talkMaxDuration)

			if var_338_4 <= arg_335_1.time_ and arg_335_1.time_ < var_338_4 + var_338_9 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_4) / var_338_9

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_4 + var_338_9 and arg_335_1.time_ < var_338_4 + var_338_9 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play411331080 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 411331080
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play411331081(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["4040ui_story"]) and arg_339_1.var_.characterEffect4040ui_story == nil then
				arg_339_1.var_.characterEffect4040ui_story = arg_339_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_0 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["4040ui_story"]) then
				if arg_339_1.var_.characterEffect4040ui_story and not isNil(arg_339_1.actors_["4040ui_story"]) then
					arg_339_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_339_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_339_1.time_ - 0) / var_342_0)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["4040ui_story"]) and arg_339_1.var_.characterEffect4040ui_story then
				arg_339_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_339_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_342_1 = 0
			local var_342_2 = 1.425

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_3 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(411331080).content)

				arg_339_1.text_.text = var_342_3

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_5 = 57 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_3) / 57)

				if (57 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_3) / 57)) > 0 and var_342_2 < var_342_5 then
					arg_339_1.talkMaxDuration = var_342_5

					if var_342_5 + var_342_1 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_5 + var_342_1
					end
				end

				arg_339_1.text_.text = var_342_3
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_6 = math.max(var_342_2, arg_339_1.talkMaxDuration)

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_6 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_1) / var_342_6

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_1 + var_342_6 and arg_339_1.time_ < var_342_1 + var_342_6 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play411331081 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 411331081
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play411331082(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos4040ui_story = arg_343_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_346_0 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 then
				arg_343_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_343_1.time_ - 0) / var_346_0)
				arg_343_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["4040ui_story"].transform.position).z)
				arg_343_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["4040ui_story"].transform.localEulerAngles = arg_343_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 then
				arg_343_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_343_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["4040ui_story"].transform.position).z)
				arg_343_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["4040ui_story"].transform.localEulerAngles = arg_343_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_346_1 = arg_343_1.actors_["4040ui_story"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_1) and arg_343_1.var_.characterEffect4040ui_story == nil then
				arg_343_1.var_.characterEffect4040ui_story = var_346_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_2 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_2 and not isNil(var_346_1) then
				if arg_343_1.var_.characterEffect4040ui_story and not isNil(var_346_1) then
					arg_343_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= 0 + var_346_2 and arg_343_1.time_ < 0 + var_346_2 + arg_346_0 and not isNil(var_346_1) and arg_343_1.var_.characterEffect4040ui_story then
				arg_343_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_346_4 = 0
			local var_346_5 = 0.2

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_4 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_6 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(411331081).content)

				arg_343_1.text_.text = var_346_6

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_8 = 8 <= 0 and var_346_5 or var_346_5 * (utf8.len(var_346_6) / 8)

				if (8 <= 0 and var_346_5 or var_346_5 * (utf8.len(var_346_6) / 8)) > 0 and var_346_5 < var_346_8 then
					arg_343_1.talkMaxDuration = var_346_8

					if var_346_8 + var_346_4 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_8 + var_346_4
					end
				end

				arg_343_1.text_.text = var_346_6
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_9 = math.max(var_346_5, arg_343_1.talkMaxDuration)

			if var_346_4 <= arg_343_1.time_ and arg_343_1.time_ < var_346_4 + var_346_9 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_4) / var_346_9

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_4 + var_346_9 and arg_343_1.time_ < var_346_4 + var_346_9 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play411331082 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 411331082
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play411331083(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["4040ui_story"]) and arg_347_1.var_.characterEffect4040ui_story == nil then
				arg_347_1.var_.characterEffect4040ui_story = arg_347_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["4040ui_story"]) then
				if arg_347_1.var_.characterEffect4040ui_story and not isNil(arg_347_1.actors_["4040ui_story"]) then
					arg_347_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_347_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_347_1.time_ - 0) / var_350_0)
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["4040ui_story"]) and arg_347_1.var_.characterEffect4040ui_story then
				arg_347_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_347_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_350_1 = 0
			local var_350_2 = 0.275

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_3 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(411331082).content)

				arg_347_1.text_.text = var_350_3

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 11 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_3) / 11)

				if (11 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_3) / 11)) > 0 and var_350_2 < var_350_5 then
					arg_347_1.talkMaxDuration = var_350_5

					if var_350_5 + var_350_1 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + var_350_1
					end
				end

				arg_347_1.text_.text = var_350_3
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_6 = math.max(var_350_2, arg_347_1.talkMaxDuration)

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_6 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_1) / var_350_6

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_1 + var_350_6 and arg_347_1.time_ < var_350_1 + var_350_6 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play411331083 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 411331083
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play411331084(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos4040ui_story = arg_351_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_354_0 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 then
				arg_351_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_351_1.time_ - 0) / var_354_0)
				arg_351_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["4040ui_story"].transform.position).z)
				arg_351_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["4040ui_story"].transform.localEulerAngles = arg_351_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 then
				arg_351_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_351_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["4040ui_story"].transform.position).z)
				arg_351_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["4040ui_story"].transform.localEulerAngles = arg_351_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_354_1 = arg_351_1.actors_["4040ui_story"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect4040ui_story == nil then
				arg_351_1.var_.characterEffect4040ui_story = var_354_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_2 and not isNil(var_354_1) then
				if arg_351_1.var_.characterEffect4040ui_story and not isNil(var_354_1) then
					arg_351_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 0 + var_354_2 and arg_351_1.time_ < 0 + var_354_2 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect4040ui_story then
				arg_351_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_354_4 = 0
			local var_354_5 = 0.625

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_6 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(411331083).content)

				arg_351_1.text_.text = var_354_6

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_8 = 25 <= 0 and var_354_5 or var_354_5 * (utf8.len(var_354_6) / 25)

				if (25 <= 0 and var_354_5 or var_354_5 * (utf8.len(var_354_6) / 25)) > 0 and var_354_5 < var_354_8 then
					arg_351_1.talkMaxDuration = var_354_8

					if var_354_8 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_8 + var_354_4
					end
				end

				arg_351_1.text_.text = var_354_6
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_9 = math.max(var_354_5, arg_351_1.talkMaxDuration)

			if var_354_4 <= arg_351_1.time_ and arg_351_1.time_ < var_354_4 + var_354_9 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_4) / var_354_9

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_4 + var_354_9 and arg_351_1.time_ < var_354_4 + var_354_9 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play411331084 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 411331084
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play411331085(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["4040ui_story"]) and arg_355_1.var_.characterEffect4040ui_story == nil then
				arg_355_1.var_.characterEffect4040ui_story = arg_355_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_0 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["4040ui_story"]) then
				if arg_355_1.var_.characterEffect4040ui_story and not isNil(arg_355_1.actors_["4040ui_story"]) then
					arg_355_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_355_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_355_1.time_ - 0) / var_358_0)
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["4040ui_story"]) and arg_355_1.var_.characterEffect4040ui_story then
				arg_355_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_355_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_358_1 = 0
			local var_358_2 = 0.4

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_3 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(411331084).content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 16 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 16)

				if (16 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 16)) > 0 and var_358_2 < var_358_5 then
					arg_355_1.talkMaxDuration = var_358_5

					if var_358_5 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + var_358_1
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_6 = math.max(var_358_2, arg_355_1.talkMaxDuration)

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_6 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_1) / var_358_6

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_1 + var_358_6 and arg_355_1.time_ < var_358_1 + var_358_6 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play411331085 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 411331085
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play411331086(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos4040ui_story = arg_359_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_362_0 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 then
				arg_359_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_359_1.time_ - 0) / var_362_0)
				arg_359_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["4040ui_story"].transform.position).z)
				arg_359_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["4040ui_story"].transform.localEulerAngles = arg_359_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 then
				arg_359_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_359_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["4040ui_story"].transform.position).z)
				arg_359_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["4040ui_story"].transform.localEulerAngles = arg_359_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_362_1 = arg_359_1.actors_["4040ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect4040ui_story == nil then
				arg_359_1.var_.characterEffect4040ui_story = var_362_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_2 and not isNil(var_362_1) then
				if arg_359_1.var_.characterEffect4040ui_story and not isNil(var_362_1) then
					arg_359_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_2 and arg_359_1.time_ < 0 + var_362_2 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect4040ui_story then
				arg_359_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_362_4 = 0
			local var_362_5 = 0.25

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_4 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_6 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(411331085).content)

				arg_359_1.text_.text = var_362_6

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_8 = 10 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_6) / 10)

				if (10 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_6) / 10)) > 0 and var_362_5 < var_362_8 then
					arg_359_1.talkMaxDuration = var_362_8

					if var_362_8 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_8 + var_362_4
					end
				end

				arg_359_1.text_.text = var_362_6
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_9 = math.max(var_362_5, arg_359_1.talkMaxDuration)

			if var_362_4 <= arg_359_1.time_ and arg_359_1.time_ < var_362_4 + var_362_9 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_4) / var_362_9

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_4 + var_362_9 and arg_359_1.time_ < var_362_4 + var_362_9 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play411331086 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 411331086
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play411331087(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos4040ui_story = arg_363_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_366_0 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 then
				arg_363_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_363_1.time_ - 0) / var_366_0)
				arg_363_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["4040ui_story"].transform.position).z)
				arg_363_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["4040ui_story"].transform.localEulerAngles = arg_363_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 then
				arg_363_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_363_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["4040ui_story"].transform.position).z)
				arg_363_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["4040ui_story"].transform.localEulerAngles = arg_363_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_366_1 = arg_363_1.actors_["4040ui_story"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect4040ui_story == nil then
				arg_363_1.var_.characterEffect4040ui_story = var_366_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_2 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_2 and not isNil(var_366_1) then
				if arg_363_1.var_.characterEffect4040ui_story and not isNil(var_366_1) then
					arg_363_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_363_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_363_1.time_ - 0) / var_366_2)
				end
			end

			if arg_363_1.time_ >= 0 + var_366_2 and arg_363_1.time_ < 0 + var_366_2 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect4040ui_story then
				arg_363_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_363_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_366_3 = 0
			local var_366_4 = 1.3

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_3 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_5 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(411331086).content)

				arg_363_1.text_.text = var_366_5

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_7 = 52 <= 0 and var_366_4 or var_366_4 * (utf8.len(var_366_5) / 52)

				if (52 <= 0 and var_366_4 or var_366_4 * (utf8.len(var_366_5) / 52)) > 0 and var_366_4 < var_366_7 then
					arg_363_1.talkMaxDuration = var_366_7

					if var_366_7 + var_366_3 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_3
					end
				end

				arg_363_1.text_.text = var_366_5
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_8 = math.max(var_366_4, arg_363_1.talkMaxDuration)

			if var_366_3 <= arg_363_1.time_ and arg_363_1.time_ < var_366_3 + var_366_8 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_3) / var_366_8

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_3 + var_366_8 and arg_363_1.time_ < var_366_3 + var_366_8 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play411331087 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 411331087
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play411331088(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 1.225

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_1 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(411331087).content)

				arg_367_1.text_.text = var_370_1

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_3 = 49 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 49)

				if (49 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 49)) > 0 and var_370_0 < var_370_3 then
					arg_367_1.talkMaxDuration = var_370_3

					if var_370_3 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_3 + 0
					end
				end

				arg_367_1.text_.text = var_370_1
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_4 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_4 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_4

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_4 and arg_367_1.time_ < 0 + var_370_4 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play411331088 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 411331088
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play411331089(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0
			local var_374_1 = 0.35

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0

				arg_371_1.dialog_:SetActive(true)

				arg_371_1.dialogCg_.alpha = 0

				local var_374_2 = LeanTween.value(arg_371_1.dialog_, 0, 1, 0.3)

				var_374_2:setOnUpdate(LuaHelper.FloatAction(function(arg_375_0)
					arg_371_1.dialogCg_.alpha = arg_375_0
				end))
				var_374_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_371_1.dialog_)
					var_374_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_371_1.duration_ = arg_371_1.duration_ + 0.3

				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_3 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(411331088).content)

				arg_371_1.text_.text = var_374_3

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_5 = 14 <= 0 and var_374_1 or var_374_1 * (utf8.len(var_374_3) / 14)

				if (14 <= 0 and var_374_1 or var_374_1 * (utf8.len(var_374_3) / 14)) > 0 and var_374_1 < var_374_5 then
					arg_371_1.talkMaxDuration = var_374_5
					var_374_0 = var_374_0 + 0.3

					if var_374_5 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_5 + var_374_0
					end
				end

				arg_371_1.text_.text = var_374_3
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_6 = var_374_0 + 0.3
			local var_374_7 = math.max(var_374_1, arg_371_1.talkMaxDuration)

			if var_374_0 + 0.3 <= arg_371_1.time_ and arg_371_1.time_ < var_374_6 + var_374_7 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_6) / var_374_7

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_6 + var_374_7 and arg_371_1.time_ < var_374_6 + var_374_7 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play411331089 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 411331089
		arg_377_1.duration_ = 9

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play411331090(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if arg_377_1.bgs_.D10 == nil then
				local var_380_0 = Object.Instantiate(arg_377_1.paintGo_)

				var_380_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D10")
				var_380_0.name = "D10"
				var_380_0.transform.parent = arg_377_1.stage_.transform
				var_380_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_377_1.bgs_.D10 = var_380_0
			end

			if 2 < arg_377_1.time_ and arg_377_1.time_ <= 2 + arg_380_0 then
				local var_380_1 = arg_377_1.bgs_.D10

				arg_377_1.bgs_.D10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_380_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_380_2 = var_380_1:GetComponent("SpriteRenderer")

				if var_380_2 and var_380_2.sprite then
					local var_380_3 = 2 * (var_380_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_380_1.transform.localScale = Vector3.New(var_380_3 / var_380_2.sprite.bounds.size.y < var_380_3 * manager.ui.mainCameraCom_.aspect / var_380_2.sprite.bounds.size.x and var_380_3 * manager.ui.mainCameraCom_.aspect / var_380_2.sprite.bounds.size.x or var_380_3 / var_380_2.sprite.bounds.size.y, var_380_3 / var_380_2.sprite.bounds.size.y < var_380_3 * manager.ui.mainCameraCom_.aspect / var_380_2.sprite.bounds.size.x and var_380_3 * manager.ui.mainCameraCom_.aspect / var_380_2.sprite.bounds.size.x or var_380_3 / var_380_2.sprite.bounds.size.y, 0)
				end

				for iter_380_0, iter_380_1 in pairs(arg_377_1.bgs_) do
					if iter_380_0 ~= "D10" then
						iter_380_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_380_4 = 0

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_4 + arg_380_0 then
				arg_377_1.mask_.enabled = true
				arg_377_1.mask_.raycastTarget = true

				arg_377_1:SetGaussion(false)
			end

			local var_380_5 = 2

			if var_380_4 <= arg_377_1.time_ and arg_377_1.time_ < var_380_4 + var_380_5 then
				local var_380_6 = Color.New(0, 0, 0)

				var_380_6.a = Mathf.Lerp(0, 1, (arg_377_1.time_ - var_380_4) / var_380_5)
				arg_377_1.mask_.color = var_380_6
			end

			if arg_377_1.time_ >= var_380_4 + var_380_5 and arg_377_1.time_ < var_380_4 + var_380_5 + arg_380_0 then
				local var_380_7 = Color.New(0, 0, 0)

				var_380_7.a = 1
				arg_377_1.mask_.color = var_380_7
			end

			local var_380_8 = 2

			if 2 < arg_377_1.time_ and arg_377_1.time_ <= var_380_8 + arg_380_0 then
				arg_377_1.mask_.enabled = true
				arg_377_1.mask_.raycastTarget = true

				arg_377_1:SetGaussion(false)
			end

			local var_380_9 = 2

			if var_380_8 <= arg_377_1.time_ and arg_377_1.time_ < var_380_8 + var_380_9 then
				local var_380_10 = Color.New(0, 0, 0)

				var_380_10.a = Mathf.Lerp(1, 0, (arg_377_1.time_ - var_380_8) / var_380_9)
				arg_377_1.mask_.color = var_380_10
			end

			if arg_377_1.time_ >= var_380_8 + var_380_9 and arg_377_1.time_ < var_380_8 + var_380_9 + arg_380_0 then
				local var_380_11 = Color.New(0, 0, 0)

				arg_377_1.mask_.enabled = false
				var_380_11.a = 0
				arg_377_1.mask_.color = var_380_11
			end

			if arg_377_1.frameCnt_ <= 1 then
				arg_377_1.dialog_:SetActive(false)
			end

			local var_380_12 = 4
			local var_380_13 = 0.875

			if 4 < arg_377_1.time_ and arg_377_1.time_ <= var_380_12 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0

				arg_377_1.dialog_:SetActive(true)

				arg_377_1.dialogCg_.alpha = 0

				local var_380_14 = LeanTween.value(arg_377_1.dialog_, 0, 1, 0.3)

				var_380_14:setOnUpdate(LuaHelper.FloatAction(function(arg_381_0)
					arg_377_1.dialogCg_.alpha = arg_381_0
				end))
				var_380_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_377_1.dialog_)
					var_380_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_377_1.duration_ = arg_377_1.duration_ + 0.3

				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_15 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(411331089).content)

				arg_377_1.text_.text = var_380_15

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_17 = 35 <= 0 and var_380_13 or var_380_13 * (utf8.len(var_380_15) / 35)

				if (35 <= 0 and var_380_13 or var_380_13 * (utf8.len(var_380_15) / 35)) > 0 and var_380_13 < var_380_17 then
					arg_377_1.talkMaxDuration = var_380_17
					var_380_12 = var_380_12 + 0.3

					if var_380_17 + var_380_12 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_17 + var_380_12
					end
				end

				arg_377_1.text_.text = var_380_15
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_18 = var_380_12 + 0.3
			local var_380_19 = math.max(var_380_13, arg_377_1.talkMaxDuration)

			if var_380_12 + 0.3 <= arg_377_1.time_ and arg_377_1.time_ < var_380_18 + var_380_19 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_18) / var_380_19

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_18 + var_380_19 and arg_377_1.time_ < var_380_18 + var_380_19 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play411331090 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 411331090
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play411331091(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 1.075

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_1 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(411331090).content)

				arg_383_1.text_.text = var_386_1

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_3 = 43 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 43)

				if (43 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 43)) > 0 and var_386_0 < var_386_3 then
					arg_383_1.talkMaxDuration = var_386_3

					if var_386_3 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_3 + 0
					end
				end

				arg_383_1.text_.text = var_386_1
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_4 = math.max(var_386_0, arg_383_1.talkMaxDuration)

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_4 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - 0) / var_386_4

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= 0 + var_386_4 and arg_383_1.time_ < 0 + var_386_4 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play411331091 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 411331091
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play411331092(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if arg_387_1.actors_["10014ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10014ui_story"))) then
				local var_390_0 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_387_1.stage_.transform)

				var_390_0.name = "10014ui_story"
				var_390_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_387_1.actors_["10014ui_story"] = var_390_0

				local var_390_1 = var_390_0:GetComponentInChildren(typeof(CharacterEffect))

				var_390_1.enabled = true

				local var_390_2 = GameObjectTools.GetOrAddComponent(var_390_0, typeof(DynamicBoneHelper))

				if var_390_2 then
					var_390_2:EnableDynamicBone(false)
				end

				arg_387_1:ShowWeapon(var_390_1.transform, false)

				arg_387_1.var_["10014ui_story" .. "Animator"] = var_390_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_387_1.var_["10014ui_story" .. "Animator"].applyRootMotion = true
				arg_387_1.var_["10014ui_story" .. "LipSync"] = var_390_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_390_3 = arg_387_1.actors_["10014ui_story"].transform

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos10014ui_story = var_390_3.localPosition
			end

			local var_390_4 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_4 then
				var_390_3.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_387_1.time_ - 0) / var_390_4)
				var_390_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_390_3.position).x, (manager.ui.mainCamera.transform.position - var_390_3.position).y, (manager.ui.mainCamera.transform.position - var_390_3.position).z)
				var_390_3.localEulerAngles.z = 0
				var_390_3.localEulerAngles.x = 0
				var_390_3.localEulerAngles = var_390_3.localEulerAngles
			end

			if arg_387_1.time_ >= 0 + var_390_4 and arg_387_1.time_ < 0 + var_390_4 + arg_390_0 then
				var_390_3.localPosition = Vector3.New(0, -1.06, -6.2)
				var_390_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_390_3.position).x, (manager.ui.mainCamera.transform.position - var_390_3.position).y, (manager.ui.mainCamera.transform.position - var_390_3.position).z)
				var_390_3.localEulerAngles.z = 0
				var_390_3.localEulerAngles.x = 0
				var_390_3.localEulerAngles = var_390_3.localEulerAngles
			end

			local var_390_5 = arg_387_1.actors_["10014ui_story"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_5) and arg_387_1.var_.characterEffect10014ui_story == nil then
				arg_387_1.var_.characterEffect10014ui_story = var_390_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_6 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_6 and not isNil(var_390_5) then
				if arg_387_1.var_.characterEffect10014ui_story and not isNil(var_390_5) then
					arg_387_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= 0 + var_390_6 and arg_387_1.time_ < 0 + var_390_6 + arg_390_0 and not isNil(var_390_5) and arg_387_1.var_.characterEffect10014ui_story then
				arg_387_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_390_8 = 0
			local var_390_9 = 0.775

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_8 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_10 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(411331091).content)

				arg_387_1.text_.text = var_390_10

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_12 = 31 <= 0 and var_390_9 or var_390_9 * (utf8.len(var_390_10) / 31)

				if (31 <= 0 and var_390_9 or var_390_9 * (utf8.len(var_390_10) / 31)) > 0 and var_390_9 < var_390_12 then
					arg_387_1.talkMaxDuration = var_390_12

					if var_390_12 + var_390_8 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_12 + var_390_8
					end
				end

				arg_387_1.text_.text = var_390_10
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_13 = math.max(var_390_9, arg_387_1.talkMaxDuration)

			if var_390_8 <= arg_387_1.time_ and arg_387_1.time_ < var_390_8 + var_390_13 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_8) / var_390_13

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_8 + var_390_13 and arg_387_1.time_ < var_390_8 + var_390_13 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play411331092 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 411331092
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play411331093(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0.925

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_1 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(411331092).content)

				arg_391_1.text_.text = var_394_1

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_3 = 37 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_1) / 37)

				if (37 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_1) / 37)) > 0 and var_394_0 < var_394_3 then
					arg_391_1.talkMaxDuration = var_394_3

					if var_394_3 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_3 + 0
					end
				end

				arg_391_1.text_.text = var_394_1
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_4 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_4 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_4

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_4 and arg_391_1.time_ < 0 + var_394_4 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play411331093 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 411331093
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play411331094(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos10014ui_story = arg_395_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_398_0 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 then
				arg_395_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_395_1.time_ - 0) / var_398_0)
				arg_395_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["10014ui_story"].transform.position).z)
				arg_395_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["10014ui_story"].transform.localEulerAngles = arg_395_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 then
				arg_395_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_395_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["10014ui_story"].transform.position).z)
				arg_395_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["10014ui_story"].transform.localEulerAngles = arg_395_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_398_1 = arg_395_1.actors_["10014ui_story"]

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect10014ui_story == nil then
				arg_395_1.var_.characterEffect10014ui_story = var_398_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_2 and not isNil(var_398_1) then
				if arg_395_1.var_.characterEffect10014ui_story and not isNil(var_398_1) then
					arg_395_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= 0 + var_398_2 and arg_395_1.time_ < 0 + var_398_2 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect10014ui_story then
				arg_395_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action4_1")
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_398_4 = 0
			local var_398_5 = 0.9

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_4 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_6 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(411331093).content)

				arg_395_1.text_.text = var_398_6

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_8 = 36 <= 0 and var_398_5 or var_398_5 * (utf8.len(var_398_6) / 36)

				if (36 <= 0 and var_398_5 or var_398_5 * (utf8.len(var_398_6) / 36)) > 0 and var_398_5 < var_398_8 then
					arg_395_1.talkMaxDuration = var_398_8

					if var_398_8 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_8 + var_398_4
					end
				end

				arg_395_1.text_.text = var_398_6
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_9 = math.max(var_398_5, arg_395_1.talkMaxDuration)

			if var_398_4 <= arg_395_1.time_ and arg_395_1.time_ < var_398_4 + var_398_9 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_4) / var_398_9

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_4 + var_398_9 and arg_395_1.time_ < var_398_4 + var_398_9 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play411331094 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 411331094
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play411331095(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["10014ui_story"]) and arg_399_1.var_.characterEffect10014ui_story == nil then
				arg_399_1.var_.characterEffect10014ui_story = arg_399_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_0 = 0.200000002980232

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 and not isNil(arg_399_1.actors_["10014ui_story"]) then
				if arg_399_1.var_.characterEffect10014ui_story and not isNil(arg_399_1.actors_["10014ui_story"]) then
					arg_399_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_399_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_399_1.time_ - 0) / var_402_0)
				end
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 and not isNil(arg_399_1.actors_["10014ui_story"]) and arg_399_1.var_.characterEffect10014ui_story then
				arg_399_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_399_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_402_1 = 0
			local var_402_2 = 0.725

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_3 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(411331094).content)

				arg_399_1.text_.text = var_402_3

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 29 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 29)

				if (29 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 29)) > 0 and var_402_2 < var_402_5 then
					arg_399_1.talkMaxDuration = var_402_5

					if var_402_5 + var_402_1 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_5 + var_402_1
					end
				end

				arg_399_1.text_.text = var_402_3
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_6 = math.max(var_402_2, arg_399_1.talkMaxDuration)

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_6 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_1) / var_402_6

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_1 + var_402_6 and arg_399_1.time_ < var_402_1 + var_402_6 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play411331095 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 411331095
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play411331096(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos10014ui_story = arg_403_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_406_0 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 then
				arg_403_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos10014ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_403_1.time_ - 0) / var_406_0)
				arg_403_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["10014ui_story"].transform.position).z)
				arg_403_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["10014ui_story"].transform.localEulerAngles = arg_403_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 then
				arg_403_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_403_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["10014ui_story"].transform.position).z)
				arg_403_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["10014ui_story"].transform.localEulerAngles = arg_403_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_406_1 = arg_403_1.actors_["10014ui_story"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect10014ui_story == nil then
				arg_403_1.var_.characterEffect10014ui_story = var_406_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_2 and not isNil(var_406_1) then
				if arg_403_1.var_.characterEffect10014ui_story and not isNil(var_406_1) then
					arg_403_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_403_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_403_1.time_ - 0) / var_406_2)
				end
			end

			if arg_403_1.time_ >= 0 + var_406_2 and arg_403_1.time_ < 0 + var_406_2 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect10014ui_story then
				arg_403_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_403_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_406_3 = arg_403_1.actors_["4040ui_story"].transform

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos4040ui_story = var_406_3.localPosition
			end

			local var_406_4 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_4 then
				var_406_3.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos4040ui_story, Vector3.New(0.7, -1.55, -5.5), (arg_403_1.time_ - 0) / var_406_4)
				var_406_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_406_3.position).x, (manager.ui.mainCamera.transform.position - var_406_3.position).y, (manager.ui.mainCamera.transform.position - var_406_3.position).z)
				var_406_3.localEulerAngles.z = 0
				var_406_3.localEulerAngles.x = 0
				var_406_3.localEulerAngles = var_406_3.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_4 and arg_403_1.time_ < 0 + var_406_4 + arg_406_0 then
				var_406_3.localPosition = Vector3.New(0.7, -1.55, -5.5)
				var_406_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_406_3.position).x, (manager.ui.mainCamera.transform.position - var_406_3.position).y, (manager.ui.mainCamera.transform.position - var_406_3.position).z)
				var_406_3.localEulerAngles.z = 0
				var_406_3.localEulerAngles.x = 0
				var_406_3.localEulerAngles = var_406_3.localEulerAngles
			end

			local var_406_5 = arg_403_1.actors_["4040ui_story"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_5) and arg_403_1.var_.characterEffect4040ui_story == nil then
				arg_403_1.var_.characterEffect4040ui_story = var_406_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_6 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_6 and not isNil(var_406_5) then
				if arg_403_1.var_.characterEffect4040ui_story and not isNil(var_406_5) then
					arg_403_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_6 and arg_403_1.time_ < 0 + var_406_6 + arg_406_0 and not isNil(var_406_5) and arg_403_1.var_.characterEffect4040ui_story then
				arg_403_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_406_8 = 0
			local var_406_9 = 0.4

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_8 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_10 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(411331095).content)

				arg_403_1.text_.text = var_406_10

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_12 = 16 <= 0 and var_406_9 or var_406_9 * (utf8.len(var_406_10) / 16)

				if (16 <= 0 and var_406_9 or var_406_9 * (utf8.len(var_406_10) / 16)) > 0 and var_406_9 < var_406_12 then
					arg_403_1.talkMaxDuration = var_406_12

					if var_406_12 + var_406_8 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_12 + var_406_8
					end
				end

				arg_403_1.text_.text = var_406_10
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_13 = math.max(var_406_9, arg_403_1.talkMaxDuration)

			if var_406_8 <= arg_403_1.time_ and arg_403_1.time_ < var_406_8 + var_406_13 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_8) / var_406_13

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_8 + var_406_13 and arg_403_1.time_ < var_406_8 + var_406_13 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play411331096 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 411331096
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play411331097(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos10014ui_story = arg_407_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_410_0 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 then
				arg_407_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos10014ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_407_1.time_ - 0) / var_410_0)
				arg_407_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_407_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["10014ui_story"].transform.position).z)
				arg_407_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_407_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_407_1.actors_["10014ui_story"].transform.localEulerAngles = arg_407_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 then
				arg_407_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_407_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_407_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["10014ui_story"].transform.position).z)
				arg_407_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_407_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_407_1.actors_["10014ui_story"].transform.localEulerAngles = arg_407_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_410_1 = arg_407_1.actors_["10014ui_story"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_1) and arg_407_1.var_.characterEffect10014ui_story == nil then
				arg_407_1.var_.characterEffect10014ui_story = var_410_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_2 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_2 and not isNil(var_410_1) then
				if arg_407_1.var_.characterEffect10014ui_story and not isNil(var_410_1) then
					arg_407_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= 0 + var_410_2 and arg_407_1.time_ < 0 + var_410_2 + arg_410_0 and not isNil(var_410_1) and arg_407_1.var_.characterEffect10014ui_story then
				arg_407_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action4_2")
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_410_4 = arg_407_1.actors_["4040ui_story"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_4) and arg_407_1.var_.characterEffect4040ui_story == nil then
				arg_407_1.var_.characterEffect4040ui_story = var_410_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_5 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_5 and not isNil(var_410_4) then
				if arg_407_1.var_.characterEffect4040ui_story and not isNil(var_410_4) then
					arg_407_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_407_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_407_1.time_ - 0) / var_410_5)
				end
			end

			if arg_407_1.time_ >= 0 + var_410_5 and arg_407_1.time_ < 0 + var_410_5 + arg_410_0 and not isNil(var_410_4) and arg_407_1.var_.characterEffect4040ui_story then
				arg_407_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_407_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_410_6 = 0
			local var_410_7 = 0.575

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_6 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_8 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(411331096).content)

				arg_407_1.text_.text = var_410_8

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_10 = 23 <= 0 and var_410_7 or var_410_7 * (utf8.len(var_410_8) / 23)

				if (23 <= 0 and var_410_7 or var_410_7 * (utf8.len(var_410_8) / 23)) > 0 and var_410_7 < var_410_10 then
					arg_407_1.talkMaxDuration = var_410_10

					if var_410_10 + var_410_6 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_10 + var_410_6
					end
				end

				arg_407_1.text_.text = var_410_8
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_11 = math.max(var_410_7, arg_407_1.talkMaxDuration)

			if var_410_6 <= arg_407_1.time_ and arg_407_1.time_ < var_410_6 + var_410_11 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_6) / var_410_11

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_6 + var_410_11 and arg_407_1.time_ < var_410_6 + var_410_11 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_407_1:InitPlayNodeList()
	end,
	Play411331097 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 411331097
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play411331098(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 1.25

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_1 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(411331097).content)

				arg_411_1.text_.text = var_414_1

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_3 = 50 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 50)

				if (50 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 50)) > 0 and var_414_0 < var_414_3 then
					arg_411_1.talkMaxDuration = var_414_3

					if var_414_3 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_3 + 0
					end
				end

				arg_411_1.text_.text = var_414_1
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_4 = math.max(var_414_0, arg_411_1.talkMaxDuration)

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_4 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - 0) / var_414_4

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= 0 + var_414_4 and arg_411_1.time_ < 0 + var_414_4 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play411331098 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 411331098
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play411331099(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_418_0 = 0
			local var_418_1 = 0.35

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_2 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(411331098).content)

				arg_415_1.text_.text = var_418_2

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_4 = 14 <= 0 and var_418_1 or var_418_1 * (utf8.len(var_418_2) / 14)

				if (14 <= 0 and var_418_1 or var_418_1 * (utf8.len(var_418_2) / 14)) > 0 and var_418_1 < var_418_4 then
					arg_415_1.talkMaxDuration = var_418_4

					if var_418_4 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_4 + var_418_0
					end
				end

				arg_415_1.text_.text = var_418_2
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_5 = math.max(var_418_1, arg_415_1.talkMaxDuration)

			if var_418_0 <= arg_415_1.time_ and arg_415_1.time_ < var_418_0 + var_418_5 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_0) / var_418_5

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_0 + var_418_5 and arg_415_1.time_ < var_418_0 + var_418_5 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play411331099 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 411331099
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play411331100(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.moveOldPos10014ui_story = arg_419_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_422_0 = 0.001

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 then
				arg_419_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_419_1.time_ - 0) / var_422_0)
				arg_419_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["10014ui_story"].transform.position).z)
				arg_419_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["10014ui_story"].transform.localEulerAngles = arg_419_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 then
				arg_419_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_419_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["10014ui_story"].transform.position).z)
				arg_419_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["10014ui_story"].transform.localEulerAngles = arg_419_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_422_1 = arg_419_1.actors_["10014ui_story"]

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(var_422_1) and arg_419_1.var_.characterEffect10014ui_story == nil then
				arg_419_1.var_.characterEffect10014ui_story = var_422_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_2 = 0.200000002980232

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_2 and not isNil(var_422_1) then
				if arg_419_1.var_.characterEffect10014ui_story and not isNil(var_422_1) then
					arg_419_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_419_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_419_1.time_ - 0) / var_422_2)
				end
			end

			if arg_419_1.time_ >= 0 + var_422_2 and arg_419_1.time_ < 0 + var_422_2 + arg_422_0 and not isNil(var_422_1) and arg_419_1.var_.characterEffect10014ui_story then
				arg_419_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_419_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_422_3 = arg_419_1.actors_["4040ui_story"].transform

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.moveOldPos4040ui_story = var_422_3.localPosition
			end

			local var_422_4 = 0.001

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_4 then
				var_422_3.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_419_1.time_ - 0) / var_422_4)
				var_422_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_422_3.position).x, (manager.ui.mainCamera.transform.position - var_422_3.position).y, (manager.ui.mainCamera.transform.position - var_422_3.position).z)
				var_422_3.localEulerAngles.z = 0
				var_422_3.localEulerAngles.x = 0
				var_422_3.localEulerAngles = var_422_3.localEulerAngles
			end

			if arg_419_1.time_ >= 0 + var_422_4 and arg_419_1.time_ < 0 + var_422_4 + arg_422_0 then
				var_422_3.localPosition = Vector3.New(0, 100, 0)
				var_422_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_422_3.position).x, (manager.ui.mainCamera.transform.position - var_422_3.position).y, (manager.ui.mainCamera.transform.position - var_422_3.position).z)
				var_422_3.localEulerAngles.z = 0
				var_422_3.localEulerAngles.x = 0
				var_422_3.localEulerAngles = var_422_3.localEulerAngles
			end

			local var_422_5 = arg_419_1.actors_["4040ui_story"]

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(var_422_5) and arg_419_1.var_.characterEffect4040ui_story == nil then
				arg_419_1.var_.characterEffect4040ui_story = var_422_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_6 = 0.200000002980232

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_6 and not isNil(var_422_5) then
				if arg_419_1.var_.characterEffect4040ui_story and not isNil(var_422_5) then
					arg_419_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_419_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_419_1.time_ - 0) / var_422_6)
				end
			end

			if arg_419_1.time_ >= 0 + var_422_6 and arg_419_1.time_ < 0 + var_422_6 + arg_422_0 and not isNil(var_422_5) and arg_419_1.var_.characterEffect4040ui_story then
				arg_419_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_419_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_422_7 = 0
			local var_422_8 = 0.75

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_7 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_9 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(411331099).content)

				arg_419_1.text_.text = var_422_9

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_11 = 30 <= 0 and var_422_8 or var_422_8 * (utf8.len(var_422_9) / 30)

				if (30 <= 0 and var_422_8 or var_422_8 * (utf8.len(var_422_9) / 30)) > 0 and var_422_8 < var_422_11 then
					arg_419_1.talkMaxDuration = var_422_11

					if var_422_11 + var_422_7 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_11 + var_422_7
					end
				end

				arg_419_1.text_.text = var_422_9
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_12 = math.max(var_422_8, arg_419_1.talkMaxDuration)

			if var_422_7 <= arg_419_1.time_ and arg_419_1.time_ < var_422_7 + var_422_12 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_7) / var_422_12

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_7 + var_422_12 and arg_419_1.time_ < var_422_7 + var_422_12 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play411331100 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 411331100
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play411331101(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0.45

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[908].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_1 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(411331100).content)

				arg_423_1.text_.text = var_426_1

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_3 = 18 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_1) / 18)

				if (18 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_1) / 18)) > 0 and var_426_0 < var_426_3 then
					arg_423_1.talkMaxDuration = var_426_3

					if var_426_3 + 0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_3 + 0
					end
				end

				arg_423_1.text_.text = var_426_1
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_4 = math.max(var_426_0, arg_423_1.talkMaxDuration)

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_4 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - 0) / var_426_4

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= 0 + var_426_4 and arg_423_1.time_ < 0 + var_426_4 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play411331101 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 411331101
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play411331102(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0.55

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[907].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_1 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(411331101).content)

				arg_427_1.text_.text = var_430_1

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_3 = 22 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_1) / 22)

				if (22 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_1) / 22)) > 0 and var_430_0 < var_430_3 then
					arg_427_1.talkMaxDuration = var_430_3

					if var_430_3 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_3 + 0
					end
				end

				arg_427_1.text_.text = var_430_1
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_4 = math.max(var_430_0, arg_427_1.talkMaxDuration)

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_4 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - 0) / var_430_4

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= 0 + var_430_4 and arg_427_1.time_ < 0 + var_430_4 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play411331102 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 411331102
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play411331103(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 1.425

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_1 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(411331102).content)

				arg_431_1.text_.text = var_434_1

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_3 = 57 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 57)

				if (57 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 57)) > 0 and var_434_0 < var_434_3 then
					arg_431_1.talkMaxDuration = var_434_3

					if var_434_3 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_3 + 0
					end
				end

				arg_431_1.text_.text = var_434_1
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_4 = math.max(var_434_0, arg_431_1.talkMaxDuration)

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_4 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - 0) / var_434_4

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= 0 + var_434_4 and arg_431_1.time_ < 0 + var_434_4 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play411331103 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 411331103
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play411331104(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0.25

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[907].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_1 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(411331103).content)

				arg_435_1.text_.text = var_438_1

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_3 = 10 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_1) / 10)

				if (10 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_1) / 10)) > 0 and var_438_0 < var_438_3 then
					arg_435_1.talkMaxDuration = var_438_3

					if var_438_3 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_3 + 0
					end
				end

				arg_435_1.text_.text = var_438_1
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_4 = math.max(var_438_0, arg_435_1.talkMaxDuration)

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_4 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - 0) / var_438_4

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= 0 + var_438_4 and arg_435_1.time_ < 0 + var_438_4 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play411331104 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 411331104
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play411331105(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0.35

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_1 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(411331104).content)

				arg_439_1.text_.text = var_442_1

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_3 = 14 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_1) / 14)

				if (14 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_1) / 14)) > 0 and var_442_0 < var_442_3 then
					arg_439_1.talkMaxDuration = var_442_3

					if var_442_3 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_3 + 0
					end
				end

				arg_439_1.text_.text = var_442_1
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_4 = math.max(var_442_0, arg_439_1.talkMaxDuration)

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_4 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - 0) / var_442_4

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= 0 + var_442_4 and arg_439_1.time_ < 0 + var_442_4 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play411331105 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 411331105
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play411331106(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_9000

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				local var_446_0 = arg_443_1.var_.effect888

				if not arg_443_1.var_.effect888 then
					var_446_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_02"), manager.ui.mainCamera.transform)
					var_446_0.name = "888"
					arg_443_1.var_.effect888 = var_446_0
				else
					var_446_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_446_0.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_446_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.06666666666667 < arg_443_1.time_ and arg_443_1.time_ <= 1.06666666666667 + arg_446_0 then
				local var_446_2 = arg_443_1.var_.effect999

				if not arg_443_1.var_.effect999 then
					var_446_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_red"), manager.ui.mainCamera.transform)
					var_446_2.name = "999"
					arg_443_1.var_.effect999 = var_446_2
				else
					var_446_2.transform:SetParent(var_446_9000)
				end

				var_446_2.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_446_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.73333333333333 < arg_443_1.time_ and arg_443_1.time_ <= 1.73333333333333 + arg_446_0 then
				if arg_443_1.var_.effect999 then
					Object.Destroy(arg_443_1.var_.effect999)

					arg_443_1.var_.effect999 = nil
				end
			end

			local var_446_5 = 0

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_5 + arg_446_0 then
				arg_443_1.allBtn_.enabled = false
			end

			if arg_443_1.time_ >= var_446_5 + 2 and arg_443_1.time_ < var_446_5 + 2 + arg_446_0 then
				arg_443_1.allBtn_.enabled = true
			end

			local var_446_6 = manager.ui.mainCamera.transform

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.var_.shakeOldPos = var_446_6.localPosition
			end

			local var_446_7 = 2

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_7 then
				local var_446_8, var_446_9 = math.modf((arg_443_1.time_ - 0) / 0.066)

				var_446_6.localPosition = Vector3.New(var_446_9 * 0.13, var_446_9 * 0.13, var_446_9 * 0.13) + arg_443_1.var_.shakeOldPos
			end

			if arg_443_1.time_ >= 0 + var_446_7 and arg_443_1.time_ < 0 + var_446_7 + arg_446_0 then
				var_446_6.localPosition = arg_443_1.var_.shakeOldPos
			end

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_stab2", "")
			end

			local var_446_11 = 0
			local var_446_12 = 1.475

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_11 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0

				arg_443_1.dialog_:SetActive(true)

				arg_443_1.dialogCg_.alpha = 0

				local var_446_13 = LeanTween.value(arg_443_1.dialog_, 0, 1, 0.3)

				var_446_13:setOnUpdate(LuaHelper.FloatAction(function(arg_447_0)
					arg_443_1.dialogCg_.alpha = arg_447_0
				end))
				var_446_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_443_1.dialog_)
					var_446_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_443_1.duration_ = arg_443_1.duration_ + 0.3

				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_14 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(411331105).content)

				arg_443_1.text_.text = var_446_14

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_16 = 59 <= 0 and var_446_12 or var_446_12 * (utf8.len(var_446_14) / 59)

				if (59 <= 0 and var_446_12 or var_446_12 * (utf8.len(var_446_14) / 59)) > 0 and var_446_12 < var_446_16 then
					arg_443_1.talkMaxDuration = var_446_16
					var_446_11 = var_446_11 + 0.3

					if var_446_16 + var_446_11 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_16 + var_446_11
					end
				end

				arg_443_1.text_.text = var_446_14
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_17 = var_446_11 + 0.3
			local var_446_18 = math.max(var_446_12, arg_443_1.talkMaxDuration)

			if var_446_11 + 0.3 <= arg_443_1.time_ and arg_443_1.time_ < var_446_17 + var_446_18 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_17) / var_446_18

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_17 + var_446_18 and arg_443_1.time_ < var_446_17 + var_446_18 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play411331106 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 411331106
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play411331107(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos4040ui_story = arg_449_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_452_0 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 then
				arg_449_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_449_1.time_ - 0) / var_452_0)
				arg_449_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["4040ui_story"].transform.position).z)
				arg_449_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["4040ui_story"].transform.localEulerAngles = arg_449_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 then
				arg_449_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_449_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["4040ui_story"].transform.position).z)
				arg_449_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["4040ui_story"].transform.localEulerAngles = arg_449_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_452_1 = arg_449_1.actors_["4040ui_story"]

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(var_452_1) and arg_449_1.var_.characterEffect4040ui_story == nil then
				arg_449_1.var_.characterEffect4040ui_story = var_452_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_2 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_2 and not isNil(var_452_1) then
				if arg_449_1.var_.characterEffect4040ui_story and not isNil(var_452_1) then
					arg_449_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= 0 + var_452_2 and arg_449_1.time_ < 0 + var_452_2 + arg_452_0 and not isNil(var_452_1) and arg_449_1.var_.characterEffect4040ui_story then
				arg_449_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				if arg_449_1.var_.effect888 then
					Object.Destroy(arg_449_1.var_.effect888)

					arg_449_1.var_.effect888 = nil
				end
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				if arg_449_1.var_.effect999 then
					Object.Destroy(arg_449_1.var_.effect999)

					arg_449_1.var_.effect999 = nil
				end
			end

			local var_452_6 = 0
			local var_452_7 = 0.125

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_6 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_8 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(411331106).content)

				arg_449_1.text_.text = var_452_8

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_10 = 5 <= 0 and var_452_7 or var_452_7 * (utf8.len(var_452_8) / 5)

				if (5 <= 0 and var_452_7 or var_452_7 * (utf8.len(var_452_8) / 5)) > 0 and var_452_7 < var_452_10 then
					arg_449_1.talkMaxDuration = var_452_10

					if var_452_10 + var_452_6 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_10 + var_452_6
					end
				end

				arg_449_1.text_.text = var_452_8
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_11 = math.max(var_452_7, arg_449_1.talkMaxDuration)

			if var_452_6 <= arg_449_1.time_ and arg_449_1.time_ < var_452_6 + var_452_11 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_6) / var_452_11

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_6 + var_452_11 and arg_449_1.time_ < var_452_6 + var_452_11 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play411331107 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 411331107
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play411331108(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos4040ui_story = arg_453_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_456_0 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 then
				arg_453_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_453_1.time_ - 0) / var_456_0)
				arg_453_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["4040ui_story"].transform.position).z)
				arg_453_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["4040ui_story"].transform.localEulerAngles = arg_453_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 then
				arg_453_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_453_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["4040ui_story"].transform.position).z)
				arg_453_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["4040ui_story"].transform.localEulerAngles = arg_453_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_456_1 = arg_453_1.actors_["4040ui_story"]

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect4040ui_story == nil then
				arg_453_1.var_.characterEffect4040ui_story = var_456_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_2 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_2 and not isNil(var_456_1) then
				if arg_453_1.var_.characterEffect4040ui_story and not isNil(var_456_1) then
					arg_453_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_453_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_453_1.time_ - 0) / var_456_2)
				end
			end

			if arg_453_1.time_ >= 0 + var_456_2 and arg_453_1.time_ < 0 + var_456_2 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect4040ui_story then
				arg_453_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_453_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_456_3 = 0
			local var_456_4 = 1.125

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_3 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_5 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(411331107).content)

				arg_453_1.text_.text = var_456_5

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_7 = 45 <= 0 and var_456_4 or var_456_4 * (utf8.len(var_456_5) / 45)

				if (45 <= 0 and var_456_4 or var_456_4 * (utf8.len(var_456_5) / 45)) > 0 and var_456_4 < var_456_7 then
					arg_453_1.talkMaxDuration = var_456_7

					if var_456_7 + var_456_3 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_7 + var_456_3
					end
				end

				arg_453_1.text_.text = var_456_5
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_8 = math.max(var_456_4, arg_453_1.talkMaxDuration)

			if var_456_3 <= arg_453_1.time_ and arg_453_1.time_ < var_456_3 + var_456_8 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_3) / var_456_8

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_3 + var_456_8 and arg_453_1.time_ < var_456_3 + var_456_8 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play411331108 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 411331108
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play411331109(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 1.425

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_1 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(411331108).content)

				arg_457_1.text_.text = var_460_1

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_3 = 57 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_1) / 57)

				if (57 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_1) / 57)) > 0 and var_460_0 < var_460_3 then
					arg_457_1.talkMaxDuration = var_460_3

					if var_460_3 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_3 + 0
					end
				end

				arg_457_1.text_.text = var_460_1
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_4 = math.max(var_460_0, arg_457_1.talkMaxDuration)

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_4 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - 0) / var_460_4

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= 0 + var_460_4 and arg_457_1.time_ < 0 + var_460_4 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play411331109 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 411331109
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play411331110(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0.625

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_1 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(411331109).content)

				arg_461_1.text_.text = var_464_1

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_3 = 25 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 25)

				if (25 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 25)) > 0 and var_464_0 < var_464_3 then
					arg_461_1.talkMaxDuration = var_464_3

					if var_464_3 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_3 + 0
					end
				end

				arg_461_1.text_.text = var_464_1
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_4 = math.max(var_464_0, arg_461_1.talkMaxDuration)

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_4 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - 0) / var_464_4

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= 0 + var_464_4 and arg_461_1.time_ < 0 + var_464_4 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play411331110 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 411331110
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play411331111(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.moveOldPos4040ui_story = arg_465_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_468_0 = 0.001

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 then
				arg_465_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_465_1.time_ - 0) / var_468_0)
				arg_465_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["4040ui_story"].transform.position).z)
				arg_465_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["4040ui_story"].transform.localEulerAngles = arg_465_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 then
				arg_465_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_465_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["4040ui_story"].transform.position).z)
				arg_465_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["4040ui_story"].transform.localEulerAngles = arg_465_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_468_1 = arg_465_1.actors_["4040ui_story"]

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect4040ui_story == nil then
				arg_465_1.var_.characterEffect4040ui_story = var_468_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_2 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_2 and not isNil(var_468_1) then
				if arg_465_1.var_.characterEffect4040ui_story and not isNil(var_468_1) then
					arg_465_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= 0 + var_468_2 and arg_465_1.time_ < 0 + var_468_2 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect4040ui_story then
				arg_465_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_468_4 = manager.ui.mainCamera.transform

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.shakeOldPos = var_468_4.localPosition
			end

			local var_468_5 = 0.6

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_5 then
				local var_468_6, var_468_7 = math.modf((arg_465_1.time_ - 0) / 0.066)

				var_468_4.localPosition = Vector3.New(var_468_7 * 0.13, var_468_7 * 0.13, var_468_7 * 0.13) + arg_465_1.var_.shakeOldPos
			end

			if arg_465_1.time_ >= 0 + var_468_5 and arg_465_1.time_ < 0 + var_468_5 + arg_468_0 then
				var_468_4.localPosition = arg_465_1.var_.shakeOldPos
			end

			local var_468_8 = 0

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_8 + arg_468_0 then
				arg_465_1.allBtn_.enabled = false
			end

			if arg_465_1.time_ >= var_468_8 + 0.6 and arg_465_1.time_ < var_468_8 + 0.6 + arg_468_0 then
				arg_465_1.allBtn_.enabled = true
			end

			local var_468_9 = 0
			local var_468_10 = 0.225

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_9 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_11 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(411331110).content)

				arg_465_1.text_.text = var_468_11

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_13 = 9 <= 0 and var_468_10 or var_468_10 * (utf8.len(var_468_11) / 9)

				if (9 <= 0 and var_468_10 or var_468_10 * (utf8.len(var_468_11) / 9)) > 0 and var_468_10 < var_468_13 then
					arg_465_1.talkMaxDuration = var_468_13

					if var_468_13 + var_468_9 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_13 + var_468_9
					end
				end

				arg_465_1.text_.text = var_468_11
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_14 = math.max(var_468_10, arg_465_1.talkMaxDuration)

			if var_468_9 <= arg_465_1.time_ and arg_465_1.time_ < var_468_9 + var_468_14 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_9) / var_468_14

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_9 + var_468_14 and arg_465_1.time_ < var_468_9 + var_468_14 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play411331111 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 411331111
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play411331112(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.var_.moveOldPos4040ui_story = arg_469_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_472_0 = 0.001

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 then
				arg_469_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_469_1.time_ - 0) / var_472_0)
				arg_469_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_469_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["4040ui_story"].transform.position).z)
				arg_469_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_469_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_469_1.actors_["4040ui_story"].transform.localEulerAngles = arg_469_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 then
				arg_469_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_469_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_469_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["4040ui_story"].transform.position).z)
				arg_469_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_469_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_469_1.actors_["4040ui_story"].transform.localEulerAngles = arg_469_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_472_1 = arg_469_1.actors_["4040ui_story"]

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(var_472_1) and arg_469_1.var_.characterEffect4040ui_story == nil then
				arg_469_1.var_.characterEffect4040ui_story = var_472_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_2 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_2 and not isNil(var_472_1) then
				if arg_469_1.var_.characterEffect4040ui_story and not isNil(var_472_1) then
					arg_469_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_469_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_469_1.time_ - 0) / var_472_2)
				end
			end

			if arg_469_1.time_ >= 0 + var_472_2 and arg_469_1.time_ < 0 + var_472_2 + arg_472_0 and not isNil(var_472_1) and arg_469_1.var_.characterEffect4040ui_story then
				arg_469_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_469_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_472_3 = 0
			local var_472_4 = 0.225

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_3 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_5 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(411331111).content)

				arg_469_1.text_.text = var_472_5

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_7 = 9 <= 0 and var_472_4 or var_472_4 * (utf8.len(var_472_5) / 9)

				if (9 <= 0 and var_472_4 or var_472_4 * (utf8.len(var_472_5) / 9)) > 0 and var_472_4 < var_472_7 then
					arg_469_1.talkMaxDuration = var_472_7

					if var_472_7 + var_472_3 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_3
					end
				end

				arg_469_1.text_.text = var_472_5
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_8 = math.max(var_472_4, arg_469_1.talkMaxDuration)

			if var_472_3 <= arg_469_1.time_ and arg_469_1.time_ < var_472_3 + var_472_8 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_3) / var_472_8

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_3 + var_472_8 and arg_469_1.time_ < var_472_3 + var_472_8 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_469_1:InitPlayNodeList()
	end,
	Play411331112 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 411331112
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play411331113(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0.3

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, false)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_1 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(411331112).content)

				arg_473_1.text_.text = var_476_1

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_3 = 12 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 12)

				if (12 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 12)) > 0 and var_476_0 < var_476_3 then
					arg_473_1.talkMaxDuration = var_476_3

					if var_476_3 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_3 + 0
					end
				end

				arg_473_1.text_.text = var_476_1
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_4 = math.max(var_476_0, arg_473_1.talkMaxDuration)

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_4 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - 0) / var_476_4

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= 0 + var_476_4 and arg_473_1.time_ < 0 + var_476_4 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play411331113 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 411331113
		arg_477_1.duration_ = 5.85

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play411331114(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_480_0 = 0.566666666666667

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 then
				local var_480_1, var_480_2 = math.modf((arg_477_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_480_2 * 0.13, var_480_2 * 0.13, var_480_2 * 0.13) + arg_477_1.var_.shakeOldPos
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 then
				manager.ui.mainCamera.transform.localPosition = arg_477_1.var_.shakeOldPos
			end

			if arg_477_1.frameCnt_ <= 1 then
				arg_477_1.dialog_:SetActive(false)
			end

			local var_480_3 = 0.85
			local var_480_4 = 0.15

			if 0.85 < arg_477_1.time_ and arg_477_1.time_ <= var_480_3 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0

				arg_477_1.dialog_:SetActive(true)

				arg_477_1.dialogCg_.alpha = 0

				local var_480_5 = LeanTween.value(arg_477_1.dialog_, 0, 1, 0.3)

				var_480_5:setOnUpdate(LuaHelper.FloatAction(function(arg_481_0)
					arg_477_1.dialogCg_.alpha = arg_481_0
				end))
				var_480_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_477_1.dialog_)
					var_480_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_477_1.duration_ = arg_477_1.duration_ + 0.3

				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_6 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(411331113).content)

				arg_477_1.text_.text = var_480_6

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_8 = 6 <= 0 and var_480_4 or var_480_4 * (utf8.len(var_480_6) / 6)

				if (6 <= 0 and var_480_4 or var_480_4 * (utf8.len(var_480_6) / 6)) > 0 and var_480_4 < var_480_8 then
					arg_477_1.talkMaxDuration = var_480_8
					var_480_3 = var_480_3 + 0.3

					if var_480_8 + var_480_3 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_8 + var_480_3
					end
				end

				arg_477_1.text_.text = var_480_6
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_9 = var_480_3 + 0.3
			local var_480_10 = math.max(var_480_4, arg_477_1.talkMaxDuration)

			if var_480_3 + 0.3 <= arg_477_1.time_ and arg_477_1.time_ < var_480_9 + var_480_10 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_9) / var_480_10

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_9 + var_480_10 and arg_477_1.time_ < var_480_9 + var_480_10 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play411331114 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 411331114
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play411331115(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 1.275

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_1 = arg_483_1:FormatText(arg_483_1:GetWordFromCfg(411331114).content)

				arg_483_1.text_.text = var_486_1

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_3 = 51 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_1) / 51)

				if (51 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_1) / 51)) > 0 and var_486_0 < var_486_3 then
					arg_483_1.talkMaxDuration = var_486_3

					if var_486_3 + 0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_3 + 0
					end
				end

				arg_483_1.text_.text = var_486_1
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_4 = math.max(var_486_0, arg_483_1.talkMaxDuration)

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_4 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - 0) / var_486_4

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= 0 + var_486_4 and arg_483_1.time_ < 0 + var_486_4 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play411331115 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 411331115
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play411331116(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0.175

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[907].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_1 = arg_487_1:FormatText(arg_487_1:GetWordFromCfg(411331115).content)

				arg_487_1.text_.text = var_490_1

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_3 = 7 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_1) / 7)

				if (7 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_1) / 7)) > 0 and var_490_0 < var_490_3 then
					arg_487_1.talkMaxDuration = var_490_3

					if var_490_3 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_3 + 0
					end
				end

				arg_487_1.text_.text = var_490_1
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_4 = math.max(var_490_0, arg_487_1.talkMaxDuration)

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_4 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - 0) / var_490_4

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= 0 + var_490_4 and arg_487_1.time_ < 0 + var_490_4 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play411331116 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 411331116
		arg_491_1.duration_ = 5

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play411331117(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0.9

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, false)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_1 = arg_491_1:FormatText(arg_491_1:GetWordFromCfg(411331116).content)

				arg_491_1.text_.text = var_494_1

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_3 = 36 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_1) / 36)

				if (36 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_1) / 36)) > 0 and var_494_0 < var_494_3 then
					arg_491_1.talkMaxDuration = var_494_3

					if var_494_3 + 0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_3 + 0
					end
				end

				arg_491_1.text_.text = var_494_1
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)
				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_4 = math.max(var_494_0, arg_491_1.talkMaxDuration)

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_4 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - 0) / var_494_4

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= 0 + var_494_4 and arg_491_1.time_ < 0 + var_494_4 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play411331117 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 411331117
		arg_495_1.duration_ = 5.57

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play411331118(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.mask_.enabled = true
				arg_495_1.mask_.raycastTarget = false

				arg_495_1:SetGaussion(false)
			end

			local var_498_0 = 0.466666666666667

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 then
				local var_498_1 = Color.New(0.9811321, 0.06016379, 0.06016379)

				var_498_1.a = Mathf.Lerp(1, 0, (arg_495_1.time_ - 0) / var_498_0)
				arg_495_1.mask_.color = var_498_1
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 then
				local var_498_2 = Color.New(0.9811321, 0.06016379, 0.06016379)

				arg_495_1.mask_.enabled = false
				var_498_2.a = 0
				arg_495_1.mask_.color = var_498_2
			end

			if arg_495_1.frameCnt_ <= 1 then
				arg_495_1.dialog_:SetActive(false)
			end

			local var_498_3 = 0.566666666666667
			local var_498_4 = 1.375

			if 0.566666666666667 < arg_495_1.time_ and arg_495_1.time_ <= var_498_3 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0

				arg_495_1.dialog_:SetActive(true)

				arg_495_1.dialogCg_.alpha = 0

				local var_498_5 = LeanTween.value(arg_495_1.dialog_, 0, 1, 0.3)

				var_498_5:setOnUpdate(LuaHelper.FloatAction(function(arg_499_0)
					arg_495_1.dialogCg_.alpha = arg_499_0
				end))
				var_498_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_495_1.dialog_)
					var_498_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_495_1.duration_ = arg_495_1.duration_ + 0.3

				SetActive(arg_495_1.leftNameGo_, false)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_6 = arg_495_1:FormatText(arg_495_1:GetWordFromCfg(411331117).content)

				arg_495_1.text_.text = var_498_6

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_8 = 55 <= 0 and var_498_4 or var_498_4 * (utf8.len(var_498_6) / 55)

				if (55 <= 0 and var_498_4 or var_498_4 * (utf8.len(var_498_6) / 55)) > 0 and var_498_4 < var_498_8 then
					arg_495_1.talkMaxDuration = var_498_8
					var_498_3 = var_498_3 + 0.3

					if var_498_8 + var_498_3 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_8 + var_498_3
					end
				end

				arg_495_1.text_.text = var_498_6
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_9 = var_498_3 + 0.3
			local var_498_10 = math.max(var_498_4, arg_495_1.talkMaxDuration)

			if var_498_3 + 0.3 <= arg_495_1.time_ and arg_495_1.time_ < var_498_9 + var_498_10 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_9) / var_498_10

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_9 + var_498_10 and arg_495_1.time_ < var_498_9 + var_498_10 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play411331118 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 411331118
		arg_501_1.duration_ = 5.83

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play411331119(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				local var_504_0 = arg_501_1.bgs_.STblack

				arg_501_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_504_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_504_1 = var_504_0:GetComponent("SpriteRenderer")

				if var_504_1 and var_504_1.sprite then
					local var_504_2 = 2 * (var_504_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_504_0.transform.localScale = Vector3.New(var_504_2 / var_504_1.sprite.bounds.size.y < var_504_2 * manager.ui.mainCameraCom_.aspect / var_504_1.sprite.bounds.size.x and var_504_2 * manager.ui.mainCameraCom_.aspect / var_504_1.sprite.bounds.size.x or var_504_2 / var_504_1.sprite.bounds.size.y, var_504_2 / var_504_1.sprite.bounds.size.y < var_504_2 * manager.ui.mainCameraCom_.aspect / var_504_1.sprite.bounds.size.x and var_504_2 * manager.ui.mainCameraCom_.aspect / var_504_1.sprite.bounds.size.x or var_504_2 / var_504_1.sprite.bounds.size.y, 0)
				end

				for iter_504_0, iter_504_1 in pairs(arg_501_1.bgs_) do
					if iter_504_0 ~= "STblack" then
						iter_504_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_504_3 = 0

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_3 + arg_504_0 then
				arg_501_1.mask_.enabled = true
				arg_501_1.mask_.raycastTarget = true

				arg_501_1:SetGaussion(false)
			end

			local var_504_4 = 0.933333333333333

			if var_504_3 <= arg_501_1.time_ and arg_501_1.time_ < var_504_3 + var_504_4 then
				local var_504_5 = Color.New(1, 1, 1)

				var_504_5.a = Mathf.Lerp(1, 0, (arg_501_1.time_ - var_504_3) / var_504_4)
				arg_501_1.mask_.color = var_504_5
			end

			if arg_501_1.time_ >= var_504_3 + var_504_4 and arg_501_1.time_ < var_504_3 + var_504_4 + arg_504_0 then
				local var_504_6 = Color.New(1, 1, 1)

				arg_501_1.mask_.enabled = false
				var_504_6.a = 0
				arg_501_1.mask_.color = var_504_6
			end

			local var_504_7 = manager.ui.mainCamera.transform

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.var_.shakeOldPos = var_504_7.localPosition
			end

			local var_504_8 = 0.633333333333333

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_8 then
				local var_504_9, var_504_10 = math.modf((arg_501_1.time_ - 0) / 0.066)

				var_504_7.localPosition = Vector3.New(var_504_10 * 0.13, var_504_10 * 0.13, var_504_10 * 0.13) + arg_501_1.var_.shakeOldPos
			end

			if arg_501_1.time_ >= 0 + var_504_8 and arg_501_1.time_ < 0 + var_504_8 + arg_504_0 then
				var_504_7.localPosition = arg_501_1.var_.shakeOldPos
			end

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1:AudioAction("play", "effect", "se_story_128", "se_story_128_stab", "")
			end

			if arg_501_1.frameCnt_ <= 1 then
				arg_501_1.dialog_:SetActive(false)
			end

			local var_504_12 = 0.833333333333333
			local var_504_13 = 0.325

			if 0.833333333333333 < arg_501_1.time_ and arg_501_1.time_ <= var_504_12 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0

				arg_501_1.dialog_:SetActive(true)

				arg_501_1.dialogCg_.alpha = 0

				local var_504_14 = LeanTween.value(arg_501_1.dialog_, 0, 1, 0.3)

				var_504_14:setOnUpdate(LuaHelper.FloatAction(function(arg_505_0)
					arg_501_1.dialogCg_.alpha = arg_505_0
				end))
				var_504_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_501_1.dialog_)
					var_504_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_501_1.duration_ = arg_501_1.duration_ + 0.3

				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[908].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_15 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(411331118).content)

				arg_501_1.text_.text = var_504_15

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_17 = 13 <= 0 and var_504_13 or var_504_13 * (utf8.len(var_504_15) / 13)

				if (13 <= 0 and var_504_13 or var_504_13 * (utf8.len(var_504_15) / 13)) > 0 and var_504_13 < var_504_17 then
					arg_501_1.talkMaxDuration = var_504_17
					var_504_12 = var_504_12 + 0.3

					if var_504_17 + var_504_12 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_17 + var_504_12
					end
				end

				arg_501_1.text_.text = var_504_15
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_18 = var_504_12 + 0.3
			local var_504_19 = math.max(var_504_13, arg_501_1.talkMaxDuration)

			if var_504_12 + 0.3 <= arg_501_1.time_ and arg_501_1.time_ < var_504_18 + var_504_19 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_18) / var_504_19

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_18 + var_504_19 and arg_501_1.time_ < var_504_18 + var_504_19 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play411331119 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 411331119
		arg_507_1.duration_ = 5.43

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play411331120(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_510_0 = 0.633333333333333

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 then
				local var_510_1, var_510_2 = math.modf((arg_507_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_510_2 * 0.13, var_510_2 * 0.13, var_510_2 * 0.13) + arg_507_1.var_.shakeOldPos
			end

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 then
				manager.ui.mainCamera.transform.localPosition = arg_507_1.var_.shakeOldPos
			end

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_stab2", "")
			end

			if arg_507_1.frameCnt_ <= 1 then
				arg_507_1.dialog_:SetActive(false)
			end

			local var_510_4 = 0.433333333333333
			local var_510_5 = 0.3

			if 0.433333333333333 < arg_507_1.time_ and arg_507_1.time_ <= var_510_4 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0

				arg_507_1.dialog_:SetActive(true)

				arg_507_1.dialogCg_.alpha = 0

				local var_510_6 = LeanTween.value(arg_507_1.dialog_, 0, 1, 0.3)

				var_510_6:setOnUpdate(LuaHelper.FloatAction(function(arg_511_0)
					arg_507_1.dialogCg_.alpha = arg_511_0
				end))
				var_510_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_507_1.dialog_)
					var_510_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_507_1.duration_ = arg_507_1.duration_ + 0.3

				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[907].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, true)
				arg_507_1.iconController_:SetSelectedState("hero")

				arg_507_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_507_1.callingController_:SetSelectedState("normal")

				arg_507_1.keyicon_.color = Color.New(1, 1, 1)
				arg_507_1.icon_.color = Color.New(1, 1, 1)

				local var_510_7 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(411331119).content)

				arg_507_1.text_.text = var_510_7

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_9 = 12 <= 0 and var_510_5 or var_510_5 * (utf8.len(var_510_7) / 12)

				if (12 <= 0 and var_510_5 or var_510_5 * (utf8.len(var_510_7) / 12)) > 0 and var_510_5 < var_510_9 then
					arg_507_1.talkMaxDuration = var_510_9
					var_510_4 = var_510_4 + 0.3

					if var_510_9 + var_510_4 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_9 + var_510_4
					end
				end

				arg_507_1.text_.text = var_510_7
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_10 = var_510_4 + 0.3
			local var_510_11 = math.max(var_510_5, arg_507_1.talkMaxDuration)

			if var_510_4 + 0.3 <= arg_507_1.time_ and arg_507_1.time_ < var_510_10 + var_510_11 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_10) / var_510_11

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_10 + var_510_11 and arg_507_1.time_ < var_510_10 + var_510_11 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play411331120 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 411331120
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play411331121(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0.05

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, false)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_1 = arg_513_1:FormatText(arg_513_1:GetWordFromCfg(411331120).content)

				arg_513_1.text_.text = var_516_1

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_3 = 2 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 2)

				if (2 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 2)) > 0 and var_516_0 < var_516_3 then
					arg_513_1.talkMaxDuration = var_516_3

					if var_516_3 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_3 + 0
					end
				end

				arg_513_1.text_.text = var_516_1
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_4 = math.max(var_516_0, arg_513_1.talkMaxDuration)

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_4 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - 0) / var_516_4

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= 0 + var_516_4 and arg_513_1.time_ < 0 + var_516_4 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play411331121 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 411331121
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play411331122(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0.275

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, false)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_1 = arg_517_1:FormatText(arg_517_1:GetWordFromCfg(411331121).content)

				arg_517_1.text_.text = var_520_1

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_3 = 11 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_1) / 11)

				if (11 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_1) / 11)) > 0 and var_520_0 < var_520_3 then
					arg_517_1.talkMaxDuration = var_520_3

					if var_520_3 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_3 + 0
					end
				end

				arg_517_1.text_.text = var_520_1
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_4 = math.max(var_520_0, arg_517_1.talkMaxDuration)

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_4 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - 0) / var_520_4

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= 0 + var_520_4 and arg_517_1.time_ < 0 + var_520_4 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play411331122 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 411331122
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play411331123(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0.125

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, false)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_1 = arg_521_1:FormatText(arg_521_1:GetWordFromCfg(411331122).content)

				arg_521_1.text_.text = var_524_1

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_3 = 5 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_1) / 5)

				if (5 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_1) / 5)) > 0 and var_524_0 < var_524_3 then
					arg_521_1.talkMaxDuration = var_524_3

					if var_524_3 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_3 + 0
					end
				end

				arg_521_1.text_.text = var_524_1
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_4 = math.max(var_524_0, arg_521_1.talkMaxDuration)

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_4 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - 0) / var_524_4

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= 0 + var_524_4 and arg_521_1.time_ < 0 + var_524_4 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play411331123 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 411331123
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play411331124(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0.2

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, false)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_1 = arg_525_1:FormatText(arg_525_1:GetWordFromCfg(411331123).content)

				arg_525_1.text_.text = var_528_1

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_3 = 8 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_1) / 8)

				if (8 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_1) / 8)) > 0 and var_528_0 < var_528_3 then
					arg_525_1.talkMaxDuration = var_528_3

					if var_528_3 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_3 + 0
					end
				end

				arg_525_1.text_.text = var_528_1
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_4 = math.max(var_528_0, arg_525_1.talkMaxDuration)

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_4 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - 0) / var_528_4

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= 0 + var_528_4 and arg_525_1.time_ < 0 + var_528_4 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play411331124 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 411331124
		arg_529_1.duration_ = 9

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play411331125(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 2 < arg_529_1.time_ and arg_529_1.time_ <= 2 + arg_532_0 then
				local var_532_0 = arg_529_1.bgs_.D10

				arg_529_1.bgs_.D10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_532_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_532_1 = var_532_0:GetComponent("SpriteRenderer")

				if var_532_1 and var_532_1.sprite then
					local var_532_2 = 2 * (var_532_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_532_0.transform.localScale = Vector3.New(var_532_2 / var_532_1.sprite.bounds.size.y < var_532_2 * manager.ui.mainCameraCom_.aspect / var_532_1.sprite.bounds.size.x and var_532_2 * manager.ui.mainCameraCom_.aspect / var_532_1.sprite.bounds.size.x or var_532_2 / var_532_1.sprite.bounds.size.y, var_532_2 / var_532_1.sprite.bounds.size.y < var_532_2 * manager.ui.mainCameraCom_.aspect / var_532_1.sprite.bounds.size.x and var_532_2 * manager.ui.mainCameraCom_.aspect / var_532_1.sprite.bounds.size.x or var_532_2 / var_532_1.sprite.bounds.size.y, 0)
				end

				for iter_532_0, iter_532_1 in pairs(arg_529_1.bgs_) do
					if iter_532_0 ~= "D10" then
						iter_532_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_532_3 = 0

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_3 + arg_532_0 then
				arg_529_1.mask_.enabled = true
				arg_529_1.mask_.raycastTarget = true

				arg_529_1:SetGaussion(false)
			end

			local var_532_4 = 2

			if var_532_3 <= arg_529_1.time_ and arg_529_1.time_ < var_532_3 + var_532_4 then
				local var_532_5 = Color.New(0, 0, 0)

				var_532_5.a = Mathf.Lerp(1, 0, (arg_529_1.time_ - var_532_3) / var_532_4)
				arg_529_1.mask_.color = var_532_5
			end

			if arg_529_1.time_ >= var_532_3 + var_532_4 and arg_529_1.time_ < var_532_3 + var_532_4 + arg_532_0 then
				local var_532_6 = Color.New(0, 0, 0)

				arg_529_1.mask_.enabled = false
				var_532_6.a = 0
				arg_529_1.mask_.color = var_532_6
			end

			local var_532_7 = 2

			if 2 < arg_529_1.time_ and arg_529_1.time_ <= var_532_7 + arg_532_0 then
				arg_529_1.mask_.enabled = true
				arg_529_1.mask_.raycastTarget = true

				arg_529_1:SetGaussion(false)
			end

			local var_532_8 = 2

			if var_532_7 <= arg_529_1.time_ and arg_529_1.time_ < var_532_7 + var_532_8 then
				local var_532_9 = Color.New(0, 0, 0)

				var_532_9.a = Mathf.Lerp(1, 0, (arg_529_1.time_ - var_532_7) / var_532_8)
				arg_529_1.mask_.color = var_532_9
			end

			if arg_529_1.time_ >= var_532_7 + var_532_8 and arg_529_1.time_ < var_532_7 + var_532_8 + arg_532_0 then
				local var_532_10 = Color.New(0, 0, 0)

				arg_529_1.mask_.enabled = false
				var_532_10.a = 0
				arg_529_1.mask_.color = var_532_10
			end

			if arg_529_1.frameCnt_ <= 1 then
				arg_529_1.dialog_:SetActive(false)
			end

			local var_532_11 = 4
			local var_532_12 = 0.775

			if 4 < arg_529_1.time_ and arg_529_1.time_ <= var_532_11 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0

				arg_529_1.dialog_:SetActive(true)

				arg_529_1.dialogCg_.alpha = 0

				local var_532_13 = LeanTween.value(arg_529_1.dialog_, 0, 1, 0.3)

				var_532_13:setOnUpdate(LuaHelper.FloatAction(function(arg_533_0)
					arg_529_1.dialogCg_.alpha = arg_533_0
				end))
				var_532_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_529_1.dialog_)
					var_532_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_529_1.duration_ = arg_529_1.duration_ + 0.3

				SetActive(arg_529_1.leftNameGo_, false)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_14 = arg_529_1:FormatText(arg_529_1:GetWordFromCfg(411331124).content)

				arg_529_1.text_.text = var_532_14

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_16 = 31 <= 0 and var_532_12 or var_532_12 * (utf8.len(var_532_14) / 31)

				if (31 <= 0 and var_532_12 or var_532_12 * (utf8.len(var_532_14) / 31)) > 0 and var_532_12 < var_532_16 then
					arg_529_1.talkMaxDuration = var_532_16
					var_532_11 = var_532_11 + 0.3

					if var_532_16 + var_532_11 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_16 + var_532_11
					end
				end

				arg_529_1.text_.text = var_532_14
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_17 = var_532_11 + 0.3
			local var_532_18 = math.max(var_532_12, arg_529_1.talkMaxDuration)

			if var_532_11 + 0.3 <= arg_529_1.time_ and arg_529_1.time_ < var_532_17 + var_532_18 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_17) / var_532_18

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_17 + var_532_18 and arg_529_1.time_ < var_532_17 + var_532_18 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play411331125 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 411331125
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play411331126(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = 1.375

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, false)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_1 = arg_535_1:FormatText(arg_535_1:GetWordFromCfg(411331125).content)

				arg_535_1.text_.text = var_538_1

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_3 = 55 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_1) / 55)

				if (55 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_1) / 55)) > 0 and var_538_0 < var_538_3 then
					arg_535_1.talkMaxDuration = var_538_3

					if var_538_3 + 0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_3 + 0
					end
				end

				arg_535_1.text_.text = var_538_1
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_4 = math.max(var_538_0, arg_535_1.talkMaxDuration)

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_4 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - 0) / var_538_4

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= 0 + var_538_4 and arg_535_1.time_ < 0 + var_538_4 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play411331126 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 411331126
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play411331127(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 1.3

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, false)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_1 = arg_539_1:FormatText(arg_539_1:GetWordFromCfg(411331126).content)

				arg_539_1.text_.text = var_542_1

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_3 = 52 <= 0 and var_542_0 or var_542_0 * (utf8.len(var_542_1) / 52)

				if (52 <= 0 and var_542_0 or var_542_0 * (utf8.len(var_542_1) / 52)) > 0 and var_542_0 < var_542_3 then
					arg_539_1.talkMaxDuration = var_542_3

					if var_542_3 + 0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_3 + 0
					end
				end

				arg_539_1.text_.text = var_542_1
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_4 = math.max(var_542_0, arg_539_1.talkMaxDuration)

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_4 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - 0) / var_542_4

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= 0 + var_542_4 and arg_539_1.time_ < 0 + var_542_4 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play411331127 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 411331127
		arg_543_1.duration_ = 5

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play411331128(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1.var_.moveOldPos4040ui_story = arg_543_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_546_0 = 0.001

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_0 then
				arg_543_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_543_1.time_ - 0) / var_546_0)
				arg_543_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_543_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_543_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_543_1.actors_["4040ui_story"].transform.position).z)
				arg_543_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_543_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_543_1.actors_["4040ui_story"].transform.localEulerAngles = arg_543_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_543_1.time_ >= 0 + var_546_0 and arg_543_1.time_ < 0 + var_546_0 + arg_546_0 then
				arg_543_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_543_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_543_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_543_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_543_1.actors_["4040ui_story"].transform.position).z)
				arg_543_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_543_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_543_1.actors_["4040ui_story"].transform.localEulerAngles = arg_543_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_546_1 = arg_543_1.actors_["4040ui_story"]

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 and not isNil(var_546_1) and arg_543_1.var_.characterEffect4040ui_story == nil then
				arg_543_1.var_.characterEffect4040ui_story = var_546_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_2 = 0.200000002980232

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_2 and not isNil(var_546_1) then
				if arg_543_1.var_.characterEffect4040ui_story and not isNil(var_546_1) then
					arg_543_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_543_1.time_ >= 0 + var_546_2 and arg_543_1.time_ < 0 + var_546_2 + arg_546_0 and not isNil(var_546_1) and arg_543_1.var_.characterEffect4040ui_story then
				arg_543_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_546_4 = 0
			local var_546_5 = 0.175

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_4 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_6 = arg_543_1:FormatText(arg_543_1:GetWordFromCfg(411331127).content)

				arg_543_1.text_.text = var_546_6

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_8 = 7 <= 0 and var_546_5 or var_546_5 * (utf8.len(var_546_6) / 7)

				if (7 <= 0 and var_546_5 or var_546_5 * (utf8.len(var_546_6) / 7)) > 0 and var_546_5 < var_546_8 then
					arg_543_1.talkMaxDuration = var_546_8

					if var_546_8 + var_546_4 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_8 + var_546_4
					end
				end

				arg_543_1.text_.text = var_546_6
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_9 = math.max(var_546_5, arg_543_1.talkMaxDuration)

			if var_546_4 <= arg_543_1.time_ and arg_543_1.time_ < var_546_4 + var_546_9 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_4) / var_546_9

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_4 + var_546_9 and arg_543_1.time_ < var_546_4 + var_546_9 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_543_1:InitPlayNodeList()
	end,
	Play411331128 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 411331128
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play411331129(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 and not isNil(arg_547_1.actors_["4040ui_story"]) and arg_547_1.var_.characterEffect4040ui_story == nil then
				arg_547_1.var_.characterEffect4040ui_story = arg_547_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_0 = 0.200000002980232

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_0 and not isNil(arg_547_1.actors_["4040ui_story"]) then
				if arg_547_1.var_.characterEffect4040ui_story and not isNil(arg_547_1.actors_["4040ui_story"]) then
					arg_547_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_547_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_547_1.time_ - 0) / var_550_0)
				end
			end

			if arg_547_1.time_ >= 0 + var_550_0 and arg_547_1.time_ < 0 + var_550_0 + arg_550_0 and not isNil(arg_547_1.actors_["4040ui_story"]) and arg_547_1.var_.characterEffect4040ui_story then
				arg_547_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_547_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_550_1 = 0
			local var_550_2 = 1.45

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, false)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_3 = arg_547_1:FormatText(arg_547_1:GetWordFromCfg(411331128).content)

				arg_547_1.text_.text = var_550_3

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_5 = 58 <= 0 and var_550_2 or var_550_2 * (utf8.len(var_550_3) / 58)

				if (58 <= 0 and var_550_2 or var_550_2 * (utf8.len(var_550_3) / 58)) > 0 and var_550_2 < var_550_5 then
					arg_547_1.talkMaxDuration = var_550_5

					if var_550_5 + var_550_1 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_5 + var_550_1
					end
				end

				arg_547_1.text_.text = var_550_3
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_6 = math.max(var_550_2, arg_547_1.talkMaxDuration)

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_6 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_1) / var_550_6

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_1 + var_550_6 and arg_547_1.time_ < var_550_1 + var_550_6 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play411331129 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 411331129
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play411331130(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0.55

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, true)
				arg_551_1.iconController_:SetSelectedState("hero")

				arg_551_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_551_1.callingController_:SetSelectedState("normal")

				arg_551_1.keyicon_.color = Color.New(1, 1, 1)
				arg_551_1.icon_.color = Color.New(1, 1, 1)

				local var_554_1 = arg_551_1:FormatText(arg_551_1:GetWordFromCfg(411331129).content)

				arg_551_1.text_.text = var_554_1

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_3 = 22 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 22)

				if (22 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 22)) > 0 and var_554_0 < var_554_3 then
					arg_551_1.talkMaxDuration = var_554_3

					if var_554_3 + 0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_3 + 0
					end
				end

				arg_551_1.text_.text = var_554_1
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_4 = math.max(var_554_0, arg_551_1.talkMaxDuration)

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_4 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - 0) / var_554_4

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= 0 + var_554_4 and arg_551_1.time_ < 0 + var_554_4 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play411331130 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 411331130
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play411331131(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1.var_.moveOldPos4040ui_story = arg_555_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_558_0 = 0.001

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_0 then
				arg_555_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_555_1.time_ - 0) / var_558_0)
				arg_555_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_555_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["4040ui_story"].transform.position).z)
				arg_555_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_555_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_555_1.actors_["4040ui_story"].transform.localEulerAngles = arg_555_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_555_1.time_ >= 0 + var_558_0 and arg_555_1.time_ < 0 + var_558_0 + arg_558_0 then
				arg_555_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_555_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_555_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["4040ui_story"].transform.position).z)
				arg_555_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_555_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_555_1.actors_["4040ui_story"].transform.localEulerAngles = arg_555_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_558_1 = arg_555_1.actors_["4040ui_story"]

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 and not isNil(var_558_1) and arg_555_1.var_.characterEffect4040ui_story == nil then
				arg_555_1.var_.characterEffect4040ui_story = var_558_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_558_2 = 0.200000002980232

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_2 and not isNil(var_558_1) then
				if arg_555_1.var_.characterEffect4040ui_story and not isNil(var_558_1) then
					arg_555_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_555_1.time_ >= 0 + var_558_2 and arg_555_1.time_ < 0 + var_558_2 + arg_558_0 and not isNil(var_558_1) and arg_555_1.var_.characterEffect4040ui_story then
				arg_555_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_558_4 = 0
			local var_558_5 = 0.225

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_4 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_6 = arg_555_1:FormatText(arg_555_1:GetWordFromCfg(411331130).content)

				arg_555_1.text_.text = var_558_6

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_8 = 9 <= 0 and var_558_5 or var_558_5 * (utf8.len(var_558_6) / 9)

				if (9 <= 0 and var_558_5 or var_558_5 * (utf8.len(var_558_6) / 9)) > 0 and var_558_5 < var_558_8 then
					arg_555_1.talkMaxDuration = var_558_8

					if var_558_8 + var_558_4 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_8 + var_558_4
					end
				end

				arg_555_1.text_.text = var_558_6
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_9 = math.max(var_558_5, arg_555_1.talkMaxDuration)

			if var_558_4 <= arg_555_1.time_ and arg_555_1.time_ < var_558_4 + var_558_9 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_4) / var_558_9

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_4 + var_558_9 and arg_555_1.time_ < var_558_4 + var_558_9 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_555_1:InitPlayNodeList()
	end,
	Play411331131 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 411331131
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play411331132(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 and not isNil(arg_559_1.actors_["4040ui_story"]) and arg_559_1.var_.characterEffect4040ui_story == nil then
				arg_559_1.var_.characterEffect4040ui_story = arg_559_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_562_0 = 0.200000002980232

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_0 and not isNil(arg_559_1.actors_["4040ui_story"]) then
				if arg_559_1.var_.characterEffect4040ui_story and not isNil(arg_559_1.actors_["4040ui_story"]) then
					arg_559_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_559_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_559_1.time_ - 0) / var_562_0)
				end
			end

			if arg_559_1.time_ >= 0 + var_562_0 and arg_559_1.time_ < 0 + var_562_0 + arg_562_0 and not isNil(arg_559_1.actors_["4040ui_story"]) and arg_559_1.var_.characterEffect4040ui_story then
				arg_559_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_559_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_562_1 = 0
			local var_562_2 = 0.875

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_1 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, false)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_3 = arg_559_1:FormatText(arg_559_1:GetWordFromCfg(411331131).content)

				arg_559_1.text_.text = var_562_3

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_5 = 35 <= 0 and var_562_2 or var_562_2 * (utf8.len(var_562_3) / 35)

				if (35 <= 0 and var_562_2 or var_562_2 * (utf8.len(var_562_3) / 35)) > 0 and var_562_2 < var_562_5 then
					arg_559_1.talkMaxDuration = var_562_5

					if var_562_5 + var_562_1 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_5 + var_562_1
					end
				end

				arg_559_1.text_.text = var_562_3
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_6 = math.max(var_562_2, arg_559_1.talkMaxDuration)

			if var_562_1 <= arg_559_1.time_ and arg_559_1.time_ < var_562_1 + var_562_6 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_1) / var_562_6

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_1 + var_562_6 and arg_559_1.time_ < var_562_1 + var_562_6 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play411331132 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 411331132
		arg_563_1.duration_ = 5

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play411331133(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = 0.375

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, true)
				arg_563_1.iconController_:SetSelectedState("hero")

				arg_563_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_563_1.callingController_:SetSelectedState("normal")

				arg_563_1.keyicon_.color = Color.New(1, 1, 1)
				arg_563_1.icon_.color = Color.New(1, 1, 1)

				local var_566_1 = arg_563_1:FormatText(arg_563_1:GetWordFromCfg(411331132).content)

				arg_563_1.text_.text = var_566_1

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_3 = 15 <= 0 and var_566_0 or var_566_0 * (utf8.len(var_566_1) / 15)

				if (15 <= 0 and var_566_0 or var_566_0 * (utf8.len(var_566_1) / 15)) > 0 and var_566_0 < var_566_3 then
					arg_563_1.talkMaxDuration = var_566_3

					if var_566_3 + 0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_3 + 0
					end
				end

				arg_563_1.text_.text = var_566_1
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)
				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_4 = math.max(var_566_0, arg_563_1.talkMaxDuration)

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_4 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - 0) / var_566_4

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= 0 + var_566_4 and arg_563_1.time_ < 0 + var_566_4 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play411331133 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 411331133
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play411331134(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = 1.15

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				arg_567_1.leftNameTxt_.text = arg_567_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, true)
				arg_567_1.iconController_:SetSelectedState("hero")

				arg_567_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_567_1.callingController_:SetSelectedState("normal")

				arg_567_1.keyicon_.color = Color.New(1, 1, 1)
				arg_567_1.icon_.color = Color.New(1, 1, 1)

				local var_570_1 = arg_567_1:FormatText(arg_567_1:GetWordFromCfg(411331133).content)

				arg_567_1.text_.text = var_570_1

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_3 = 46 <= 0 and var_570_0 or var_570_0 * (utf8.len(var_570_1) / 46)

				if (46 <= 0 and var_570_0 or var_570_0 * (utf8.len(var_570_1) / 46)) > 0 and var_570_0 < var_570_3 then
					arg_567_1.talkMaxDuration = var_570_3

					if var_570_3 + 0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_3 + 0
					end
				end

				arg_567_1.text_.text = var_570_1
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_4 = math.max(var_570_0, arg_567_1.talkMaxDuration)

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_4 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - 0) / var_570_4

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= 0 + var_570_4 and arg_567_1.time_ < 0 + var_570_4 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play411331134 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 411331134
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play411331135(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = 1.05

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				arg_571_1.leftNameTxt_.text = arg_571_1:FormatText(StoryNameCfg[904].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, true)
				arg_571_1.iconController_:SetSelectedState("hero")

				arg_571_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_571_1.callingController_:SetSelectedState("normal")

				arg_571_1.keyicon_.color = Color.New(1, 1, 1)
				arg_571_1.icon_.color = Color.New(1, 1, 1)

				local var_574_1 = arg_571_1:FormatText(arg_571_1:GetWordFromCfg(411331134).content)

				arg_571_1.text_.text = var_574_1

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_3 = 42 <= 0 and var_574_0 or var_574_0 * (utf8.len(var_574_1) / 42)

				if (42 <= 0 and var_574_0 or var_574_0 * (utf8.len(var_574_1) / 42)) > 0 and var_574_0 < var_574_3 then
					arg_571_1.talkMaxDuration = var_574_3

					if var_574_3 + 0 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_3 + 0
					end
				end

				arg_571_1.text_.text = var_574_1
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)
				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_4 = math.max(var_574_0, arg_571_1.talkMaxDuration)

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_4 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - 0) / var_574_4

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= 0 + var_574_4 and arg_571_1.time_ < 0 + var_574_4 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play411331135 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 411331135
		arg_575_1.duration_ = 5

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play411331136(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 1.725

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, false)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_1 = arg_575_1:FormatText(arg_575_1:GetWordFromCfg(411331135).content)

				arg_575_1.text_.text = var_578_1

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_3 = 69 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_1) / 69)

				if (69 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_1) / 69)) > 0 and var_578_0 < var_578_3 then
					arg_575_1.talkMaxDuration = var_578_3

					if var_578_3 + 0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_3 + 0
					end
				end

				arg_575_1.text_.text = var_578_1
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)
				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_4 = math.max(var_578_0, arg_575_1.talkMaxDuration)

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_4 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - 0) / var_578_4

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= 0 + var_578_4 and arg_575_1.time_ < 0 + var_578_4 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play411331136 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 411331136
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play411331137(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			if arg_579_1.bgs_.ML0107 == nil then
				local var_582_0 = Object.Instantiate(arg_579_1.paintGo_)

				var_582_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ML0107")
				var_582_0.name = "ML0107"
				var_582_0.transform.parent = arg_579_1.stage_.transform
				var_582_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_579_1.bgs_.ML0107 = var_582_0
			end

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				local var_582_1 = arg_579_1.bgs_.ML0107

				arg_579_1.bgs_.ML0107.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_582_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_582_2 = var_582_1:GetComponent("SpriteRenderer")

				if var_582_2 and var_582_2.sprite then
					local var_582_3 = 2 * (var_582_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_582_1.transform.localScale = Vector3.New(var_582_3 / var_582_2.sprite.bounds.size.y < var_582_3 * manager.ui.mainCameraCom_.aspect / var_582_2.sprite.bounds.size.x and var_582_3 * manager.ui.mainCameraCom_.aspect / var_582_2.sprite.bounds.size.x or var_582_3 / var_582_2.sprite.bounds.size.y, var_582_3 / var_582_2.sprite.bounds.size.y < var_582_3 * manager.ui.mainCameraCom_.aspect / var_582_2.sprite.bounds.size.x and var_582_3 * manager.ui.mainCameraCom_.aspect / var_582_2.sprite.bounds.size.x or var_582_3 / var_582_2.sprite.bounds.size.y, 0)
				end

				for iter_582_0, iter_582_1 in pairs(arg_579_1.bgs_) do
					if iter_582_0 ~= "ML0107" then
						iter_582_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_582_4 = 0

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_4 + arg_582_0 then
				arg_579_1.mask_.enabled = true
				arg_579_1.mask_.raycastTarget = true

				arg_579_1:SetGaussion(false)
			end

			local var_582_5 = 2

			if var_582_4 <= arg_579_1.time_ and arg_579_1.time_ < var_582_4 + var_582_5 then
				local var_582_6 = Color.New(1, 1, 1)

				var_582_6.a = Mathf.Lerp(1, 0, (arg_579_1.time_ - var_582_4) / var_582_5)
				arg_579_1.mask_.color = var_582_6
			end

			if arg_579_1.time_ >= var_582_4 + var_582_5 and arg_579_1.time_ < var_582_4 + var_582_5 + arg_582_0 then
				local var_582_7 = Color.New(1, 1, 1)

				arg_579_1.mask_.enabled = false
				var_582_7.a = 0
				arg_579_1.mask_.color = var_582_7
			end

			local var_582_8 = arg_579_1.actors_["4040ui_story"].transform

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1.var_.moveOldPos4040ui_story = var_582_8.localPosition
			end

			local var_582_9 = 0.001

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_9 then
				var_582_8.localPosition = Vector3.Lerp(arg_579_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_579_1.time_ - 0) / var_582_9)
				var_582_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_582_8.position).x, (manager.ui.mainCamera.transform.position - var_582_8.position).y, (manager.ui.mainCamera.transform.position - var_582_8.position).z)
				var_582_8.localEulerAngles.z = 0
				var_582_8.localEulerAngles.x = 0
				var_582_8.localEulerAngles = var_582_8.localEulerAngles
			end

			if arg_579_1.time_ >= 0 + var_582_9 and arg_579_1.time_ < 0 + var_582_9 + arg_582_0 then
				var_582_8.localPosition = Vector3.New(0, 100, 0)
				var_582_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_582_8.position).x, (manager.ui.mainCamera.transform.position - var_582_8.position).y, (manager.ui.mainCamera.transform.position - var_582_8.position).z)
				var_582_8.localEulerAngles.z = 0
				var_582_8.localEulerAngles.x = 0
				var_582_8.localEulerAngles = var_582_8.localEulerAngles
			end

			local var_582_10 = arg_579_1.actors_["4040ui_story"]

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 and not isNil(var_582_10) and arg_579_1.var_.characterEffect4040ui_story == nil then
				arg_579_1.var_.characterEffect4040ui_story = var_582_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_582_11 = 0.034000001847744

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_11 and not isNil(var_582_10) then
				if arg_579_1.var_.characterEffect4040ui_story and not isNil(var_582_10) then
					arg_579_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_579_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_579_1.time_ - 0) / var_582_11)
				end
			end

			if arg_579_1.time_ >= 0 + var_582_11 and arg_579_1.time_ < 0 + var_582_11 + arg_582_0 and not isNil(var_582_10) and arg_579_1.var_.characterEffect4040ui_story then
				arg_579_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_579_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_582_12 = arg_579_1.bgs_.ML0107.transform

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1.var_.moveOldPosML0107 = var_582_12.localPosition
			end

			local var_582_13 = 0.1

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_13 then
				var_582_12.localPosition = Vector3.Lerp(arg_579_1.var_.moveOldPosML0107, Vector3.New(-1.08, 0.41, 2.77), (arg_579_1.time_ - 0) / var_582_13)
			end

			if arg_579_1.time_ >= 0 + var_582_13 and arg_579_1.time_ < 0 + var_582_13 + arg_582_0 then
				var_582_12.localPosition = Vector3.New(-1.08, 0.41, 2.77)
			end

			local var_582_14 = arg_579_1.bgs_.ML0107.transform

			if 0.1 < arg_579_1.time_ and arg_579_1.time_ <= 0.1 + arg_582_0 then
				arg_579_1.var_.moveOldPosML0107 = var_582_14.localPosition
			end

			local var_582_15 = 4.4

			if 0.1 <= arg_579_1.time_ and arg_579_1.time_ < 0.1 + var_582_15 then
				var_582_14.localPosition = Vector3.Lerp(arg_579_1.var_.moveOldPosML0107, Vector3.New(0, 1, 10), (arg_579_1.time_ - 0.1) / var_582_15)
			end

			if arg_579_1.time_ >= 0.1 + var_582_15 and arg_579_1.time_ < 0.1 + var_582_15 + arg_582_0 then
				var_582_14.localPosition = Vector3.New(0, 1, 10)
			end

			local var_582_16 = 1.999999999999

			if 1.999999999999 < arg_579_1.time_ and arg_579_1.time_ <= var_582_16 + arg_582_0 then
				arg_579_1.allBtn_.enabled = false
			end

			if arg_579_1.time_ >= var_582_16 + 2.500000000001 and arg_579_1.time_ < var_582_16 + 2.500000000001 + arg_582_0 then
				arg_579_1.allBtn_.enabled = true
			end

			local var_582_17 = 0
			local var_582_18 = 0.5

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_17 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0

				arg_579_1.dialog_:SetActive(true)

				arg_579_1.dialogCg_.alpha = 0

				local var_582_19 = LeanTween.value(arg_579_1.dialog_, 0, 1, 0.3)

				var_582_19:setOnUpdate(LuaHelper.FloatAction(function(arg_583_0)
					arg_579_1.dialogCg_.alpha = arg_583_0
				end))
				var_582_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_579_1.dialog_)
					var_582_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_579_1.duration_ = arg_579_1.duration_ + 0.3

				SetActive(arg_579_1.leftNameGo_, false)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_20 = arg_579_1:FormatText(arg_579_1:GetWordFromCfg(411331136).content)

				arg_579_1.text_.text = var_582_20

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_22 = 20 <= 0 and var_582_18 or var_582_18 * (utf8.len(var_582_20) / 20)

				if (20 <= 0 and var_582_18 or var_582_18 * (utf8.len(var_582_20) / 20)) > 0 and var_582_18 < var_582_22 then
					arg_579_1.talkMaxDuration = var_582_22
					var_582_17 = var_582_17 + 0.3

					if var_582_22 + var_582_17 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_22 + var_582_17
					end
				end

				arg_579_1.text_.text = var_582_20
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_23 = var_582_17 + 0.3
			local var_582_24 = math.max(var_582_18, arg_579_1.talkMaxDuration)

			if var_582_17 + 0.3 <= arg_579_1.time_ and arg_579_1.time_ < var_582_23 + var_582_24 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_23) / var_582_24

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_23 + var_582_24 and arg_579_1.time_ < var_582_23 + var_582_24 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "ML0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.4,
				className = "StoryMoveNode",
				startTime = 0.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_579_1:InitPlayNodeList()
	end,
	Play411331137 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 411331137
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play411331138(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0.575

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, false)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_1 = arg_585_1:FormatText(arg_585_1:GetWordFromCfg(411331137).content)

				arg_585_1.text_.text = var_588_1

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_3 = 23 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_1) / 23)

				if (23 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_1) / 23)) > 0 and var_588_0 < var_588_3 then
					arg_585_1.talkMaxDuration = var_588_3

					if var_588_3 + 0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_3 + 0
					end
				end

				arg_585_1.text_.text = var_588_1
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_4 = math.max(var_588_0, arg_585_1.talkMaxDuration)

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_4 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - 0) / var_588_4

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= 0 + var_588_4 and arg_585_1.time_ < 0 + var_588_4 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play411331138 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 411331138
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play411331139(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = 1.375

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, false)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_1 = arg_589_1:FormatText(arg_589_1:GetWordFromCfg(411331138).content)

				arg_589_1.text_.text = var_592_1

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_3 = 55 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_1) / 55)

				if (55 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_1) / 55)) > 0 and var_592_0 < var_592_3 then
					arg_589_1.talkMaxDuration = var_592_3

					if var_592_3 + 0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_3 + 0
					end
				end

				arg_589_1.text_.text = var_592_1
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_4 = math.max(var_592_0, arg_589_1.talkMaxDuration)

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_4 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - 0) / var_592_4

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= 0 + var_592_4 and arg_589_1.time_ < 0 + var_592_4 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play411331139 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 411331139
		arg_593_1.duration_ = 5

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play411331140(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 0.15

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				arg_593_1.leftNameTxt_.text = arg_593_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_1 = arg_593_1:FormatText(arg_593_1:GetWordFromCfg(411331139).content)

				arg_593_1.text_.text = var_596_1

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_3 = 6 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_1) / 6)

				if (6 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_1) / 6)) > 0 and var_596_0 < var_596_3 then
					arg_593_1.talkMaxDuration = var_596_3

					if var_596_3 + 0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_3 + 0
					end
				end

				arg_593_1.text_.text = var_596_1
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)
				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_4 = math.max(var_596_0, arg_593_1.talkMaxDuration)

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_4 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - 0) / var_596_4

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= 0 + var_596_4 and arg_593_1.time_ < 0 + var_596_4 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play411331140 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 411331140
		arg_597_1.duration_ = 5

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play411331141(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = 1.325

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, false)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_1 = arg_597_1:FormatText(arg_597_1:GetWordFromCfg(411331140).content)

				arg_597_1.text_.text = var_600_1

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_3 = 53 <= 0 and var_600_0 or var_600_0 * (utf8.len(var_600_1) / 53)

				if (53 <= 0 and var_600_0 or var_600_0 * (utf8.len(var_600_1) / 53)) > 0 and var_600_0 < var_600_3 then
					arg_597_1.talkMaxDuration = var_600_3

					if var_600_3 + 0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_3 + 0
					end
				end

				arg_597_1.text_.text = var_600_1
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)
				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_4 = math.max(var_600_0, arg_597_1.talkMaxDuration)

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_4 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - 0) / var_600_4

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= 0 + var_600_4 and arg_597_1.time_ < 0 + var_600_4 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play411331141 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 411331141
		arg_601_1.duration_ = 5

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play411331142(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = 0.3

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				arg_601_1.leftNameTxt_.text = arg_601_1:FormatText(StoryNameCfg[906].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, true)
				arg_601_1.iconController_:SetSelectedState("hero")

				arg_601_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_601_1.callingController_:SetSelectedState("normal")

				arg_601_1.keyicon_.color = Color.New(1, 1, 1)
				arg_601_1.icon_.color = Color.New(1, 1, 1)

				local var_604_1 = arg_601_1:FormatText(arg_601_1:GetWordFromCfg(411331141).content)

				arg_601_1.text_.text = var_604_1

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_3 = 12 <= 0 and var_604_0 or var_604_0 * (utf8.len(var_604_1) / 12)

				if (12 <= 0 and var_604_0 or var_604_0 * (utf8.len(var_604_1) / 12)) > 0 and var_604_0 < var_604_3 then
					arg_601_1.talkMaxDuration = var_604_3

					if var_604_3 + 0 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_3 + 0
					end
				end

				arg_601_1.text_.text = var_604_1
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_4 = math.max(var_604_0, arg_601_1.talkMaxDuration)

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_4 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - 0) / var_604_4

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= 0 + var_604_4 and arg_601_1.time_ < 0 + var_604_4 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play411331142 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 411331142
		arg_605_1.duration_ = 5

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play411331143(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 0.725

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, false)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_1 = arg_605_1:FormatText(arg_605_1:GetWordFromCfg(411331142).content)

				arg_605_1.text_.text = var_608_1

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_3 = 29 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_1) / 29)

				if (29 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_1) / 29)) > 0 and var_608_0 < var_608_3 then
					arg_605_1.talkMaxDuration = var_608_3

					if var_608_3 + 0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_3 + 0
					end
				end

				arg_605_1.text_.text = var_608_1
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)
				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_4 = math.max(var_608_0, arg_605_1.talkMaxDuration)

			if 0 <= arg_605_1.time_ and arg_605_1.time_ < 0 + var_608_4 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - 0) / var_608_4

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= 0 + var_608_4 and arg_605_1.time_ < 0 + var_608_4 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play411331143 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 411331143
		arg_609_1.duration_ = 5

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play411331144(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = 0.85

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, false)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_1 = arg_609_1:FormatText(arg_609_1:GetWordFromCfg(411331143).content)

				arg_609_1.text_.text = var_612_1

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_3 = 34 <= 0 and var_612_0 or var_612_0 * (utf8.len(var_612_1) / 34)

				if (34 <= 0 and var_612_0 or var_612_0 * (utf8.len(var_612_1) / 34)) > 0 and var_612_0 < var_612_3 then
					arg_609_1.talkMaxDuration = var_612_3

					if var_612_3 + 0 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_3 + 0
					end
				end

				arg_609_1.text_.text = var_612_1
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)
				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_4 = math.max(var_612_0, arg_609_1.talkMaxDuration)

			if 0 <= arg_609_1.time_ and arg_609_1.time_ < 0 + var_612_4 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - 0) / var_612_4

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= 0 + var_612_4 and arg_609_1.time_ < 0 + var_612_4 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play411331144 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 411331144
		arg_613_1.duration_ = 5

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play411331145(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = 0.425

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				arg_613_1.leftNameTxt_.text = arg_613_1:FormatText(StoryNameCfg[673].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, true)
				arg_613_1.iconController_:SetSelectedState("hero")

				arg_613_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_613_1.callingController_:SetSelectedState("normal")

				arg_613_1.keyicon_.color = Color.New(1, 1, 1)
				arg_613_1.icon_.color = Color.New(1, 1, 1)

				local var_616_1 = arg_613_1:FormatText(arg_613_1:GetWordFromCfg(411331144).content)

				arg_613_1.text_.text = var_616_1

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_3 = 17 <= 0 and var_616_0 or var_616_0 * (utf8.len(var_616_1) / 17)

				if (17 <= 0 and var_616_0 or var_616_0 * (utf8.len(var_616_1) / 17)) > 0 and var_616_0 < var_616_3 then
					arg_613_1.talkMaxDuration = var_616_3

					if var_616_3 + 0 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_3 + 0
					end
				end

				arg_613_1.text_.text = var_616_1
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)
				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_4 = math.max(var_616_0, arg_613_1.talkMaxDuration)

			if 0 <= arg_613_1.time_ and arg_613_1.time_ < 0 + var_616_4 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - 0) / var_616_4

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= 0 + var_616_4 and arg_613_1.time_ < 0 + var_616_4 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play411331145 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 411331145
		arg_617_1.duration_ = 2

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play411331146(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				local var_620_0 = arg_617_1.bgs_.STblack

				arg_617_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_620_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_620_1 = var_620_0:GetComponent("SpriteRenderer")

				if var_620_1 and var_620_1.sprite then
					local var_620_2 = 2 * (var_620_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_620_0.transform.localScale = Vector3.New(var_620_2 / var_620_1.sprite.bounds.size.y < var_620_2 * manager.ui.mainCameraCom_.aspect / var_620_1.sprite.bounds.size.x and var_620_2 * manager.ui.mainCameraCom_.aspect / var_620_1.sprite.bounds.size.x or var_620_2 / var_620_1.sprite.bounds.size.y, var_620_2 / var_620_1.sprite.bounds.size.y < var_620_2 * manager.ui.mainCameraCom_.aspect / var_620_1.sprite.bounds.size.x and var_620_2 * manager.ui.mainCameraCom_.aspect / var_620_1.sprite.bounds.size.x or var_620_2 / var_620_1.sprite.bounds.size.y, 0)
				end

				for iter_620_0, iter_620_1 in pairs(arg_617_1.bgs_) do
					if iter_620_0 ~= "STblack" then
						iter_620_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1.fswbg_:SetActive(true)
				arg_617_1.dialog_:SetActive(false)

				arg_617_1.fswtw_.percent = 0
				arg_617_1.fswt_.text = arg_617_1:FormatText(arg_617_1:GetWordFromCfg(411331145).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.fswt_)

				arg_617_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_617_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_617_1.fswtw_:SetDirty()

				arg_617_1.typewritterCharCountI18N = 0

				SetActive(arg_617_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_617_1:ShowNextGo(false)
			end

			local var_620_3 = 0.0166666666666667

			if 0.0166666666666667 < arg_617_1.time_ and arg_617_1.time_ <= var_620_3 + arg_620_0 then
				arg_617_1.var_.oldValueTypewriter = arg_617_1.fswtw_.percent

				SetActive(arg_617_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_617_1:ShowNextGo(false)
			end

			local var_620_4 = 9
			local var_620_5 = 0.6
			local var_620_6, var_620_7 = arg_617_1:GetPercentByPara(arg_617_1:FormatText(arg_617_1:GetWordFromCfg(411331145).content), 1)

			if var_620_3 < arg_617_1.time_ and arg_617_1.time_ <= var_620_3 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0

				local var_620_8 = var_620_4 <= 0 and var_620_5 or var_620_5 * ((var_620_7 - arg_617_1.typewritterCharCountI18N) / var_620_4)

				if (var_620_4 <= 0 and var_620_5 or var_620_5 * ((var_620_7 - arg_617_1.typewritterCharCountI18N) / var_620_4)) > 0 and var_620_5 < var_620_8 then
					arg_617_1.talkMaxDuration = var_620_8

					if var_620_8 + var_620_3 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_8 + var_620_3
					end
				end
			end

			local var_620_9 = math.max(0.6, arg_617_1.talkMaxDuration)

			if var_620_3 <= arg_617_1.time_ and arg_617_1.time_ < var_620_3 + var_620_9 then
				arg_617_1.fswtw_.percent = Mathf.Lerp(arg_617_1.var_.oldValueTypewriter, var_620_6, (arg_617_1.time_ - var_620_3) / var_620_9)
				arg_617_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_617_1.fswtw_:SetDirty()
			end

			if arg_617_1.time_ >= var_620_3 + var_620_9 and arg_617_1.time_ < var_620_3 + var_620_9 + arg_620_0 then
				arg_617_1.fswtw_.percent = var_620_6

				arg_617_1.fswtw_:SetDirty()
				arg_617_1:ShowNextGo(true)

				arg_617_1.typewritterCharCountI18N = var_620_7
			end

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				local var_620_10 = arg_617_1.fswbg_.transform:Find("textbox/adapt/content") or arg_617_1.fswbg_.transform:Find("textbox/content")
				local var_620_11 = arg_617_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_620_12 = var_620_10:GetComponent("RectTransform")

				var_620_10:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_620_12.offsetMin = Vector2.New(0, 0)
				var_620_12.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play411331146 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 411331146
		arg_621_1.duration_ = 5

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play411331147(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 then
				arg_621_1.fswbg_:SetActive(false)
				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_621_1:ShowNextGo(false)
			end

			local var_624_0 = 0
			local var_624_1 = 0.3

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= var_624_0 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0

				arg_621_1.dialog_:SetActive(true)

				arg_621_1.dialogCg_.alpha = 0

				local var_624_2 = LeanTween.value(arg_621_1.dialog_, 0, 1, 0.3)

				var_624_2:setOnUpdate(LuaHelper.FloatAction(function(arg_625_0)
					arg_621_1.dialogCg_.alpha = arg_625_0
				end))
				var_624_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_621_1.dialog_)
					var_624_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_621_1.duration_ = arg_621_1.duration_ + 0.3

				SetActive(arg_621_1.leftNameGo_, true)

				arg_621_1.leftNameTxt_.text = arg_621_1:FormatText(StoryNameCfg[673].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, true)
				arg_621_1.iconController_:SetSelectedState("hero")

				arg_621_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_621_1.callingController_:SetSelectedState("normal")

				arg_621_1.keyicon_.color = Color.New(1, 1, 1)
				arg_621_1.icon_.color = Color.New(1, 1, 1)

				local var_624_3 = arg_621_1:FormatText(arg_621_1:GetWordFromCfg(411331146).content)

				arg_621_1.text_.text = var_624_3

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_5 = 12 <= 0 and var_624_1 or var_624_1 * (utf8.len(var_624_3) / 12)

				if (12 <= 0 and var_624_1 or var_624_1 * (utf8.len(var_624_3) / 12)) > 0 and var_624_1 < var_624_5 then
					arg_621_1.talkMaxDuration = var_624_5
					var_624_0 = var_624_0 + 0.3

					if var_624_5 + var_624_0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_5 + var_624_0
					end
				end

				arg_621_1.text_.text = var_624_3
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)
				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_6 = var_624_0 + 0.3
			local var_624_7 = math.max(var_624_1, arg_621_1.talkMaxDuration)

			if var_624_0 + 0.3 <= arg_621_1.time_ and arg_621_1.time_ < var_624_6 + var_624_7 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_6) / var_624_7

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_6 + var_624_7 and arg_621_1.time_ < var_624_6 + var_624_7 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play411331147 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 411331147
		arg_627_1.duration_ = 1

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play411331148(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 then
				arg_627_1.fswbg_:SetActive(true)
				arg_627_1.dialog_:SetActive(false)

				arg_627_1.fswtw_.percent = 0
				arg_627_1.fswt_.text = arg_627_1:FormatText(arg_627_1:GetWordFromCfg(411331147).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.fswt_)

				arg_627_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_627_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_627_1.fswtw_:SetDirty()

				arg_627_1.typewritterCharCountI18N = 0

				SetActive(arg_627_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_627_1:ShowNextGo(false)
			end

			local var_630_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_627_1.time_ and arg_627_1.time_ <= var_630_0 + arg_630_0 then
				arg_627_1.var_.oldValueTypewriter = arg_627_1.fswtw_.percent

				SetActive(arg_627_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_627_1:ShowNextGo(false)
			end

			local var_630_1 = 10
			local var_630_2 = 0.666666666666667
			local var_630_3, var_630_4 = arg_627_1:GetPercentByPara(arg_627_1:FormatText(arg_627_1:GetWordFromCfg(411331147).content), 1)

			if var_630_0 < arg_627_1.time_ and arg_627_1.time_ <= var_630_0 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0

				local var_630_5 = var_630_1 <= 0 and var_630_2 or var_630_2 * ((var_630_4 - arg_627_1.typewritterCharCountI18N) / var_630_1)

				if (var_630_1 <= 0 and var_630_2 or var_630_2 * ((var_630_4 - arg_627_1.typewritterCharCountI18N) / var_630_1)) > 0 and var_630_2 < var_630_5 then
					arg_627_1.talkMaxDuration = var_630_5

					if var_630_5 + var_630_0 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_5 + var_630_0
					end
				end
			end

			local var_630_6 = math.max(0.666666666666667, arg_627_1.talkMaxDuration)

			if var_630_0 <= arg_627_1.time_ and arg_627_1.time_ < var_630_0 + var_630_6 then
				arg_627_1.fswtw_.percent = Mathf.Lerp(arg_627_1.var_.oldValueTypewriter, var_630_3, (arg_627_1.time_ - var_630_0) / var_630_6)
				arg_627_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_627_1.fswtw_:SetDirty()
			end

			if arg_627_1.time_ >= var_630_0 + var_630_6 and arg_627_1.time_ < var_630_0 + var_630_6 + arg_630_0 then
				arg_627_1.fswtw_.percent = var_630_3

				arg_627_1.fswtw_:SetDirty()
				arg_627_1:ShowNextGo(true)

				arg_627_1.typewritterCharCountI18N = var_630_4
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play411331148 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 411331148
		arg_631_1.duration_ = 5

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play411331149(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 then
				arg_631_1.fswbg_:SetActive(false)
				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_631_1:ShowNextGo(false)
			end

			local var_634_0 = 0
			local var_634_1 = 0.3

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_0 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0

				arg_631_1.dialog_:SetActive(true)

				arg_631_1.dialogCg_.alpha = 0

				local var_634_2 = LeanTween.value(arg_631_1.dialog_, 0, 1, 0.3)

				var_634_2:setOnUpdate(LuaHelper.FloatAction(function(arg_635_0)
					arg_631_1.dialogCg_.alpha = arg_635_0
				end))
				var_634_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_631_1.dialog_)
					var_634_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_631_1.duration_ = arg_631_1.duration_ + 0.3

				SetActive(arg_631_1.leftNameGo_, true)

				arg_631_1.leftNameTxt_.text = arg_631_1:FormatText(StoryNameCfg[673].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, true)
				arg_631_1.iconController_:SetSelectedState("hero")

				arg_631_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_631_1.callingController_:SetSelectedState("normal")

				arg_631_1.keyicon_.color = Color.New(1, 1, 1)
				arg_631_1.icon_.color = Color.New(1, 1, 1)

				local var_634_3 = arg_631_1:FormatText(arg_631_1:GetWordFromCfg(411331148).content)

				arg_631_1.text_.text = var_634_3

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_5 = 12 <= 0 and var_634_1 or var_634_1 * (utf8.len(var_634_3) / 12)

				if (12 <= 0 and var_634_1 or var_634_1 * (utf8.len(var_634_3) / 12)) > 0 and var_634_1 < var_634_5 then
					arg_631_1.talkMaxDuration = var_634_5
					var_634_0 = var_634_0 + 0.3

					if var_634_5 + var_634_0 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_5 + var_634_0
					end
				end

				arg_631_1.text_.text = var_634_3
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)
				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_6 = var_634_0 + 0.3
			local var_634_7 = math.max(var_634_1, arg_631_1.talkMaxDuration)

			if var_634_0 + 0.3 <= arg_631_1.time_ and arg_631_1.time_ < var_634_6 + var_634_7 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_6) / var_634_7

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_6 + var_634_7 and arg_631_1.time_ < var_634_6 + var_634_7 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play411331149 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 411331149
		arg_637_1.duration_ = 8.19

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play411331150(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			if 1.96666666666667 < arg_637_1.time_ and arg_637_1.time_ <= 1.96666666666667 + arg_640_0 then
				local var_640_0 = arg_637_1.bgs_.ML0107

				arg_637_1.bgs_.ML0107.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_640_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_640_1 = var_640_0:GetComponent("SpriteRenderer")

				if var_640_1 and var_640_1.sprite then
					local var_640_2 = 2 * (var_640_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_640_0.transform.localScale = Vector3.New(var_640_2 / var_640_1.sprite.bounds.size.y < var_640_2 * manager.ui.mainCameraCom_.aspect / var_640_1.sprite.bounds.size.x and var_640_2 * manager.ui.mainCameraCom_.aspect / var_640_1.sprite.bounds.size.x or var_640_2 / var_640_1.sprite.bounds.size.y, var_640_2 / var_640_1.sprite.bounds.size.y < var_640_2 * manager.ui.mainCameraCom_.aspect / var_640_1.sprite.bounds.size.x and var_640_2 * manager.ui.mainCameraCom_.aspect / var_640_1.sprite.bounds.size.x or var_640_2 / var_640_1.sprite.bounds.size.y, 0)
				end

				for iter_640_0, iter_640_1 in pairs(arg_637_1.bgs_) do
					if iter_640_0 ~= "ML0107" then
						iter_640_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_640_3 = 0

			if 0 < arg_637_1.time_ and arg_637_1.time_ <= var_640_3 + arg_640_0 then
				arg_637_1.mask_.enabled = true
				arg_637_1.mask_.raycastTarget = true

				arg_637_1:SetGaussion(false)
			end

			local var_640_4 = 2

			if var_640_3 <= arg_637_1.time_ and arg_637_1.time_ < var_640_3 + var_640_4 then
				local var_640_5 = Color.New(1, 1, 1)

				var_640_5.a = Mathf.Lerp(1, 0, (arg_637_1.time_ - var_640_3) / var_640_4)
				arg_637_1.mask_.color = var_640_5
			end

			if arg_637_1.time_ >= var_640_3 + var_640_4 and arg_637_1.time_ < var_640_3 + var_640_4 + arg_640_0 then
				local var_640_6 = Color.New(1, 1, 1)

				arg_637_1.mask_.enabled = false
				var_640_6.a = 0
				arg_637_1.mask_.color = var_640_6
			end

			local var_640_7 = 3.19166666666667
			local var_640_8 = 0.075

			if 3.19166666666667 < arg_637_1.time_ and arg_637_1.time_ <= var_640_7 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, true)

				arg_637_1.leftNameTxt_.text = arg_637_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_637_1.leftNameTxt_.transform)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1.leftNameTxt_.text)
				SetActive(arg_637_1.iconTrs_.gameObject, false)
				arg_637_1.callingController_:SetSelectedState("normal")

				local var_640_9 = arg_637_1:FormatText(arg_637_1:GetWordFromCfg(411331149).content)

				arg_637_1.text_.text = var_640_9

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_11 = 3 <= 0 and var_640_8 or var_640_8 * (utf8.len(var_640_9) / 3)

				if (3 <= 0 and var_640_8 or var_640_8 * (utf8.len(var_640_9) / 3)) > 0 and var_640_8 < var_640_11 then
					arg_637_1.talkMaxDuration = var_640_11

					if var_640_11 + var_640_7 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_11 + var_640_7
					end
				end

				arg_637_1.text_.text = var_640_9
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)
				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_12 = math.max(var_640_8, arg_637_1.talkMaxDuration)

			if var_640_7 <= arg_637_1.time_ and arg_637_1.time_ < var_640_7 + var_640_12 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - var_640_7) / var_640_12

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= var_640_7 + var_640_12 and arg_637_1.time_ < var_640_7 + var_640_12 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {}

		arg_637_1:InitPlayNodeList()
	end,
	Play411331150 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 411331150
		arg_641_1.duration_ = 5

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play411331151(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			local var_644_0 = 0.675

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, false)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_1 = arg_641_1:FormatText(arg_641_1:GetWordFromCfg(411331150).content)

				arg_641_1.text_.text = var_644_1

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_3 = 27 <= 0 and var_644_0 or var_644_0 * (utf8.len(var_644_1) / 27)

				if (27 <= 0 and var_644_0 or var_644_0 * (utf8.len(var_644_1) / 27)) > 0 and var_644_0 < var_644_3 then
					arg_641_1.talkMaxDuration = var_644_3

					if var_644_3 + 0 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_3 + 0
					end
				end

				arg_641_1.text_.text = var_644_1
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)
				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_4 = math.max(var_644_0, arg_641_1.talkMaxDuration)

			if 0 <= arg_641_1.time_ and arg_641_1.time_ < 0 + var_644_4 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - 0) / var_644_4

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= 0 + var_644_4 and arg_641_1.time_ < 0 + var_644_4 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {}

		arg_641_1:InitPlayNodeList()
	end,
	Play411331151 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 411331151
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play411331152(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = 0.4

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, false)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_645_1.iconTrs_.gameObject, false)
				arg_645_1.callingController_:SetSelectedState("normal")

				local var_648_1 = arg_645_1:FormatText(arg_645_1:GetWordFromCfg(411331151).content)

				arg_645_1.text_.text = var_648_1

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_3 = 16 <= 0 and var_648_0 or var_648_0 * (utf8.len(var_648_1) / 16)

				if (16 <= 0 and var_648_0 or var_648_0 * (utf8.len(var_648_1) / 16)) > 0 and var_648_0 < var_648_3 then
					arg_645_1.talkMaxDuration = var_648_3

					if var_648_3 + 0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_3 + 0
					end
				end

				arg_645_1.text_.text = var_648_1
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_4 = math.max(var_648_0, arg_645_1.talkMaxDuration)

			if 0 <= arg_645_1.time_ and arg_645_1.time_ < 0 + var_648_4 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - 0) / var_648_4

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= 0 + var_648_4 and arg_645_1.time_ < 0 + var_648_4 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play411331152 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 411331152
		arg_649_1.duration_ = 5

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play411331153(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 0.575

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, false)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_1 = arg_649_1:FormatText(arg_649_1:GetWordFromCfg(411331152).content)

				arg_649_1.text_.text = var_652_1

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_3 = 23 <= 0 and var_652_0 or var_652_0 * (utf8.len(var_652_1) / 23)

				if (23 <= 0 and var_652_0 or var_652_0 * (utf8.len(var_652_1) / 23)) > 0 and var_652_0 < var_652_3 then
					arg_649_1.talkMaxDuration = var_652_3

					if var_652_3 + 0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_3 + 0
					end
				end

				arg_649_1.text_.text = var_652_1
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)
				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_4 = math.max(var_652_0, arg_649_1.talkMaxDuration)

			if 0 <= arg_649_1.time_ and arg_649_1.time_ < 0 + var_652_4 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - 0) / var_652_4

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= 0 + var_652_4 and arg_649_1.time_ < 0 + var_652_4 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play411331153 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 411331153
		arg_653_1.duration_ = 5

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play411331154(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = 1

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, false)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_1 = arg_653_1:FormatText(arg_653_1:GetWordFromCfg(411331153).content)

				arg_653_1.text_.text = var_656_1

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_3 = 40 <= 0 and var_656_0 or var_656_0 * (utf8.len(var_656_1) / 40)

				if (40 <= 0 and var_656_0 or var_656_0 * (utf8.len(var_656_1) / 40)) > 0 and var_656_0 < var_656_3 then
					arg_653_1.talkMaxDuration = var_656_3

					if var_656_3 + 0 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_3 + 0
					end
				end

				arg_653_1.text_.text = var_656_1
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_4 = math.max(var_656_0, arg_653_1.talkMaxDuration)

			if 0 <= arg_653_1.time_ and arg_653_1.time_ < 0 + var_656_4 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - 0) / var_656_4

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= 0 + var_656_4 and arg_653_1.time_ < 0 + var_656_4 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play411331154 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 411331154
		arg_657_1.duration_ = 5

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play411331155(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			local var_660_0 = 0.225

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				arg_657_1.leftNameTxt_.text = arg_657_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_1 = arg_657_1:FormatText(arg_657_1:GetWordFromCfg(411331154).content)

				arg_657_1.text_.text = var_660_1

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_3 = 9 <= 0 and var_660_0 or var_660_0 * (utf8.len(var_660_1) / 9)

				if (9 <= 0 and var_660_0 or var_660_0 * (utf8.len(var_660_1) / 9)) > 0 and var_660_0 < var_660_3 then
					arg_657_1.talkMaxDuration = var_660_3

					if var_660_3 + 0 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_3 + 0
					end
				end

				arg_657_1.text_.text = var_660_1
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)
				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_4 = math.max(var_660_0, arg_657_1.talkMaxDuration)

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_4 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - 0) / var_660_4

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= 0 + var_660_4 and arg_657_1.time_ < 0 + var_660_4 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	Play411331155 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 411331155
		arg_661_1.duration_ = 9

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play411331156(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			if 2 < arg_661_1.time_ and arg_661_1.time_ <= 2 + arg_664_0 then
				local var_664_0 = arg_661_1.bgs_.I07

				arg_661_1.bgs_.I07.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_664_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_664_1 = var_664_0:GetComponent("SpriteRenderer")

				if var_664_1 and var_664_1.sprite then
					local var_664_2 = 2 * (var_664_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_664_0.transform.localScale = Vector3.New(var_664_2 / var_664_1.sprite.bounds.size.y < var_664_2 * manager.ui.mainCameraCom_.aspect / var_664_1.sprite.bounds.size.x and var_664_2 * manager.ui.mainCameraCom_.aspect / var_664_1.sprite.bounds.size.x or var_664_2 / var_664_1.sprite.bounds.size.y, var_664_2 / var_664_1.sprite.bounds.size.y < var_664_2 * manager.ui.mainCameraCom_.aspect / var_664_1.sprite.bounds.size.x and var_664_2 * manager.ui.mainCameraCom_.aspect / var_664_1.sprite.bounds.size.x or var_664_2 / var_664_1.sprite.bounds.size.y, 0)
				end

				for iter_664_0, iter_664_1 in pairs(arg_661_1.bgs_) do
					if iter_664_0 ~= "I07" then
						iter_664_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_664_3 = 0

			if 0 < arg_661_1.time_ and arg_661_1.time_ <= var_664_3 + arg_664_0 then
				arg_661_1.mask_.enabled = true
				arg_661_1.mask_.raycastTarget = true

				arg_661_1:SetGaussion(false)
			end

			local var_664_4 = 2

			if var_664_3 <= arg_661_1.time_ and arg_661_1.time_ < var_664_3 + var_664_4 then
				local var_664_5 = Color.New(0, 0, 0)

				var_664_5.a = Mathf.Lerp(0, 1, (arg_661_1.time_ - var_664_3) / var_664_4)
				arg_661_1.mask_.color = var_664_5
			end

			if arg_661_1.time_ >= var_664_3 + var_664_4 and arg_661_1.time_ < var_664_3 + var_664_4 + arg_664_0 then
				local var_664_6 = Color.New(0, 0, 0)

				var_664_6.a = 1
				arg_661_1.mask_.color = var_664_6
			end

			local var_664_7 = 2

			if 2 < arg_661_1.time_ and arg_661_1.time_ <= var_664_7 + arg_664_0 then
				arg_661_1.mask_.enabled = true
				arg_661_1.mask_.raycastTarget = true

				arg_661_1:SetGaussion(false)
			end

			local var_664_8 = 2

			if var_664_7 <= arg_661_1.time_ and arg_661_1.time_ < var_664_7 + var_664_8 then
				local var_664_9 = Color.New(0, 0, 0)

				var_664_9.a = Mathf.Lerp(1, 0, (arg_661_1.time_ - var_664_7) / var_664_8)
				arg_661_1.mask_.color = var_664_9
			end

			if arg_661_1.time_ >= var_664_7 + var_664_8 and arg_661_1.time_ < var_664_7 + var_664_8 + arg_664_0 then
				local var_664_10 = Color.New(0, 0, 0)

				arg_661_1.mask_.enabled = false
				var_664_10.a = 0
				arg_661_1.mask_.color = var_664_10
			end

			if arg_661_1.frameCnt_ <= 1 then
				arg_661_1.dialog_:SetActive(false)
			end

			local var_664_11 = 4
			local var_664_12 = 1.45

			if 4 < arg_661_1.time_ and arg_661_1.time_ <= var_664_11 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0

				arg_661_1.dialog_:SetActive(true)

				arg_661_1.dialogCg_.alpha = 0

				local var_664_13 = LeanTween.value(arg_661_1.dialog_, 0, 1, 0.3)

				var_664_13:setOnUpdate(LuaHelper.FloatAction(function(arg_665_0)
					arg_661_1.dialogCg_.alpha = arg_665_0
				end))
				var_664_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_661_1.dialog_)
					var_664_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_661_1.duration_ = arg_661_1.duration_ + 0.3

				SetActive(arg_661_1.leftNameGo_, false)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_661_1.iconTrs_.gameObject, false)
				arg_661_1.callingController_:SetSelectedState("normal")

				local var_664_14 = arg_661_1:FormatText(arg_661_1:GetWordFromCfg(411331155).content)

				arg_661_1.text_.text = var_664_14

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_16 = 58 <= 0 and var_664_12 or var_664_12 * (utf8.len(var_664_14) / 58)

				if (58 <= 0 and var_664_12 or var_664_12 * (utf8.len(var_664_14) / 58)) > 0 and var_664_12 < var_664_16 then
					arg_661_1.talkMaxDuration = var_664_16
					var_664_11 = var_664_11 + 0.3

					if var_664_16 + var_664_11 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_16 + var_664_11
					end
				end

				arg_661_1.text_.text = var_664_14
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)
				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_17 = var_664_11 + 0.3
			local var_664_18 = math.max(var_664_12, arg_661_1.talkMaxDuration)

			if var_664_11 + 0.3 <= arg_661_1.time_ and arg_661_1.time_ < var_664_17 + var_664_18 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_17) / var_664_18

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_17 + var_664_18 and arg_661_1.time_ < var_664_17 + var_664_18 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play411331156 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 411331156
		arg_667_1.duration_ = 5

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play411331157(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 then
				arg_667_1.var_.moveOldPos4040ui_story = arg_667_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_670_0 = 0.001

			if 0 <= arg_667_1.time_ and arg_667_1.time_ < 0 + var_670_0 then
				arg_667_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_667_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_667_1.time_ - 0) / var_670_0)
				arg_667_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_667_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_667_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_667_1.actors_["4040ui_story"].transform.position).z)
				arg_667_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_667_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_667_1.actors_["4040ui_story"].transform.localEulerAngles = arg_667_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_667_1.time_ >= 0 + var_670_0 and arg_667_1.time_ < 0 + var_670_0 + arg_670_0 then
				arg_667_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_667_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_667_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_667_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_667_1.actors_["4040ui_story"].transform.position).z)
				arg_667_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_667_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_667_1.actors_["4040ui_story"].transform.localEulerAngles = arg_667_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_670_1 = arg_667_1.actors_["4040ui_story"]

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 and not isNil(var_670_1) and arg_667_1.var_.characterEffect4040ui_story == nil then
				arg_667_1.var_.characterEffect4040ui_story = var_670_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_670_2 = 0.200000002980232

			if 0 <= arg_667_1.time_ and arg_667_1.time_ < 0 + var_670_2 and not isNil(var_670_1) then
				if arg_667_1.var_.characterEffect4040ui_story and not isNil(var_670_1) then
					arg_667_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_667_1.time_ >= 0 + var_670_2 and arg_667_1.time_ < 0 + var_670_2 + arg_670_0 and not isNil(var_670_1) and arg_667_1.var_.characterEffect4040ui_story then
				arg_667_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 then
				arg_667_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 then
				arg_667_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_670_4 = 0
			local var_670_5 = 0.225

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= var_670_4 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, true)

				arg_667_1.leftNameTxt_.text = arg_667_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_667_1.leftNameTxt_.transform)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1.leftNameTxt_.text)
				SetActive(arg_667_1.iconTrs_.gameObject, false)
				arg_667_1.callingController_:SetSelectedState("normal")

				local var_670_6 = arg_667_1:FormatText(arg_667_1:GetWordFromCfg(411331156).content)

				arg_667_1.text_.text = var_670_6

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_8 = 9 <= 0 and var_670_5 or var_670_5 * (utf8.len(var_670_6) / 9)

				if (9 <= 0 and var_670_5 or var_670_5 * (utf8.len(var_670_6) / 9)) > 0 and var_670_5 < var_670_8 then
					arg_667_1.talkMaxDuration = var_670_8

					if var_670_8 + var_670_4 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_8 + var_670_4
					end
				end

				arg_667_1.text_.text = var_670_6
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)
				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_9 = math.max(var_670_5, arg_667_1.talkMaxDuration)

			if var_670_4 <= arg_667_1.time_ and arg_667_1.time_ < var_670_4 + var_670_9 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - var_670_4) / var_670_9

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= var_670_4 + var_670_9 and arg_667_1.time_ < var_670_4 + var_670_9 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_667_1:InitPlayNodeList()
	end,
	Play411331157 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 411331157
		arg_671_1.duration_ = 5

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play411331158(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			if 0 < arg_671_1.time_ and arg_671_1.time_ <= 0 + arg_674_0 and not isNil(arg_671_1.actors_["4040ui_story"]) and arg_671_1.var_.characterEffect4040ui_story == nil then
				arg_671_1.var_.characterEffect4040ui_story = arg_671_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_674_0 = 0.200000002980232

			if 0 <= arg_671_1.time_ and arg_671_1.time_ < 0 + var_674_0 and not isNil(arg_671_1.actors_["4040ui_story"]) then
				if arg_671_1.var_.characterEffect4040ui_story and not isNil(arg_671_1.actors_["4040ui_story"]) then
					arg_671_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_671_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_671_1.time_ - 0) / var_674_0)
				end
			end

			if arg_671_1.time_ >= 0 + var_674_0 and arg_671_1.time_ < 0 + var_674_0 + arg_674_0 and not isNil(arg_671_1.actors_["4040ui_story"]) and arg_671_1.var_.characterEffect4040ui_story then
				arg_671_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_671_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_674_1 = 0
			local var_674_2 = 1.275

			if 0 < arg_671_1.time_ and arg_671_1.time_ <= var_674_1 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, false)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_3 = arg_671_1:FormatText(arg_671_1:GetWordFromCfg(411331157).content)

				arg_671_1.text_.text = var_674_3

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_5 = 51 <= 0 and var_674_2 or var_674_2 * (utf8.len(var_674_3) / 51)

				if (51 <= 0 and var_674_2 or var_674_2 * (utf8.len(var_674_3) / 51)) > 0 and var_674_2 < var_674_5 then
					arg_671_1.talkMaxDuration = var_674_5

					if var_674_5 + var_674_1 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_5 + var_674_1
					end
				end

				arg_671_1.text_.text = var_674_3
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)
				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_6 = math.max(var_674_2, arg_671_1.talkMaxDuration)

			if var_674_1 <= arg_671_1.time_ and arg_671_1.time_ < var_674_1 + var_674_6 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_1) / var_674_6

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_1 + var_674_6 and arg_671_1.time_ < var_674_1 + var_674_6 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {}

		arg_671_1:InitPlayNodeList()
	end,
	Play411331158 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 411331158
		arg_675_1.duration_ = 5

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play411331159(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1.var_.moveOldPos10014ui_story = arg_675_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_678_0 = 0.001

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_0 then
				arg_675_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_675_1.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_675_1.time_ - 0) / var_678_0)
				arg_675_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_675_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_675_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_675_1.actors_["10014ui_story"].transform.position).z)
				arg_675_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_675_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_675_1.actors_["10014ui_story"].transform.localEulerAngles = arg_675_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_675_1.time_ >= 0 + var_678_0 and arg_675_1.time_ < 0 + var_678_0 + arg_678_0 then
				arg_675_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_675_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_675_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_675_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_675_1.actors_["10014ui_story"].transform.position).z)
				arg_675_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_675_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_675_1.actors_["10014ui_story"].transform.localEulerAngles = arg_675_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_678_1 = arg_675_1.actors_["10014ui_story"]

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 and not isNil(var_678_1) and arg_675_1.var_.characterEffect10014ui_story == nil then
				arg_675_1.var_.characterEffect10014ui_story = var_678_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_678_2 = 0.200000002980232

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_2 and not isNil(var_678_1) then
				if arg_675_1.var_.characterEffect10014ui_story and not isNil(var_678_1) then
					arg_675_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_675_1.time_ >= 0 + var_678_2 and arg_675_1.time_ < 0 + var_678_2 + arg_678_0 and not isNil(var_678_1) and arg_675_1.var_.characterEffect10014ui_story then
				arg_675_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_678_4 = arg_675_1.actors_["4040ui_story"].transform

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1.var_.moveOldPos4040ui_story = var_678_4.localPosition
			end

			local var_678_5 = 0.001

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_5 then
				var_678_4.localPosition = Vector3.Lerp(arg_675_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_675_1.time_ - 0) / var_678_5)
				var_678_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_678_4.position).x, (manager.ui.mainCamera.transform.position - var_678_4.position).y, (manager.ui.mainCamera.transform.position - var_678_4.position).z)
				var_678_4.localEulerAngles.z = 0
				var_678_4.localEulerAngles.x = 0
				var_678_4.localEulerAngles = var_678_4.localEulerAngles
			end

			if arg_675_1.time_ >= 0 + var_678_5 and arg_675_1.time_ < 0 + var_678_5 + arg_678_0 then
				var_678_4.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_678_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_678_4.position).x, (manager.ui.mainCamera.transform.position - var_678_4.position).y, (manager.ui.mainCamera.transform.position - var_678_4.position).z)
				var_678_4.localEulerAngles.z = 0
				var_678_4.localEulerAngles.x = 0
				var_678_4.localEulerAngles = var_678_4.localEulerAngles
			end

			local var_678_6 = arg_675_1.actors_["4040ui_story"]

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 and not isNil(var_678_6) and arg_675_1.var_.characterEffect4040ui_story == nil then
				arg_675_1.var_.characterEffect4040ui_story = var_678_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_678_7 = 0.200000002980232

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_7 and not isNil(var_678_6) then
				if arg_675_1.var_.characterEffect4040ui_story and not isNil(var_678_6) then
					arg_675_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_675_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_675_1.time_ - 0) / var_678_7)
				end
			end

			if arg_675_1.time_ >= 0 + var_678_7 and arg_675_1.time_ < 0 + var_678_7 + arg_678_0 and not isNil(var_678_6) and arg_675_1.var_.characterEffect4040ui_story then
				arg_675_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_675_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_678_8 = 0
			local var_678_9 = 0.275

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= var_678_8 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				arg_675_1.leftNameTxt_.text = arg_675_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_10 = arg_675_1:FormatText(arg_675_1:GetWordFromCfg(411331158).content)

				arg_675_1.text_.text = var_678_10

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_12 = 11 <= 0 and var_678_9 or var_678_9 * (utf8.len(var_678_10) / 11)

				if (11 <= 0 and var_678_9 or var_678_9 * (utf8.len(var_678_10) / 11)) > 0 and var_678_9 < var_678_12 then
					arg_675_1.talkMaxDuration = var_678_12

					if var_678_12 + var_678_8 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_12 + var_678_8
					end
				end

				arg_675_1.text_.text = var_678_10
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)
				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_13 = math.max(var_678_9, arg_675_1.talkMaxDuration)

			if var_678_8 <= arg_675_1.time_ and arg_675_1.time_ < var_678_8 + var_678_13 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_8) / var_678_13

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_8 + var_678_13 and arg_675_1.time_ < var_678_8 + var_678_13 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_675_1:InitPlayNodeList()
	end,
	Play411331159 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 411331159
		arg_679_1.duration_ = 5

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play411331160(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 then
				arg_679_1.var_.moveOldPos4040ui_story = arg_679_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_682_0 = 0.001

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_0 then
				arg_679_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_679_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_679_1.time_ - 0) / var_682_0)
				arg_679_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_679_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_679_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_679_1.actors_["4040ui_story"].transform.position).z)
				arg_679_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_679_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_679_1.actors_["4040ui_story"].transform.localEulerAngles = arg_679_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_679_1.time_ >= 0 + var_682_0 and arg_679_1.time_ < 0 + var_682_0 + arg_682_0 then
				arg_679_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_679_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_679_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_679_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_679_1.actors_["4040ui_story"].transform.position).z)
				arg_679_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_679_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_679_1.actors_["4040ui_story"].transform.localEulerAngles = arg_679_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_682_1 = arg_679_1.actors_["4040ui_story"]

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 and not isNil(var_682_1) and arg_679_1.var_.characterEffect4040ui_story == nil then
				arg_679_1.var_.characterEffect4040ui_story = var_682_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_682_2 = 0.200000002980232

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_2 and not isNil(var_682_1) then
				if arg_679_1.var_.characterEffect4040ui_story and not isNil(var_682_1) then
					arg_679_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_679_1.time_ >= 0 + var_682_2 and arg_679_1.time_ < 0 + var_682_2 + arg_682_0 and not isNil(var_682_1) and arg_679_1.var_.characterEffect4040ui_story then
				arg_679_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 then
				arg_679_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 then
				arg_679_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_682_4 = arg_679_1.actors_["10014ui_story"]

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 and not isNil(var_682_4) and arg_679_1.var_.characterEffect10014ui_story == nil then
				arg_679_1.var_.characterEffect10014ui_story = var_682_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_682_5 = 0.200000002980232

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_5 and not isNil(var_682_4) then
				if arg_679_1.var_.characterEffect10014ui_story and not isNil(var_682_4) then
					arg_679_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_679_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_679_1.time_ - 0) / var_682_5)
				end
			end

			if arg_679_1.time_ >= 0 + var_682_5 and arg_679_1.time_ < 0 + var_682_5 + arg_682_0 and not isNil(var_682_4) and arg_679_1.var_.characterEffect10014ui_story then
				arg_679_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_679_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_682_6 = 0
			local var_682_7 = 0.15

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= var_682_6 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				arg_679_1.leftNameTxt_.text = arg_679_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_8 = arg_679_1:FormatText(arg_679_1:GetWordFromCfg(411331159).content)

				arg_679_1.text_.text = var_682_8

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_10 = 6 <= 0 and var_682_7 or var_682_7 * (utf8.len(var_682_8) / 6)

				if (6 <= 0 and var_682_7 or var_682_7 * (utf8.len(var_682_8) / 6)) > 0 and var_682_7 < var_682_10 then
					arg_679_1.talkMaxDuration = var_682_10

					if var_682_10 + var_682_6 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_10 + var_682_6
					end
				end

				arg_679_1.text_.text = var_682_8
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)
				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_11 = math.max(var_682_7, arg_679_1.talkMaxDuration)

			if var_682_6 <= arg_679_1.time_ and arg_679_1.time_ < var_682_6 + var_682_11 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_6) / var_682_11

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_6 + var_682_11 and arg_679_1.time_ < var_682_6 + var_682_11 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_679_1:InitPlayNodeList()
	end,
	Play411331160 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 411331160
		arg_683_1.duration_ = 5

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play411331161(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 and not isNil(arg_683_1.actors_["4040ui_story"]) and arg_683_1.var_.characterEffect4040ui_story == nil then
				arg_683_1.var_.characterEffect4040ui_story = arg_683_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_686_0 = 0.200000002980232

			if 0 <= arg_683_1.time_ and arg_683_1.time_ < 0 + var_686_0 and not isNil(arg_683_1.actors_["4040ui_story"]) then
				if arg_683_1.var_.characterEffect4040ui_story and not isNil(arg_683_1.actors_["4040ui_story"]) then
					arg_683_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_683_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_683_1.time_ - 0) / var_686_0)
				end
			end

			if arg_683_1.time_ >= 0 + var_686_0 and arg_683_1.time_ < 0 + var_686_0 + arg_686_0 and not isNil(arg_683_1.actors_["4040ui_story"]) and arg_683_1.var_.characterEffect4040ui_story then
				arg_683_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_683_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_686_1 = 0
			local var_686_2 = 1.3

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= var_686_1 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, false)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_3 = arg_683_1:FormatText(arg_683_1:GetWordFromCfg(411331160).content)

				arg_683_1.text_.text = var_686_3

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_5 = 52 <= 0 and var_686_2 or var_686_2 * (utf8.len(var_686_3) / 52)

				if (52 <= 0 and var_686_2 or var_686_2 * (utf8.len(var_686_3) / 52)) > 0 and var_686_2 < var_686_5 then
					arg_683_1.talkMaxDuration = var_686_5

					if var_686_5 + var_686_1 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_5 + var_686_1
					end
				end

				arg_683_1.text_.text = var_686_3
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)
				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_6 = math.max(var_686_2, arg_683_1.talkMaxDuration)

			if var_686_1 <= arg_683_1.time_ and arg_683_1.time_ < var_686_1 + var_686_6 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_1) / var_686_6

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_1 + var_686_6 and arg_683_1.time_ < var_686_1 + var_686_6 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play411331161 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 411331161
		arg_687_1.duration_ = 5

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play411331162(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 then
				arg_687_1.var_.moveOldPos10014ui_story = arg_687_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_690_0 = 0.001

			if 0 <= arg_687_1.time_ and arg_687_1.time_ < 0 + var_690_0 then
				arg_687_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_687_1.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_687_1.time_ - 0) / var_690_0)
				arg_687_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_687_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_687_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_687_1.actors_["10014ui_story"].transform.position).z)
				arg_687_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_687_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_687_1.actors_["10014ui_story"].transform.localEulerAngles = arg_687_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_687_1.time_ >= 0 + var_690_0 and arg_687_1.time_ < 0 + var_690_0 + arg_690_0 then
				arg_687_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_687_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_687_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_687_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_687_1.actors_["10014ui_story"].transform.position).z)
				arg_687_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_687_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_687_1.actors_["10014ui_story"].transform.localEulerAngles = arg_687_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_690_1 = arg_687_1.actors_["10014ui_story"]

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 and not isNil(var_690_1) and arg_687_1.var_.characterEffect10014ui_story == nil then
				arg_687_1.var_.characterEffect10014ui_story = var_690_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_690_2 = 0.200000002980232

			if 0 <= arg_687_1.time_ and arg_687_1.time_ < 0 + var_690_2 and not isNil(var_690_1) then
				if arg_687_1.var_.characterEffect10014ui_story and not isNil(var_690_1) then
					arg_687_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_687_1.time_ >= 0 + var_690_2 and arg_687_1.time_ < 0 + var_690_2 + arg_690_0 and not isNil(var_690_1) and arg_687_1.var_.characterEffect10014ui_story then
				arg_687_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 then
				arg_687_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 then
				arg_687_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_690_4 = 0
			local var_690_5 = 0.3

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= var_690_4 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				arg_687_1.leftNameTxt_.text = arg_687_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, false)
				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_6 = arg_687_1:FormatText(arg_687_1:GetWordFromCfg(411331161).content)

				arg_687_1.text_.text = var_690_6

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_8 = 12 <= 0 and var_690_5 or var_690_5 * (utf8.len(var_690_6) / 12)

				if (12 <= 0 and var_690_5 or var_690_5 * (utf8.len(var_690_6) / 12)) > 0 and var_690_5 < var_690_8 then
					arg_687_1.talkMaxDuration = var_690_8

					if var_690_8 + var_690_4 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_8 + var_690_4
					end
				end

				arg_687_1.text_.text = var_690_6
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)
				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_9 = math.max(var_690_5, arg_687_1.talkMaxDuration)

			if var_690_4 <= arg_687_1.time_ and arg_687_1.time_ < var_690_4 + var_690_9 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_4) / var_690_9

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_4 + var_690_9 and arg_687_1.time_ < var_690_4 + var_690_9 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_687_1:InitPlayNodeList()
	end,
	Play411331162 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 411331162
		arg_691_1.duration_ = 5

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play411331163(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 and not isNil(arg_691_1.actors_["10014ui_story"]) and arg_691_1.var_.characterEffect10014ui_story == nil then
				arg_691_1.var_.characterEffect10014ui_story = arg_691_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_694_0 = 0.200000002980232

			if 0 <= arg_691_1.time_ and arg_691_1.time_ < 0 + var_694_0 and not isNil(arg_691_1.actors_["10014ui_story"]) then
				if arg_691_1.var_.characterEffect10014ui_story and not isNil(arg_691_1.actors_["10014ui_story"]) then
					arg_691_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_691_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_691_1.time_ - 0) / var_694_0)
				end
			end

			if arg_691_1.time_ >= 0 + var_694_0 and arg_691_1.time_ < 0 + var_694_0 + arg_694_0 and not isNil(arg_691_1.actors_["10014ui_story"]) and arg_691_1.var_.characterEffect10014ui_story then
				arg_691_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_691_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_694_1 = 0
			local var_694_2 = 1.075

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= var_694_1 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, false)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_3 = arg_691_1:FormatText(arg_691_1:GetWordFromCfg(411331162).content)

				arg_691_1.text_.text = var_694_3

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_5 = 43 <= 0 and var_694_2 or var_694_2 * (utf8.len(var_694_3) / 43)

				if (43 <= 0 and var_694_2 or var_694_2 * (utf8.len(var_694_3) / 43)) > 0 and var_694_2 < var_694_5 then
					arg_691_1.talkMaxDuration = var_694_5

					if var_694_5 + var_694_1 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_5 + var_694_1
					end
				end

				arg_691_1.text_.text = var_694_3
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)
				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_6 = math.max(var_694_2, arg_691_1.talkMaxDuration)

			if var_694_1 <= arg_691_1.time_ and arg_691_1.time_ < var_694_1 + var_694_6 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_1) / var_694_6

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_1 + var_694_6 and arg_691_1.time_ < var_694_1 + var_694_6 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {}

		arg_691_1:InitPlayNodeList()
	end,
	Play411331163 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 411331163
		arg_695_1.duration_ = 5

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play411331164(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = 1.175

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, false)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_1 = arg_695_1:FormatText(arg_695_1:GetWordFromCfg(411331163).content)

				arg_695_1.text_.text = var_698_1

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_3 = 47 <= 0 and var_698_0 or var_698_0 * (utf8.len(var_698_1) / 47)

				if (47 <= 0 and var_698_0 or var_698_0 * (utf8.len(var_698_1) / 47)) > 0 and var_698_0 < var_698_3 then
					arg_695_1.talkMaxDuration = var_698_3

					if var_698_3 + 0 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_3 + 0
					end
				end

				arg_695_1.text_.text = var_698_1
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)
				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_4 = math.max(var_698_0, arg_695_1.talkMaxDuration)

			if 0 <= arg_695_1.time_ and arg_695_1.time_ < 0 + var_698_4 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - 0) / var_698_4

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= 0 + var_698_4 and arg_695_1.time_ < 0 + var_698_4 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {}

		arg_695_1:InitPlayNodeList()
	end,
	Play411331164 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 411331164
		arg_699_1.duration_ = 5

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play411331165(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1.var_.moveOldPos10014ui_story = arg_699_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_702_0 = 0.001

			if 0 <= arg_699_1.time_ and arg_699_1.time_ < 0 + var_702_0 then
				arg_699_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_699_1.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_699_1.time_ - 0) / var_702_0)
				arg_699_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_699_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_699_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_699_1.actors_["10014ui_story"].transform.position).z)
				arg_699_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_699_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_699_1.actors_["10014ui_story"].transform.localEulerAngles = arg_699_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_699_1.time_ >= 0 + var_702_0 and arg_699_1.time_ < 0 + var_702_0 + arg_702_0 then
				arg_699_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_699_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_699_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_699_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_699_1.actors_["10014ui_story"].transform.position).z)
				arg_699_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_699_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_699_1.actors_["10014ui_story"].transform.localEulerAngles = arg_699_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_702_1 = arg_699_1.actors_["10014ui_story"]

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 and not isNil(var_702_1) and arg_699_1.var_.characterEffect10014ui_story == nil then
				arg_699_1.var_.characterEffect10014ui_story = var_702_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_702_2 = 0.200000002980232

			if 0 <= arg_699_1.time_ and arg_699_1.time_ < 0 + var_702_2 and not isNil(var_702_1) then
				if arg_699_1.var_.characterEffect10014ui_story and not isNil(var_702_1) then
					arg_699_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_699_1.time_ >= 0 + var_702_2 and arg_699_1.time_ < 0 + var_702_2 + arg_702_0 and not isNil(var_702_1) and arg_699_1.var_.characterEffect10014ui_story then
				arg_699_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_702_4 = 0
			local var_702_5 = 0.65

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= var_702_4 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				arg_699_1.leftNameTxt_.text = arg_699_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_6 = arg_699_1:FormatText(arg_699_1:GetWordFromCfg(411331164).content)

				arg_699_1.text_.text = var_702_6

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_8 = 26 <= 0 and var_702_5 or var_702_5 * (utf8.len(var_702_6) / 26)

				if (26 <= 0 and var_702_5 or var_702_5 * (utf8.len(var_702_6) / 26)) > 0 and var_702_5 < var_702_8 then
					arg_699_1.talkMaxDuration = var_702_8

					if var_702_8 + var_702_4 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_8 + var_702_4
					end
				end

				arg_699_1.text_.text = var_702_6
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)
				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_9 = math.max(var_702_5, arg_699_1.talkMaxDuration)

			if var_702_4 <= arg_699_1.time_ and arg_699_1.time_ < var_702_4 + var_702_9 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_4) / var_702_9

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_4 + var_702_9 and arg_699_1.time_ < var_702_4 + var_702_9 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_699_1:InitPlayNodeList()
	end,
	Play411331165 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 411331165
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play411331166(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 then
				arg_703_1.var_.moveOldPos4040ui_story = arg_703_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_706_0 = 0.001

			if 0 <= arg_703_1.time_ and arg_703_1.time_ < 0 + var_706_0 then
				arg_703_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_703_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_703_1.time_ - 0) / var_706_0)
				arg_703_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_703_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_703_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_703_1.actors_["4040ui_story"].transform.position).z)
				arg_703_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_703_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_703_1.actors_["4040ui_story"].transform.localEulerAngles = arg_703_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_703_1.time_ >= 0 + var_706_0 and arg_703_1.time_ < 0 + var_706_0 + arg_706_0 then
				arg_703_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_703_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_703_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_703_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_703_1.actors_["4040ui_story"].transform.position).z)
				arg_703_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_703_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_703_1.actors_["4040ui_story"].transform.localEulerAngles = arg_703_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_706_1 = arg_703_1.actors_["4040ui_story"]

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 and not isNil(var_706_1) and arg_703_1.var_.characterEffect4040ui_story == nil then
				arg_703_1.var_.characterEffect4040ui_story = var_706_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_706_2 = 0.200000002980232

			if 0 <= arg_703_1.time_ and arg_703_1.time_ < 0 + var_706_2 and not isNil(var_706_1) then
				if arg_703_1.var_.characterEffect4040ui_story and not isNil(var_706_1) then
					arg_703_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_703_1.time_ >= 0 + var_706_2 and arg_703_1.time_ < 0 + var_706_2 + arg_706_0 and not isNil(var_706_1) and arg_703_1.var_.characterEffect4040ui_story then
				arg_703_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 then
				arg_703_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 then
				arg_703_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_706_4 = arg_703_1.actors_["10014ui_story"]

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 and not isNil(var_706_4) and arg_703_1.var_.characterEffect10014ui_story == nil then
				arg_703_1.var_.characterEffect10014ui_story = var_706_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_706_5 = 0.200000002980232

			if 0 <= arg_703_1.time_ and arg_703_1.time_ < 0 + var_706_5 and not isNil(var_706_4) then
				if arg_703_1.var_.characterEffect10014ui_story and not isNil(var_706_4) then
					arg_703_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_703_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_703_1.time_ - 0) / var_706_5)
				end
			end

			if arg_703_1.time_ >= 0 + var_706_5 and arg_703_1.time_ < 0 + var_706_5 + arg_706_0 and not isNil(var_706_4) and arg_703_1.var_.characterEffect10014ui_story then
				arg_703_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_703_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_706_6 = 0
			local var_706_7 = 0.225

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= var_706_6 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, true)

				arg_703_1.leftNameTxt_.text = arg_703_1:FormatText(StoryNameCfg[905].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_703_1.leftNameTxt_.transform)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1.leftNameTxt_.text)
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_8 = arg_703_1:FormatText(arg_703_1:GetWordFromCfg(411331165).content)

				arg_703_1.text_.text = var_706_8

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_10 = 9 <= 0 and var_706_7 or var_706_7 * (utf8.len(var_706_8) / 9)

				if (9 <= 0 and var_706_7 or var_706_7 * (utf8.len(var_706_8) / 9)) > 0 and var_706_7 < var_706_10 then
					arg_703_1.talkMaxDuration = var_706_10

					if var_706_10 + var_706_6 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_10 + var_706_6
					end
				end

				arg_703_1.text_.text = var_706_8
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_11 = math.max(var_706_7, arg_703_1.talkMaxDuration)

			if var_706_6 <= arg_703_1.time_ and arg_703_1.time_ < var_706_6 + var_706_11 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_6) / var_706_11

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_6 + var_706_11 and arg_703_1.time_ < var_706_6 + var_706_11 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_703_1:InitPlayNodeList()
	end,
	Play411331166 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 411331166
		arg_707_1.duration_ = 5

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play411331167(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 and not isNil(arg_707_1.actors_["4040ui_story"]) and arg_707_1.var_.characterEffect4040ui_story == nil then
				arg_707_1.var_.characterEffect4040ui_story = arg_707_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_710_0 = 0.200000002980232

			if 0 <= arg_707_1.time_ and arg_707_1.time_ < 0 + var_710_0 and not isNil(arg_707_1.actors_["4040ui_story"]) then
				if arg_707_1.var_.characterEffect4040ui_story and not isNil(arg_707_1.actors_["4040ui_story"]) then
					arg_707_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_707_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_707_1.time_ - 0) / var_710_0)
				end
			end

			if arg_707_1.time_ >= 0 + var_710_0 and arg_707_1.time_ < 0 + var_710_0 + arg_710_0 and not isNil(arg_707_1.actors_["4040ui_story"]) and arg_707_1.var_.characterEffect4040ui_story then
				arg_707_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_707_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_710_1 = 0
			local var_710_2 = 1.5

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= var_710_1 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, false)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_3 = arg_707_1:FormatText(arg_707_1:GetWordFromCfg(411331166).content)

				arg_707_1.text_.text = var_710_3

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_5 = 60 <= 0 and var_710_2 or var_710_2 * (utf8.len(var_710_3) / 60)

				if (60 <= 0 and var_710_2 or var_710_2 * (utf8.len(var_710_3) / 60)) > 0 and var_710_2 < var_710_5 then
					arg_707_1.talkMaxDuration = var_710_5

					if var_710_5 + var_710_1 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_5 + var_710_1
					end
				end

				arg_707_1.text_.text = var_710_3
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)
				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_6 = math.max(var_710_2, arg_707_1.talkMaxDuration)

			if var_710_1 <= arg_707_1.time_ and arg_707_1.time_ < var_710_1 + var_710_6 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_1) / var_710_6

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_1 + var_710_6 and arg_707_1.time_ < var_710_1 + var_710_6 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {}

		arg_707_1:InitPlayNodeList()
	end,
	Play411331167 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 411331167
		arg_711_1.duration_ = 5

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play411331168(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 then
				arg_711_1.var_.moveOldPos4040ui_story = arg_711_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_714_0 = 0.001

			if 0 <= arg_711_1.time_ and arg_711_1.time_ < 0 + var_714_0 then
				arg_711_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_711_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_711_1.time_ - 0) / var_714_0)
				arg_711_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_711_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_711_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_711_1.actors_["4040ui_story"].transform.position).z)
				arg_711_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_711_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_711_1.actors_["4040ui_story"].transform.localEulerAngles = arg_711_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_711_1.time_ >= 0 + var_714_0 and arg_711_1.time_ < 0 + var_714_0 + arg_714_0 then
				arg_711_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_711_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_711_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_711_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_711_1.actors_["4040ui_story"].transform.position).z)
				arg_711_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_711_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_711_1.actors_["4040ui_story"].transform.localEulerAngles = arg_711_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_714_1 = arg_711_1.actors_["4040ui_story"]

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 and not isNil(var_714_1) and arg_711_1.var_.characterEffect4040ui_story == nil then
				arg_711_1.var_.characterEffect4040ui_story = var_714_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_714_2 = 0.200000002980232

			if 0 <= arg_711_1.time_ and arg_711_1.time_ < 0 + var_714_2 and not isNil(var_714_1) then
				if arg_711_1.var_.characterEffect4040ui_story and not isNil(var_714_1) then
					arg_711_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_711_1.time_ >= 0 + var_714_2 and arg_711_1.time_ < 0 + var_714_2 + arg_714_0 and not isNil(var_714_1) and arg_711_1.var_.characterEffect4040ui_story then
				arg_711_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 then
				arg_711_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_714_4 = 0
			local var_714_5 = 0.75

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= var_714_4 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, true)

				arg_711_1.leftNameTxt_.text = arg_711_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_711_1.leftNameTxt_.transform)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1.leftNameTxt_.text)
				SetActive(arg_711_1.iconTrs_.gameObject, false)
				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_6 = arg_711_1:FormatText(arg_711_1:GetWordFromCfg(411331167).content)

				arg_711_1.text_.text = var_714_6

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_8 = 30 <= 0 and var_714_5 or var_714_5 * (utf8.len(var_714_6) / 30)

				if (30 <= 0 and var_714_5 or var_714_5 * (utf8.len(var_714_6) / 30)) > 0 and var_714_5 < var_714_8 then
					arg_711_1.talkMaxDuration = var_714_8

					if var_714_8 + var_714_4 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_8 + var_714_4
					end
				end

				arg_711_1.text_.text = var_714_6
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)
				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_9 = math.max(var_714_5, arg_711_1.talkMaxDuration)

			if var_714_4 <= arg_711_1.time_ and arg_711_1.time_ < var_714_4 + var_714_9 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - var_714_4) / var_714_9

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= var_714_4 + var_714_9 and arg_711_1.time_ < var_714_4 + var_714_9 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_711_1:InitPlayNodeList()
	end,
	Play411331168 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 411331168
		arg_715_1.duration_ = 5

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play411331169(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 then
				arg_715_1.var_.moveOldPos10014ui_story = arg_715_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_718_0 = 0.001

			if 0 <= arg_715_1.time_ and arg_715_1.time_ < 0 + var_718_0 then
				arg_715_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_715_1.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_715_1.time_ - 0) / var_718_0)
				arg_715_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_715_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_715_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_715_1.actors_["10014ui_story"].transform.position).z)
				arg_715_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_715_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_715_1.actors_["10014ui_story"].transform.localEulerAngles = arg_715_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_715_1.time_ >= 0 + var_718_0 and arg_715_1.time_ < 0 + var_718_0 + arg_718_0 then
				arg_715_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_715_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_715_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_715_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_715_1.actors_["10014ui_story"].transform.position).z)
				arg_715_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_715_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_715_1.actors_["10014ui_story"].transform.localEulerAngles = arg_715_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_718_1 = arg_715_1.actors_["10014ui_story"]

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 and not isNil(var_718_1) and arg_715_1.var_.characterEffect10014ui_story == nil then
				arg_715_1.var_.characterEffect10014ui_story = var_718_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_718_2 = 0.200000002980232

			if 0 <= arg_715_1.time_ and arg_715_1.time_ < 0 + var_718_2 and not isNil(var_718_1) then
				if arg_715_1.var_.characterEffect10014ui_story and not isNil(var_718_1) then
					arg_715_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_715_1.time_ >= 0 + var_718_2 and arg_715_1.time_ < 0 + var_718_2 + arg_718_0 and not isNil(var_718_1) and arg_715_1.var_.characterEffect10014ui_story then
				arg_715_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 then
				arg_715_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 then
				arg_715_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_718_4 = arg_715_1.actors_["4040ui_story"]

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 and not isNil(var_718_4) and arg_715_1.var_.characterEffect4040ui_story == nil then
				arg_715_1.var_.characterEffect4040ui_story = var_718_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_718_5 = 0.200000002980232

			if 0 <= arg_715_1.time_ and arg_715_1.time_ < 0 + var_718_5 and not isNil(var_718_4) then
				if arg_715_1.var_.characterEffect4040ui_story and not isNil(var_718_4) then
					arg_715_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_715_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_715_1.time_ - 0) / var_718_5)
				end
			end

			if arg_715_1.time_ >= 0 + var_718_5 and arg_715_1.time_ < 0 + var_718_5 + arg_718_0 and not isNil(var_718_4) and arg_715_1.var_.characterEffect4040ui_story then
				arg_715_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_715_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_718_6 = 0
			local var_718_7 = 0.175

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= var_718_6 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, true)

				arg_715_1.leftNameTxt_.text = arg_715_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_715_1.leftNameTxt_.transform)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1.leftNameTxt_.text)
				SetActive(arg_715_1.iconTrs_.gameObject, false)
				arg_715_1.callingController_:SetSelectedState("normal")

				local var_718_8 = arg_715_1:FormatText(arg_715_1:GetWordFromCfg(411331168).content)

				arg_715_1.text_.text = var_718_8

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_10 = 7 <= 0 and var_718_7 or var_718_7 * (utf8.len(var_718_8) / 7)

				if (7 <= 0 and var_718_7 or var_718_7 * (utf8.len(var_718_8) / 7)) > 0 and var_718_7 < var_718_10 then
					arg_715_1.talkMaxDuration = var_718_10

					if var_718_10 + var_718_6 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_10 + var_718_6
					end
				end

				arg_715_1.text_.text = var_718_8
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)
				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_11 = math.max(var_718_7, arg_715_1.talkMaxDuration)

			if var_718_6 <= arg_715_1.time_ and arg_715_1.time_ < var_718_6 + var_718_11 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - var_718_6) / var_718_11

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= var_718_6 + var_718_11 and arg_715_1.time_ < var_718_6 + var_718_11 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end

		arg_715_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_715_1:InitPlayNodeList()
	end,
	Play411331169 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 411331169
		arg_719_1.duration_ = 5

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play411331170(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			if 0 < arg_719_1.time_ and arg_719_1.time_ <= 0 + arg_722_0 then
				arg_719_1.var_.moveOldPos4040ui_story = arg_719_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_722_0 = 0.001

			if 0 <= arg_719_1.time_ and arg_719_1.time_ < 0 + var_722_0 then
				arg_719_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_719_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_719_1.time_ - 0) / var_722_0)
				arg_719_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_719_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_719_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_719_1.actors_["4040ui_story"].transform.position).z)
				arg_719_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_719_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_719_1.actors_["4040ui_story"].transform.localEulerAngles = arg_719_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_719_1.time_ >= 0 + var_722_0 and arg_719_1.time_ < 0 + var_722_0 + arg_722_0 then
				arg_719_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_719_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_719_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_719_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_719_1.actors_["4040ui_story"].transform.position).z)
				arg_719_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_719_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_719_1.actors_["4040ui_story"].transform.localEulerAngles = arg_719_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_722_1 = arg_719_1.actors_["4040ui_story"]

			if 0 < arg_719_1.time_ and arg_719_1.time_ <= 0 + arg_722_0 and not isNil(var_722_1) and arg_719_1.var_.characterEffect4040ui_story == nil then
				arg_719_1.var_.characterEffect4040ui_story = var_722_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_722_2 = 0.200000002980232

			if 0 <= arg_719_1.time_ and arg_719_1.time_ < 0 + var_722_2 and not isNil(var_722_1) then
				if arg_719_1.var_.characterEffect4040ui_story and not isNil(var_722_1) then
					arg_719_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_719_1.time_ >= 0 + var_722_2 and arg_719_1.time_ < 0 + var_722_2 + arg_722_0 and not isNil(var_722_1) and arg_719_1.var_.characterEffect4040ui_story then
				arg_719_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_719_1.time_ and arg_719_1.time_ <= 0 + arg_722_0 then
				arg_719_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_719_1.time_ and arg_719_1.time_ <= 0 + arg_722_0 then
				arg_719_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_722_4 = arg_719_1.actors_["10014ui_story"]

			if 0 < arg_719_1.time_ and arg_719_1.time_ <= 0 + arg_722_0 and not isNil(var_722_4) and arg_719_1.var_.characterEffect10014ui_story == nil then
				arg_719_1.var_.characterEffect10014ui_story = var_722_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_722_5 = 0.200000002980232

			if 0 <= arg_719_1.time_ and arg_719_1.time_ < 0 + var_722_5 and not isNil(var_722_4) then
				if arg_719_1.var_.characterEffect10014ui_story and not isNil(var_722_4) then
					arg_719_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_719_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_719_1.time_ - 0) / var_722_5)
				end
			end

			if arg_719_1.time_ >= 0 + var_722_5 and arg_719_1.time_ < 0 + var_722_5 + arg_722_0 and not isNil(var_722_4) and arg_719_1.var_.characterEffect10014ui_story then
				arg_719_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_719_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_722_6 = 0
			local var_722_7 = 0.125

			if 0 < arg_719_1.time_ and arg_719_1.time_ <= var_722_6 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0
				arg_719_1.dialogCg_.alpha = 1

				arg_719_1.dialog_:SetActive(true)
				SetActive(arg_719_1.leftNameGo_, true)

				arg_719_1.leftNameTxt_.text = arg_719_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_719_1.leftNameTxt_.transform)

				arg_719_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_719_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_719_1:RecordName(arg_719_1.leftNameTxt_.text)
				SetActive(arg_719_1.iconTrs_.gameObject, false)
				arg_719_1.callingController_:SetSelectedState("normal")

				local var_722_8 = arg_719_1:FormatText(arg_719_1:GetWordFromCfg(411331169).content)

				arg_719_1.text_.text = var_722_8

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.text_)

				local var_722_10 = 5 <= 0 and var_722_7 or var_722_7 * (utf8.len(var_722_8) / 5)

				if (5 <= 0 and var_722_7 or var_722_7 * (utf8.len(var_722_8) / 5)) > 0 and var_722_7 < var_722_10 then
					arg_719_1.talkMaxDuration = var_722_10

					if var_722_10 + var_722_6 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_10 + var_722_6
					end
				end

				arg_719_1.text_.text = var_722_8
				arg_719_1.typewritter.percent = 0

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(false)
				arg_719_1:RecordContent(arg_719_1.text_.text)
			end

			local var_722_11 = math.max(var_722_7, arg_719_1.talkMaxDuration)

			if var_722_6 <= arg_719_1.time_ and arg_719_1.time_ < var_722_6 + var_722_11 then
				arg_719_1.typewritter.percent = (arg_719_1.time_ - var_722_6) / var_722_11

				arg_719_1.typewritter:SetDirty()
			end

			if arg_719_1.time_ >= var_722_6 + var_722_11 and arg_719_1.time_ < var_722_6 + var_722_11 + arg_722_0 then
				arg_719_1.typewritter.percent = 1

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(true)
			end
		end

		arg_719_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_719_1:InitPlayNodeList()
	end,
	Play411331170 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 411331170
		arg_723_1.duration_ = 5

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play411331171(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			if 0 < arg_723_1.time_ and arg_723_1.time_ <= 0 + arg_726_0 and not isNil(arg_723_1.actors_["4040ui_story"]) and arg_723_1.var_.characterEffect4040ui_story == nil then
				arg_723_1.var_.characterEffect4040ui_story = arg_723_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_726_0 = 0.200000002980232

			if 0 <= arg_723_1.time_ and arg_723_1.time_ < 0 + var_726_0 and not isNil(arg_723_1.actors_["4040ui_story"]) then
				if arg_723_1.var_.characterEffect4040ui_story and not isNil(arg_723_1.actors_["4040ui_story"]) then
					arg_723_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_723_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_723_1.time_ - 0) / var_726_0)
				end
			end

			if arg_723_1.time_ >= 0 + var_726_0 and arg_723_1.time_ < 0 + var_726_0 + arg_726_0 and not isNil(arg_723_1.actors_["4040ui_story"]) and arg_723_1.var_.characterEffect4040ui_story then
				arg_723_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_723_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_726_1 = 0
			local var_726_2 = 1.175

			if 0 < arg_723_1.time_ and arg_723_1.time_ <= var_726_1 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0
				arg_723_1.dialogCg_.alpha = 1

				arg_723_1.dialog_:SetActive(true)
				SetActive(arg_723_1.leftNameGo_, false)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_723_1.iconTrs_.gameObject, false)
				arg_723_1.callingController_:SetSelectedState("normal")

				local var_726_3 = arg_723_1:FormatText(arg_723_1:GetWordFromCfg(411331170).content)

				arg_723_1.text_.text = var_726_3

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_5 = 47 <= 0 and var_726_2 or var_726_2 * (utf8.len(var_726_3) / 47)

				if (47 <= 0 and var_726_2 or var_726_2 * (utf8.len(var_726_3) / 47)) > 0 and var_726_2 < var_726_5 then
					arg_723_1.talkMaxDuration = var_726_5

					if var_726_5 + var_726_1 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_5 + var_726_1
					end
				end

				arg_723_1.text_.text = var_726_3
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)
				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_6 = math.max(var_726_2, arg_723_1.talkMaxDuration)

			if var_726_1 <= arg_723_1.time_ and arg_723_1.time_ < var_726_1 + var_726_6 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - var_726_1) / var_726_6

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= var_726_1 + var_726_6 and arg_723_1.time_ < var_726_1 + var_726_6 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end

		arg_723_1.nodeConfigList_ = {}

		arg_723_1:InitPlayNodeList()
	end,
	Play411331171 = function(arg_727_0, arg_727_1)
		arg_727_1.time_ = 0
		arg_727_1.frameCnt_ = 0
		arg_727_1.state_ = "playing"
		arg_727_1.curTalkId_ = 411331171
		arg_727_1.duration_ = 5

		SetActive(arg_727_1.tipsGo_, false)

		function arg_727_1.onSingleLineFinish_()
			arg_727_1.onSingleLineUpdate_ = nil
			arg_727_1.onSingleLineFinish_ = nil
			arg_727_1.state_ = "waiting"
		end

		function arg_727_1.playNext_(arg_729_0)
			if arg_729_0 == 1 then
				arg_727_0:Play411331172(arg_727_1)
			end
		end

		function arg_727_1.onSingleLineUpdate_(arg_730_0)
			if 0 < arg_727_1.time_ and arg_727_1.time_ <= 0 + arg_730_0 then
				arg_727_1.var_.moveOldPos10014ui_story = arg_727_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_730_0 = 0.001

			if 0 <= arg_727_1.time_ and arg_727_1.time_ < 0 + var_730_0 then
				arg_727_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_727_1.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_727_1.time_ - 0) / var_730_0)
				arg_727_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_727_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_727_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_727_1.actors_["10014ui_story"].transform.position).z)
				arg_727_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_727_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_727_1.actors_["10014ui_story"].transform.localEulerAngles = arg_727_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_727_1.time_ >= 0 + var_730_0 and arg_727_1.time_ < 0 + var_730_0 + arg_730_0 then
				arg_727_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_727_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_727_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_727_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_727_1.actors_["10014ui_story"].transform.position).z)
				arg_727_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_727_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_727_1.actors_["10014ui_story"].transform.localEulerAngles = arg_727_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_730_1 = arg_727_1.actors_["10014ui_story"]

			if 0 < arg_727_1.time_ and arg_727_1.time_ <= 0 + arg_730_0 and not isNil(var_730_1) and arg_727_1.var_.characterEffect10014ui_story == nil then
				arg_727_1.var_.characterEffect10014ui_story = var_730_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_730_2 = 0.200000002980232

			if 0 <= arg_727_1.time_ and arg_727_1.time_ < 0 + var_730_2 and not isNil(var_730_1) then
				if arg_727_1.var_.characterEffect10014ui_story and not isNil(var_730_1) then
					arg_727_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_727_1.time_ >= 0 + var_730_2 and arg_727_1.time_ < 0 + var_730_2 + arg_730_0 and not isNil(var_730_1) and arg_727_1.var_.characterEffect10014ui_story then
				arg_727_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_727_1.time_ and arg_727_1.time_ <= 0 + arg_730_0 then
				arg_727_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_727_1.time_ and arg_727_1.time_ <= 0 + arg_730_0 then
				arg_727_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_730_4 = 0
			local var_730_5 = 0.6

			if 0 < arg_727_1.time_ and arg_727_1.time_ <= var_730_4 + arg_730_0 then
				arg_727_1.talkMaxDuration = 0
				arg_727_1.dialogCg_.alpha = 1

				arg_727_1.dialog_:SetActive(true)
				SetActive(arg_727_1.leftNameGo_, true)

				arg_727_1.leftNameTxt_.text = arg_727_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_727_1.leftNameTxt_.transform)

				arg_727_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_727_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_727_1:RecordName(arg_727_1.leftNameTxt_.text)
				SetActive(arg_727_1.iconTrs_.gameObject, false)
				arg_727_1.callingController_:SetSelectedState("normal")

				local var_730_6 = arg_727_1:FormatText(arg_727_1:GetWordFromCfg(411331171).content)

				arg_727_1.text_.text = var_730_6

				LuaForUtil.ClearLinePrefixSymbol(arg_727_1.text_)

				local var_730_8 = 24 <= 0 and var_730_5 or var_730_5 * (utf8.len(var_730_6) / 24)

				if (24 <= 0 and var_730_5 or var_730_5 * (utf8.len(var_730_6) / 24)) > 0 and var_730_5 < var_730_8 then
					arg_727_1.talkMaxDuration = var_730_8

					if var_730_8 + var_730_4 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_8 + var_730_4
					end
				end

				arg_727_1.text_.text = var_730_6
				arg_727_1.typewritter.percent = 0

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(false)
				arg_727_1:RecordContent(arg_727_1.text_.text)
			end

			local var_730_9 = math.max(var_730_5, arg_727_1.talkMaxDuration)

			if var_730_4 <= arg_727_1.time_ and arg_727_1.time_ < var_730_4 + var_730_9 then
				arg_727_1.typewritter.percent = (arg_727_1.time_ - var_730_4) / var_730_9

				arg_727_1.typewritter:SetDirty()
			end

			if arg_727_1.time_ >= var_730_4 + var_730_9 and arg_727_1.time_ < var_730_4 + var_730_9 + arg_730_0 then
				arg_727_1.typewritter.percent = 1

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(true)
			end
		end

		arg_727_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_727_1:InitPlayNodeList()
	end,
	Play411331172 = function(arg_731_0, arg_731_1)
		arg_731_1.time_ = 0
		arg_731_1.frameCnt_ = 0
		arg_731_1.state_ = "playing"
		arg_731_1.curTalkId_ = 411331172
		arg_731_1.duration_ = 5

		SetActive(arg_731_1.tipsGo_, false)

		function arg_731_1.onSingleLineFinish_()
			arg_731_1.onSingleLineUpdate_ = nil
			arg_731_1.onSingleLineFinish_ = nil
			arg_731_1.state_ = "waiting"
		end

		function arg_731_1.playNext_(arg_733_0)
			if arg_733_0 == 1 then
				arg_731_0:Play411331173(arg_731_1)
			end
		end

		function arg_731_1.onSingleLineUpdate_(arg_734_0)
			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 then
				arg_731_1.var_.moveOldPos4040ui_story = arg_731_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_734_0 = 0.001

			if 0 <= arg_731_1.time_ and arg_731_1.time_ < 0 + var_734_0 then
				arg_731_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_731_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_731_1.time_ - 0) / var_734_0)
				arg_731_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_731_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_731_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_731_1.actors_["4040ui_story"].transform.position).z)
				arg_731_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_731_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_731_1.actors_["4040ui_story"].transform.localEulerAngles = arg_731_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_731_1.time_ >= 0 + var_734_0 and arg_731_1.time_ < 0 + var_734_0 + arg_734_0 then
				arg_731_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_731_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_731_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_731_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_731_1.actors_["4040ui_story"].transform.position).z)
				arg_731_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_731_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_731_1.actors_["4040ui_story"].transform.localEulerAngles = arg_731_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_734_1 = arg_731_1.actors_["4040ui_story"]

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 and not isNil(var_734_1) and arg_731_1.var_.characterEffect4040ui_story == nil then
				arg_731_1.var_.characterEffect4040ui_story = var_734_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_734_2 = 0.200000002980232

			if 0 <= arg_731_1.time_ and arg_731_1.time_ < 0 + var_734_2 and not isNil(var_734_1) then
				if arg_731_1.var_.characterEffect4040ui_story and not isNil(var_734_1) then
					arg_731_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_731_1.time_ >= 0 + var_734_2 and arg_731_1.time_ < 0 + var_734_2 + arg_734_0 and not isNil(var_734_1) and arg_731_1.var_.characterEffect4040ui_story then
				arg_731_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 then
				arg_731_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 then
				arg_731_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_734_4 = arg_731_1.actors_["10014ui_story"]

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 and not isNil(var_734_4) and arg_731_1.var_.characterEffect10014ui_story == nil then
				arg_731_1.var_.characterEffect10014ui_story = var_734_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_734_5 = 0.200000002980232

			if 0 <= arg_731_1.time_ and arg_731_1.time_ < 0 + var_734_5 and not isNil(var_734_4) then
				if arg_731_1.var_.characterEffect10014ui_story and not isNil(var_734_4) then
					arg_731_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_731_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_731_1.time_ - 0) / var_734_5)
				end
			end

			if arg_731_1.time_ >= 0 + var_734_5 and arg_731_1.time_ < 0 + var_734_5 + arg_734_0 and not isNil(var_734_4) and arg_731_1.var_.characterEffect10014ui_story then
				arg_731_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_731_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_734_6 = 0
			local var_734_7 = 0.275

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= var_734_6 + arg_734_0 then
				arg_731_1.talkMaxDuration = 0
				arg_731_1.dialogCg_.alpha = 1

				arg_731_1.dialog_:SetActive(true)
				SetActive(arg_731_1.leftNameGo_, true)

				arg_731_1.leftNameTxt_.text = arg_731_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_731_1.leftNameTxt_.transform)

				arg_731_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_731_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_731_1:RecordName(arg_731_1.leftNameTxt_.text)
				SetActive(arg_731_1.iconTrs_.gameObject, false)
				arg_731_1.callingController_:SetSelectedState("normal")

				local var_734_8 = arg_731_1:FormatText(arg_731_1:GetWordFromCfg(411331172).content)

				arg_731_1.text_.text = var_734_8

				LuaForUtil.ClearLinePrefixSymbol(arg_731_1.text_)

				local var_734_10 = 11 <= 0 and var_734_7 or var_734_7 * (utf8.len(var_734_8) / 11)

				if (11 <= 0 and var_734_7 or var_734_7 * (utf8.len(var_734_8) / 11)) > 0 and var_734_7 < var_734_10 then
					arg_731_1.talkMaxDuration = var_734_10

					if var_734_10 + var_734_6 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_10 + var_734_6
					end
				end

				arg_731_1.text_.text = var_734_8
				arg_731_1.typewritter.percent = 0

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(false)
				arg_731_1:RecordContent(arg_731_1.text_.text)
			end

			local var_734_11 = math.max(var_734_7, arg_731_1.talkMaxDuration)

			if var_734_6 <= arg_731_1.time_ and arg_731_1.time_ < var_734_6 + var_734_11 then
				arg_731_1.typewritter.percent = (arg_731_1.time_ - var_734_6) / var_734_11

				arg_731_1.typewritter:SetDirty()
			end

			if arg_731_1.time_ >= var_734_6 + var_734_11 and arg_731_1.time_ < var_734_6 + var_734_11 + arg_734_0 then
				arg_731_1.typewritter.percent = 1

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(true)
			end
		end

		arg_731_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_731_1:InitPlayNodeList()
	end,
	Play411331173 = function(arg_735_0, arg_735_1)
		arg_735_1.time_ = 0
		arg_735_1.frameCnt_ = 0
		arg_735_1.state_ = "playing"
		arg_735_1.curTalkId_ = 411331173
		arg_735_1.duration_ = 5

		SetActive(arg_735_1.tipsGo_, false)

		function arg_735_1.onSingleLineFinish_()
			arg_735_1.onSingleLineUpdate_ = nil
			arg_735_1.onSingleLineFinish_ = nil
			arg_735_1.state_ = "waiting"
		end

		function arg_735_1.playNext_(arg_737_0)
			if arg_737_0 == 1 then
				arg_735_0:Play411331174(arg_735_1)
			end
		end

		function arg_735_1.onSingleLineUpdate_(arg_738_0)
			if 0 < arg_735_1.time_ and arg_735_1.time_ <= 0 + arg_738_0 and not isNil(arg_735_1.actors_["4040ui_story"]) and arg_735_1.var_.characterEffect4040ui_story == nil then
				arg_735_1.var_.characterEffect4040ui_story = arg_735_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_738_0 = 0.200000002980232

			if 0 <= arg_735_1.time_ and arg_735_1.time_ < 0 + var_738_0 and not isNil(arg_735_1.actors_["4040ui_story"]) then
				if arg_735_1.var_.characterEffect4040ui_story and not isNil(arg_735_1.actors_["4040ui_story"]) then
					arg_735_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_735_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_735_1.time_ - 0) / var_738_0)
				end
			end

			if arg_735_1.time_ >= 0 + var_738_0 and arg_735_1.time_ < 0 + var_738_0 + arg_738_0 and not isNil(arg_735_1.actors_["4040ui_story"]) and arg_735_1.var_.characterEffect4040ui_story then
				arg_735_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_735_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_738_1 = 0
			local var_738_2 = 0.6

			if 0 < arg_735_1.time_ and arg_735_1.time_ <= var_738_1 + arg_738_0 then
				arg_735_1.talkMaxDuration = 0
				arg_735_1.dialogCg_.alpha = 1

				arg_735_1.dialog_:SetActive(true)
				SetActive(arg_735_1.leftNameGo_, false)

				arg_735_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_735_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_735_1:RecordName(arg_735_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_735_1.iconTrs_.gameObject, false)
				arg_735_1.callingController_:SetSelectedState("normal")

				local var_738_3 = arg_735_1:FormatText(arg_735_1:GetWordFromCfg(411331173).content)

				arg_735_1.text_.text = var_738_3

				LuaForUtil.ClearLinePrefixSymbol(arg_735_1.text_)

				local var_738_5 = 24 <= 0 and var_738_2 or var_738_2 * (utf8.len(var_738_3) / 24)

				if (24 <= 0 and var_738_2 or var_738_2 * (utf8.len(var_738_3) / 24)) > 0 and var_738_2 < var_738_5 then
					arg_735_1.talkMaxDuration = var_738_5

					if var_738_5 + var_738_1 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_5 + var_738_1
					end
				end

				arg_735_1.text_.text = var_738_3
				arg_735_1.typewritter.percent = 0

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(false)
				arg_735_1:RecordContent(arg_735_1.text_.text)
			end

			local var_738_6 = math.max(var_738_2, arg_735_1.talkMaxDuration)

			if var_738_1 <= arg_735_1.time_ and arg_735_1.time_ < var_738_1 + var_738_6 then
				arg_735_1.typewritter.percent = (arg_735_1.time_ - var_738_1) / var_738_6

				arg_735_1.typewritter:SetDirty()
			end

			if arg_735_1.time_ >= var_738_1 + var_738_6 and arg_735_1.time_ < var_738_1 + var_738_6 + arg_738_0 then
				arg_735_1.typewritter.percent = 1

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(true)
			end
		end

		arg_735_1.nodeConfigList_ = {}

		arg_735_1:InitPlayNodeList()
	end,
	Play411331174 = function(arg_739_0, arg_739_1)
		arg_739_1.time_ = 0
		arg_739_1.frameCnt_ = 0
		arg_739_1.state_ = "playing"
		arg_739_1.curTalkId_ = 411331174
		arg_739_1.duration_ = 5

		SetActive(arg_739_1.tipsGo_, false)

		function arg_739_1.onSingleLineFinish_()
			arg_739_1.onSingleLineUpdate_ = nil
			arg_739_1.onSingleLineFinish_ = nil
			arg_739_1.state_ = "waiting"
		end

		function arg_739_1.playNext_(arg_741_0)
			if arg_741_0 == 1 then
				arg_739_0:Play411331175(arg_739_1)
			end
		end

		function arg_739_1.onSingleLineUpdate_(arg_742_0)
			if 0 < arg_739_1.time_ and arg_739_1.time_ <= 0 + arg_742_0 then
				arg_739_1.var_.moveOldPos4040ui_story = arg_739_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_742_0 = 0.001

			if 0 <= arg_739_1.time_ and arg_739_1.time_ < 0 + var_742_0 then
				arg_739_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_739_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_739_1.time_ - 0) / var_742_0)
				arg_739_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_739_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_739_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_739_1.actors_["4040ui_story"].transform.position).z)
				arg_739_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_739_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_739_1.actors_["4040ui_story"].transform.localEulerAngles = arg_739_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_739_1.time_ >= 0 + var_742_0 and arg_739_1.time_ < 0 + var_742_0 + arg_742_0 then
				arg_739_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_739_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_739_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_739_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_739_1.actors_["4040ui_story"].transform.position).z)
				arg_739_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_739_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_739_1.actors_["4040ui_story"].transform.localEulerAngles = arg_739_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_742_1 = arg_739_1.actors_["4040ui_story"]

			if 0 < arg_739_1.time_ and arg_739_1.time_ <= 0 + arg_742_0 and not isNil(var_742_1) and arg_739_1.var_.characterEffect4040ui_story == nil then
				arg_739_1.var_.characterEffect4040ui_story = var_742_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_742_2 = 0.200000002980232

			if 0 <= arg_739_1.time_ and arg_739_1.time_ < 0 + var_742_2 and not isNil(var_742_1) then
				if arg_739_1.var_.characterEffect4040ui_story and not isNil(var_742_1) then
					arg_739_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_739_1.time_ >= 0 + var_742_2 and arg_739_1.time_ < 0 + var_742_2 + arg_742_0 and not isNil(var_742_1) and arg_739_1.var_.characterEffect4040ui_story then
				arg_739_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_739_1.time_ and arg_739_1.time_ <= 0 + arg_742_0 then
				arg_739_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_742_4 = 0
			local var_742_5 = 0.5

			if 0 < arg_739_1.time_ and arg_739_1.time_ <= var_742_4 + arg_742_0 then
				arg_739_1.talkMaxDuration = 0
				arg_739_1.dialogCg_.alpha = 1

				arg_739_1.dialog_:SetActive(true)
				SetActive(arg_739_1.leftNameGo_, true)

				arg_739_1.leftNameTxt_.text = arg_739_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_739_1.leftNameTxt_.transform)

				arg_739_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_739_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_739_1:RecordName(arg_739_1.leftNameTxt_.text)
				SetActive(arg_739_1.iconTrs_.gameObject, false)
				arg_739_1.callingController_:SetSelectedState("normal")

				local var_742_6 = arg_739_1:FormatText(arg_739_1:GetWordFromCfg(411331174).content)

				arg_739_1.text_.text = var_742_6

				LuaForUtil.ClearLinePrefixSymbol(arg_739_1.text_)

				local var_742_8 = 20 <= 0 and var_742_5 or var_742_5 * (utf8.len(var_742_6) / 20)

				if (20 <= 0 and var_742_5 or var_742_5 * (utf8.len(var_742_6) / 20)) > 0 and var_742_5 < var_742_8 then
					arg_739_1.talkMaxDuration = var_742_8

					if var_742_8 + var_742_4 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_8 + var_742_4
					end
				end

				arg_739_1.text_.text = var_742_6
				arg_739_1.typewritter.percent = 0

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(false)
				arg_739_1:RecordContent(arg_739_1.text_.text)
			end

			local var_742_9 = math.max(var_742_5, arg_739_1.talkMaxDuration)

			if var_742_4 <= arg_739_1.time_ and arg_739_1.time_ < var_742_4 + var_742_9 then
				arg_739_1.typewritter.percent = (arg_739_1.time_ - var_742_4) / var_742_9

				arg_739_1.typewritter:SetDirty()
			end

			if arg_739_1.time_ >= var_742_4 + var_742_9 and arg_739_1.time_ < var_742_4 + var_742_9 + arg_742_0 then
				arg_739_1.typewritter.percent = 1

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(true)
			end
		end

		arg_739_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_739_1:InitPlayNodeList()
	end,
	Play411331175 = function(arg_743_0, arg_743_1)
		arg_743_1.time_ = 0
		arg_743_1.frameCnt_ = 0
		arg_743_1.state_ = "playing"
		arg_743_1.curTalkId_ = 411331175
		arg_743_1.duration_ = 5

		SetActive(arg_743_1.tipsGo_, false)

		function arg_743_1.onSingleLineFinish_()
			arg_743_1.onSingleLineUpdate_ = nil
			arg_743_1.onSingleLineFinish_ = nil
			arg_743_1.state_ = "waiting"
		end

		function arg_743_1.playNext_(arg_745_0)
			if arg_745_0 == 1 then
				arg_743_0:Play411331176(arg_743_1)
			end
		end

		function arg_743_1.onSingleLineUpdate_(arg_746_0)
			if 0 < arg_743_1.time_ and arg_743_1.time_ <= 0 + arg_746_0 then
				arg_743_1.var_.moveOldPos4040ui_story = arg_743_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_746_0 = 0.001

			if 0 <= arg_743_1.time_ and arg_743_1.time_ < 0 + var_746_0 then
				arg_743_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_743_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_743_1.time_ - 0) / var_746_0)
				arg_743_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_743_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_743_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_743_1.actors_["4040ui_story"].transform.position).z)
				arg_743_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_743_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_743_1.actors_["4040ui_story"].transform.localEulerAngles = arg_743_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_743_1.time_ >= 0 + var_746_0 and arg_743_1.time_ < 0 + var_746_0 + arg_746_0 then
				arg_743_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_743_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_743_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_743_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_743_1.actors_["4040ui_story"].transform.position).z)
				arg_743_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_743_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_743_1.actors_["4040ui_story"].transform.localEulerAngles = arg_743_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_746_1 = arg_743_1.actors_["4040ui_story"]

			if 0 < arg_743_1.time_ and arg_743_1.time_ <= 0 + arg_746_0 and not isNil(var_746_1) and arg_743_1.var_.characterEffect4040ui_story == nil then
				arg_743_1.var_.characterEffect4040ui_story = var_746_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_746_2 = 0.200000002980232

			if 0 <= arg_743_1.time_ and arg_743_1.time_ < 0 + var_746_2 and not isNil(var_746_1) then
				if arg_743_1.var_.characterEffect4040ui_story and not isNil(var_746_1) then
					arg_743_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_743_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_743_1.time_ - 0) / var_746_2)
				end
			end

			if arg_743_1.time_ >= 0 + var_746_2 and arg_743_1.time_ < 0 + var_746_2 + arg_746_0 and not isNil(var_746_1) and arg_743_1.var_.characterEffect4040ui_story then
				arg_743_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_743_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_746_3 = arg_743_1.actors_["10014ui_story"].transform

			if 0 < arg_743_1.time_ and arg_743_1.time_ <= 0 + arg_746_0 then
				arg_743_1.var_.moveOldPos10014ui_story = var_746_3.localPosition
			end

			local var_746_4 = 0.001

			if 0 <= arg_743_1.time_ and arg_743_1.time_ < 0 + var_746_4 then
				var_746_3.localPosition = Vector3.Lerp(arg_743_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_743_1.time_ - 0) / var_746_4)
				var_746_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_746_3.position).x, (manager.ui.mainCamera.transform.position - var_746_3.position).y, (manager.ui.mainCamera.transform.position - var_746_3.position).z)
				var_746_3.localEulerAngles.z = 0
				var_746_3.localEulerAngles.x = 0
				var_746_3.localEulerAngles = var_746_3.localEulerAngles
			end

			if arg_743_1.time_ >= 0 + var_746_4 and arg_743_1.time_ < 0 + var_746_4 + arg_746_0 then
				var_746_3.localPosition = Vector3.New(0, 100, 0)
				var_746_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_746_3.position).x, (manager.ui.mainCamera.transform.position - var_746_3.position).y, (manager.ui.mainCamera.transform.position - var_746_3.position).z)
				var_746_3.localEulerAngles.z = 0
				var_746_3.localEulerAngles.x = 0
				var_746_3.localEulerAngles = var_746_3.localEulerAngles
			end

			local var_746_5 = arg_743_1.actors_["10014ui_story"]

			if 0 < arg_743_1.time_ and arg_743_1.time_ <= 0 + arg_746_0 and not isNil(var_746_5) and arg_743_1.var_.characterEffect10014ui_story == nil then
				arg_743_1.var_.characterEffect10014ui_story = var_746_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_746_6 = 0.200000002980232

			if 0 <= arg_743_1.time_ and arg_743_1.time_ < 0 + var_746_6 and not isNil(var_746_5) then
				if arg_743_1.var_.characterEffect10014ui_story and not isNil(var_746_5) then
					arg_743_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_743_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_743_1.time_ - 0) / var_746_6)
				end
			end

			if arg_743_1.time_ >= 0 + var_746_6 and arg_743_1.time_ < 0 + var_746_6 + arg_746_0 and not isNil(var_746_5) and arg_743_1.var_.characterEffect10014ui_story then
				arg_743_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_743_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_746_7 = 0
			local var_746_8 = 1.325

			if 0 < arg_743_1.time_ and arg_743_1.time_ <= var_746_7 + arg_746_0 then
				arg_743_1.talkMaxDuration = 0
				arg_743_1.dialogCg_.alpha = 1

				arg_743_1.dialog_:SetActive(true)
				SetActive(arg_743_1.leftNameGo_, false)

				arg_743_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_743_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_743_1:RecordName(arg_743_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_743_1.iconTrs_.gameObject, false)
				arg_743_1.callingController_:SetSelectedState("normal")

				local var_746_9 = arg_743_1:FormatText(arg_743_1:GetWordFromCfg(411331175).content)

				arg_743_1.text_.text = var_746_9

				LuaForUtil.ClearLinePrefixSymbol(arg_743_1.text_)

				local var_746_11 = 53 <= 0 and var_746_8 or var_746_8 * (utf8.len(var_746_9) / 53)

				if (53 <= 0 and var_746_8 or var_746_8 * (utf8.len(var_746_9) / 53)) > 0 and var_746_8 < var_746_11 then
					arg_743_1.talkMaxDuration = var_746_11

					if var_746_11 + var_746_7 > arg_743_1.duration_ then
						arg_743_1.duration_ = var_746_11 + var_746_7
					end
				end

				arg_743_1.text_.text = var_746_9
				arg_743_1.typewritter.percent = 0

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(false)
				arg_743_1:RecordContent(arg_743_1.text_.text)
			end

			local var_746_12 = math.max(var_746_8, arg_743_1.talkMaxDuration)

			if var_746_7 <= arg_743_1.time_ and arg_743_1.time_ < var_746_7 + var_746_12 then
				arg_743_1.typewritter.percent = (arg_743_1.time_ - var_746_7) / var_746_12

				arg_743_1.typewritter:SetDirty()
			end

			if arg_743_1.time_ >= var_746_7 + var_746_12 and arg_743_1.time_ < var_746_7 + var_746_12 + arg_746_0 then
				arg_743_1.typewritter.percent = 1

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(true)
			end
		end

		arg_743_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_743_1:InitPlayNodeList()
	end,
	Play411331176 = function(arg_747_0, arg_747_1)
		arg_747_1.time_ = 0
		arg_747_1.frameCnt_ = 0
		arg_747_1.state_ = "playing"
		arg_747_1.curTalkId_ = 411331176
		arg_747_1.duration_ = 5

		SetActive(arg_747_1.tipsGo_, false)

		function arg_747_1.onSingleLineFinish_()
			arg_747_1.onSingleLineUpdate_ = nil
			arg_747_1.onSingleLineFinish_ = nil
			arg_747_1.state_ = "waiting"
		end

		function arg_747_1.playNext_(arg_749_0)
			if arg_749_0 == 1 then
				arg_747_0:Play411331177(arg_747_1)
			end
		end

		function arg_747_1.onSingleLineUpdate_(arg_750_0)
			if 0 < arg_747_1.time_ and arg_747_1.time_ <= 0 + arg_750_0 then
				arg_747_1.var_.moveOldPos10014ui_story = arg_747_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_750_0 = 0.001

			if 0 <= arg_747_1.time_ and arg_747_1.time_ < 0 + var_750_0 then
				arg_747_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_747_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_747_1.time_ - 0) / var_750_0)
				arg_747_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_747_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_747_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_747_1.actors_["10014ui_story"].transform.position).z)
				arg_747_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_747_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_747_1.actors_["10014ui_story"].transform.localEulerAngles = arg_747_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_747_1.time_ >= 0 + var_750_0 and arg_747_1.time_ < 0 + var_750_0 + arg_750_0 then
				arg_747_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_747_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_747_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_747_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_747_1.actors_["10014ui_story"].transform.position).z)
				arg_747_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_747_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_747_1.actors_["10014ui_story"].transform.localEulerAngles = arg_747_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_750_1 = arg_747_1.actors_["10014ui_story"]

			if 0 < arg_747_1.time_ and arg_747_1.time_ <= 0 + arg_750_0 and not isNil(var_750_1) and arg_747_1.var_.characterEffect10014ui_story == nil then
				arg_747_1.var_.characterEffect10014ui_story = var_750_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_750_2 = 0.200000002980232

			if 0 <= arg_747_1.time_ and arg_747_1.time_ < 0 + var_750_2 and not isNil(var_750_1) then
				if arg_747_1.var_.characterEffect10014ui_story and not isNil(var_750_1) then
					arg_747_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_747_1.time_ >= 0 + var_750_2 and arg_747_1.time_ < 0 + var_750_2 + arg_750_0 and not isNil(var_750_1) and arg_747_1.var_.characterEffect10014ui_story then
				arg_747_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_747_1.time_ and arg_747_1.time_ <= 0 + arg_750_0 then
				arg_747_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_747_1.time_ and arg_747_1.time_ <= 0 + arg_750_0 then
				arg_747_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_750_4 = 0
			local var_750_5 = 0.075

			if 0 < arg_747_1.time_ and arg_747_1.time_ <= var_750_4 + arg_750_0 then
				arg_747_1.talkMaxDuration = 0
				arg_747_1.dialogCg_.alpha = 1

				arg_747_1.dialog_:SetActive(true)
				SetActive(arg_747_1.leftNameGo_, true)

				arg_747_1.leftNameTxt_.text = arg_747_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_747_1.leftNameTxt_.transform)

				arg_747_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_747_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_747_1:RecordName(arg_747_1.leftNameTxt_.text)
				SetActive(arg_747_1.iconTrs_.gameObject, false)
				arg_747_1.callingController_:SetSelectedState("normal")

				local var_750_6 = arg_747_1:FormatText(arg_747_1:GetWordFromCfg(411331176).content)

				arg_747_1.text_.text = var_750_6

				LuaForUtil.ClearLinePrefixSymbol(arg_747_1.text_)

				local var_750_8 = 3 <= 0 and var_750_5 or var_750_5 * (utf8.len(var_750_6) / 3)

				if (3 <= 0 and var_750_5 or var_750_5 * (utf8.len(var_750_6) / 3)) > 0 and var_750_5 < var_750_8 then
					arg_747_1.talkMaxDuration = var_750_8

					if var_750_8 + var_750_4 > arg_747_1.duration_ then
						arg_747_1.duration_ = var_750_8 + var_750_4
					end
				end

				arg_747_1.text_.text = var_750_6
				arg_747_1.typewritter.percent = 0

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(false)
				arg_747_1:RecordContent(arg_747_1.text_.text)
			end

			local var_750_9 = math.max(var_750_5, arg_747_1.talkMaxDuration)

			if var_750_4 <= arg_747_1.time_ and arg_747_1.time_ < var_750_4 + var_750_9 then
				arg_747_1.typewritter.percent = (arg_747_1.time_ - var_750_4) / var_750_9

				arg_747_1.typewritter:SetDirty()
			end

			if arg_747_1.time_ >= var_750_4 + var_750_9 and arg_747_1.time_ < var_750_4 + var_750_9 + arg_750_0 then
				arg_747_1.typewritter.percent = 1

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(true)
			end
		end

		arg_747_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_747_1:InitPlayNodeList()
	end,
	Play411331177 = function(arg_751_0, arg_751_1)
		arg_751_1.time_ = 0
		arg_751_1.frameCnt_ = 0
		arg_751_1.state_ = "playing"
		arg_751_1.curTalkId_ = 411331177
		arg_751_1.duration_ = 5

		SetActive(arg_751_1.tipsGo_, false)

		function arg_751_1.onSingleLineFinish_()
			arg_751_1.onSingleLineUpdate_ = nil
			arg_751_1.onSingleLineFinish_ = nil
			arg_751_1.state_ = "waiting"
		end

		function arg_751_1.playNext_(arg_753_0)
			if arg_753_0 == 1 then
				arg_751_0:Play411331178(arg_751_1)
			end
		end

		function arg_751_1.onSingleLineUpdate_(arg_754_0)
			if 0 < arg_751_1.time_ and arg_751_1.time_ <= 0 + arg_754_0 then
				arg_751_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			local var_754_0 = 0
			local var_754_1 = 0.4

			if 0 < arg_751_1.time_ and arg_751_1.time_ <= var_754_0 + arg_754_0 then
				arg_751_1.talkMaxDuration = 0
				arg_751_1.dialogCg_.alpha = 1

				arg_751_1.dialog_:SetActive(true)
				SetActive(arg_751_1.leftNameGo_, true)

				arg_751_1.leftNameTxt_.text = arg_751_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_751_1.leftNameTxt_.transform)

				arg_751_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_751_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_751_1:RecordName(arg_751_1.leftNameTxt_.text)
				SetActive(arg_751_1.iconTrs_.gameObject, false)
				arg_751_1.callingController_:SetSelectedState("normal")

				local var_754_2 = arg_751_1:FormatText(arg_751_1:GetWordFromCfg(411331177).content)

				arg_751_1.text_.text = var_754_2

				LuaForUtil.ClearLinePrefixSymbol(arg_751_1.text_)

				local var_754_4 = 16 <= 0 and var_754_1 or var_754_1 * (utf8.len(var_754_2) / 16)

				if (16 <= 0 and var_754_1 or var_754_1 * (utf8.len(var_754_2) / 16)) > 0 and var_754_1 < var_754_4 then
					arg_751_1.talkMaxDuration = var_754_4

					if var_754_4 + var_754_0 > arg_751_1.duration_ then
						arg_751_1.duration_ = var_754_4 + var_754_0
					end
				end

				arg_751_1.text_.text = var_754_2
				arg_751_1.typewritter.percent = 0

				arg_751_1.typewritter:SetDirty()
				arg_751_1:ShowNextGo(false)
				arg_751_1:RecordContent(arg_751_1.text_.text)
			end

			local var_754_5 = math.max(var_754_1, arg_751_1.talkMaxDuration)

			if var_754_0 <= arg_751_1.time_ and arg_751_1.time_ < var_754_0 + var_754_5 then
				arg_751_1.typewritter.percent = (arg_751_1.time_ - var_754_0) / var_754_5

				arg_751_1.typewritter:SetDirty()
			end

			if arg_751_1.time_ >= var_754_0 + var_754_5 and arg_751_1.time_ < var_754_0 + var_754_5 + arg_754_0 then
				arg_751_1.typewritter.percent = 1

				arg_751_1.typewritter:SetDirty()
				arg_751_1:ShowNextGo(true)
			end
		end

		arg_751_1.nodeConfigList_ = {}

		arg_751_1:InitPlayNodeList()
	end,
	Play411331178 = function(arg_755_0, arg_755_1)
		arg_755_1.time_ = 0
		arg_755_1.frameCnt_ = 0
		arg_755_1.state_ = "playing"
		arg_755_1.curTalkId_ = 411331178
		arg_755_1.duration_ = 5

		SetActive(arg_755_1.tipsGo_, false)

		function arg_755_1.onSingleLineFinish_()
			arg_755_1.onSingleLineUpdate_ = nil
			arg_755_1.onSingleLineFinish_ = nil
			arg_755_1.state_ = "waiting"
		end

		function arg_755_1.playNext_(arg_757_0)
			if arg_757_0 == 1 then
				arg_755_0:Play411331179(arg_755_1)
			end
		end

		function arg_755_1.onSingleLineUpdate_(arg_758_0)
			if 0 < arg_755_1.time_ and arg_755_1.time_ <= 0 + arg_758_0 then
				arg_755_1.var_.moveOldPos10014ui_story = arg_755_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_758_0 = 0.001

			if 0 <= arg_755_1.time_ and arg_755_1.time_ < 0 + var_758_0 then
				arg_755_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_755_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_755_1.time_ - 0) / var_758_0)
				arg_755_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_755_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_755_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_755_1.actors_["10014ui_story"].transform.position).z)
				arg_755_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_755_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_755_1.actors_["10014ui_story"].transform.localEulerAngles = arg_755_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_755_1.time_ >= 0 + var_758_0 and arg_755_1.time_ < 0 + var_758_0 + arg_758_0 then
				arg_755_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_755_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_755_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_755_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_755_1.actors_["10014ui_story"].transform.position).z)
				arg_755_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_755_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_755_1.actors_["10014ui_story"].transform.localEulerAngles = arg_755_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_758_1 = arg_755_1.actors_["10014ui_story"]

			if 0 < arg_755_1.time_ and arg_755_1.time_ <= 0 + arg_758_0 and not isNil(var_758_1) and arg_755_1.var_.characterEffect10014ui_story == nil then
				arg_755_1.var_.characterEffect10014ui_story = var_758_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_758_2 = 0.200000002980232

			if 0 <= arg_755_1.time_ and arg_755_1.time_ < 0 + var_758_2 and not isNil(var_758_1) then
				if arg_755_1.var_.characterEffect10014ui_story and not isNil(var_758_1) then
					arg_755_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_755_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_755_1.time_ - 0) / var_758_2)
				end
			end

			if arg_755_1.time_ >= 0 + var_758_2 and arg_755_1.time_ < 0 + var_758_2 + arg_758_0 and not isNil(var_758_1) and arg_755_1.var_.characterEffect10014ui_story then
				arg_755_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_755_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_758_3 = 0
			local var_758_4 = 1.3

			if 0 < arg_755_1.time_ and arg_755_1.time_ <= var_758_3 + arg_758_0 then
				arg_755_1.talkMaxDuration = 0
				arg_755_1.dialogCg_.alpha = 1

				arg_755_1.dialog_:SetActive(true)
				SetActive(arg_755_1.leftNameGo_, false)

				arg_755_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_755_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_755_1:RecordName(arg_755_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_755_1.iconTrs_.gameObject, false)
				arg_755_1.callingController_:SetSelectedState("normal")

				local var_758_5 = arg_755_1:FormatText(arg_755_1:GetWordFromCfg(411331178).content)

				arg_755_1.text_.text = var_758_5

				LuaForUtil.ClearLinePrefixSymbol(arg_755_1.text_)

				local var_758_7 = 52 <= 0 and var_758_4 or var_758_4 * (utf8.len(var_758_5) / 52)

				if (52 <= 0 and var_758_4 or var_758_4 * (utf8.len(var_758_5) / 52)) > 0 and var_758_4 < var_758_7 then
					arg_755_1.talkMaxDuration = var_758_7

					if var_758_7 + var_758_3 > arg_755_1.duration_ then
						arg_755_1.duration_ = var_758_7 + var_758_3
					end
				end

				arg_755_1.text_.text = var_758_5
				arg_755_1.typewritter.percent = 0

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(false)
				arg_755_1:RecordContent(arg_755_1.text_.text)
			end

			local var_758_8 = math.max(var_758_4, arg_755_1.talkMaxDuration)

			if var_758_3 <= arg_755_1.time_ and arg_755_1.time_ < var_758_3 + var_758_8 then
				arg_755_1.typewritter.percent = (arg_755_1.time_ - var_758_3) / var_758_8

				arg_755_1.typewritter:SetDirty()
			end

			if arg_755_1.time_ >= var_758_3 + var_758_8 and arg_755_1.time_ < var_758_3 + var_758_8 + arg_758_0 then
				arg_755_1.typewritter.percent = 1

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(true)
			end
		end

		arg_755_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_755_1:InitPlayNodeList()
	end,
	Play411331179 = function(arg_759_0, arg_759_1)
		arg_759_1.time_ = 0
		arg_759_1.frameCnt_ = 0
		arg_759_1.state_ = "playing"
		arg_759_1.curTalkId_ = 411331179
		arg_759_1.duration_ = 5

		SetActive(arg_759_1.tipsGo_, false)

		function arg_759_1.onSingleLineFinish_()
			arg_759_1.onSingleLineUpdate_ = nil
			arg_759_1.onSingleLineFinish_ = nil
			arg_759_1.state_ = "waiting"
		end

		function arg_759_1.playNext_(arg_761_0)
			if arg_761_0 == 1 then
				arg_759_0:Play411331180(arg_759_1)
			end
		end

		function arg_759_1.onSingleLineUpdate_(arg_762_0)
			if 0 < arg_759_1.time_ and arg_759_1.time_ <= 0 + arg_762_0 then
				local var_762_0 = arg_759_1.var_.effectshiwang2

				if not arg_759_1.var_.effectshiwang2 then
					var_762_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), manager.ui.mainCamera.transform)
					var_762_0.name = "shiwang2"
					arg_759_1.var_.effectshiwang2 = var_762_0
				else
					var_762_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_762_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_762_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_762_2 = 0
			local var_762_3 = 0.425

			if 0 < arg_759_1.time_ and arg_759_1.time_ <= var_762_2 + arg_762_0 then
				arg_759_1.talkMaxDuration = 0
				arg_759_1.dialogCg_.alpha = 1

				arg_759_1.dialog_:SetActive(true)
				SetActive(arg_759_1.leftNameGo_, false)

				arg_759_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_759_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_759_1:RecordName(arg_759_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_759_1.iconTrs_.gameObject, false)
				arg_759_1.callingController_:SetSelectedState("normal")

				local var_762_4 = arg_759_1:FormatText(arg_759_1:GetWordFromCfg(411331179).content)

				arg_759_1.text_.text = var_762_4

				LuaForUtil.ClearLinePrefixSymbol(arg_759_1.text_)

				local var_762_6 = 17 <= 0 and var_762_3 or var_762_3 * (utf8.len(var_762_4) / 17)

				if (17 <= 0 and var_762_3 or var_762_3 * (utf8.len(var_762_4) / 17)) > 0 and var_762_3 < var_762_6 then
					arg_759_1.talkMaxDuration = var_762_6

					if var_762_6 + var_762_2 > arg_759_1.duration_ then
						arg_759_1.duration_ = var_762_6 + var_762_2
					end
				end

				arg_759_1.text_.text = var_762_4
				arg_759_1.typewritter.percent = 0

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(false)
				arg_759_1:RecordContent(arg_759_1.text_.text)
			end

			local var_762_7 = math.max(var_762_3, arg_759_1.talkMaxDuration)

			if var_762_2 <= arg_759_1.time_ and arg_759_1.time_ < var_762_2 + var_762_7 then
				arg_759_1.typewritter.percent = (arg_759_1.time_ - var_762_2) / var_762_7

				arg_759_1.typewritter:SetDirty()
			end

			if arg_759_1.time_ >= var_762_2 + var_762_7 and arg_759_1.time_ < var_762_2 + var_762_7 + arg_762_0 then
				arg_759_1.typewritter.percent = 1

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(true)
			end
		end

		arg_759_1.nodeConfigList_ = {}

		arg_759_1:InitPlayNodeList()
	end,
	Play411331180 = function(arg_763_0, arg_763_1)
		arg_763_1.time_ = 0
		arg_763_1.frameCnt_ = 0
		arg_763_1.state_ = "playing"
		arg_763_1.curTalkId_ = 411331180
		arg_763_1.duration_ = 5

		SetActive(arg_763_1.tipsGo_, false)

		function arg_763_1.onSingleLineFinish_()
			arg_763_1.onSingleLineUpdate_ = nil
			arg_763_1.onSingleLineFinish_ = nil
			arg_763_1.state_ = "waiting"
		end

		function arg_763_1.playNext_(arg_765_0)
			if arg_765_0 == 1 then
				arg_763_0:Play411331181(arg_763_1)
			end
		end

		function arg_763_1.onSingleLineUpdate_(arg_766_0)
			local var_766_0 = 0.9

			if 0 < arg_763_1.time_ and arg_763_1.time_ <= 0 + arg_766_0 then
				arg_763_1.talkMaxDuration = 0
				arg_763_1.dialogCg_.alpha = 1

				arg_763_1.dialog_:SetActive(true)
				SetActive(arg_763_1.leftNameGo_, false)

				arg_763_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_763_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_763_1:RecordName(arg_763_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_763_1.iconTrs_.gameObject, false)
				arg_763_1.callingController_:SetSelectedState("normal")

				local var_766_1 = arg_763_1:FormatText(arg_763_1:GetWordFromCfg(411331180).content)

				arg_763_1.text_.text = var_766_1

				LuaForUtil.ClearLinePrefixSymbol(arg_763_1.text_)

				local var_766_3 = 36 <= 0 and var_766_0 or var_766_0 * (utf8.len(var_766_1) / 36)

				if (36 <= 0 and var_766_0 or var_766_0 * (utf8.len(var_766_1) / 36)) > 0 and var_766_0 < var_766_3 then
					arg_763_1.talkMaxDuration = var_766_3

					if var_766_3 + 0 > arg_763_1.duration_ then
						arg_763_1.duration_ = var_766_3 + 0
					end
				end

				arg_763_1.text_.text = var_766_1
				arg_763_1.typewritter.percent = 0

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(false)
				arg_763_1:RecordContent(arg_763_1.text_.text)
			end

			local var_766_4 = math.max(var_766_0, arg_763_1.talkMaxDuration)

			if 0 <= arg_763_1.time_ and arg_763_1.time_ < 0 + var_766_4 then
				arg_763_1.typewritter.percent = (arg_763_1.time_ - 0) / var_766_4

				arg_763_1.typewritter:SetDirty()
			end

			if arg_763_1.time_ >= 0 + var_766_4 and arg_763_1.time_ < 0 + var_766_4 + arg_766_0 then
				arg_763_1.typewritter.percent = 1

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(true)
			end
		end

		arg_763_1.nodeConfigList_ = {}

		arg_763_1:InitPlayNodeList()
	end,
	Play411331181 = function(arg_767_0, arg_767_1)
		arg_767_1.time_ = 0
		arg_767_1.frameCnt_ = 0
		arg_767_1.state_ = "playing"
		arg_767_1.curTalkId_ = 411331181
		arg_767_1.duration_ = 5

		SetActive(arg_767_1.tipsGo_, false)

		function arg_767_1.onSingleLineFinish_()
			arg_767_1.onSingleLineUpdate_ = nil
			arg_767_1.onSingleLineFinish_ = nil
			arg_767_1.state_ = "waiting"
			arg_767_1.auto_ = false
		end

		function arg_767_1.playNext_(arg_769_0)
			arg_767_1.onStoryFinished_()
		end

		function arg_767_1.onSingleLineUpdate_(arg_770_0)
			if 0 < arg_767_1.time_ and arg_767_1.time_ <= 0 + arg_770_0 then
				arg_767_1.var_.moveOldPos4040ui_story = arg_767_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_770_0 = 0.001

			if 0 <= arg_767_1.time_ and arg_767_1.time_ < 0 + var_770_0 then
				arg_767_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_767_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_767_1.time_ - 0) / var_770_0)
				arg_767_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_767_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_767_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_767_1.actors_["4040ui_story"].transform.position).z)
				arg_767_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_767_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_767_1.actors_["4040ui_story"].transform.localEulerAngles = arg_767_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_767_1.time_ >= 0 + var_770_0 and arg_767_1.time_ < 0 + var_770_0 + arg_770_0 then
				arg_767_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_767_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_767_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_767_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_767_1.actors_["4040ui_story"].transform.position).z)
				arg_767_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_767_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_767_1.actors_["4040ui_story"].transform.localEulerAngles = arg_767_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_770_1 = arg_767_1.actors_["4040ui_story"]

			if 0 < arg_767_1.time_ and arg_767_1.time_ <= 0 + arg_770_0 and not isNil(var_770_1) and arg_767_1.var_.characterEffect4040ui_story == nil then
				arg_767_1.var_.characterEffect4040ui_story = var_770_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_770_2 = 0.200000002980232

			if 0 <= arg_767_1.time_ and arg_767_1.time_ < 0 + var_770_2 and not isNil(var_770_1) then
				if arg_767_1.var_.characterEffect4040ui_story and not isNil(var_770_1) then
					arg_767_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_767_1.time_ >= 0 + var_770_2 and arg_767_1.time_ < 0 + var_770_2 + arg_770_0 and not isNil(var_770_1) and arg_767_1.var_.characterEffect4040ui_story then
				arg_767_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_767_1.time_ and arg_767_1.time_ <= 0 + arg_770_0 then
				arg_767_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_767_1.time_ and arg_767_1.time_ <= 0 + arg_770_0 then
				arg_767_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 0 < arg_767_1.time_ and arg_767_1.time_ <= 0 + arg_770_0 then
				if arg_767_1.var_.effectshiwang2 then
					Object.Destroy(arg_767_1.var_.effectshiwang2)

					arg_767_1.var_.effectshiwang2 = nil
				end
			end

			local var_770_5 = 0
			local var_770_6 = 0.35

			if 0 < arg_767_1.time_ and arg_767_1.time_ <= var_770_5 + arg_770_0 then
				arg_767_1.talkMaxDuration = 0
				arg_767_1.dialogCg_.alpha = 1

				arg_767_1.dialog_:SetActive(true)
				SetActive(arg_767_1.leftNameGo_, true)

				arg_767_1.leftNameTxt_.text = arg_767_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_767_1.leftNameTxt_.transform)

				arg_767_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_767_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_767_1:RecordName(arg_767_1.leftNameTxt_.text)
				SetActive(arg_767_1.iconTrs_.gameObject, false)
				arg_767_1.callingController_:SetSelectedState("normal")

				local var_770_7 = arg_767_1:FormatText(arg_767_1:GetWordFromCfg(411331181).content)

				arg_767_1.text_.text = var_770_7

				LuaForUtil.ClearLinePrefixSymbol(arg_767_1.text_)

				local var_770_9 = 14 <= 0 and var_770_6 or var_770_6 * (utf8.len(var_770_7) / 14)

				if (14 <= 0 and var_770_6 or var_770_6 * (utf8.len(var_770_7) / 14)) > 0 and var_770_6 < var_770_9 then
					arg_767_1.talkMaxDuration = var_770_9

					if var_770_9 + var_770_5 > arg_767_1.duration_ then
						arg_767_1.duration_ = var_770_9 + var_770_5
					end
				end

				arg_767_1.text_.text = var_770_7
				arg_767_1.typewritter.percent = 0

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(false)
				arg_767_1:RecordContent(arg_767_1.text_.text)
			end

			local var_770_10 = math.max(var_770_6, arg_767_1.talkMaxDuration)

			if var_770_5 <= arg_767_1.time_ and arg_767_1.time_ < var_770_5 + var_770_10 then
				arg_767_1.typewritter.percent = (arg_767_1.time_ - var_770_5) / var_770_10

				arg_767_1.typewritter:SetDirty()
			end

			if arg_767_1.time_ >= var_770_5 + var_770_10 and arg_767_1.time_ < var_770_5 + var_770_10 + arg_770_0 then
				arg_767_1.typewritter.percent = 1

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(true)
			end
		end

		arg_767_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_767_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I07a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I07",
		"TextureConfig/Background/D10",
		"TextureConfig/Background/ML0107"
	},
	voices = {}
}
